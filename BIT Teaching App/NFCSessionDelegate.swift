// NFCSessionDelegate.swift
// BIT Teaching App

import Foundation
import CoreNFC
import UIKit

class NFCSessionDelegate: NSObject, NFCNDEFReaderSessionDelegate {
    /// Stores the raw string from the last successful tag scan
    var lastScannedTagPayload: String?

    private let completionHandler: (String) -> Void

    init(completion: @escaping (String) -> Void) {
        self.completionHandler = completion
    }

    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        // You can post an accessibility announcement here if you like
        DispatchQueue.main.async {
            UIAccessibility.post(notification: .announcement,
                                 argument: "Hold your iPhone near the NFC tag.")
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession,
                       didInvalidateWithError error: Error) {
        // Ignore the “first‐read” invalidation so it doesn’t immediately call back
        if let readerError = error as? NFCReaderError,
           readerError.code == .readerSessionInvalidationErrorFirstNDEFTagRead {
            return
        }
        // Otherwise treat it as a real error
        DispatchQueue.main.async {
            let msg = error.localizedDescription
            UIAccessibility.post(notification: .announcement,
                                 argument: "NFC session ended: \(msg)")
            self.completionHandler("invalid")
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession,
                       didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard let firstMessage = messages.first,
              let firstRecord  = firstMessage.records.first else {
            DispatchQueue.main.async {
                UIAccessibility.post(notification: .announcement,
                                     argument: "Invalid or unreadable NFC tag.")
                self.completionHandler("invalid")
            }
            return
        }

        // Strip out the 3‐byte language prefix
        let payload = firstRecord.payload.advanced(by: 3)
        let text = String(data: payload, encoding: .utf8)?
                       .trimmingCharacters(in: .whitespacesAndNewlines)
                   ?? "invalid"

        // Store it for later (e.g. your QuizView.evaluateAnswer())
        lastScannedTagPayload = text

        DispatchQueue.main.async {
            self.completionHandler(text)
        }
    }
}
