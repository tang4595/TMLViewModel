//
//  TMLBucketVM.swift
//  TMLViewModel
//
//  Created by tang on 2024/7/9.
//

import Foundation

fileprivate var BucketNextAssociatedKey: Void?


// MARK: Bucket VM's Delegate

public protocol EMBucketVMCoordinatorProtocol: NSObjectProtocol {
    var ioQueue: DispatchQueue? { get }
}

public extension EMBucketVMCoordinatorProtocol {
    var ioQueue: DispatchQueue? { nil }
}


// MARK: Bucket VM

public protocol EMBucketVM: NSObjectProtocol {
    /// Next
    var next: EMBucketVM? { get }
    /// 模块名
    var module: String? { get }
    /// 事件代理
    var delegate: EMBucketVMCoordinatorProtocol? { get set }
}

extension EMBucketVM {
    
    public var next: EMBucketVM? { _next }
    internal var _next: EMBucketVM? {
        get { objc_getAssociatedObject(self, &BucketNextAssociatedKey) as? EMBucketVM }
        set { objc_setAssociatedObject(self, &BucketNextAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    public var module: String? { nil }
}
