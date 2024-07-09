//
//  ViewController.swift
//  Example
//
//  Created by tang on 2024/7/9.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    
    @IBOutlet weak var name1Label: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    
    private var cancelSet = Set<AnyCancellable>()
    private let viewModel = RootVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        binds()
    }

    @IBAction func updateTapped(_ sender: Any) {
        viewModel.updateVms(text1.text, text2.text)
    }
}

private extension ViewController {
    
    func binds() {
        viewModel.bucketVm1?.name
            .dropFirst()
            .map{ "BucketVM1's name is: \($0 ?? "")" }
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: name1Label)
            .store(in: &cancelSet)
        
        viewModel.bucketVm2?.name
            .dropFirst()
            .map{ "BucketVM2's name is: \($0 ?? "")" }
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: name2Label)
            .store(in: &cancelSet)
    }
}
