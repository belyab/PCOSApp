import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var begin: Bool
    @NSManaged public var begun: Bool
    @NSManaged public var began: Bool

}

extension Student : Identifiable {

}
