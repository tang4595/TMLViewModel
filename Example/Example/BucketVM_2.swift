//
//  BucketVM_2.swift
//  Example
//
//  Created by tang on 2024/7/9.
//

import Foundation
import TMLViewModel
import Combine

extension RootVM.ChildVM.ChildVM_1.BucketVM {
    
    class BucketVM_2: NSObject {
        
        weak var coordinatorDelegate: BucketVM_2CoordinatorProtocol?
        
        private let nameSubject = CurrentValueSubject<String?, Never>(nil)
    }
}

extension RootVM.ChildVM.ChildVM_1.BucketVM.BucketVM_2: TMLBucketVM {
    
    var delegate: (any TMLViewModel.TMLBucketVMCoordinatorProtocol)? {
        get { coordinatorDelegate }
        set { coordinatorDelegate = newValue as? BucketVM_2CoordinatorProtocol }
    }
}

// MARK: Define

protocol BucketVM_2CoordinatorProtocol: TMLBucketVMCoordinatorProtocol {
    var bucketVm2_getName: String? { get }
    func bucketVm2_handleName(_ name: String?)
}

extension RootVM.ChildVM.ChildVM_1.BucketVM.BucketVM_2 {}

// MARK: Getter

extension RootVM.ChildVM.ChildVM_1.BucketVM.BucketVM_2 {
    
    var name: AnyPublisher<String?, Never> { nameSubject.eraseToAnyPublisher() }
}

// MARK: Public

extension RootVM.ChildVM.ChildVM_1.BucketVM.BucketVM_2 {
    
    func updateName() {
        coordinatorDelegate?.bucketVm2_handleName(coordinatorDelegate?.bucketVm2_getName)
        nameSubject.send(coordinatorDelegate?.bucketVm2_getName)
    }
}
