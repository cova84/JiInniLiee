//
//  FirstViewController.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/11/16.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.
//


import UIKit

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //plistの配列を一時保存するメンバ変数
    var selectHototelDetailDic = NSDictionary()
    var selectHototelTopDic = NSDictionary()

    //toDitailセグエ用　plistの配列を保存するメンバ変数
    var getKeyDic = NSDictionary()
    
    
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
        
    
        
//        //plistの読み込み--------------------------------------------------------
//        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
//        let path2 = Bundle.main.path(forResource: "hotel_list_Top", ofType: "plist")
//        //ファイルの内容を読み込んでディクショナリー型に格納
//        let hotelTopDic = NSDictionary(contentsOfFile: path2!)
//        selectHototelTopDic.append(hotelTopDic as NSDictionary)
//
//
//        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
//        let path1 = Bundle.main.path(forResource: "hotel_list_Detail", ofType: "plist")
//        //ファイルの内容を読み込んでディクショナリー型に格納
//        let hotelDetailDic = NSDictionary(contentsOfFile: path1!)
//        selectHototelDetailDic.append(hotelDetailDic as NSDictionary)
//
//
//        let idTop = hotelTopDic!["id"]! as! String
//        let idDetail = hotelDetailDic!["id"]! as! String
    
        
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
                //plistの読み込み--------------------------------------------------------
                //ファイルパスを取得（エリア名が格納されているプロパティリスト）
                let path2 = Bundle.main.path(forResource: "hotel_list_Top", ofType: "plist")
                //ファイルの内容を読み込んでディクショナリー型に格納
                let hotelTopDic = NSDictionary(contentsOfFile: path2!)
                
        
                //ファイルパスを取得（エリア名が格納されているプロパティリスト）
                let path1 = Bundle.main.path(forResource: "hotel_list_Detail", ofType: "plist")
                //ファイルの内容を読み込んでディクショナリー型に格納
                let hotelDetailDic = NSDictionary(contentsOfFile: path1!)
        
        
                let idTop = hotelTopDic!["id"]! as! String
                let idDetail = hotelDetailDic!["id"]! as! String


        //----------------------------------------------------------------------------------------
        //        北アメリカ northAmerican   000-199
        //        中南米   latinAmerica    200-299
        //        アジア（北〜東〜東南アジア）  asia_north_east_southeast 600-899
        //        アジア（中央〜西〜南アジア）    asia_center_west_south  900-1299
        //        アフリカ  africa  500-599
        //        ヨーロッパ europe  300-499
        //        オーストラリア・オセアニア australia_oceania   1300-1399
        //        let northAmericanId = 0 ..< 200
        //        let latinAmericaId = 200 ..< 300
        //        let asia_n_e_seId = 6000 ..< 900
        //        let asia_c_w_sId = 900 ..< 1300
        //        let africaId = 500 ..< 600
        //        let europeId = 300 ..< 500
        //        let australia_oceaniaId = 1300 ..< 1400
        //----------------------------------------------------------------------------------------


        for idTop in 0...200{
            print ("idTop")
        }

        area.append((
              title: "北アメリカ"
            , details: [Int(atof(idTop))]
            , extended: false
            , category: 1
        ))

        country.append((
              title: "\([hotelTopDic!["country"]! as! String])"
            , no: atof(idTop) as! Int
            , details: [Int(atof(idDetail))]
            , extended: false
            , category: 2
        ))

        inn.append((
              title: "\([hotelDetailDic!["hotelName"]! as! String])"
            , no: atof(idDetail) as! Int
            , details: []
            , extended: false
            , category: 3
        ))

        
        
//        area.append((
//              title: "北アメリカ"
//            , details: [hotelTopDic!["北アメリカ"]! as! NSDictionary]
//
//            , extended: false
//            ,category:1
//        ))
//
//        area.append((
//              title: "中南米"
//            , details: [hotelTopDic!["中南米"]! as! NSDictionary]
//            , extended: false
//            ,category:1
//        ))
//
//        area.append((
//              title: "北〜東〜東南アジア"
//            , details: [hotelTopDic!["アジア（北〜東〜東南アジア）"]! as! NSDictionary]
//            , extended: false
//            ,category:1
//        ))
//
//        area.append((
//              title: "中央〜南〜西アジア"
//            , details: [hotelTopDic!["アジア（中央〜西〜南アジア）"]! as! NSDictionary]
//            , extended: false
//            ,category:1
//        ))
//
//
//        area.append((
//              title: "ヨーロッパ"
//            , details: [hotelTopDic!["ヨーロッパ"]! as! NSDictionary]
//            , extended: false
//            ,category:1
//        ))
//
//
//        area.append((
//              title: "アフリカ"
//            , details: [hotelTopDic!["アフリカ"]! as! NSDictionary]
//            , extended: false
//            ,category:1
//        ))
//
//
//        area.append((
//              title: "オーストラリア・オセアニア"
//            , details:[hotelTopDic!["オーストラリア・オセアニア"]! as! NSDictionary]
//            , extended: false
//            ,category:1
//        ))
        
        
        
//        area.append((title: "エリア１", details: [1,2], extended: false,category:1))
//
//        country.append((title: "国1",no:1, details: [21,22], extended: false,category:2))
//        country.append((title: "国2",no:2, details: [31,32], extended: false,category:2))
//
//        inn.append((title: "宿21",no:21, details: [], extended: false,category:3))
//        inn.append((title: "宿22",no:22, details: [], extended: false,category:3))
//        inn.append((title: "宿31",no:31, details: [], extended: false,category:3))
//        inn.append((title: "宿32",no:32, details: [], extended: false,category:3))

        //最初はエリアだけを表示するためエリアのみを表示用の配列に保存しておく
        viewData = area
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
