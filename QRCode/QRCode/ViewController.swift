//
//  ViewController.swift
//  QRCode
//
//  Created by Vũ Quý Đạt  on 14/05/2021.
//

import UIKit
import AVFoundation
import CryptoSwift
import Foundation
import CommonCrypto

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }


    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let code = "rOaTxpo0p3ZRiXUXk7m/fw=="
        let clear = "vudat81299"
        
        
        
        do {
            let aes = try AES(key: "0123456789abcdef", iv: "abcdef9876543210", padding: .pkcs5)
            print(try aes.encrypt(Array(clear.data(using: .utf8)!)))
            let encryptedData = Data(try aes.encrypt(Array(clear.data(using: .utf8)!)))
            let encryptedString = encryptedData.base64EncodedString()
            print(encryptedString)
            
//            let data = NSData(base64Encoded: encryptedString, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let data = NSData(base64Encoded: encryptedString, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let dec = try aes.decrypt([UInt8](data)) //On iOS12: This returns corrupted data. iOS 13 works fine.
            let decryptedData = Data(dec)

            let final = String(bytes: decryptedData.bytes, encoding: .utf8)
            print(final)
            
            
            
            
//            let decryptedData2 = Data(try aes.decrypt(Array(encryptedString.data(using: .utf8)!)))
//            let decryptedString = decryptedData.base64EncodedString()
//            print(decryptedString)
        } catch {
            print(error.localizedDescription)
        }
        
//        let input = "vudat81299"
//        let encrypted: Array<UInt8> = try! AES(key: "0123456789abcdef", iv:"abcdef9876543210").encrypt(Array(input.data(using: .utf8)!))
//        let decrypted = try! encrypted.decrypt(cipher: ChaCha20(key: "0123456789abcdef", iv: "abcdef9876543210"))
        
        
        
//        print(clear.cryptoSwiftAESEncrypt(key: "0123456789abcdef", iv: "abcdef9876543210"))
//        print((clear.cryptoSwiftAESEncrypt(key: "0123456789abcdef", iv: "abcdef9876543210"))?.cryptoSwiftAESDecrypt(key: "0123456789abcdef", iv: "abcdef9876543210"))
        
        
        
        
        
        
        
        
        
        
        
//        let clearData = "clearData0123456".data(using:String.Encoding.utf8)!
//        let keyData   = "0123456789abcdef".data(using:String.Encoding.utf8)!
//        print("clearData:   \(clearData as NSData)")
//        print("keyData:     \(keyData as NSData)")
//
//        var cryptData :Data?
//        do {
////            cryptData = try aesCBCEncrypt(data:clearData, keyData:keyData)
//            cryptData = code.data(using:String.Encoding.utf8)!
//            print("cryptData:   \(cryptData! as NSData)")
//        }
//        catch (let status) {
//            print("Error aesCBCEncrypt: \(status)")
//        }
//
//        let decryptData :Data?
//        do {
//            let decryptData = try aesCBCDecrypt(data:cryptData!, keyData:keyData)
//            print("decryptData: \(decryptData! as NSData)")
//        }
//        catch (let status) {
//            print("Error aesCBCDecrypt: \(status)")
//        }
//        let test = "tS/nYsHxGOqVQ0tp1dNyr5JsA9IOcQMnPUdm7Zv2WhuATxCMao0d4v+lNsbehCkJbvcFbVkMEIwDHV45SnDztrC8vTgOlVJY8vGXYTTqdT8="
//        let keys = "HomeMonitor"
//
//        if let result = decrypt(encryptedText: test, keys: keys) {
//            print(result) //->TestStringToEncrypt
//        } else {
//            print("*Cannot decrypt*")
//        }

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

        dismiss(animated: true)
    }

    func found(code: String) {
        
        
        
        
        
        
//        print(decrypt(encryptedText: code.toBase64(), keys: key128))
        
        
//        print(decrypt(encryptedText: code, keys: key128))
//        print(code)
//        print(aes128?.decrypt(data: Data(code.utf8))!)
//        print(aes256?.decrypt(data: Data(code.utf8)))
//        print(code)
//        aes128?.decrypt(data: encryptedPassword128)
//        print(encryptedPassword128)
//        print(aes128?.decrypt(data: encryptedPassword128))
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    enum AESError: Error {
        case KeyError((String, Int))
        case IVError((String, Int))
        case CryptorError((String, Int))
    }

    // The iv is prefixed to the encrypted data
    func aesCBCEncrypt(data:Data, keyData:Data) throws -> Data {
        let keyLength = keyData.count
        let validKeyLengths = [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256]
        if (validKeyLengths.contains(keyLength) == false) {
            throw AESError.KeyError(("Invalid key length", keyLength))
        }

        let ivSize = kCCBlockSizeAES128;
        let cryptLength = size_t(ivSize + data.count + kCCBlockSizeAES128)
        var cryptData = Data(count:cryptLength)

        let status = cryptData.withUnsafeMutableBytes {ivBytes in
            SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, ivBytes)
        }
        if (status != 0) {
            throw AESError.IVError(("IV generation failed", Int(status)))
        }

        var numBytesEncrypted :size_t = 0
        let options   = CCOptions(kCCOptionPKCS7Padding)

        let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
            data.withUnsafeBytes {dataBytes in
                keyData.withUnsafeBytes {keyBytes in
                    CCCrypt(CCOperation(kCCEncrypt),
                            CCAlgorithm(kCCAlgorithmAES),
                            options,
                            keyBytes, keyLength,
                            cryptBytes,
                            dataBytes, data.count,
                            cryptBytes+kCCBlockSizeAES128, cryptLength,
                            &numBytesEncrypted)
                }
            }
        }

        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.count = numBytesEncrypted + ivSize
        }
        else {
            throw AESError.CryptorError(("Encryption failed", Int(cryptStatus)))
        }

        return cryptData;
    }

    // The iv is prefixed to the encrypted data
    func aesCBCDecrypt(data:Data, keyData:Data) throws -> Data? {
        let keyLength = keyData.count
        let validKeyLengths = [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256]
        if (validKeyLengths.contains(keyLength) == false) {
            throw AESError.KeyError(("Invalid key length", keyLength))
        }

        let ivSize = kCCBlockSizeAES128;
        print(ivSize)
        let clearLength = size_t(data.count - ivSize)
        var clearData = Data(count:clearLength)

        var numBytesDecrypted :size_t = 0
        let options   = CCOptions(kCCOptionPKCS7Padding)

        let cryptStatus = clearData.withUnsafeMutableBytes {cryptBytes in
            data.withUnsafeBytes {dataBytes in
                keyData.withUnsafeBytes {keyBytes in
                    CCCrypt(CCOperation(kCCDecrypt),
                            CCAlgorithm(kCCAlgorithmAES128),
                            options,
                            keyBytes, keyLength,
                            dataBytes,
                            dataBytes+kCCBlockSizeAES128, clearLength,
                            cryptBytes, clearLength,
                            &numBytesDecrypted)
                }
            }
        }

        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            clearData.count = numBytesDecrypted
        }
        else {
            throw AESError.CryptorError(("Decryption failed", Int(cryptStatus)))
        }

        return clearData;
    }

}



// MARK: - Encrypt.
















//struct AES {
//
//    // MARK: - Value
//    // MARK: Private
//    private let key: Data
//    private let iv: Data
//
//
//    // MARK: - Initialzier
//    init?(key: String, iv: String) {
//        guard key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES256, let keyData = key.data(using: .utf8) else {
//            debugPrint("Error: Failed to set a key.")
//            return nil
//        }
//
//        guard iv.count == kCCBlockSizeAES128, let ivData = iv.data(using: .utf8) else {
//            debugPrint("Error: Failed to set an initial vector.")
//            return nil
//        }
//
//
//        self.key = keyData
//        self.iv  = ivData
//    }
//
//
//    // MARK: - Function
//    // MARK: Public
//    func encrypt(string: String) -> Data? {
//        return crypt(data: string.data(using: .utf8), option: CCOperation(kCCEncrypt))
//    }
//
//    func decrypt(data: Data?) -> String? {
//        guard let decryptedData = crypt(data: data, option: CCOperation(kCCDecrypt)) else { return nil }
//        return String(bytes: decryptedData, encoding: .utf8)
//    }
//
//    func crypt(data: Data?, option: CCOperation) -> Data? {
//        guard let data = data else { return nil }
//
//        let cryptLength = data.count + kCCBlockSizeAES128
//        var cryptData   = Data(count: cryptLength)
//
//        let keyLength = key.count
//        let options   = CCOptions(kCCOptionPKCS7Padding)
//
//        var bytesLength = Int(0)
//
//        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
//            data.withUnsafeBytes { dataBytes in
//                iv.withUnsafeBytes { ivBytes in
//                    key.withUnsafeBytes { keyBytes in
//                    CCCrypt(option, CCAlgorithm(kCCAlgorithmAES), options, keyBytes.baseAddress, keyLength, ivBytes.baseAddress, dataBytes.baseAddress, data.count, cryptBytes.baseAddress, cryptLength, &bytesLength)
//                    }
//                }
//            }
//        }
//
//        guard UInt32(status) == UInt32(kCCSuccess) else {
//            debugPrint("Error: Failed to crypt data. Status \(status)")
//            return nil
//        }
//
//        cryptData.removeSubrange(bytesLength..<cryptData.count)
//        return cryptData
//    }
//}
//let password = "UserPassword1!"
//let key128   = "0123456789abcdef"                   // 16 bytes for AES128
//let key256   = "12345678901234561234567890123456"   // 32 bytes for AES256
//let iv       = "abcdef9876543210"                   // 16 bytes for AES128
//
//let aes128 = AES(key: key128, iv: iv)
//let aes256 = AES(key: key256, iv: iv)
//
//let encryptedPassword128 = aes128?.encrypt(string: password)
//
//let encryptedPassword256 = aes256?.encrypt(string: password)



//
//func decrypt(encryptedText: String, keys: String)  -> String? { //### `String?` rather than `String`
//    //### Decode `encryptedText` as Base-64
//    guard let encryptedData = Data(base64Encoded: encryptedText) else {
//        print("Data is not a valid Base-64")
//        return nil
//    }
//    let derivedKey = generateDerivedKey(keyString: keys)
//    //### A little bit shorter, when `derivedKey` is of type `[UInt8]`
//    let keyData = Data(bytes: derivedKey[0..<32])
//    let ivData = Data(bytes: derivedKey[32..<48])
//    if let decryptedData = testDeCrypt(data: encryptedData, keyData: keyData, ivData: ivData, operation: kCCDecrypt) {
//        //### Use `utf16LittleEndian`
//        return String(bytes: decryptedData, encoding: .utf16LittleEndian)
//    } else {
//        //### return nil, when `testDeCrypt` fails
//        return nil
//    }
//}
//
//func generateDerivedKey(keyString: String) -> [UInt8] { //### `[UInt8]`
//    let salt: [UInt8] = [0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76]
//    var key = [UInt8](repeating: 0, count: 48)
//    CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2), keyString, keyString.utf8.count, salt, salt.count, CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA1), 1000, &key, 48)
//
//    //### return the Array of `UInt8` directly
//    return key
//}
//
//func testDeCrypt(data: Data, keyData: Data, ivData: Data, operation: Int) -> Data? { //### make it Optional
//    assert(keyData.count == Int(kCCKeySizeAES128) || keyData.count == Int(kCCKeySizeAES192) || keyData.count == Int(kCCKeySizeAES256))
//    var decryptedData = Data(count: data.count)
//    var numBytesDecrypted: size_t = 0
//    let operation = CCOperation(operation)
//    let algoritm = CCAlgorithm(kCCAlgorithmAES)
//    let options = CCOptions(kCCOptionPKCS7Padding)
//    let decryptedDataCount = decryptedData.count
//    let cryptoStatus = keyData.withUnsafeBytes {keyDataBytes in
//        ivData.withUnsafeBytes {ivDataBytes in
//            data.withUnsafeBytes {dataBytes in
//                decryptedData.withUnsafeMutableBytes {decryptedDataBytes in
//                    CCCrypt(operation, algoritm, options, keyDataBytes, keyData.count, ivDataBytes, dataBytes, data.count, decryptedDataBytes, decryptedDataCount, &numBytesDecrypted)
//                }
//            }
//        }
//    }
//    if cryptoStatus == CCCryptorStatus(kCCSuccess) {
//        decryptedData.count = numBytesDecrypted
//        return decryptedData
//    } else {
//        return nil //### returning `nil` instead of `Data()`
//    }
//}
extension String {
    //Base64 decode
    func fromBase64() -> String? {
            guard let data = Data(base64Encoded: self) else {
                    return nil
            }
            return String(data: data, encoding: .utf8)
    }

    //Base64 encode
    func toBase64() -> String {
            return Data(self.utf8).base64EncodedString()
    }
}


extension String {
    
    func cryptoSwiftAESEncrypt(key: String, iv: String) -> String? {
        guard let dec = try? AES(key: key, iv: iv, padding: .pkcs7).encrypt(Array(self.utf8))
        else {
            return nil
        }
        let decData = Data(bytes: dec, count: Int(dec.count)).base64EncodedString(options: .lineLength64Characters)
        return decData
    }
    
    func cryptoSwiftAESDecrypt(key: String, iv: String) -> String? {
        var dec: [UInt8]?
        do {
        dec = try? AES(key: key, iv: iv, padding: .pkcs7).decrypt(Array(self.utf8))
        } catch {
            print(error.localizedDescription)
            return ""
        }
        let decData = Data(bytes: dec!, count: Int(dec!.count)).base64EncodedString(options: .lineLength64Characters)
        return decData
    }
}
