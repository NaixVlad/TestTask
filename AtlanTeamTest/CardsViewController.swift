//
//  CardsViewController.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 07.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import UIKit

private let postCellIdentifier = "PostCell"
private let commentCellIdentifier = "CommentCell"
private let resultCellIdentifier = "ResultCell"
private let photoCellIdentifier = "PhotoCell"
private let defaultCellIdentifier = "Cell"

class CardsViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var swipeTipImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var numberOfItems = 0
    private let cardsTitles = ["Посты", "Комментарии", "Случайное задание", "Пользователи", "Фото"]
    private let sectionInsets = UIEdgeInsets(top: 100.0, left: 20.0, bottom: 100.0, right: 20.0)
    
    var request: AnyObject?
    
    var post: Post?
    var comment: Comment?
    var image: UIImage?
    var randomTask: Task?
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
 
        collectionView.isHidden = true
        swipeTipImageView.isHidden = true
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        
        self.prepareData { (succes) in
            
            DispatchQueue.main.async {
               
                if succes {
                    self.swipeTipImageView.isHidden = false
                    self.collectionView.isHidden = false

                    self.hideTipAnimation()
                    
                    self.numberOfItems = self.cardsTitles.count
                    self.collectionView?.reloadData()
                }

                self.activityIndicatorView.stopAnimating()
                
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - Animation
    
    func hideTipAnimation() {
        UIView.animate(withDuration: 0.5, delay: 2, options: .curveLinear, animations: {
            self.swipeTipImageView.alpha = 0
        }, completion: nil)
    }
    
    //MARK: - Gestures
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
    
        view.endEditing(true)
        
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton {
            let button = touch.view as! UIButton
            button.sendActions(for: .touchUpInside)
        }
        
        return true

    }

    //MARK: - Networking
    
    
    func prepareData(completion: @escaping (Bool) -> ()) {
        
        let randomIdentifier = Int.random(range: 1...200)
        self.fetchTodoWithId(randomIdentifier, completion: { (success) in
            guard success == true else {
                completion(false)
                return
            }
            
            
            self.fetchPhotoModelWithId(3, completion:  { (success) in
                guard success == true else {
                    completion(false)
                    return
                }
                
                self.fetchUsersArray(completion: { (success) in
                    guard success == true else {
                        
                        completion(false)
                        return
                    }
                    completion(true)
                })
                
            })
        })
    }
    
    
    func fetchPostWithId(_ id: Int, completion: @escaping (Bool) -> ()) {
        let postResource = PostResource(id: id)
        let postsRequest = Request(resource: postResource)
        request = postsRequest
        postsRequest.load { [weak self] (post: Post?) in
            guard let post = post else {
                completion(false)
                return
            }
            self?.post = post
            completion(true)
        }
    }
    
    func fetchCommentWithId(_ id: Int, completion: @escaping (Bool) -> ()) {
        let commentResource = CommentResource(id: id)
        let commentRequest = Request(resource: commentResource)
        request = commentRequest
        commentRequest.load { [weak self] (comment: Comment?) in
            guard let comment = comment else {
                completion(false)
                return
            }
            self?.comment = comment
            completion(true)
        }
    }
    
    func fetchUsersArray(completion: @escaping (Bool) -> ())  {
        
        
        let usersArrayResource = UsersArrayResource()
        let usersArrayRequest = Request(resource: usersArrayResource)
        request = usersArrayRequest
        usersArrayRequest.load { [weak self] (usersArray: UsersArray?) in
            guard let usersArray = usersArray else {
                completion(false)
                print("Fetch users array error")
                return
            }
            self?.users = usersArray.items
            completion(true)
        }
        
    }
    
    func fetchPhotoModelWithId(_ id: Int, completion: @escaping (Bool) -> ()) {
        let photoResource = PhotoResource(id: id)
        let photoRequest = Request(resource: photoResource)
        request = photoRequest
        photoRequest.load { [weak self] (photo: Photo?) in
            guard let url = photo?.url else {
                completion(false)
                print("Fetch photo model error")
                return
            }
            
            self?.fetchImage(url, completion: { (success) in
                if success == true {
                    completion(true)
                } else {
                    completion(false)
                }
                
            })
        }
    }
    
    private func fetchImage(_ url: URL, completion: @escaping (Bool) -> ()) {
        let imageRequest = ImageRequest(url: url)
        self.request = imageRequest
        imageRequest.load(withCompletion: { [weak self] (image: UIImage?) in
            guard let image = image else {
                completion(false)
                print("Fetch image error")
                return
            }
            
            completion(true)
            self?.image = image
            
        })
        
    }
    
    func fetchTodoWithId(_ id: Int, completion: @escaping (Bool) -> ()) {
        let todoResource = TodoResource(id: id)
        let todoRequest = Request(resource: todoResource)
        request = todoRequest
        todoRequest.load { [weak self] (task: Task?) in
            
            guard let task = task else {
                completion(false)
                print("Fetch task error")
                return
            }
            self?.randomTask = task
            completion(true)
            
        }
    }
    
    //MARK: - Keyboard
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let y = keyboardSize.height - sectionInsets.bottom

            setupOffsetForCollectionView(y: y)
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {

        setupOffsetForCollectionView(y: 0)
    
    }
    
    func setupOffsetForCollectionView(y: CGFloat) {
        let offset = CGPoint(x: collectionView.contentOffset.x, y: y)
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.collectionView.contentOffset = offset
        })
    }
}
    
extension CardsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row
        
        switch row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellIdentifier, for: indexPath) as! PostCell
            cell.titleLabel.text = cardsTitles[row]
            
            cell.delegate = self
            cell.indexPath = indexPath
            
            setupTextField(cell.inputTextField)
            
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellIdentifier, for: indexPath) as! CommentCell
            cell.titleLabel.text = cardsTitles[row]
            
            cell.delegate = self
            cell.indexPath = indexPath
            
             setupTextField(cell.inputTextField)
            
            
            return cell
            
        case 2, 3:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resultCellIdentifier, for: indexPath) as! ResultCell
            cell.titleLabel.text = cardsTitles[row]
            if row == 2 {
                
                cell.resultLabel.text = randomTask?.title
                
            } else {
                
                var severalNames = ""
                
                for i in 0...4 {
                    let number = i+1
                    let rowString = "\n" + number.description + ". " + users[i].username
                    severalNames += rowString
                }
                cell.resultLabel.text = severalNames
                
            }
            
            return cell
            
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCell
            cell.titleLabel.text = cardsTitles[row]
            cell.baseImageView.image = image
            return cell
            
        default:
            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellIdentifier, for: indexPath)
            
            return defaultCell
            
        }
        
    }
    
    func setupTextField(_ textField: UITextField) {
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1,
                                  width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.aquamarineDark.cgColor
        textField.layer.addSublayer(bottomLine)
        
    }

}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return itemSize()
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left + sectionInsets.right
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        view.endEditing(true)

    }
    
    
    func itemSize() -> CGSize {
        
        let availableWidth = view.frame.width - (sectionInsets.left + sectionInsets.right)
        
        let height = collectionView.bounds.height
        let availableHeight = height - (sectionInsets.top + sectionInsets.bottom)

        return CGSize(width: availableWidth, height: availableHeight)
        
    }
    
}


extension CardsViewController: PostCellDelegate {
    
    func submitPostCellAtIndexPath(_ indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PostCell
        let idString = cell.inputTextField.text ?? ""
        
        if let id = Int(idString) {
            
            if 1...100 ~= id {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                fetchPostWithId(id, completion: { (success) in
                    
                    DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    cell.postTitleLabel.text = self.post?.title
                    cell.postBodyLabel.text = self.post?.body
                    }
                    
                })
                
            } else {
                
                cell.postTitleLabel.text  = "Index out of range, введите индекс от 1 до 100"
                cell.postBodyLabel.text = "Введите значение от 1 до 100"
                
            }
        }
    }
    
}


extension CardsViewController: CommentCellDelegate {
    func submitCommentCellAtIndexPath(_ indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CommentCell
        let idString = cell.inputTextField.text ?? ""
        
        if let id = Int(idString) {
            
            if 1...500 ~= id {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                fetchCommentWithId(id, completion: { (success) in
                    
                    DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    cell.nameLabel.text = self.comment?.name
                    cell.emailLabel.text = self.comment?.email
                    cell.bodyLabel.text = self.comment?.body
                    }
                    
                })
                
            } else {
                
                cell.nameLabel.text = "Index out of range"
                cell.emailLabel.text = "Введите значение от 1 до 500"
                cell.bodyLabel.text = ""
                
            }
        }
    }
    
}
