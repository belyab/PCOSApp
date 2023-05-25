import Foundation

class UserModel: NSObject, NSCoding {
   
    let name: String
    let begin: Bool
    let begun: Bool
    let began: Bool
    
    init(name: String, begin: Bool, begun: Bool, began: Bool) {
        self.name = name
        self.begin = begin
        self.begun = begun
        self.began = began
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(begin, forKey: "begin")
        coder.encode(begun, forKey: "begun")
        coder.encode(began, forKey: "began")
       }
       
       required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
           begin = (coder.decodeObject(forKey: "begin") != nil)
           begun = (coder.decodeObject(forKey: "begun") != nil)
           began = (coder.decodeObject(forKey: "began") != nil)
       }
}

final class UserSettings {
    
    private enum SettingsKeys: String {
        case userName
        case userModel
    }
    
    static var userModel: UserModel! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.userModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserModel else { return nil }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userModel.rawValue
            
            if let userModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    print("value: \(userModel) was added to key \(key)")
                    defaults.set(savedData, forKey: key)
                } else {
                    defaults.removeObject(forKey: key)
                }
            }
        }
    }
    
    static var userName: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
        } set {
            
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userName.rawValue
            if let name = newValue {
                print("value: \(name) was added to key \(key)")
                defaults.set(name, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userName: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
        } set {
            
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userName.rawValue
            if let name = newValue {
                print("value: \(name) was added to key \(key)")
                defaults.set(name, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
