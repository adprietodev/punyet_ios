//
//  ListPlayersViewController.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import UIKit

class ListPlayersViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var titlePlayButtonView: UIView!
    @IBOutlet weak var titlePlayButtonLabel: UILabel!
    @IBOutlet weak var winOrPayView: UIStackView!
    @IBOutlet weak var winOrPayLabel: UILabel!
    @IBOutlet weak var winOrPayImageView: UIImageView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var playAgainView: UIView!
    @IBOutlet weak var playAgainLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: ListPlayersViewModelProtocol!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configureData()
        setupUI()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - IBActions
    @IBAction func playOrNewPlayers(_ sender: Any) {
        viewModel.goToCoinSelection()
    }
    

    // MARK: - Functions
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        switch viewModel.gameState {
        case .addPlayers:
            titlePlayButtonLabel.text = "JUGAR"
        case .playing:
            titlePlayButtonLabel.text = "SIGUIENTE RONDA"
        case .finish:
            playersTableView.isHidden = true
            winOrPayView.isHidden = false
            winOrPayLabel.text = "Te toca pagar Adrián"
            winOrPayLabel.textColor = .yaleBlue
            winOrPayLabel.font = .robotoMedium(with: 24)
            titlePlayButtonLabel.text = "NUEVOS JUGADORES"
            playAgainLabel.text = "VOLVER A JUGAR"
            titlePlayButtonLabel.textColor = .yaleBlue
            playAgainView.isHidden = false
        }
        roundView.layer.cornerRadius = 6
        roundView.backgroundColor = .goldenYellow
        roundLabel.textColor = .yaleBlue
        roundLabel.font = .robotoBold(with: 20)
        playAgainView.layer.cornerRadius = 6
        playAgainView.backgroundColor = .goldenYellow
        playAgainLabel.textColor = .yaleBlue
        playAgainLabel.font = .robotoBold(with: 20)
    }

    func configureTableView() {
        playersTableView.delegate = self
        playersTableView.dataSource = self
        playersTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        playersTableView.register(UINib(nibName: "TotalCoinsTableViewCell", bundle: nil), forCellReuseIdentifier: "TotalCoinsTableViewCell")
        playersTableView.register(UINib(nibName: "AddPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "AddPlayerTableViewCell")
    }
}

extension ListPlayersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .addPlayer,.totalCoins:
            return 1
        case .inGame:
            return viewModel.getPlayers(are: .playing).count
        case .classified:
            return viewModel.getPlayers(are: .cassified).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sections[indexPath.section] {
        case .addPlayer:
            let cell = playersTableView.dequeueReusableCell(withIdentifier: "AddPlayerTableViewCell", for: indexPath) as! AddPlayerTableViewCell
            cell.setupCell()
            return cell
        case .totalCoins:
            let cell = playersTableView.dequeueReusableCell(withIdentifier: "TotalCoinsTableViewCell", for: indexPath) as! TotalCoinsTableViewCell
            cell.setupCell(totalCoins: viewModel.getTotalCoins())
            return cell
        case .inGame:
            let cell = playersTableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
            let player = viewModel.getPlayers(are: .playing)[indexPath.row]
            cell.setupCell(player: player, indexPlayer: indexPath.row, statePlayer: .playing, gameState: viewModel.gameState)
            return cell
        case .classified:
            let cell = playersTableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
            let player = viewModel.getPlayers(are: .cassified)[indexPath.row]
            cell.setupCell(player: player, indexPlayer: indexPath.row, statePlayer: .cassified, gameState: viewModel.gameState)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[indexPath.section] {
        case .addPlayer,.totalCoins:
            return 24
        case .classified,.inGame:
            return 32
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch viewModel.sections[section] {
        case .addPlayer, .totalCoins:
            return nil
        case .classified, .inGame:
            return viewModel.sections[section].rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel.sections[section] == .classified || viewModel.sections[section] == .inGame else {
            return nil
        }
        
        let headerView = UIView()
        let titleSection = UILabel()
        titleSection.translatesAutoresizingMaskIntoConstraints = false
        titleSection.font = UIFont.boldSystemFont(ofSize: 18)
        titleSection.textColor = .yaleBlue
        titleSection.textAlignment = .center
        titleSection.text = viewModel.sections[section].rawValue
        
        headerView.addSubview(titleSection)
        NSLayoutConstraint.activate([
            titleSection.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0),
            titleSection.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0),
            titleSection.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleSection.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.sections[section] {
        case .addPlayer, .totalCoins:
            return 0
        case .classified, .inGame:
            return 24
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
