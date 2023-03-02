//
//  CurrencyListViewController.swift
//  DolarBlue
//
//  Created by Max Ward on 07/08/2022.
//

import UIKit

class CurrencyListViewController: UIViewController, CurrencyListView {
    
    var collectionView: UICollectionView!
    var refControl: UIRefreshControl = {
        let refControl = UIRefreshControl()
        refControl.tintColor = UIColor.white
        return refControl
    }()
    
    var presenter: CurrencyListPresenter?
    
    private var currencies: [CurrencyPresentationModel] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    init(presenter: CurrencyListPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.init(named: "Background")
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        title = "Cotizaciones"
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 4

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(UINib(nibName: "CurrencySmallCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyBox")
        collectionView.register(UINib(nibName: "CurrencyFeaturedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedBox")
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(named: "Background")
        collectionView.allowsSelection = false
        
        refControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refControl)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getCurrencies()
    }
    
    func updateCurrencyList(_ currencies: [CurrencyPresentationModel]) {
        self.currencies = currencies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.refControl.endRefreshing()
        }
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
       DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
           DispatchQueue.main.async {
               self.presenter?.getCurrencies()
           }
       }
   }

}

extension CurrencyListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedBox", for: indexPath) as! CurrencyFeaturedCollectionViewCell
            cell.setup(withCurrency: currencies[indexPath.row])
            return cell
        } else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyBox", for: indexPath) as! CurrencySmallCollectionViewCell
        cell.setup(withCurrency: currencies[indexPath.row])
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.row == 0 {
            let height = ((collectionView.bounds.width - 32) / 2) - 4
            return CGSize(width: collectionView.bounds.width - 32, height: height)
        } else {
            let width = ((collectionView.bounds.width - 32) / 2) - 4
            return CGSize(width: width, height: width)
        }
    }
}
