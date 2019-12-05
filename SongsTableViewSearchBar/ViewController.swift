//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var songData = [Song]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchQuery = "" {
        didSet{
            searchBarQuery()
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
    
    func searchBarQuery() {
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
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
                    searchBarQuery()
                    loadData()
                    return
                }
                searchQuery = searchText
    }
}
