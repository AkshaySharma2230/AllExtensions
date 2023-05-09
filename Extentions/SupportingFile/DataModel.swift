//
//  DataModel.swift
//  BrewTask
//
//  Created by AkshayKumar on 12/01/22.
//

import Foundation

struct DataModel {
    
    let approved : String
    let assigned_to : Int
    let completed : String
    let completed_on : String
    let created_at : String
    let created_by : Int
    let deadline : String
    let description : String
    let hoursAssigned : String
    let hoursCompletedTillNow : String
    let id : Int
    let reopen_count : Int
    let title : String
    
    let assigned : NSDictionary
    let creater : NSDictionary
    
    
    
    init(approved : String, assigned_to : Int, completed : String, completed_on : String,created_at : String,created_by : Int,deadline : String,description : String,hoursAssigned : String,hoursCompletedTillNow : String,id : Int,reopen_count : Int,title : String, assigned : NSDictionary,creater : NSDictionary) {
        
        self.approved = approved
        self.assigned_to = assigned_to
        self.completed = completed
        self.completed_on = completed_on
        self.created_at = created_at
        self.created_by = created_by
        self.deadline = deadline
        self.description = description
        self.hoursAssigned = hoursAssigned
        self.hoursCompletedTillNow = hoursCompletedTillNow
        self.id = id
        self.reopen_count = reopen_count
        self.title = title
        self.assigned = assigned
        self.creater = creater
    }
   
}
