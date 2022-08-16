import UIKit
import Firebase
import FirebaseDatabase
class ChatViewController: UIViewController {
    
    
    
    
    
    
    var post: [[String:Any]] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        tableView.dataSource = self
        title = "US Team Chat App"
        
        navigationItem.hidesBackButton = true
        
        self.observed()
        self.tableView.reloadData()
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        
        

        let dateMessage = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyyHHmmss"
        let idDate = dateFormatter.string(from: dateMessage)
        let sms = Database.database().reference().child("messages").child(idDate)
                
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
     
                
        let postObject = [
                            "content": messageTextfield.text ?? "No Message",
                            "timestamp": dateFormatter.string(from: dateMessage),
                            "messageId": idDate,
                            "userSenderId": Auth.auth().currentUser?.uid ?? "Unknown"] as [String: Any]
        
        
                
        sms.setValue(postObject, withCompletionBlock: {error, ref in
            if error == nil {
                self.observed()
                self.tableView.reloadData()
                DispatchQueue.main.async {
                    self.messageTextfield.text = ""
                }
                        
            } else {
                print("Error")
                    }
            })
        
      
       
        
        print("This what happens to ", self.post.count)
        
    }
    
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
      
    
    }
    
    
    
    
    
    func observed(){
        let message = Database.database().reference().child("messages")
                //var Post: [String] = []
                var Post: [[String:Any]] = []
                message.observe(.value, with: {snapshot in
                    for child in snapshot.children{
                        if let childSnapshot = child as? DataSnapshot,
                           let dict = childSnapshot.value as? [String: Any],
                           let id = dict["userSenderId"],
                           let text = dict["content"],
                           let timestamp = dict["timestamp"]
                        
                        {
                            Post.append(dict)
                            
                        }
                    }
                    
                    self.post = Post
                    
                  
                    print(Post.count)
                    self.tableView.reloadData()
                    let indexPath = IndexPath(row: self.post.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    
                
                    
                })
        
            }
    
    }
    
    



extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(self.post.count, "tableview count")
        
        return self.post.count
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let posts = self.post[indexPath.row]
        
            
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath ) as! MessageCellTableViewCell
       cell.label.text = "\(self.post[indexPath.row]["content"]!)"
       
        
        if posts["userSenderId"] as? String  == Auth.auth().currentUser?.uid {
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            cell.ID.isHidden = true
            cell.ID.text = "\(self.post[indexPath.row]["userSenderId"]!)"
            cell.messageBubble.backgroundColor = .systemGreen
            cell.label.textColor = .black
        }
        else {
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.ID.isHidden = false
            cell.messageBubble.backgroundColor = .systemBlue
            cell.label.textColor = .black
        }
        
        return cell
        
    }
    
    
}


/*extension ChatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}*/
