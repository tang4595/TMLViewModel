//
//  TMLBucketableVM.swift
//  TMLViewModel
//
//  Created by tang on 2024/7/9.
//

import Foundation

fileprivate var BucketHeadAssociatedKey: Void?


// MARK: BucketableVM

public protocol TMLBucketableVMProtocol: NSObjectProtocol {
    /// 头结点
    var bucketsHead: TMLBucketVM? { get }
    /// [可选] - 初始化
    func setupBuckets(_ buckets: [TMLBucketVM], delegate: TMLBucketVMCoordinatorProtocol?) -> TMLBucketVM?
    /// [可选] - 设置事件代理（如果手动实现Buckets关系构造，必须调用此方法设置代理，自动构造使用setupBuckets(:,:)）
    func setupBucketsDelegate(_ to: TMLBucketVMCoordinatorProtocol?)
    /// 查询结点
    func findBucket(_ type: TMLBucketVM.Type) -> TMLBucketVM?
}

extension TMLBucketableVMProtocol {
    
    public var bucketsHead: TMLBucketVM? { _bucketsHead }
    fileprivate var _bucketsHead: TMLBucketVM? {
        get { objc_getAssociatedObject(self, &BucketHeadAssociatedKey) as? TMLBucketVM }
        set { objc_setAssociatedObject(self, &BucketHeadAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}


// MARK: Setup

extension TMLBucketableVMProtocol {
    
    @discardableResult
    public func setupBuckets(_ buckets: [TMLBucketVM], delegate: TMLBucketVMCoordinatorProtocol?) -> TMLBucketVM? {
        guard !buckets.isEmpty else { return nil }
        var pre: TMLBucketVM?
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
    
    public func setupBucketsDelegate(_ to: TMLBucketVMCoordinatorProtocol?) {
        recrSetupBucketsDelegate(to, head: bucketsHead)
    }
    
    private func recrSetupBucketsDelegate(_ to: TMLBucketVMCoordinatorProtocol?, head: TMLBucketVM?) {
        guard let head else { return }
        head.delegate = to
        recrSetupBucketsDelegate(to, head: head.next)
    }
}


// MARK: Search

extension TMLBucketableVMProtocol {
    
    public func findBucket(_ type: TMLBucketVM.Type) -> TMLBucketVM? {
        return recrFindBucket(with: type, head: bucketsHead)
    }
    
    private func recrFindBucket(with bucketType: TMLBucketVM.Type, head: TMLBucketVM?) -> TMLBucketVM? {
        guard let head else { return nil }
        if head.isMember(of: bucketType) { return head }
        return recrFindBucket(with: bucketType, head: head.next)
    }
}
