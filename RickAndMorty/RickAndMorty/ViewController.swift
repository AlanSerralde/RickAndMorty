//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Diplomado on 01/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView! /*{
        didSet {
           tableViewOutlet.register(UINib(nibName: "RickAndMortyTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }*/
    
    let restClient = RESTClient<PaginatedResponse<Character>>(client: Client("https://rickandmortyapi.com"))
    
    var currentPage: Int = 1
    
    var queryPage: [String: String] = ["page": "2"]
    
    var characters: [Character]? {
        didSet {
            tableViewOutlet.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        tableViewOutlet.dataSource = self
        //
        //        restClient.show("api/Character") { response in
        //            self.characters = response.results
        //            print(response.results)
        tableViewOutlet.prefetchDataSource = self
        tableViewOutlet.dataSource = self
        
        restClient.show("/api/character/"/*, query: ["page": "2"]*/) { response in
            self.characters = response.results
            
        }
        
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RickAndMortyTableViewCell
        
//        cell?.ImgCellOutlet
//        cell?.nameLabelCellOutlet.text = characters?[indexPath.row].name
//        cell?.speciesLabelCellOutlet.text = characters?[indexPath.row].species
//        cell?.idLabelCellOutlet.text = "\(String(describing: characters?[indexPath.row].id))"
        
        cell.textLabel?.text = characters?[indexPath.row].name
        cell.detailTextLabel?.text = characters?[indexPath.row].species
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let characters = characters else { return }
        let loadParameter = indexPaths.contains { $0.row >= characters.count - 1 }
        
        if loadParameter {
                restClient.show("/api/character/", queryParams: queryPage) { response in
                    self.characters?.append(contentsOf: response.results)
                }
                currentPage += 1
                queryPage = ["page":"\(currentPage)"]
            }
        }
    }

