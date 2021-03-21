//
//  ViewController.swift
//  StructMemoryLeak
//
//  Created by Yuichi Fujiki on 15/3/21.
//

import UIKit

// https://stackoverflow.com/questions/27441456/swift-stack-and-heap-understanding#answer-42453109
//
// For Escaping Closure:
// An important note to keep in mind is that in cases where a value stored on a stack is captured in a closure, that value will be copied to the heap so that it's still available by the time the closure is executed.
class ViewController: UIViewController {

    lazy var leakButton: UIButton = {
        let button = UIButton()

        button.setTitle("Leak", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        button.addTarget(self, action: #selector(leak), for: .touchUpInside)

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20)
        ])

        return button
    }()

    lazy var nonLeakButton: UIButton = {
        let button = UIButton()

        button.setTitle("NonLeak", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        button.addTarget(self, action: #selector(nonLeak), for: .touchUpInside)

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ])

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = leakButton
        _ = nonLeakButton
    }

    @objc func leak(sender: Any) {
        var sa = StructA()

        sa.closure = {
            // The moment you capture the struct instance in the escaping closure, the struct goes into the heap and memory leak is born
            sa.noop()
        }
    }

    @objc func nonLeak(sender: Any) {
        // Just making a struct instance with class object inside and doing normal operation does not lead to memory leak
        let sa = StructA()

        sa.noop()
    }
}

class ClassA {
}

struct StructA {
    let ca = ClassA()
    var closure: (() -> Void)?

    func noop() {
        // Do nothing
    }
}
