//
//  RNAudioKit.swift
//  trippiness_mobile
//
//  Created by Hani Mohammed on 02/04/20.
//  Copyright © 2020 Hani Mohammed. All rights reserved.
//

import Foundation
import AudioKit

@objc(RNAudioKit)
class RNAudioKit: NSObject {

  @objc(trimAudio:start:end:resolver:rejecter:)
  func trimAudio(_ file: String, start: NSNumber, end: NSNumber,
    resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    do {
      let akAudioFile = try AKAudioFile(readFileName: file, baseDir: .documents)
      try AKAudioFile(forReading: akAudioFile.avAsset.url).extractAsynchronously(fromSample: Int64(Int(truncating: start) * akAudioFile.sampleRate), toSample: Int64(Int(truncating: end) * akAudioFile.sampleRate), baseDir: .temp, name: akAudioFile.fileName){exportedFile, error in
        if error == nil {
          print("Export succeeded \(String(describing: exportedFile))")
          exportedFile?.exportAsynchronously(name: (exportedFile?.fileName ?? "exported") + ".wav", baseDir: .documents, exportFormat: .wav){convertedFile,error in
            if error == nil {
              print("Export succeeded")
              resolve(convertedFile?.fileNamePlusExtension)
            }
            else {
              print("Export failed: \(String(describing: error))")
              reject("convert_error", "Failed to Convert.", error)
            }
          }

        } else {
          print("Export failed: \(String(describing: error))")
          reject("extract_error", "Failed to Extract.", error)
        }
      }
    } catch {
      reject("file_error", "Failed to Open File.", error);
    }
  }

}
