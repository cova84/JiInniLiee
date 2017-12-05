//
//  FirstViewController.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/11/16.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.
//


import UIKit

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //toDitailセグエ用　plistの配列を保存するメンバ変数
    var getKeyDic = NSDictionary()
    //セル内の情報を保存するメンバ変数
    var selectPinKeyDic = NSDictionary()
    
    @IBOutlet weak var topTableView: UITableView!
    var area:[(title: String, details: [Int], extended: Bool,category:Int)] = []

    var country:[(title: String, no:Int, details: [Int], extended: Bool,category:Int)] = []

    var inn:[(title: String, no:Int, details: [Int], extended: Bool,category:Int)] = []

    //表示専用の配列
    var viewData:[(title: String, details: [Int], extended: Bool,category:Int)] = []


    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //動きを確認するのに必要なデータの作成
        createData()

    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //文字列を表示するセルの取得（セルの再利用）
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        //表示したい文字の設定
        cell.textLabel?.text = viewData[indexPath.row].title

        //文字を設定したセルを返す
        return cell
    }


    /// MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if viewData[indexPath.row].category == 3{
            //宿の場合、別画面に遷移するなどの処理を記載する
            print(viewData[indexPath.row].title)
        }else{
            //開閉処理
            if viewData[indexPath.row].extended {
                //閉じる
                viewData[indexPath.row].extended = false
                var changeRowNum = createViewData(indexNumber: indexPath.row)

                self.toContract(tableView, indexPath: indexPath,changeRowNum: changeRowNum)
            }else{
                //開く
                viewData[indexPath.row].extended = true

                var changeRowNum = createViewData(indexNumber: indexPath.row)

                self.toExpand(tableView, indexPath: indexPath,changeRowNum: changeRowNum)
            }

        }
    }

    /// close details.
    ///
    /// - Parameter tableView: self.tableView
    /// - Parameter indexPath: NSIndexPath
    fileprivate func toContract(_ tableView: UITableView, indexPath: IndexPath, changeRowNum:Int) {
        let startRow = indexPath.row + 1
        let endRow = indexPath.row + changeRowNum + 1

        var indexPaths: [IndexPath] = []
        for i in startRow ..< endRow {
            indexPaths.append(IndexPath(row: i , section:indexPath.section))
        }

        tableView.deleteRows(at: indexPaths,
                             with: UITableViewRowAnimation.fade)
    }

    /// open details.
    ///
    /// - Parameter tableView: self.tableView
    /// - Parameter indexPath: NSIndexPath
    fileprivate func toExpand(_ tableView: UITableView, indexPath: IndexPath, changeRowNum:Int) {
        let startRow = indexPath.row + 1
        let endRow = indexPath.row + changeRowNum + 1

        var indexPaths: [IndexPath] = []
        for i in startRow ..< endRow {
            indexPaths.append(IndexPath(row: i, section:indexPath.section))
        }

        tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)

        // scroll to the selected cell.
        tableView.scrollToRow(at: IndexPath(
            row:indexPath.row, section:indexPath.section),
                              at: UITableViewScrollPosition.top, animated: true)
    }

    func createViewData(indexNumber:Int)->Int{

        var changeNum = 0
        //開閉状態を一旦別変数へ退避
        let previousViewData = viewData

        viewData = []

        var pNumber = 0
        var skipNumber = 0
        for data in previousViewData{
            if pNumber < indexNumber {
                viewData.append(data)
            }

            if indexNumber == pNumber {
                viewData.append(data)
                if previousViewData[pNumber].extended{
                    //開く（子データ追加）
                    var ids = previousViewData[pNumber].details

                    //エリアの場合は紐づく国を追加
                    if previousViewData[pNumber].category == 1 {

                        for deach in ids{
                            for ceach in country{
                                if ceach.no == deach{
                                    viewData.append((title: ceach.title,details:ceach.details,extended:false,category:2))
                                    changeNum += 1
                                }
                            }

                        }


                    }

                    //国の場合は紐づく宿を追加
                    if previousViewData[pNumber].category == 2 {

                        for deach in ids{
                            for ieach in inn{
                                if ieach.no == deach{
                                    viewData.append((title: ieach.title,details:ieach.details,extended:false,category:3))
                                    changeNum += 1
                                }
                            }

                        }


                    }

                }else{
                    //閉じる（子データの削除）
                    //スキップするデータ数を計算
                    var sindex = 0
                    for sdata in previousViewData{
                        if sindex > pNumber {
                            if sdata.category > previousViewData[pNumber].category{
                                skipNumber += 1
                            }else{
                                break
                            }

                        }
                        sindex += 1
                    }

                    changeNum = skipNumber


                }
            }

            print(skipNumber)


            if pNumber > indexNumber {
                if pNumber > indexNumber + skipNumber{
                    viewData.append(data)
                }
            }

            pNumber += 1
        }


        return changeNum
    }

    func createData(){
        area.append((title: "エリア１", details: [1,2], extended: false,category:1))

        area.append((title: "エリア２", details: [11,12,13,14], extended: false,category:1))

        area.append((title: "エリア３", details: [111,112,113,114,115], extended: false,category:1))


        country.append((title: "国1",no:1, details: [21,22], extended: false,category:2))
        country.append((title: "国2",no:2, details: [31,32], extended: false,category:2))

        country.append((title: "国11",no:11, details: [41,42], extended: false,category:2))
        country.append((title: "国12",no:12, details: [51,52], extended: false,category:2))
        country.append((title: "国13",no:13, details: [61,62], extended: false,category:2))
        country.append((title: "国14",no:14, details: [71,72], extended: false,category:2))

        country.append((title: "国111",no:111, details: [141], extended: false,category:2))
        country.append((title: "国112",no:112, details: [151], extended: false,category:2))
        country.append((title: "国113",no:113, details: [161,162,163], extended: false,category:2))
        country.append((title: "国114",no:114, details: [171,172], extended: false,category:2))
        country.append((title: "国115",no:115, details: [171,172], extended: false,category:2))

        inn.append((title: "宿21",no:21, details: [], extended: false,category:3))
        inn.append((title: "宿22",no:22, details: [], extended: false,category:3))
        inn.append((title: "宿31",no:31, details: [], extended: false,category:3))
        inn.append((title: "宿32",no:32, details: [], extended: false,category:3))
        inn.append((title: "宿41",no:41, details: [], extended: false,category:3))
        inn.append((title: "宿42",no:42, details: [], extended: false,category:3))
        inn.append((title: "宿51",no:51, details: [], extended: false,category:3))
        inn.append((title: "宿52",no:52, details: [], extended: false,category:3))
        inn.append((title: "宿61",no:61, details: [], extended: false,category:3))
        inn.append((title: "宿62",no:62, details: [], extended: false,category:3))
        inn.append((title: "宿71",no:71, details: [], extended: false,category:3))
        inn.append((title: "宿72",no:72, details: [], extended: false,category:3))
        inn.append((title: "宿141",no:141, details: [], extended: false,category:3))
        inn.append((title: "宿151",no:151, details: [], extended: false,category:3))
        inn.append((title: "宿161",no:161, details: [], extended: false,category:3))
        inn.append((title: "宿162",no:162, details: [], extended: false,category:3))
        inn.append((title: "宿163",no:163, details: [], extended: false,category:3))
        inn.append((title: "宿171",no:171, details: [], extended: false,category:3))
        inn.append((title: "国172",no:172, details: [], extended: false,category:3))

        //最初はエリアだけを表示するためエリアのみを表示用の配列に保存しておく
        viewData = area
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
