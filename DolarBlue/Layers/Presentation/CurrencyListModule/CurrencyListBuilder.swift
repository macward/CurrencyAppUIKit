//
//  CurrencyListBuilder.swift
//  DolarBlue
//
//  Created by Max Ward on 09/08/2022.
//

import Foundation

class CurrencyListBuilder {
    
    class func build() -> CurrencyListViewController {
        
        let repository = CurrencyRepositoryDefault(remoteDataSource: CurrencyRemoteDataSource(),
                                                   localDataSource: CurrencyLocalDataSoruce())
        
        let useCase = CurrencyUseCaseDefault(repository: repository)
        let interactor = CurrencyListInteractorDefault(useCase: useCase)
        let presenter = CurrencyListPresenterDefault()
        
        let viewController = CurrencyListViewController(presenter: presenter)
        
        presenter.view = viewController
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return viewController
        
    }
}
