//
//  ViewController.swift
//  Machinestalk
//
//  Created by Adel on 2/22/23.
//

import UIKit
import Combine

class EventsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var allEventsIcon: UIImageView!
    @IBOutlet weak var savedEventsIcon: UIImageView!
    @IBOutlet var iconsStack: [UIImageView]!
    @IBOutlet weak var savedEventsLabel: UnderlinedLabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var allEventsLabel: UnderlinedLabel!
    // MARK: - Properties
    
    var viewModel = EventViewModel()
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {

        super.viewDidLoad()
        observeResults()
        setupTableView()
        tableView.roundCorners(corners: [.topLeft,.topRight])
        updateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cancellable = nil
    }

    //Wem make use of this function to observe when the api request is complete
    func observeResults() {
        cancellable = viewModel.$eventsResult
            .sink { _ in 
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    }
    
    // Here remains the logic upon switching between the segment control index
    func updateView() {
        let index = segmentControl.selectedSegmentIndex
        [allEventsIcon, savedEventsIcon].forEach{$0?.tintColor = .lightGray}
        savedEventsLabel.clearStyle()
        allEventsLabel.clearStyle()
        if index == 0 {
            // We request the livedatafrom the api
            viewModel.performRequestFor()
            [allEventsLabel, viewTitle].forEach{$0?.text = AllEventsTabBarString }
            allEventsIcon.tintColor = .white
            
        } else {
            // otherwise we fetch previously stored data in local
            //we are using the same event array to display live and local events
            viewModel.reset()
            viewModel.loadFavoriteData()
            [savedEventsLabel, viewTitle].forEach{$0?.text = SavedEventsTabBarString }
            savedEventsIcon.tintColor = .white
        }
    }
    
    func storeFewElementsInFavorite() {
        if !viewModel.eventsResult.isEmpty {
            let fewElements = viewModel.eventsResult[0...2]
            fewElements.forEach{viewModel.addToPersistent(event: $0)}
        }
    }
    
    @IBAction func segmentControlClick(_ sender: UISegmentedControl) {
        updateView()
        }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.registerNibCell(.eventLine)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:
                   Int) -> Int
    {
        return viewModel.eventsResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: .eventLine, for: indexPath) as? EventViewCell
        let model = viewModel.eventsResult[indexPath.row]
        cell?.setupCell(with: model)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
}





