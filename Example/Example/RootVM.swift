//
//  RootVM.swift
//  Example
//
//  Created by tang on 2024/7/9.
//

import Foundation
import TMLViewModel

class RootVM: NSObject {
    
    private var name1: String?
    private var name2: String?
    
    private let childVm = RootVM.ChildVM.ChildVM_1()
    
    override init() {
        super.init()
        childVm.coordinatorDelegate = self
    }
}

// MARK: Define

extension RootVM {
    
    enum ChildVM {}
}

// MARK: Getter

extension RootVM {
    
    var bucketVm1: ChildVM1Bucket.BucketVM_1? { childVm.findBucket(ChildVM1Bucket.BucketVM_1.self) as? ChildVM1Bucket.BucketVM_1 }
    var bucketVm2: ChildVM1Bucket.BucketVM_2? { childVm.findBucket(ChildVM1Bucket.BucketVM_2.self) as? ChildVM1Bucket.BucketVM_2 }
}

// MARK: Public

extension RootVM {
    
    func updateVms(_ name1: String?, _ name2: String?) {
        self.name1 = name1
        self.name2 = name2
        bucketVm1?.updateName()
        bucketVm2?.updateName()
    }
}

// MARK: ChildVM_1CoordinatorProtocol

extension RootVM: ChildVM_1CoordinatorProtocol {
    
    var nameName1: String? { name1 }
    
    var nameName2: String? { name2 }
}
