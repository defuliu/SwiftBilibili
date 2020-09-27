//
//  HomeMainViewController.swift
//  SwiftBilibili
//
//  Created by luowen on 2020/9/4.
//  Copyright © 2020 luowen. All rights reserved.
//

import UIKit

import JXSegmentedView

/// 首页主控制器
final class HomeMainViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        refresh()

        ConfigAPI.adList.request()
            .mapObject(AdInfoModel.self)
            .subscribe { (_) in

            }
            .disposed(by: disposeBag)

    }

    // MARK: Private Method
    private func refresh() {
        segmentedDataSource.titles = ["猴哥", "青蛙王子", "旺财","猴哥", "青蛙王子", "旺财","猴哥", "青蛙王子", "旺财"]
    }

    // MARK: Super Method
    override func resetTheme() {
        themeService.attrsStream
            .subscribe(onNext: {[weak self] (theme) in
                guard let self = self else { return }
                self.indicator.indicatorColor = theme.mainColorModel.pi5
                self.segmentedDataSource.titleNormalColor = theme.mainColorModel.ba0
                self.segmentedDataSource.titleSelectedColor = theme.mainColorModel.pi5
            })
            .disposed(by: rx.disposeBag)
    }

    override func setupUI() {
        view.addSubview(segmentedView)

    }

    override func setupConstraints() {
        segmentedView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(88)
            $0.height.equalTo(36)
        }
    }

    // MARK: Lazy Load
    lazy var segmentedView = JXSegmentedView().then {
        $0.delegate = self
        $0.dataSource = segmentedDataSource
        $0.indicators = [indicator]
    }

    lazy var indicator = JXSegmentedIndicatorLineView().then {
        $0.isIndicatorWidthSameAsItemContent = true
        $0.indicatorWidthIncrement = 4
    }

    lazy var segmentedDataSource: JXSegmentedTitleDataSource = {
        let segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.isItemSpacingAverageEnabled = false
        segmentedDataSource.itemSpacing = 30
        segmentedDataSource.titleNormalFont = UIFont.systemFont(ofSize: 14)
        segmentedDataSource.titleSelectedFont = UIFont.systemFont(ofSize: 15)
        return segmentedDataSource
    }()

}

// MARK: Delegate
// MARK: JXSegmentedViewDelegate
extension HomeMainViewController: JXSegmentedViewDelegate {

}