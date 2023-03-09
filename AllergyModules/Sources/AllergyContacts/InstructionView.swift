//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 30) {
                VStack(spacing: 5) {
                    Text("Patch Testing Purpose and Steps")
                        .font(.title3)
                    Text(instruction1)
                        .padding()
                    BaselineView()
                    Text(instruction2)
                        .padding()
                    AfterApplicationView()
                    Text(instruction3)
                        .padding()
                    DayTwoView()
                    Text(instruction4)
                        .padding()
                }
            }
        }
    }
    
    private var instruction1: String {
        guard let instructionPath1 = Bundle.module.path(forResource: "PatchTestingInstructions1", ofType: "md"),
              let instruction1 = try? String(contentsOfFile: instructionPath1) else {
            return ""
        }
        
        return instruction1
    }
    private var instruction2: String {
        guard let instructionPath2 = Bundle.module.path(forResource: "PatchTestingInstructions2", ofType: "md"),
              let instruction2 = try? String(contentsOfFile: instructionPath2) else {
            return ""
        }
        
        return instruction2
    }
    private var instruction3: String {
        guard let instructionPath3 = Bundle.module.path(forResource: "PatchTestingInstructions3", ofType: "md"),
              let instruction3 = try? String(contentsOfFile: instructionPath3) else {
            return ""
        }
        
        return instruction3
    }
    private var instruction4: String {
        guard let instructionPath4 = Bundle.module.path(forResource: "PatchTestingInstructions4", ofType: "md"),
              let instruction4 = try? String(contentsOfFile: instructionPath4) else {
            return ""
        }
        
        return instruction4
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
