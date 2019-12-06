//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

enum SearchScope {
    case name
    case artist
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var songData = [Song]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var currentScope = SearchScope.name
    
    var searchQuery = "" {
        didSet{
            switch currentScope {
            case .name:
                songData = Song.loveSongs.filter
                    {$0.name.lowercased().contains(searchQuery.lowercased())}
            case .artist:
                songData = Song.loveSongs.filter
                    {$0.artist.lowercased().contains(searchQuery.lowercased())}
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let SongDetailController = segue.destination as? SongDetailController, let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        SongDetailController.songDetail = songData[indexPath.row]
    }

    func loadData() {
        songData = Song.loveSongs
    }
    
    func searchBarQuery(for userSearch: String) {
        guard !userSearch.isEmpty else { return }
        songData = Song.loveSongs.filter {$0.name.lowercased().contains(searchQuery.lowercased())
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let songCell = songData[indexPath.row]
        cell.textLabel?.text = songCell.name
        cell.detailTextLabel?.text = songCell.artist
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
                    loadData()
                    return
                }
                searchQuery = searchText
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .name
        case 1:
            currentScope = .artist
        default:
            print("yea right lol")
        }
    }
}
