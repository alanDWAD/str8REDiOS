//
//  OverallLeagueVC.swift
//  str8REDiOSV002
//
//  Created by Alan Tingey on 07/07/2017.
//  Copyright © 2017 Alan Tingey. All rights reserved.
//

import UIKit



struct Player {
    let name : String
    var score : String
}


class OverallLeagueVC: UITableViewController {
    
  var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://str8red.com/jsonoverallleaderboard/current/"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print("there was an error")
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [[String]]
                    self.players = parsedData.map { Player(name: $0[0], score: $0[1]) }
                    print(self.players.count)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()

    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        
        
        if self.players.count == 0 {
            return self.players.count
        }
        else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let player = self.players[indexPath.row]
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = NumberFormatter.localizedString(from: NSNumber(value: Int(player.score)!), number: NumberFormatter.Style.decimal)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Overall Leaderboard:"
    }
    


}
