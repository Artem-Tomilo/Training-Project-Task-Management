import Foundation

/*
 ProjectStubErrors - перечисление возможных ошибок для экрана Список проектов
 
 parameters:
 message - текст ошибки, показывающийся в алерте
 */

enum ProjectStubErrors: Error {
    case noSuchProject, addProjectFailed, editProjectFailed, deleteProjectFailed
    
    var message: String {
        switch self {
        case .noSuchProject:
            return "Не удалось получить проект"
        case .addProjectFailed:
            return "Не удалось добавить проект"
        case .editProjectFailed:
            return "Не удалось отредактировать проект"
        case .deleteProjectFailed:
            return "Не удалось удалить проект"
        }
    }
}
