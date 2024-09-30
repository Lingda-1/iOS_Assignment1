//
//  ViewController.swift
//  Assignment1
//
//  Created by user on 2024-09-27.
//

import UIKit

class ViewController: UIViewController {

    // UI Elements
    let heightTextField = UITextField()
    let weightTextField = UITextField()
    let measurementSegmentedControl = UISegmentedControl(items: ["SI (kg, cm)", "Imperial (lb, in)"])
    let resultLabel = UILabel()
    let calculateButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the UI
        setupUI()
    }

    func setupUI() {
        // Set up text fields
        heightTextField.placeholder = "Height"
        heightTextField.borderStyle = .roundedRect
        heightTextField.keyboardType = .decimalPad
        heightTextField.translatesAutoresizingMaskIntoConstraints = false

        weightTextField.placeholder = "Weight"
        weightTextField.borderStyle = .roundedRect
        weightTextField.keyboardType = .decimalPad
        weightTextField.translatesAutoresizingMaskIntoConstraints = false

        // Set up segmented control
        measurementSegmentedControl.selectedSegmentIndex = 0
        measurementSegmentedControl.translatesAutoresizingMaskIntoConstraints = false

        // Set up button
        calculateButton.setTitle("Calculate BMI", for: .normal)
        calculateButton.addTarget(self, action: #selector(calculateBMI), for: .touchUpInside)
        calculateButton.translatesAutoresizingMaskIntoConstraints = false

        // Set up result label
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        // Add views
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(measurementSegmentedControl)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)

        // Layout constraints
        NSLayoutConstraint.activate([
            measurementSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            measurementSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            heightTextField.topAnchor.constraint(equalTo: measurementSegmentedControl.bottomAnchor, constant: 20),
            heightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            heightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            weightTextField.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20),
            weightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            calculateButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc func calculateBMI() {
        guard let heightValue = Double(heightTextField.text!), heightValue > 0,
              let weightValue = Double(weightTextField.text!), weightValue > 0 else {
            resultLabel.text = "Please enter valid positive numbers."
            return
        }

        var bmi: Double

        if measurementSegmentedControl.selectedSegmentIndex == 0 { // SI
            bmi = weightValue / ((heightValue / 100) * (heightValue / 100))
        } else { // Imperial
            bmi = (weightValue / (heightValue * heightValue)) * 703
        }

        resultLabel.text = "Your BMI is \(String(format: "%.2f", bmi)), which is categorized as \(getBMICategory(bmi))"
    }

    func getBMICategory(_ bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight"
        case 18.5..<24.9:
            return "Normal weight"
        case 25..<29.9:
            return "Overweight"
        default:
            return "Obesity"
        }
    }
}
