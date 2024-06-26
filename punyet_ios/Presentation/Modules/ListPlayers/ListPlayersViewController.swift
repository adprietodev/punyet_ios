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
    @IBOutlet weak var playOrPlayAgainView: UIView!
    @IBOutlet weak var playOrPlayAgainLabel: UILabel!
    @IBOutlet weak var playOrPlayAgainButton: UIButton!
    @IBOutlet weak var winOrPayView: UIStackView!
    @IBOutlet weak var winOrPayLabel: UILabel!
    @IBOutlet weak var winOrPayImageView: UIImageView!
    
    // MARK: - Properties
    var viewModel: ListPlayersViewModelProtocol!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
        setupBindings()
        disablePlayButton()
        setupGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.configureData()
        setupUI()
        playersTableView.reloadData()
    }

    // MARK: - IBActions
    @IBAction func playOrPlayAgain(_ sender: Any) {
        viewModel.gameState == .finish ? playAgain() : viewModel.goToCoinSelection()
    }

    // MARK: - Functions
    func setupUI() {
        switch viewModel.gameState {
        case .addPlayers:
            playOrPlayAgainLabel.text = "JUGAR"
        case .playing:
            viewModel.changePlayerTurn()
            playOrPlayAgainLabel.text = "SIGUIENTE RONDA"
        case .finish:
            playersTableView.isHidden.toggle()
            winOrPayView.isHidden.toggle()
            winOrPayLabel.text = "Te toca pagar \(viewModel.getLoser())"
            winOrPayLabel.textColor = .yaleBlue
            winOrPayLabel.font = .robotoMedium(with: 24)
            playOrPlayAgainLabel.text = "VOLVER A JUGAR"
            playOrPlayAgainLabel.textColor = .yaleBlue
        }
        
        playOrPlayAgainView.layer.cornerRadius = 6
        playOrPlayAgainView.backgroundColor = .goldenYellow
        playOrPlayAgainLabel.textColor = .yaleBlue
        playOrPlayAgainLabel.font = .robotoBold(with: 20)
    }

    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func disablePlayButton() {
        playOrPlayAgainButton.isEnabled = false
        playOrPlayAgainView.layer.opacity = 0.5
        playOrPlayAgainLabel.layer.opacity = 0.5
    }

    func enablePlayButton() {
        playOrPlayAgainButton.isEnabled = true
        playOrPlayAgainView.layer.opacity = 1
        playOrPlayAgainLabel.layer.opacity = 1
    }

    func setupBindings() {
        viewModel.showAlertExistingPlayer = {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                showAlertExistingPlayer()
            }
        }
        viewModel.reloadInGameSectionTable = {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                playersTableView.reloadSections(IndexSet(integer: 2), with: .automatic)
            }
        }
        viewModel.reloadTotalCoinSectionTable = {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                let indexPath = IndexPath(row: 0, section: 1)
                playersTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        viewModel.enabledOrDisabledPlayButton = { isEnabled in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                isEnabled ? enablePlayButton() : disablePlayButton()
            }
        }
    }

    func configureTableView() {
        playersTableView.delegate = self
        playersTableView.dataSource = self
        playersTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        playersTableView.register(UINib(nibName: "TotalCoinsTableViewCell", bundle: nil), forCellReuseIdentifier: "TotalCoinsTableViewCell")
        playersTableView.register(UINib(nibName: "AddPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "AddPlayerTableViewCell")
    }

    func configureNavigation() {
        self.navigationItem.title = "PUNYET"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.robotoBold(with: 20), NSAttributedString.Key.foregroundColor: UIColor.yaleBlue ]
        self.navigationItem.backBarButtonItem?.isHidden = true
    }

    func playAgain() {
        viewModel.resetGame()
        playersTableView.isHidden.toggle()
        winOrPayView.isHidden.toggle()
        setupUI()
        playersTableView.reloadData()
    }

    func showAlertExistingPlayer() {
        let alert = UIAlertController(title: "Nombre existente", message: "El nombre ya esta en la lista, por favor selecciona otro", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
            return viewModel.getPlayers(are: .classified).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sections[indexPath.section] {
        case .addPlayer:
            let cell = playersTableView.dequeueReusableCell(withIdentifier: "AddPlayerTableViewCell", for: indexPath) as! AddPlayerTableViewCell
            cell.setupCell(delegate: viewModel as! AddPlayerTableViewCellDelegate)
            return cell
        case .totalCoins:
            let cell = playersTableView.dequeueReusableCell(withIdentifier: "TotalCoinsTableViewCell", for: indexPath) as! TotalCoinsTableViewCell
            cell.setupCell(totalCoins: viewModel.getTotalCoins())
            return cell
        case .inGame:
            let cell = playersTableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
            let player = viewModel.getPlayers(are: .playing)[indexPath.row]
            cell.setupCell(player: player, indexPlayer: indexPath.row, statePlayer: .playing, gameState: viewModel.gameState,delegate: viewModel as! PlayerTableViewCellDelegate)
            return cell
        case .classified:
            let cell = playersTableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
            let player = viewModel.getPlayers(are: .classified)[indexPath.row]
            cell.setupCell(player: player, indexPlayer: indexPath.row, statePlayer: .classified, gameState: viewModel.gameState,delegate: viewModel as! PlayerTableViewCellDelegate)
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
