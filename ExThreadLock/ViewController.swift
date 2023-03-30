//
//  ViewController.swift
//  ExThreadLock
//
//  Created by 김종권 on 2023/03/31.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = DispatchQueue(label: "work_queue")
        let workItem = DispatchWorkItem { [weak self] in
            print("start")
            let value = self?.someDelayWork()
            print("end", value)
        }
        
        queue.async(execute: workItem)
        print("test>")
        let result = workItem.wait(timeout: DispatchTime.now() + 1)

        switch result {
        case .success:
            print("success")
        case .timedOut:
            workItem.cancel()
            print("isCancelled?", workItem.isCancelled)
            print("timedOut")
        }
    }
    
    private func someDelayWork() -> Int {
        sleep(3)
        return 3
    }
}
