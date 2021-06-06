struct ToDO {
    var title = ""
    var content = ""
    var priority = ""
    
    var description: String {
        return "\"\(title)\" | content: \(content) | with priority \"\(priority)\""
    }
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

let main_menu = "To Do App\nCommands:\ncreate <title> <content> <priority> --> create new To do\nall --> see all Todos\n" +
            "edit <id> --> Edit menu\ndelete <id>\n"



while true {
    test()
    print(main_menu)
    let command = "delete 0".components(separatedBy: " ") //readLine().components(separatedBy: " ")

    switch command[0] {
        case "create":
            var temp:ToDO = ToDO(title:command[1],content:command[2],priority:command[3])
            all_todos.append(temp)
            print_all_objects()
        case "see":
            print_all_objects()
        case "edit":
            edit_menu(obj:&all_todos[Int(command[1])!])
            print_all_objects()
        case "delete":
            all_todos.remove(at:Int(command[1])!)
            //should we remove obj too?
            print_all_objects()
        default:
            print("fukc u")
    }
    break
}
