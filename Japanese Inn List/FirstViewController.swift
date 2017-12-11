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
    
    //タップされたtopTableViewの配列を格納するメンバ変数
    var contentHotel:[NSDictionary] = []

    //選択されたエリア名を保存するメンバ変数
    var keyList:[String] = []
    var dataList:[NSDictionary] = []
    
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
        
        //TODO;リスト完成後再入力
        area.append((title: "北アメリカ"    , details: [    000,    100], extended: false,category:1))
        area.append((title: "中南米"    , details: [    200,    210,    220,    230], extended: false,category:1))
        area.append((title: "アジア（北〜東〜東南アジア）"    , details: [    700,    710,    800,    810,    820,    830], extended: false,category:1))
        area.append((title: "アジア（中央〜南〜西アジア）"    , details: [    900,    1100,    1200], extended: false,category:1))
        //area.append((title: "アジア（予備）"    , details: [], extended: false,category:1))
        area.append((title: "アフリカ"    , details: [    500,    510], extended: false,category:1))
        area.append((title: "ヨーロッパ"    , details: [    300,    310,    330,    340,    350,    360,    370,    380,    390,    400,    410,    420,    430], extended: false,category:1))
        area.append((title: "オーストラリア・オセアニア"    , details: [    1300,    1310], extended: false,category:1))
        
        
        
        country.append((title: "アメリカ",no:    000    , details: [    001,    002,    003,                                        ], extended: false,category:2))
        country.append((title: "カナダ",no:    100     , details: [    101,    102,    103,    104,    105,    106,    107,    108 ], extended: false,category:2))
        country.append((title: "ジャマイカ",no:    200     , details: [    201,    202,                                              ], extended: false,category:2))
        country.append((title: "グアテマラ",no:    210     , details: [    211,    212,    213,    214,                              ], extended: false,category:2))
        country.append((title: "パラグアイ",no:    220     , details: [    221,                                                     ], extended: false,category:2))
        country.append((title: "チリ",no:    230     , details: [    231,                                                           ], extended: false,category:2))
        country.append((title: "フランス",no:    300     , details: [    301,    302,    303,                                        ], extended: false,category:2))
        country.append((title: "イギリス",no:    310     , details: [    311,    312,    313,    314,    315,    316,    317,    318,    319,    320,    321,    322,    323,    324,                            ], extended: false,category:2))
        country.append((title: "スペイン",no:    330     , details: [    330,    331,    332,    333,    334,    335                ], extended: false,category:2))
        country.append((title: "ポルトガル",no:    340     , details: [    334,                                                      ], extended: false,category:2))
        country.append((title: "ドイツ",no:    350     , details: [    335,    336,                                                 ], extended: false,category:2))
        country.append((title: "スイス",no:    360     , details: [    337,    338,    339,                                         ], extended: false,category:2))
        country.append((title: "ポーランド",no:    370     , details: [    340,                                                       ], extended: false,category:2))
        country.append((title: "ハンガリー",no:    380     , details: [    341,    342,    343,                                       ], extended: false,category:2))
        country.append((title: "オランダ",no:    390     , details: [    344,                                                         ], extended: false,category:2))
        country.append((title: "スペイン",no:    400     , details: [    330,    331,    332,    333,    334,    335,                 ], extended: false,category:2))
        country.append((title: "クロアチア",no:    410     , details: [    351,    352,    353,                                        ], extended: false,category:2))
        country.append((title: "ベルギー",no:    420     , details: [    361,                                                          ], extended: false,category:2))
        country.append((title: "イタリア",no:    430     , details: [    371,    372,    373,    374,    375,    376,    377,    378,  ], extended: false,category:2))
        country.append((title: "タンザニア",no:    500     , details: [    501,                                                         ], extended: false,category:2))
        country.append((title: "エジプト",no:    510     , details: [    511,                                                           ], extended: false,category:2))
        country.append((title: "中国",no:    700     , details: [    701,    702,                                                      ], extended: false,category:2))
        country.append((title: "台湾",no:    710     , details: [    711,    712,    713,                                              ], extended: false,category:2))
        country.append((title: "カンボジア",no:    800     , details: [    801,    802,                                                  ], extended: false,category:2))
        country.append((title: "タイ",no:    810     , details: [    811,    812,    813,    814,    815,                               ], extended: false,category:2))
        country.append((title: "フィリピン",no:    820     , details: [    821,    822,    823,    824,                                  ], extended: false,category:2))
        country.append((title: "インドネシア",no:    830     , details: [    831,    832,    833,                                         ], extended: false,category:2))
        country.append((title: "ネパール",no:    900     , details: [    901,    902,    903,    904,                                     ], extended: false,category:2))
        country.append((title: "キルギス",no:    1100     , details: [    1101,                                                           ], extended: false,category:2))
        country.append((title: "トルコ",no:    1200     , details: [    1201,                                                             ], extended: false,category:2))
        country.append((title: "オーストラリア",no:    1300     , details: [    1301,                                                      ], extended: false,category:2))
        country.append((title: "ニュージーランド",no:    1310     , details: [    1311,    1312,    1313,    1314,    1315,    1316,        ], extended: false,category:2))
        
        
        
        //plistの読み込み--------------------------------------------------------
        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
        let path1 = Bundle.main.path(forResource: "hotel_list_Detail", ofType: "plist")
        //ファイルの内容を読み込んでディクショナリー型に格納
        let hotelDetailDic = NSDictionary(contentsOfFile: path1!)
        
        
        for (key,data) in hotelDetailDic! {
            keyList.append(key as! String)

            let dic = hotelDetailDic![key]! as! NSDictionary
            let hotelNameDic = dic["hotelName"]! as! String
            let idDic = dic["id"]! as! String
            let idNum = Int(atof(idDic))

            inn.append((
                title: "\(hotelNameDic)"
                , no: idNum
                , details: []
                , extended: false
                , category: 3
            ))

            contentHotel.append(dic as NSDictionary)
        
        }
        
        //最初はエリアだけを表示するためエリアのみを表示用の配列に保存しておく
        viewData = area
        
    }

    
    
    //セルがタップされた時のイベント
    func topTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //okayumemo Favoriteデータから読出ししたデータを取り出し
        let hotelDic = contentHotel[indexPath.row]
        let key = hotelDic["id"] as! String
        
        print(hotelDic)

        
        // 000の時はセグエ発動しなくて良い
        if key != "000" {
            //Key(ディクショナリー型で)Plistから取り出し
            let dic = readPlist(key:key)
            print(dic)
            selectHototelDetailDic = dic as! NSDictionary
            
            //セグエのidentifierを指定して、画面移動
            performSegue(withIdentifier: "toDetail", sender: self)

        }
    }

    
    
    //セグエを使って画面移動する時発動
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
        //次の画面のインスタンスを取得
        var dvc:DetailView = segue.destination as! DetailView
        //次の画面のプロパティにタップされたセルのkeyを渡す
        dvc.getKeyDic = selectHototelDetailDic
    }
    
    
    
    func readPlist(key: String) -> NSDictionary? {
        //plistの読み込み02--------------------------------------------------------
        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
        let path = Bundle.main.path(forResource: "hotel_list_Detail", ofType: "plist")
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: path!)
        
        print("\(dic)")
        
        return dic![key] as? NSDictionary
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


