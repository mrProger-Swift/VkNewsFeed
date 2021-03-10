//
//  NewsfeedViewController.swift
//  WallNewsVK
//
//  Created by User on 08.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
    
    private var titleView = TitleView()
    let headerInset: CGFloat = 50
    
    
    @IBOutlet weak var table: UITableView!
    var interactor: NewsfeedBusinessLogic?
    var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
    var feedCellLayoutCalculatorlSizes: FeedCellLayoutCalculator?
    var photos = [FeedCellPhotoAttachmentViewModel]()
    
    var gradientLayers: CAGradientLayer! {
        didSet{
            gradientLayers.startPoint = CGPoint(x: 0, y: 0)
            gradientLayers.endPoint = CGPoint(x: 0, y: 1)
            gradientLayers.colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        }
    }
    
    private var feetViewModel = FeetViewModel.init(cells: [])
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = NewsfeedInteractor()
        let presenter = NewsfeedPresenter()
        let router = NewsfeedRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        table.register(UINib(nibName: NewsFeedCell.reusableId, bundle: nil),
                       forCellReuseIdentifier: NewsFeedCell.reusableId)
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: .getUser)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        gradientLayers = CAGradientLayer()
        view.layer.insertSublayer(gradientLayers, at: 0)
        topBar()
    }
    
    private func topBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel{
        case .displayNewsFeed(feedViewModel: let feedViewModel ):
            self.feetViewModel = feedViewModel
            table.reloadData()
        case .displayUser(let userViewModel):
            titleView.setAvatar(viewModel: userViewModel)
        }
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayers.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feetViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reusableId,
                                                 for: indexPath) as! NewsFeedCell
        let cellViewModel = feetViewModel.cells[indexPath.row]
        cell.setdata(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellviewModel = feetViewModel.cells[indexPath.row]
        return cellviewModel.sizes.totalHeight
    }
}
