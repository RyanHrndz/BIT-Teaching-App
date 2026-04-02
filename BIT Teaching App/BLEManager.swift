//
//  BLEManager.swift
//  BIT Teaching App
//

import Foundation
import CoreBluetooth
import AVFoundation
import UIKit

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {

    // MARK: - Published values for SwiftUI
    @Published var velocity: Float = 0.0
    @Published var acceleration: Float = 0.0
    @Published var distance: Float = 0.0
    @Published var isConnected = false

    // MARK: - CoreBluetooth Properties
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral?

    // UUIDs used by Arduino Nano 33 BLE project
    private let speedBallServiceUUID = CBUUID(string: "FFE0")
    private let velocityCharUUID     = CBUUID(string: "FFE1")
    private let accelerationCharUUID = CBUUID(string: "FFE2")
    private let distanceCharUUID     = CBUUID(string: "FFE3")

    private let synthesizer = AVSpeechSynthesizer()

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    // MARK: - Start BLE Scan
    func startScanning() {
        print("🔍 Starting BLE scan...")
        centralManager.scanForPeripherals(withServices: [speedBallServiceUUID], options: nil)
    }

    // MARK: - Bluetooth State Handling
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("✅ Bluetooth is powered ON.")
        case .poweredOff:
            print("❌ Bluetooth is OFF.")
        case .unsupported:
            print("⚠️ BLE unsupported on this device.")
        default:
            print("⚠️ Unknown BLE state: \(central.state.rawValue)")
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("📡 Found peripheral: \(peripheral.name ?? "Unknown")")
        self.peripheral = peripheral
        self.peripheral?.delegate = self
        centralManager.stopScan()
        centralManager.connect(peripheral, options: nil)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("🔗 Connected to: \(peripheral.name ?? "Peripheral")")
        isConnected = true
        peripheral.discoverServices([speedBallServiceUUID])
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("❌ Disconnected from peripheral.")
        isConnected = false
        self.peripheral = nil
    }

    // MARK: - Discover Services and Characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }

        for service in services {
            print("📦 Discovered service: \(service.uuid)")
            if service.uuid == speedBallServiceUUID {
                peripheral.discoverCharacteristics([velocityCharUUID, accelerationCharUUID, distanceCharUUID], for: service)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }

        for characteristic in characteristics {
            print("📨 Subscribing to characteristic: \(characteristic.uuid)")
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }

    // MARK: - Handle Incoming BLE Data
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let data = characteristic.value else { return }

        let floatValue = data.withUnsafeBytes {
            $0.load(as: Float.self)
        }

        switch characteristic.uuid {
        case velocityCharUUID:
            velocity = floatValue
            print("🚀 Velocity: \(floatValue) m/s")
        case accelerationCharUUID:
            acceleration = floatValue
            print("⚡ Acceleration: \(floatValue) m/s²")
        case distanceCharUUID:
            distance = floatValue
            print("📏 Distance: \(floatValue) meters")
        default:
            print("❓ Unknown characteristic UUID: \(characteristic.uuid)")
        }
    }

    // MARK: - Optional: Speak BLE Metrics for Blind Users
    func speakMetricUpdate() {
        if !UIAccessibility.isVoiceOverRunning && isConnected {
            let text = """
            Velocity: \(velocity) meters per second.
            Acceleration: \(acceleration) meters per second squared.
            Distance: \(distance) meters.
            """
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            synthesizer.speak(utterance)
        }
    }
}
