import Foundation
import UIKit

class GameCell: UITableViewCell {
    static let reuseID = "GameCell"
}

class GameListViewController: UITableViewController {
    let dataSource = GameDataSource.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.reuseID)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.all.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let game = dataSource.all[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.reuseID, for: indexPath)
        cell.textLabel?.text = game.title
           
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = dataSource.all[indexPath.row]
        let vc = GameViewController(game: game)
        navigationController?.pushViewController(vc, animated: true)
    }
}
