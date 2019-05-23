//
//  URLTableViewController.swift
//  Tab Bar Details
//
//  Created by Denis Bystruev on 23/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class URLTableViewController: UITableViewController {
    
    var lines = [String]()
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let title = tabBarItem.title else { return }
        guard let url = URL(string: "https://\(title)") else { return }
        self.url = url
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            guard let text = String(data: data, encoding: .utf8) else { return }
            self.lines = text.split(separator: "\n").map({ String($0.trimmingCharacters(in: .whitespacesAndNewlines)) }).filter { !$0.isEmpty }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController else { return }
        guard let detailViewController = navigationController.viewControllers.first as? DetailViewController else { return }
        guard let row = tableView.indexPathForSelectedRow?.row else { return }
        if let host = url?.host {
            detailViewController.backButton.title = "< \(host)"
        }
        detailViewController.title = "Line \(row + 1)"
        detailViewController.line = lines[row]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        cell.accessoryType = .disclosureIndicator
        let row = indexPath.row
        let line = lines[row]
        cell.textLabel?.text = "\(row + 1): \(line)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: nil)
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {}
}
