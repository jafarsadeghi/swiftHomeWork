import Foundation

let MAIN_MENU = 
            "-----------------------------------\n" + 
            "To Do App\n" +
            "Use \(Commands.exit) in every menu to return to next menu\n" +
            "Commands:\n" + 
            "\(Commands.create) <title> <content> <priority> --> create new To do\n" +
            "\(Commands.all) --> see all Todos\n\(Commands.delete) <id>\n" +
            "\(Commands.edit) <id> --> Edit menu\n" +
            "\(Commands.group) --> Group menu\n" +
            "\(Commands.order) --> change ordering\n" +
            "-----------------------------------";

let LIST_MENU = 
            "-----------------------------------\n" + 
            "List Menu:\n" +
            "all --> see all lists\n" +
            "make <name> --> make a list with name\n" +
            "add <todo_id> <list_id> --> add todo item to a group\n" +
            "check <todo_id> --> see todo list name\n" +
            "-----------------------------------"; 

let ORDER_MENU =
            "-----------------------------------\n" +
            "Oredr Menu:\n" +
            "priority asc\n" +
            "priority des\n" +
            "created_time asc\n" +
            "created_time des\n" +
            "title asc\n" +
            "title des\n" +
            "------------------------------------";

enum Commands: String {
    case create = "create"
    case all = "all"
    case edit = "edit"
    case delete = "delete"
    case group = "group"
    case order = "order"
    case exit = "exit"
}

struct ToDo: Equatable {
    var title = ""
    var content = ""
    var priority = ""
    var time_created = NSDate()
    
    var description: String {
        return "\"\(title)\" | content: \(content) | with priority \"\(priority)\""
    }
}

struct List {
    var todos = [ToDo]()
    var name = ""
    var description: String {
        return "\"\(name)\" | number of ToDos: \(todos.count)"
    }
}

var all_todos = [ToDo]()
var lists = [List]()


func is_unique(array: [ToDo], new_item: ToDo) -> Bool {
    for item in array {
        if item.title == new_item.title {
            return false
        }
    }
    return true
}

// //uniqueness of list name
// extension List where ToDo: Equatable {
//     var unique: [ToDo] {
//         var uniqueValues: [ToDo] = []
//         forEach { item in
//             guard !is_unique(array:uniqueValues,new_item:item) else { return }
//             uniqueValues.append(item)
//         }
//         return uniqueValues
//     }
// }


func print_objects(todos: [ToDo]) {
    print("Objects:")
    for (index, todo) in todos.enumerated() {
        print("\(index): \(todo.description)")
    }
}

func edit_menu(obj: inout ToDo){
    edit_while: while true {
        let EDIT_MENU =
              "-----------------------------------\n" +
              "Edit Menu:\n" +
              "\(obj.description)\n" +
              "title <title> --> edit title\n" +
              "content <content> --> edit content\n" +
              "priority <priority> --> edit priority" +
              "-----------------------------------";

        print(EDIT_MENU)
        let command = readLine()!.components(separatedBy: " ")
        switch command[0] {
            case "title":
                obj.title = command[1]
                print(obj)
                
            case "content":
                obj.content = command[1]
            case "priority":
                obj.priority = command[1]
            case "exit":
                break edit_while
            default:
                print("fuck u")
        }
    }
}

func list_menu(){
    list_while: while true {
        print(LIST_MENU)
        let input_string = readLine(); 
        if input_string == nil {
          print("Please enter something!");
          continue;
        }
        let command = input_string!.components(separatedBy: " ")
        switch command[0] {
            case "all":
                for list in lists {
                  print_objects(todos: list.todos)
                }
            case "make":
                let temp = List(name: command[1])
                lists.append(temp)
                for list in lists {
                  print_objects(todos: list.todos)
                }
            case "add":
                let group_id = Int(command[2])!
                let todo_id = Int(command[1])!
                lists[group_id].todos.append(all_todos[todo_id])
            case "check":
                let todo_id = Int(command[1])!
                let todo = all_todos[todo_id] 
                for list in lists{
                    if list.todos.contains(todo){
                        print("\(todo.title) is in \(list.name) list")
                        break
                    }
                }
            case "exit":
                break list_while
            default:
                print("fuk u")
        }
    }
}

 func order_menu(){
    order_while: while true{
        print(ORDER_MENU)
        let command = readLine()!.components(separatedBy: " ")
        switch command[0] {
            case "priority":
                if command[1]=="asc"{
                    all_todos.sort{$0.priority < $1.priority}
                    print_objects(todos: all_todos)
                }else{
                    all_todos.sort{$0.priority > $1.priority}
                    print_objects(todos: all_todos)
                }
            case "created_time":
                if command[1]=="asc"{
                    all_todos.sort{$0.time_created < $1.time_created}
                    print_objects(todos: all_todos)
                }else{
                    all_todos.sort{$0.time_created > $1.time_created}
                    print_objects(todos: all_todos)
                }
            case "title":
                if command[1]=="asc"{
                    all_todos.sort{$0.title < $1.title}
                    print_objects(todos: all_todos)
                }else{
                    all_todos.sort{$0.title > $1.title}
                    print_objects(todos: all_todos)
                }
            case "exit":
                break order_while
            default:
                print("your command is not correct, try again!")
            }
        }
    }


app: while true {
    print(MAIN_MENU)
    let command = readLine()!.components(separatedBy: " ")
    switch command[0] {
        case Commands.create.rawValue:
            let temp: ToDo = ToDo(title:command[1], content:command[2], priority:command[3])
            all_todos.append(temp)
        case Commands.all.rawValue:
            print_objects(todos: all_todos)
        case Commands.edit.rawValue:
            edit_menu(obj:&all_todos[Int(command[1])!])
        case Commands.delete.rawValue:
            all_todos.remove(at:Int(command[1])!)
            //should we remove obj too?
        case Commands.group.rawValue:
            list_menu()
        // case Commands.order.rawValue:
        //     order_menu()
        //     print_objects(all_todos)
        case Commands.order.rawValue:
            order_menu()
        case "exit":
            break app
        default:
            print("fukc u")
    }
}