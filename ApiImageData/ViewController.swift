//
//  ViewController.swift
//  ApiImageData
//
//  Created by Naing Linn Aung on 10/1/22.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var heros = [HeroStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Heros"
        view.backgroundColor = .systemBackground
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = heros[indexPath.row].localized_name.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heros.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController {
            destination.hero = heros[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(complted: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.heros = try JSONDecoder().decode([HeroStats].self, from: data!)
                    DispatchQueue.main.async {
                        complted()
                    }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
        
    }

}

