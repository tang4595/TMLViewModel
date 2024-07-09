//
//  TMLBucketableVM.swift
//  TMLViewModel
//
//  Created by tang on 2024/7/9.
//

import Foundation

fileprivate var BucketHeadAssociatedKey: Void?


// MARK: BucketableVM

public protocol EMBucketableVMProtocol: NSObjectProtocol {
    /// 头结点
    var bucketsHead: EMBucketVM? { get }
    /// [可选] - 初始化
    func setupBuckets(_ buckets: [EMBucketVM], delegate: EMBucketVMCoordinatorProtocol?) -> EMBucketVM?
    /// [可选] - 设置事件代理（如果手动实现Buckets关系构造，必须调用此方法设置代理，自动构造使用setupBuckets(:,:)）
    func setupBucketsDelegate(_ to: EMBucketVMCoordinatorProtocol?)
    /// 查询结点
    func findBucket(_ type: EMBucketVM.Type) -> EMBucketVM?
}

extension EMBucketableVMProtocol {
    
    public var bucketsHead: EMBucketVM? { _bucketsHead }
    fileprivate var _bucketsHead: EMBucketVM? {
        get { objc_getAssociatedObject(self, &BucketHeadAssociatedKey) as? EMBucketVM }
        set { objc_setAssociatedObject(self, &BucketHeadAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}


// MARK: Setup

extension EMBucketableVMProtocol {
    
    @discardableResult
    public func setupBuckets(_ buckets: [EMBucketVM], delegate: EMBucketVMCoordinatorProtocol?) -> EMBucketVM? {
        guard !buckets.isEmpty else { return nil }
        var pre: EMBucketVM?
        var i: Int = buckets.count-1
        while i >= 0 {
            let cur = buckets[i]
            cur._next = pre
            pre = cur
            pre?.delegate = delegate
            i -= 1
        }
        self._bucketsHead = pre
        return self._bucketsHead
    }
    
    public func setupBucketsDelegate(_ to: EMBucketVMCoordinatorProtocol?) {
        recrSetupBucketsDelegate(to, head: bucketsHead)
    }
    
    private func recrSetupBucketsDelegate(_ to: EMBucketVMCoordinatorProtocol?, head: EMBucketVM?) {
        guard let head else { return }
        head.delegate = to
        recrSetupBucketsDelegate(to, head: head.next)
    }
}


// MARK: Search

extension EMBucketableVMProtocol {
    
    public func findBucket(_ type: EMBucketVM.Type) -> EMBucketVM? {
        return recrFindBucket(with: type, head: bucketsHead)
    }
    
    private func recrFindBucket(with bucketType: EMBucketVM.Type, head: EMBucketVM?) -> EMBucketVM? {
        guard let head else { return nil }
        if head.isMember(of: bucketType) { return head }
        return recrFindBucket(with: bucketType, head: head.next)
    }
}
