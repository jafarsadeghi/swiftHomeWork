struct ToDO {
    var title = ""
    var content = ""
    var priority = ""
    
    var description: String {
        return "\"\(title)\" | content: \(content) | with priority \"\(priority)\""
    }
}
enum Commands:String {
    case create = "create"
    case all = "all"
    case edit = "edit"
    case delete = "delete"
}

func print_all_objects() {
    print("List of all objects:\n")
    for (index,todo) in all_todos.enumerated() {
        print("\(index): \(todo.description)")
    }
}

func test() {
    var temp:ToDO = ToDO(title:"ali",content:"with content",priority:"5")
    all_todos.append(temp)
    temp = ToDO(title:"hasan",content:"with content888",priority:"5")
    all_todos.append(temp)
    print_all_objects()
}

func edit_menu(obj:inout ToDO){
    let edit_menu_str = "Edit Menu:\ntitle <title> --> edit title\ncontent <content> --> edit content\n" +
            "priority <priority> --> edit priority\n"
    while true {
        print(edit_menu_str)
        let command = "title changed_title".components(separatedBy: " ") //readLine().components(separatedBy: " ")
        switch command[0] {
            case "title":
                obj.title = command[1]
            case "content":
                obj.content = command[1]
            case "priority":
                obj.priority = command[1]
            default:
                print("fuck u")
        }
        break
    }
}


var all_todos = [ToDO]()

let main_menu = "To Do App\nCommands:\n\(Commands.create) <title> <content> <priority> --> create new To do\n" + 
            "\(Commands.all) --> see all Todos\n" +
            "\(Commands.edit) <id> --> Edit menu\n\(Commands.delete) <id>\n"

while true {
    test()
    print(main_menu)
    let command = "delete 0".components(separatedBy: " ") //readLine().components(separatedBy: " ")

    switch command[0] {
        case Commands.create.rawValue:
            var temp:ToDO = ToDO(title:command[1],content:command[2],priority:command[3])
            all_todos.append(temp)
            print_all_objects()
        case Commands.all.rawValue:
            print_all_objects()
        case Commands.edit.rawValue:
            edit_menu(obj:&all_todos[Int(command[1])!])
            print_all_objects()
        case Commands.delete.rawValue:
            all_todos.remove(at:Int(command[1])!)
            //should we remove obj too?
            print_all_objects()
        default:
            print("fukc u")
    }
    break
}
