//
//  ChildVM_1.swift
//  Example
//
//  Created by tang on 2024/7/9.
//

import Foundation
import TMLViewModel

extension RootVM.ChildVM {
    
    class ChildVM_1: NSObject, TMLBucketableVMProtocol {
        
        weak var coordinatorDelegate: ChildVM_1CoordinatorProtocol?
        
        private let bucketVm1 = RootVM.ChildVM.ChildVM_1.BucketVM.BucketVM_1()
        private let bucketVm2 = RootVM.ChildVM.ChildVM_1.BucketVM.BucketVM_2()
        
        override init() {
            super.init()
            setupBuckets([bucketVm1, bucketVm2], delegate: self)
        }
    }
}

// MARK: Define

typealias ChildVM1Bucket = RootVM.ChildVM.ChildVM_1.BucketVM

protocol ChildVM_1CoordinatorProtocol: NSObjectProtocol {
    var nameName1: String? { get }
    var nameName2: String? { get }
}

extension RootVM.ChildVM.ChildVM_1 {
    
    enum BucketVM {}
}

// MARK: Getter

extension RootVM.ChildVM.ChildVM_1 {}

// MARK: Public

extension RootVM.ChildVM.ChildVM_1 {}

// MARK: BucketVM_1CoordinatorProtocol

extension RootVM.ChildVM.ChildVM_1: BucketVM_1CoordinatorProtocol {
    
    var bucketVm1_getName: String? {
        coordinatorDelegate?.nameName1
    }
    
    func bucketVm1_handleName(_ name: String?) {
        debugPrint("bucketVm1_handleName: \(String(describing: name))")
    }
}

// MARK: Public

extension RootVM.ChildVM.ChildVM_1: BucketVM_2CoordinatorProtocol {
    
    var bucketVm2_getName: String? {
        coordinatorDelegate?.nameName2
    }
    
    func bucketVm2_handleName(_ name: String?) {
        debugPrint("bucketVm2_handleName: \(String(describing: name))")
    }
}
