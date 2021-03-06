//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    
    var notes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDateHelper.retrieveNotes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
//        cell.textLabel?.text = "Cell Row: \(indexPath.row) Section: \(indexPath.section)"
        let note = notes[indexPath.row]
        cell.noteTitleLabel.text = note.title
        cell.noteModificationTimeLabel.text = note.modificationTime?.convertToString() ?? "unknown"
        
        return cell
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard let identifier = segue.identifier else {return}

        switch identifier {
        case "displayNote":
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            let note = notes[indexPath.row]
            let destination = segue.destination as! DisplayNoteViewController
            destination.note = note
        case "addNote":
            print("create note bar button item tapped")
        default:
            print("unexpected segue identifier")
        }

    }
    override func tableView(_ tableViw: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //notes.remove(at: indexPath.row)
            let noteToDelete = notes[indexPath.row]
            CoreDateHelper.delete(note: noteToDelete)
            
            notes = CoreDateHelper.retrieveNotes()
        }
        
    }
    
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        notes = CoreDateHelper.retrieveNotes()
        
    }
    
    
    
}
