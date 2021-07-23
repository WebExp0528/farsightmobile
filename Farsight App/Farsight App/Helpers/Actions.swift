//
//  Actions.swift
//  Farsight App
//
//  Created by WebDEV on 7/23/21.
//

import Foundation
import UIKit

protocol ActionType {
    var view : FSBaseDetailView { get }
    var category : Category?  { get }
    var tag : Int  { get }
}

enum ActionItems {
    case BeforePhotos
    case DuringPhotos
    case AfterPhotos
    case Instructions
    case CreateBid
    case CompleteSurvey
}

extension ActionItems : ActionType {
    var tag: Int {
        switch self {
        case .BeforePhotos:
            return 0
        case .DuringPhotos:
            return 2
        case .AfterPhotos :
            return 4
        case .Instructions:
            return 1
        case .CreateBid:
            return 5
        case .CompleteSurvey:
            return 3
        }
    }
    
    var view: FSBaseDetailView {
        switch self {
        case .BeforePhotos:
            let photoView = FSPhotosView()
            photoView.category = Category.Before
            return photoView
        case .AfterPhotos:
            let photoView = FSPhotosView()
            photoView.category = Category.After
            return photoView
        case .DuringPhotos:
            let photoView = FSPhotosView()
            photoView.category = Category.During
            return photoView
        case .Instructions:
            return FSInstructionView()
        case .CreateBid:
            return FSAddBidView()
        case .CompleteSurvey:
            return FSSubmitView()
        }
    }
    
    var category: Category? {
        switch self {
            case .BeforePhotos:
                return Category.Before
            case .DuringPhotos:
                return Category.During
            case .AfterPhotos:
                return Category.After
            default:
                return nil
        }
    }
}
