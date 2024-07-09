//
//  TMLBucketVM.swift
//  TMLViewModel
//
//  Created by tang on 2024/7/9.
//

import Foundation

fileprivate var BucketNextAssociatedKey: Void?


// MARK: Bucket VM's Delegate

public protocol TMLBucketVMCoordinatorProtocol: NSObjectProtocol {
    var ioQueue: DispatchQueue? { get }
}

public extension TMLBucketVMCoordinatorProtocol {
    var ioQueue: DispatchQueue? { nil }
}


// MARK: Bucket VM

public protocol TMLBucketVM: NSObjectProtocol {
    /// Next
    var next: TMLBucketVM? { get }
    /// 模块名
    var module: String? { get }
    /// 事件代理
    var delegate: TMLBucketVMCoordinatorProtocol? { get set }
}

extension TMLBucketVM {
    
    public var next: TMLBucketVM? { _next }
    internal var _next: TMLBucketVM? {
        get { objc_getAssociatedObject(self, &BucketNextAssociatedKey) as? TMLBucketVM }
        set { objc_setAssociatedObject(self, &BucketNextAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    public var module: String? { nil }
}
