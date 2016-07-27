//
//  ViewModel.swift
//  SwiftMVVM
//
//  Created by liyang on 16/7/27.
//  Copyright © 2016年 SwiftMVVM. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


/**
 
 The MVVM pattern's view model protocol
 -
 */
public protocol ViewModelType {
    
    /**
     Get the view model bound RxSwift DisposeBag object
     - returns:
     An instance object of DisposeBag
     */
    var disposeBag:DisposeBag { get }
    
    /**
     Get view model reloaded event publish subject
     */
    var rx_reloaded:PublishSubject<Void> { get }
    
    /**
     Get view model's error event publish subject
     */
    var rx_error:PublishSubject<ErrorType> { get }
}


/**
 reloadable view model
 */
public protocol ReloadableViewModelType {
    
    func reload()
    
}

/**
 default implement of reloadable view model
 */
public extension ReloadableViewModelType {
    func reload() { }
}


/**
 list view model type which support pullDownRefresh and pullUpRefresh methods
 */
public protocol ListViewModelType:ReloadableViewModelType {
    
    func pullDownRefresh()
    
    func pullUpRefresh()
}

/**
 default implement of ListViewModelType
 */
public extension ListViewModelType {
    
    func reload() { pullDownRefresh() }
    
    func pullDownRefresh() {}
    
    func pullUpRefresh() {}
}

/**
 the view model base class
 */
public class ViewModel:ViewModelType, ReloadableViewModelType {
    /**
     Get the view model bound RxSwift DisposeBag object
     - returns:
     An instance object of DisposeBag
     */
    lazy public var disposeBag:DisposeBag = DisposeBag()
    
    /**
     Get view model reloaded event publish subject
     */
    lazy public var rx_reloaded:PublishSubject<Void> = PublishSubject<Void>()
    
    /**
     Get view model's error event publish subject
     */
    lazy public var rx_error:PublishSubject<ErrorType>  = PublishSubject<ErrorType>()
    
    /**
     fire error event
     */
    internal func onError(error:ErrorType) {
        rx_error.onNext(error)
    }
    
    /**
     fire reloaded event
     */
    internal func onReloaded() {
        rx_reloaded.onNext()
    }
}

public extension Observable {
    /**
     call doOnError adn bindNext with view model
     */
    public func doOnViewModel(viewModel:ViewModelType,onNext: E -> Void){
        self.doOnError { error in
            viewModel.rx_error.onNext(error)
        }.bindNext(onNext).addDisposableTo(viewModel.disposeBag)
    }
}
