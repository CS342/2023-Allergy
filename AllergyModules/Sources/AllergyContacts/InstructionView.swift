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
                VStack(spacing: 8) {
                    Text("Patch Testing Instructions")
                        .font(.title2.bold())
                    Text("Patch Testing Purpose and Steps")
                        .font(.title3)
                }
            }
            Text(instruction)
                .padding()
        }
    }
    
    private var instruction: String {
        guard let instructionPath = Bundle.module.path(forResource: "PatchTestingInstructions", ofType: "md"),
              let instruction = try? String(contentsOfFile: instructionPath) else {
            return ""
        }
        
        return instruction
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
