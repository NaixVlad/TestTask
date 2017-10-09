//
//  ContactsViewController.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 06.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

enum Contacts: String {
    case email = "Naixxx@icloud.com"
    case phone = "+7(910)285-62-15"
    case skype = "live:f9aa4642b053254f"
    case github = "https://github.com/NaixVlad"
    
    
    func getIcon() -> UIImage {
        
        switch self {
        case .email:
            return #imageLiteral(resourceName: "email")
        case .phone:
            return #imageLiteral(resourceName: "phone")
        case .skype:
            return #imageLiteral(resourceName: "skype")
        case .github:
            return #imageLiteral(resourceName: "github")
        }
        
    }
    
}

private let cellIdentifier = "Cell"

class ContactsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    private var rowHeight: CGFloat = 0
    private let numberOfRows = 4
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.layer.shadowColor = UIColor.gray.cgColor;
        tableView.layer.shadowOffset = CGSize(width: 0, height: 2.0);
        tableView.layer.shadowRadius = 2.0;
        tableView.layer.shadowOpacity = 1.0;
        tableView.layer.masksToBounds = false;
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rowHeight = tableView.frame.height / CGFloat(numberOfRows)
        tableView.layer.shadowPath = UIBezierPath(rect: (tableView?.bounds)!).cgPath
    }


}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ContactCell
        
        switch row {
        case 0:
            let email = Contacts.email
            cell.contactLabel.text = email.rawValue
            cell.iconImageView.image = email.getIcon()
        case 1:
            let phone = Contacts.phone
            cell.contactLabel.text = phone.rawValue
            cell.iconImageView.image = phone.getIcon()
        case 2:
            let github = Contacts.github
            cell.contactLabel.text = github.rawValue
            cell.iconImageView.image = github.getIcon()
        case 3:
            let skype = Contacts.skype
            cell.contactLabel.text = skype.rawValue
            cell.iconImageView.image = skype.getIcon()
        default: break
            
        }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        switch indexPath.row {
        case 0:
            writeEmailTo(Contacts.email.rawValue)
        case 1:
            callNumber(Contacts.phone.rawValue)
        case 2:
            openUrl(Contacts.github.rawValue)
        case 3:
            skypeCall(Contacts.skype.rawValue)
        default: break
        }
        
    }
    
    private func callNumber(_ phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func openUrl(_ url: String) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }

        
    }
    
    
    func skypeCall(_ id: String) {
        
        let baseUrl = "skype:"
        let installed = UIApplication.shared.canOpenURL(URL(string: baseUrl)!)
        if installed {
            let url = URL(string: baseUrl + id + "?call")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        } else {
            let url = URL(string: "https://itunes.apple.com/in/app/skype/id304878510?mt=8")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func writeEmailTo(_ email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            present(mail, animated: true)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email",
                                                   message: "Your device could not send e-mail.  Please check e-mail configuration and try again.",
                                                   preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        sendMailErrorAlert.addAction(action)
        self.present(sendMailErrorAlert, animated: true)
    }
    
    
    // MARK: MFMailComposeViewControllerDelegate
    
    
     func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}


