import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var beginView: UIView!
    @IBOutlet weak var begunView: UIView!
    @IBOutlet weak var beganView: UIView!
    @IBOutlet weak var startTestButton: UIButton!
    
    var student: Student?
    var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        changeColorView()
    }
    
    func changeColorView(){
        if let userData = userDefaults.data(forKey: "users"),
           var decodedStudents = try? JSONDecoder().decode([Student].self, from: userData),
           let currentUserIndex = decodedStudents.firstIndex(where: { $0.name == student?.name }) {
            if  decodedStudents[currentUserIndex].begin == true {
                beginView.backgroundColor = UIColor.green
            }
            if  decodedStudents[currentUserIndex].began == true {
                beganView.backgroundColor = UIColor.green
            }
            if  decodedStudents[currentUserIndex].begun == true {
                begunView.backgroundColor = UIColor.green
            }
            userDefaults.synchronize()
        }
    }
    
    @IBAction func goTestButton(_ sender: Any) {
        guard let quizViewController = storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController else {return}
        quizViewController.student = student
        self.navigationController?.pushViewController(quizViewController, animated: true)
        
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        guard let mainViewController = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {return}
        self.navigationController?.pushViewController(mainViewController, animated: false)
    }
    
}
