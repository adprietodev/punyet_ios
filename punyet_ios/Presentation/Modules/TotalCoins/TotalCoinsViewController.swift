//
//  TotalCoinsViewController.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 5/6/24.
//

import UIKit

class TotalCoinsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var askView: UIStackView!
    @IBOutlet weak var askTotalCoinsLabel: UILabel!
    @IBOutlet weak var totalCoinsTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var winView: UIStackView!
    @IBOutlet weak var playersButtonView: UIView!
    @IBOutlet weak var playersButtonLabel: UILabel!
    @IBOutlet weak var awardView: UIView!
    
    // MARK: - Properties
    var viewModel: TotalCoinsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigation()
        setupGesture()
    }

    // MARK: - IBActions
    @IBAction func searchTotalCoinsInPlayers(_ sender: Any) {
        guard let totalNumberText = totalCoinsTextField.text, let totalNumber = Int(totalNumberText), !totalNumberText.isEmpty else {
            showAlertForEmptyFields()
            return
        }
        if let player = viewModel.isAWinner(number: totalNumber) {
            markPlayerAsWinner(player: player)
        } else {
            markPlayersAsNotWinners()
        }
        askView.isHidden = true
        winView.isHidden = false
        playersButtonView.isHidden = false
    }

    @IBAction func goToListPlayers(_ sender: Any) {
        viewModel.goToListPlayers()
    }

    // MARK: - Functions
    func showAlertForEmptyFields() {
        let alert = UIAlertController(title: "No hay numero", message: "No has insertado ningún numero", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func setupUI() {
        askTotalCoinsLabel.text = "¿Cuantas monedas hay en la mesa?"
        askTotalCoinsLabel.textColor = .yaleBlue
        askTotalCoinsLabel.font = .robotoBold(with: 24)
        searchView.backgroundColor = .royalAzure
        searchView.layer.cornerRadius = 6
        searchLabel.text = "Buscar"
        searchLabel.textColor = .white
        searchLabel.font = .robotoMedium(with: 16)
        winLabel.textColor = .yaleBlue
        winLabel.font = .robotoBold(with: 24)
        playersButtonView.backgroundColor = .goldenYellow
        playersButtonView.layer.cornerRadius = 8
        playersButtonLabel.textColor = .yaleBlue
        playersButtonLabel.text = "JUGADORES"
        playersButtonLabel.font = .robotoBold(with: 20)
        
    }

    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func markPlayersAsNotWinners() {
        awardView.isHidden = true
        winLabel.text = "No hay ganador..."
    }

    func markPlayerAsWinner(player: Player) {
        winLabel.text = "¡\(player.name) has ganado!"
    }

    func configureNavigation() {
        self.navigationItem.title = "PUNYET"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.robotoBold(with: 20), NSAttributedString.Key.foregroundColor: UIColor.yaleBlue ]
        self.navigationItem.hidesBackButton = true
    }
}
