//
//  ContentView.swift
//  Calculator
//
//  Created by Giorgi Samkharadze on 02.09.22.
//

import SwiftUI
//CODEREV: enum for calculator buttons
enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case substract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "C"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    //CODEREV: button colors for different buttons
    var buttonColor: Color {
        switch self {
        case .add, .substract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
            
        }
    }
}
//CODEREV: enum for operation logic
enum Operation {
    case add, substract, multiply, divide, none
    
}


struct ContentView: View {
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    //CODEREV: buttons arr to use in logic and View
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        //CODEREV: ZStack for the black color
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                //HStack for the text display
                HStack {
                    Spacer()
                Text(value)
                    .bold()
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                }
                .padding()
                //CODEREV: VStack two forloops for button tier
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                        Button(action: {
                            self.didTap(button: item)
                        }, label: {
                            Text(item.rawValue)
                                .font(.system(size: 32))
                                .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(self.buttonWidth(item: item) / 2)
                        })
                    }
                }
                    .padding(.bottom, 3)
            }
        }
    }
        
}
    //CODEREV: actual function to tap a button, we are basicly switching tap a button and if it is operation type we hold on type of operation as well as current value, cuz thats the value we are gonna apply operation to. in case of adding multiplying etc..
    func didTap(button: CalcButton) {
        switch button {
        case .add, .substract, .multiply ,.divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .substract {
                self.currentOperation = .substract
                self.runningNumber = Int(self.value) ?? 0
            }else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
                    // CODEREV: and if user hits equal grab the current value and apply operation to it
            }else if button == .equal {
               
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .substract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
            //CODEREV: if user hits clear we clear up the value
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
            // CODEREV: default is all the numbers, if the numbers get hit and current value is zero asign value whatever the input number is, otherwise we tac on numbers
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    // CODEREV: button modifiers
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
            
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() -> CGFloat {
        
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

