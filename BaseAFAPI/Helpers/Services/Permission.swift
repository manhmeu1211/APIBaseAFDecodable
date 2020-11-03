//
//  Permission.swift
//  BaseAFAPI
//
//  Created by ManhLD on 11/3/20.
//

import Foundation
import UIKit
import Photos
import AVFoundation


class Permission {
    
    static var recordStatus: AVAudioSession.RecordPermission {
        return AVAudioSession.sharedInstance().recordPermission
    }
        
    static func requestRecordPermission(completion: @escaping ((_ authorized: Bool) -> Void)) {
        switch recordStatus {
        case .granted:
            completion(true)
        case .denied:
            completion(false)
        default:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        }
    }
    
    
    static var cameraAuthStatus: AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
    
    static func requestCameraPermission(completion: @escaping ((_ authorized: Bool) -> Void)) {
        switch Permission.cameraAuthStatus {
        case .authorized:
            completion(true)
        case .denied:
            completion(false)
        default:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        }
    }
    
    static var photoAuthStatus: PHAuthorizationStatus {
        return PHPhotoLibrary.authorizationStatus()
    }
    
    static func requestPhotoPermission(completion: @escaping ((_ authorized: Bool) -> Void)) {
        switch Permission.photoAuthStatus {
        case .authorized:
            completion(true)
        case .denied:
            completion(false)
        default:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    completion(status == .authorized)
                }
            }
        }
    }
}
