import UIKit

struct Student: Codable {
    var name: String
    var begin: Bool
    var begun: Bool
    var began: Bool
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let profileViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
        
        guard let name = nameTextField.text else { return }
        
        if let userData = UserDefaults.standard.data(forKey: "users"),
           let students = try? JSONDecoder().decode([Student].self, from: userData),
           let student = students.first(where: { $0.name == name }) {
            profileViewController.student = student
            self.navigationController?.pushViewController(profileViewController, animated: false)
            
        } else {
            
            let student = Student(name: name, begin: false, begun: false, began: false)
            var students = [Student]()
            if let userData = UserDefaults.standard.data(forKey: "users"),
               let existingUsers = try? JSONDecoder().decode([Student].self, from: userData) {
                students = existingUsers
            }
            students.append(student)
            let userData = try? JSONEncoder().encode(students)
            UserDefaults.standard.set(userData, forKey: "users")
            profileViewController.student = student
            self.navigationController?.pushViewController(profileViewController, animated: false)
        }
        
    }
}


