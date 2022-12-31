//
//  DefaultsSerializable+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/7/27.
//

import Foundation

extension DefaultsSerializable where Self: Codable {
    typealias Bridge = DefaultsCodableBridge<Self>
    typealias ArrayBridge = DefaultsCodableBridge<[Self]>
}

extension DefaultsSerializable where Self: RawRepresentable {
    typealias Bridge = DefaultsRawRepresentableBridge<Self>
    typealias ArrayBridge = DefaultsRawRepresentableArrayBridge<[Self]>
}
