//
//  BucketVM_1.swift
//  Example
//
//  Created by tang on 2024/7/9.
//

import Foundation
import TMLViewModel
import Combine

extension RootVM.ChildVM.ChildVM_1.BucketVM {
    
    class BucketVM_1: NSObject {
        
        weak var coordinatorDelegate: BucketVM_1CoordinatorProtocol?
        
        private let nameSubject = CurrentValueSubject<String?, Never>(nil)
    }
}

extension RootVM.ChildVM.ChildVM_1.BucketVM.BucketVM_1: TMLBucketVM {
    
    var delegate: (any TMLViewModel.TMLBucketVMCoordinatorProtocol)? {
        get { coordinatorDelegate }
        set { coordinatorDelegate = newValue as? BucketVM_1CoordinatorProtocol }
    }
}

// MARK: Define

protocol BucketVM_1CoordinatorProtocol: TMLBucketVMCoordinatorProtocol {
    var bucketVm1_getName: String? { get }
    func bucketVm1_handleName(_ name: String?)
}

extension RootVM.ChildVM.ChildVM_1.BucketVM.BucketVM_1 {}

// MARK: Getter

extension RootVM.ChildVM.ChildVM_1.BucketVM.BucketVM_1 {
    
    var name: AnyPublisher<String?, Never> { nameSubject.eraseToAnyPublisher() }
}

// MARK: Public

extension RootVM.ChildVM.ChildVM_1.BucketVM.BucketVM_1 {
    
    func updateName() {
        coordinatorDelegate?.bucketVm1_handleName(coordinatorDelegate?.bucketVm1_getName)
        nameSubject.send(coordinatorDelegate?.bucketVm1_getName)
    }
}
