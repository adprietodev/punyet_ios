//
//  CoinSelectionViewController.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 4/6/24.
//

import UIKit

class CoinSelectionViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var namePlayerLabel: UILabel!
    @IBOutlet weak var numbersCollectionView: UICollectionView!
    @IBOutlet weak var nextAndFinishView: UIView!
    @IBOutlet weak var nextAndFinishLabel: UILabel!
    @IBOutlet weak var nextAndFinishButton: UIButton!
    
    // MARK: - Properties
    var viewModel: CoinSelectionViewModelProtocol!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        configureNavigation()
    }

    // MARK: - IBActions
    @IBAction func nextPlayer(_ sender: Any) {
        if nextAndFinishLabel.text == "FINALIZAR" {
            viewModel.goToTotalCoins()
        } else {
            namePlayerLabel.text = viewModel.getNamePlayer()
            guard let namePlayer = namePlayerLabel.text else { return }
            let isLastPlayer = viewModel.isLastPlayerInGame(namePlayer)
            nextAndFinishLabel.text = isLastPlayer ? "FINALIZAR" : "SIGUIENTE"
            numbersCollectionView.reloadData()
            disbleNextPlayerButton()
        }
    }

    // MARK: - Functions
    func setupUI() {
        namePlayerLabel.text = viewModel.getNamePlayer()
        namePlayerLabel.textColor = .yaleBlue
        namePlayerLabel.font = .robotoBold(with: 32)
        nextAndFinishView.backgroundColor = .goldenYellow
        nextAndFinishView.layer.cornerRadius = 6
        nextAndFinishLabel.textColor = .yaleBlue
        nextAndFinishLabel.font = .robotoBold(with: 20)
        disbleNextPlayerButton()
    }

    func setupCollectionView() {
        numbersCollectionView.delegate = self
        numbersCollectionView.dataSource = self
        numbersCollectionView.register(UINib(nibName: "NumberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NumberCollectionViewCell")
    }

    func disbleNextPlayerButton() {
        
        nextAndFinishButton.isEnabled = false
        nextAndFinishView.layer.opacity = 0.5
        nextAndFinishLabel.layer.opacity = 0.5
    }

    func enableNextPlayerButton() {
        nextAndFinishButton.isEnabled = true
        nextAndFinishView.layer.opacity = 1
        nextAndFinishLabel.layer.opacity = 1
    }

    func configureNavigation() {
        self.navigationItem.title = "PUNYET"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.robotoBold(with: 20), NSAttributedString.Key.foregroundColor: UIColor.yaleBlue ]
        self.navigationItem.hidesBackButton = true
    }
}

// MARK: - Extension
extension CoinSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numbersCoin.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCollectionViewCell", for: indexPath) as! NumberCollectionViewCell
        cell.setupCell(numberCoin: viewModel.numbersCoin[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            collectionView.deselectItem(at: selectedIndexPath, animated: true)
        }
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        viewModel.setTotalNumberCoinsAtCurrentPlayer(number: indexPath.row)
        if !nextAndFinishButton.isEnabled {
            enableNextPlayerButton()
        }
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        !viewModel.checkCoinIsSelected(number: indexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.numbersCoin[indexPath.row].number == 0 {
            return CGSize(width: collectionView.frame.width, height: 100)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
}
