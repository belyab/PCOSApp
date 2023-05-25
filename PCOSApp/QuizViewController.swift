import Foundation
import UIKit

class Question {
    var question: String
    var answers: [String]
    var correctAnswerIndex: Int
    
    init(question: String, answers: [String], correctAnswerIndex: Int) {
        self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
}

class Quiz {
    var questions: [Question]
    
    init(questions: [Question]) {
        self.questions = questions
    }
}

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    
    var userDefaults = UserDefaults.standard
    
    let questions = [ Question(question: "I will _ reading this book tomorrow.", answers: ["begin", "began", "begun"], correctAnswerIndex: 1),
                      Question(question: "The movie, _ last year, is still in production.", answers: ["begin", "began", "begun"], correctAnswerIndex: 3),
                      Question(question: "He _ by producing from under his arm a great letter, nearly as large as himself.", answers: ["begin", "began", "begun"], correctAnswerIndex: 2)
    ]
    
    var currentQuestion = 0
    
    var student: Student?

    override func viewDidLoad() {
        super.viewDidLoad()
        displayQuestion()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    func displayQuestion() {
        questionTextView.text = questions[currentQuestion].question
        option1Button.setTitle(questions[currentQuestion].answers[0], for: .normal)
        option2Button.setTitle(questions[currentQuestion].answers[1], for: .normal)
        option3Button.setTitle(questions[currentQuestion].answers[2], for: .normal)
    }

    
    @IBAction func option1Button(_ sender: UIButton) {
        
        guard let profileViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
        
        if questions[currentQuestion].correctAnswerIndex == 1 {
            option1Button.backgroundColor = UIColor.green
            // Получаем данные текущего пользователя из массива students
            if let userData = userDefaults.data(forKey: "users"),
               var decodedStudents = try? JSONDecoder().decode([Student].self, from: userData),
               let currentUserIndex = decodedStudents.firstIndex(where: { $0.name == student?.name }) {
                decodedStudents[currentUserIndex].begin = true
                
                // Сохраняем массив students в userDefaults
                if let encodedStudents = try? JSONEncoder().encode(decodedStudents) {
                    userDefaults.set(encodedStudents, forKey: "users")
                    userDefaults.synchronize()
                    
                }
            }
        } else {
            option1Button.backgroundColor = UIColor.red
        }

        currentQuestion += 1
        print(currentQuestion)
        if currentQuestion == questions.count {
            profileViewController.student = student
            self.navigationController?.pushViewController(profileViewController, animated: false)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                option1Button.backgroundColor = UIColor.white
                displayQuestion()
            }
        }
    }
    
    
    @IBAction func option2Button(_ sender: UIButton) {
        
        guard let profileViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
        
        if questions[currentQuestion].correctAnswerIndex == 2 {
            option2Button.backgroundColor = UIColor.green
            // Получаем данные текущего пользователя из массива students
            if let userData = userDefaults.data(forKey: "users"),
               var decodedStudents = try? JSONDecoder().decode([Student].self, from: userData),
               let currentUserIndex = decodedStudents.firstIndex(where: { $0.name == student?.name }) {
                decodedStudents[currentUserIndex].began = true
                
                // Сохраняем массив students в userDefaults
                if let encodedStudents = try? JSONEncoder().encode(decodedStudents) {
                    userDefaults.set(encodedStudents, forKey: "users")
                    userDefaults.synchronize()
                    
                }
            }
        } else {
            option2Button.backgroundColor = UIColor.red
        }

        currentQuestion += 1
        if currentQuestion == questions.count {
            profileViewController.student = student
            self.navigationController?.pushViewController(profileViewController, animated: false)
        }  else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                option2Button.backgroundColor = UIColor.white
                displayQuestion()
            }
        }
        
    }
    
    
    @IBAction func option3Button(_ sender: UIButton) {
        
        guard let profileViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
        
        if questions[currentQuestion].correctAnswerIndex == 3 {
            option3Button.backgroundColor = UIColor.green
            // Получаем данные текущего пользователя из массива students
            if let userData = userDefaults.data(forKey: "users"),
               var decodedStudents = try? JSONDecoder().decode([Student].self, from: userData),
               let currentUserIndex = decodedStudents.firstIndex(where: { $0.name == student?.name }) {
                decodedStudents[currentUserIndex].begun = true
                
                // Сохраняем массив students в userDefaults
                if let encodedStudents = try? JSONEncoder().encode(decodedStudents) {
                    userDefaults.set(encodedStudents, forKey: "users")
                    userDefaults.synchronize()
                    
                }
            }
        } else {
            option3Button.backgroundColor = UIColor.red
        }

        currentQuestion += 1
        if currentQuestion == questions.count {
            profileViewController.student = student
            self.navigationController?.pushViewController(profileViewController, animated: false)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                option3Button.backgroundColor = UIColor.white
                displayQuestion()
            }
        }
       
    }
}
