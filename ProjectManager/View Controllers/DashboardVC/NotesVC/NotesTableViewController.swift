//
//  NotesTableViewController.swift
//  ProjectManager
//
//  Created by conner on 8/20/20.
//  Copyright © 2020 LambdaStudents. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    static var totalNotes: Int = 0
    
    let reuseIdentifier = "NoteCell"
    
    var noteController = NoteController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        let exampleNote = Note(title: "Todo-List", contents: "1) Need to purchase tools")
        let exampleNote2 = Note(title: "Hello", contents: "Lorem ipsum Aut saepe officiis eaque unde autem aut aut. Voluptatum modi voluptas eos consequatur voluptate dolore modi. Qui fugiat rerum culpa. Suscipit recusandae et sint")
        noteController.addNote(exampleNote)
        noteController.addNote(exampleNote2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        addNoteTotal()
    }
    func addNoteTotal() {
        NotesTableViewController.totalNotes = 0
        for _ in noteController.notes {
            NotesTableViewController.totalNotes += 1
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return noteController.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    // Make the background color show through spacing
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let noteCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NoteTableViewCell {
            noteCell.configureViews(for: noteController.noteAtIndex(indexPath.section))
            cell = noteCell
        }
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            noteController.removeNoteAtIndex(indexPath.row)
            tableView.deleteSections([indexPath.section], with: .fade)
        }
    }
    
    // Set Cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let noteDetailVC = segue.destination as? NoteDetailViewController {
            if segue.identifier == "ViewNoteSegue", let indexPath = tableView.indexPathForSelectedRow {
                noteDetailVC.noteController = noteController
                noteDetailVC.noteController?.selectedTableViewIndex = indexPath.section
            } else if segue.identifier == "AddNoteSegue" {
                noteDetailVC.noteController = noteController
                noteDetailVC.noteController?.selectedTableViewIndex = nil
            }
        }
    }
}

