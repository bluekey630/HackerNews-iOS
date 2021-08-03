//
//  PostsViewController.swift
//  HakerNews
//
//  Created by Admin on 2021/8/3.
//

import UIKit
import SafariServices
class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postIDs: [Int] = []
    var posts: [PostModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        getTopStories()
    }
    
    func getTopStories() {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.getTopStories(completion: {
            error, res, code in
            
            if error != nil {
                ProgressHUD.shared.dismiss()
                self.showAlert(title: "Error", msg: error!.localizedDescription)
            } else {
                if code == 200 {
                    self.postIDs = res as! [Int]
                    if self.postIDs.count > 0 {
                        self.getPostDetails()
                    }
                } else {
                    ProgressHUD.shared.dismiss()
                    self.showAlert(title: "Error", msg: "Failed getting data.")
                }
            }
        })
    }
    
    func getPostDetails() {
        var ids: [Int] = []
        if postIDs.count > 30 {
            for _ in 0..<30 {
                ids.append(postIDs[0])
                postIDs.remove(at: 0)
            }
        } else {
            for id in postIDs {
                ids.append(id)
                postIDs.remove(at: 0)
            }
        }
        
        for postID in ids {
            APIService.shared.getStoryByID(id: postID, completion: {
                error, res, code in
                
                if code == 200 {
                    let response = res as! [String: Any]
                    let post = PostModel(dict: response)
                    self.posts.append(post)
//                    self.tableView.reloadData()
                    if self.posts.count >= 30 {
                        ProgressHUD.shared.dismiss()
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }
    
    @objc func btnMainTapped(sender: UIButton) {
        let index = sender.tag
        let post = posts[index]
        if let url = URL(string: post.url) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }
}

extension PostsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 && postIDs.count > 0 {
            getPostDetails()
        }
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.lblNumber.text = "\(indexPath.row + 1)."
        let host = URL(string: post.url) == nil ? "" : " (\(URL(string: post.url)!.host!))"
        
        let title = post.title.titleStringWith(UIColor.black)
        title.append(host.urlStringWith(UIColor.lightGray))
        
        cell.lblTitle.attributedText = title

        let comments = post.descendants == 0 ? "discuss" : "\(post.descendants) comments"
        cell.lblSubTitle.text = "\(post.score) points by \(post.by) \(Common.shared.getGeneralTimeString(timestamp: post.time)) | hide | \(comments)"
        
        cell.btnMain.tag = indexPath.row
        cell.btnMain.addTarget(self, action: #selector(btnMainTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
}
