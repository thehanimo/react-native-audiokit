import AudioKit

@objc(RNAudioKit)
class RNAudioKit: NSObject {
    
    @objc(getDuration:resolver:rejecter:)
    func getDuration(
      file: String,
      resolve: @escaping RCTPromiseResolveBlock,
      rejecter reject: @escaping RCTPromiseRejectBlock
    ) -> Void {
        do {
            let akAudioFile = try AKAudioFile(readFileName: file, baseDir: .documents)
            resolve(akAudioFile.duration)
        } catch {
            reject("file_error", "Failed to Open File.", error);
        }
    }
    
    
    @objc(trim:start:end:resolver:rejecter:)
    func trim(
        file: String,
        start: NSNumber,
        end: NSNumber,
        resolve: @escaping RCTPromiseResolveBlock,
        rejecter reject: @escaping RCTPromiseRejectBlock
    ) -> Void {
        do {
            // Read Audio File
            let akAudioFile = try AKAudioFile(readFileName: file, baseDir: .documents)
            
            // Set sample rate
            AKSettings.sampleRate = akAudioFile.sampleRate
            
            // Extract samples from start to end
            try AKAudioFile(forReading: akAudioFile.avAsset.url)
                .extractAsynchronously(
                    fromSample: Int64(Int(truncating: start) * akAudioFile.sampleRate),
                    toSample: Int64(Int(truncating: end) * akAudioFile.sampleRate),
                    baseDir: .temp,
                    name: akAudioFile.fileName
                ){ extractedFile, error in
                    
                    // Export the extracted samples into a new file
                    if error == nil {
                        print("Extract succeeded.")
                        extractedFile?.exportAsynchronously(
                            name: (extractedFile?.fileName ?? "exported") + ".wav",
                            baseDir: .documents,
                            exportFormat: .wav,
                            fromSample: 0,
                            toSample: Int64(Int(Int(truncating: end) - Int(truncating: start)) * akAudioFile.sampleRate)
                        ){ exportedFile,error in
                            if error == nil {
                                print("Export succeeded.")
                                resolve(exportedFile?.fileNamePlusExtension)
                            } else {
                                print("Export failed: \(String(describing: error))")
                                reject("export_error", "Failed to Export.", error)
                            }
                        }
                    } else {
                        print("Extract failed: \(String(describing: error))")
                        reject("extract_error", "Failed to Extract.", error)
                    }
                }
        } catch {
        reject("file_error", "Failed to Open File.", error);
        }
    }
}
