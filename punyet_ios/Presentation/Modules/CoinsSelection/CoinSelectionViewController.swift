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
    }

    // MARK: - Functions
    func setupUI() {
        namePlayerLabel.textColor = .yaleBlue
        namePlayerLabel.font = .robotoBold(with: 32)
        nextAndFinishView.backgroundColor = .goldenYellow
        nextAndFinishView.layer.opacity = 0.5
        nextAndFinishView.layer.cornerRadius = 6
        nextAndFinishButton.isEnabled = false
        nextAndFinishLabel.text = "SIGUIENTE"
        nextAndFinishLabel.textColor = .yaleBlue
        nextAndFinishLabel.layer.opacity = 0.5
    }

    func setupCollectionView() {
        numbersCollectionView.delegate = self
        numbersCollectionView.dataSource = self
        numbersCollectionView.register(UINib(nibName: "NumberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NumberCollectionViewCell")
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.numbersCoin[indexPath.row].number == 0 {
            return CGSize(width: collectionView.frame.width, height: 100)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
}
