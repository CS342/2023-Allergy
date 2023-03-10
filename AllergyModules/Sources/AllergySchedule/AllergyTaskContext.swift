//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FHIR


public enum PhotoUploadContext: String, Codable, CaseIterable {
    case base
    case day0
    case day2
    case day4
    case optional
}


/// The context attached to each task in the CS342 2023 Allergy Team Application.
public enum AllergyTaskContext: Codable, Identifiable {
    case questionnaire(Questionnaire)
    case photoUpload(PhotoUploadContext)

    public var id: String {
        switch self {
        case let .questionnaire(questionnaire):
            return questionnaire.id.description
        case let .photoUpload(photoUploadContext):
            return photoUploadContext.rawValue
        }
    }

    var actionType: String {
        switch self {
        case .questionnaire:
            return String(localized: "TASK_CONTEXT_ACTION_QUESTIONNAIRE", bundle: .module)
        case .photoUpload(PhotoUploadContext.base):
            return String(localized: "TASK_CONTEXT_ACTION_PHOTOUPLOAD1", bundle: .module)
        case .photoUpload(PhotoUploadContext.day0):
            return String(localized: "TASK_CONTEXT_ACTION_PHOTOUPLOAD2", bundle: .module)
        case .photoUpload(PhotoUploadContext.day2):
            return String(localized: "TASK_CONTEXT_ACTION_PHOTOUPLOAD3", bundle: .module)
        case .photoUpload(PhotoUploadContext.day4):
            return String(localized: "TASK_CONTEXT_ACTION_PHOTOUPLOAD4", bundle: .module)
        case .photoUpload(PhotoUploadContext.optional):
            return String(localized: "TASK_CONTEXT_ACTION_PHOTOUPLOAD5", bundle: .module)
        }
    }
}
