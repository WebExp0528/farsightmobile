//
//  JobService.swift
//  Farsight App
//
//  Created by Hamza Malik on 15/07/2021.
//

import Foundation
//import Alamofire
protocol IJobService {
      typealias ResponseJobList = (DTOJobList ,Error?) -> Void

    func getJobs(byUserId userId: String, pageId: String, completion: @escaping ResponseJobList)

    

    
}
class JobService: IJobService {
    
       
    func getJobs(byUserId userId: String, pageId: String, completion: @escaping ResponseJobList) {
        let params = ["userID": userId, "pageID": pageId]

             AF.request(Config.shared.jobListApi, method: .get, parameters: params).validate().responseJSON{ response in
                   
                   switch response.result {
                   case .success(let value):
                    print(value)
                        if let value = value as? AnyObject {
                                            
                                             
                         guard let successFul = value["successful"] as? Int else{
                                return
                         }
                         if successFul == 1 {
                             
                         guard let message = value["message"] as? String else{
                                   return
                             
                         }
                        guard let urdu_message = value["urdu_message"] as? String else{
                                                         
                            return
                        }
                        guard let data = value["data"] as? [String:Any] else{
                                return
                        }
                        var Page = ""
                        var Size = ""
                        if let page = data["page"] as? String {
                            Page = page
                        }
                        if let size = data["size"] as? String {
                            Size = size
                        }
                        var List = [Dictionary<String,Any>]()
                        if let list = data["list"] as? [Dictionary<String,Any>] {
                                List = list
                               
                            }
                             var GroupID : String = ""
                             var Name : String = ""
                             var Description : String = ""
                             var GroupType : String = ""
                             var AdminID : String = ""
                             var AdminName : String = ""
                             var CreatedDate : String = ""
                             var PublicKey: String = ""
                             var PrivateKey : String = ""
                             var MessageID : String = ""
                             var SenderName : String = ""
                             var Body : String = ""
                             var ContentType : String = ""
                             var File : String = ""
                             var SentDate : String = ""
                             var SenderID : String = ""
                             var ParentID : String = ""
                             var MessageType : String = ""
                             var IsHidden : String = ""
                             var ActiveMember : String = ""
                             var Group : String = ""
                             var IsOverallRead : String = ""
                             var PrivateGroup : String = ""
                             var IsPrivateRead : String = ""
                            var AllGroupLists = [AllGroupsList]()
                                for list in List {
                             
                                                if let groupID = list["groupID"] as? String { GroupID = groupID }
                                                if let name = list["name"] as? String {  Name = name}
                                                if let description = list["description"] as? String { Description = description}
                                      if let groupType = list["groupType"] as? String { GroupType = groupType}
                                                if let adminID = list["adminID"] as? String { AdminID = adminID}
                                                if let adminName = list["adminName"] as? String { AdminName = adminName }
                                                if let createdDate = list["createdDate"] as? String { CreatedDate = createdDate}
                                                if let publicKey = list["publicKey"] as? String { PublicKey = publicKey}
                                                if let privateKey = list["privateKey"] as? String { PrivateKey = privateKey}
                                                if let messageID = list["messageID"] as? String { MessageID = messageID}
                                                if let senderName = list["senderName"] as? String { SenderName = senderName}
                                                if let body = list["body"] as? String { Body = body}
                                                if let contentType = list["contentType"] as? String { ContentType = contentType}
                                                if let file = list["file"] as? String { File = file}
                                                if let sentDate = list["sentDate"] as? String { SentDate = sentDate}
                                                if let senderID = list["senderID"] as? String { SenderID = senderID}
                                                if let parentID = list["parentID"] as? String { ParentID = parentID}
                                                if let messageType = list["messageType"] as? String { MessageType = messageType}
                                                if let isHidden = list["isHidden"] as? String { IsHidden = isHidden}
                                                if let activeMember = list["activeMember"] as? String { ActiveMember = activeMember}
                                                if let group = list["group"] as? String { Group = group}
                                                if let isOverallRead = list["isOverallRead"] as? String { IsOverallRead = isOverallRead  }
                                                if let privateGroup = list["privateGroup"] as? String { PrivateGroup = privateGroup}
                                                if let isPrivateRead = list["isPrivateRead"] as? String { IsPrivateRead = isPrivateRead}
                                    let groupList = AllGroupsList(groupID: GroupID, name: Name, description: Description,groupType: GroupType, adminID: AdminID, adminName: AdminName, createdDate: CreatedDate, publicKey: PublicKey, privateKey: PrivateKey, messageID: MessageID, senderName: SenderName, body: Body, contentType: ContentType, file: File, sentDate: SentDate, senderID: SenderID, parentID: ParentID, messageType: MessageType, isHidden: IsHidden, activeMember: ActiveMember, group: Group, isOverallRead: IsOverallRead, privateGroup: PrivateGroup, isPrivateRead: IsPrivateRead)
                                    AllGroupLists.append(groupList)
                                    
                            }


                            
                                                 
                            
                            
                            
                       let allGroups = AllGroups(successful: successFul, urdu_message: urdu_message, message: message, page: Page, size: Size, list: AllGroupLists)
                     //    let user = User(successful: successFul, message: message, data: data, groups: groups)
                             completion(allGroups,nil)
                         }else {
                             completion(AllGroups() ,NSError() as Error)
                         }
                         
                                       
                         
                     }
                    break
                   case .failure(let error):
                    print(error)
                     completion(AllGroups() ,NSError() as Error)

                    
            }
        }

            
    }
    




     
    
}
