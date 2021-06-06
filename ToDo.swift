import Foundation

struct ToDO {
    var title = ""
    var content = ""
    var priority = ""
    var time_created = NSDate()
    
    var description: String {
        return "\"\(title)\" | content: \(content) | with priority \"\(priority)\""
    }
}

struct List {
    var todos = [ToDO]()
    var name = ""
    var description: String {
        return "\"\(name)\" | number of ToDos: \(todos.count)"
    }
}

enum Commands:String {
    case create = "create"
    case all = "all"
    case edit = "edit"
    case delete = "delete"
    case group = "group"
    case order = "order"
    case exit = "exit"
}

func is_unique(array:[ToDo],new_item:ToDO){
    for item in array {
        if item.name == new_item.name{
            return false
        }
    }
    return true
}

//uniqueness of list name
extension List where ToDO: Equatable {
    var unique: [ToDO] {
        var uniqueValues: [ToDO] = []
        forEach { item in
            guard !is_unique(array:uniqueValues,new_item:item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}


func print_objects(array:[T]) {
    print("Objects:\n")
    for (index,todo) in all_todos.enumerated() {
        print("\(index): \(todo.description)")
    }
}

func edit_menu(obj:inout ToDO){
    let edit_menu_str = "Edit Menu:\n\(obj.description)\ntitle <title> --> edit title\ncontent <content> --> edit content\n" +
            "priority <priority> --> edit priority\n"
    while true {
        print(edit_menu_str)
        let command = readLine().components(separatedBy: " ")
        switch command[0] {
            case "title":
                obj.title = command[1]
            case "content":
                obj.content = command[1]
            case "priority":
                obj.priority = command[1]
            case "exit":
                break
            default:
                print("fuck u")
        }
    }
}

func list_menu(){
    let list_menu_str = "List Menu:\nall --> see all lists\nmake <name> --> make a list with name\n" +
            "add <todo_id> <list_id> --> add todo item to a group\n"
    while true {
        print(list_menu_str)
        let command = readLine().components(separatedBy: " ")
        switch command[0] {
            case "all":
                print_objects(lists)
            case "make":
                var temp = List(name:command[1],todos:[List]())
                lists.append(temp)
                print_objects(lists)
            case "add":
                var group_id = Int(command[2])!
                var todo_id = Int(command[1])!
                lists[group_id].todos.append(all_todos[todo_id])
            case "exit":
                break
            default:
                print("fuk u")
        }
    }
}

func order_menu(){
    print("Order By:\n1.Time created\t2.Title\t3.Priority\nEnter choice : ")
    var type = Int(readLine())!
    print("Ordering Type:\n1.Ascending\t2.Descending\nEnter choice : ")
    var ascending = Int(readLine())! == 1 ? true ? false
    switch type {
        case 1:
            all_todos = sort(all_todos,{s1, s2 in 
            if ascending{
                return s1.time_created > s2.time_created
            }
            else {
                return s1.time_created < s2.time_created
            }
            })
        case 2:
            all_todos = sort(all_todos,{s1, s2 in 
            if ascending{
                return s1.title > s2.title
            }
            else {
                return s1.title < s2.title
            }
            })
        case 3:
            all_todos = sort(all_todos,{s1, s2 in 
            if ascending{
                return s1.priority > s2.priority
            }
            else {
                return s1.priority < s2.priority
            }
            })
    }

}

var all_todos = [ToDO]()
var lists = [List]()

let main_menu = "To Do App\nUse \(Commands.exit) in every menu to return to next menu\nCommands:\n" + 
            "\(Commands.create) <title> <content> <priority> --> create new To do\n" +
            "\(Commands.all) --> see all Todos\n\(Commands.delete) <id>\n" +
            "\(Commands.edit) <id> --> Edit menu\n" +
            "\(Commands.group) --> Group menu\n" +
            "\(Commands.order) --> change ordering\n"

while true {
    print(main_menu)
    let command = readLine().components(separatedBy: " ")

    switch command[0] {
        case Commands.create.rawValue:
            var temp:ToDO = ToDO(title:command[1],content:command[2],priority:command[3],time_created:NSDate())
            all_todos.append(temp)
            print_objects(all_todos)
        case Commands.all.rawValue:
            print_objects(all_todos)
        case Commands.edit.rawValue:
            edit_menu(obj:&all_todos[Int(command[1])!])
            print_objects(all_todos)
        case Commands.delete.rawValue:
            all_todos.remove(at:Int(command[1])!)
            //should we remove obj too?
            print_objects(all_todos)
        case Commands.group.rawValue:
            list_menu()
        case Commands.order.rawValue:
            order_menu()
            print_objects(all_todos)
        case "exit":
            break
        default:
            print("fukc u")
    }
}
