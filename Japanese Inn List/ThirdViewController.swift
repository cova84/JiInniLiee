//
//  ThirdViewController.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/11/16.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.


import UIKit
import CoreData //フレームワーク追加！！！！！！


class ThirdViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var favoriteTableView: UITableView!

    //選択されたエリア名を保存するメンバ変数
    var getKeyDic = NSDictionary()
    var selectPinKeyDic = NSDictionary()
    var keyList:[String] = []
    var dataList:[NSDictionary] = []
    
    //Favorite（内容を）格納する配列TabelViewを準備
    var contentHotel:[NSDictionary] = []
    var contentCountry:[NSDictionary] = []
    var contentID:[NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //CoreDataを読み込む処理
        read()
    }
    
    //すでに存在するデータの読み込み処理
    func read() {
        
        //一旦からにする（初期化）
        contentHotel = []
        //AppDelegateを使う用意をしておく
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //エンティティを操作する為のオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        //どのエンティティからデータを取得してくるか設定（Favoriteエンティティ）
        let query:NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do{
            //データを一括取得
            let fetchResults = try viewContext.fetch(query)
            
            //きちんと保存できてるか、１行ずつ表示（デバックエリア）
            for result: AnyObject in fetchResults{
                let hotel :String? = result.value(forKey:"hotel") as? String
                let country :String? = result.value(forKey:"country") as? String
                var id :String? = result.value(forKey:"id") as? String
                var dic = ["hotel":hotel,"country":country] as [String : Any]
                print("hotel:\(hotel!) country:\(country!) ")
                contentHotel.append(dic as NSDictionary)
                
                //TODO:idをカスタムクラスに保存
                //var id = getKeyCore()
            }
        }catch{
        }
        favoriteTableView.reloadData()
    }
    
    
    //TODO:削除設定カスタムセルにボタンをつける--------------------------------------------------------------------------------------
    //    @IBAction func tapDelete(_ sender: UIButton) {
    //
    //        //AppDelegate使う準備をする（インスタンス化）
    //        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //
    //        //エンティティを操作する為のオブジェクトを作成
    //        let viewContext = appDelegate.persistentContainer.viewContext
    //
    //        //どのエンティティからデータを取得するか設定（Favoriteエンティティ）
    //        let query:NSFetchRequest<Favorite> = Favorite.fetchRequest()
    //
    //        //削除したデータを取得（今回は全て取得）
    //        do{
    //            //削除するデータを取得(今回は全て)
    //            let fetchResulte = try viewContext.fetch(query)
    //
    //            //１行ずつ（取り出した上で）削除
    //            for result:AnyObject in fetchResulte{
    //
    //                //削除処理を行うために型変換
    //                let record = result as! NSManagedObject
    //                viewContext.delete(record)
    //            }
    //
    //            //削除した状態を保存
    //            try viewContext.save()
    //
    //        }catch{
    //        }
    //
    //        //再読み込み
    //        read()
    //
    //    }
    ////TODO:削除設定--------------------------------------------------------------------------------------
    
    //TabelView用処理
    //行数の決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentHotel.count
    }
    
    //リストに表示する文字列を決定し、表示（cellForRowAtを検索）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //文字列を表示するセルの取得（セルの再利用）
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! customCellTableViewCell
        //表示したい文字の設定（セルの中には文字、画像も入る）
        var dic = contentHotel[indexPath.row] as! NSDictionary
        //文字を設定したセルを返す
        return cell
    }
    
    
    ///TODO:ここの設定が必要
    //セルがタップされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Key(ディクショナリー型で)値の保存
        var dic:getKeyCore = contentHotel[indexPath.row] as! NSDictionary

        
        
        selectPinKeyDic =
        //セグエのidentifierを指定して、画面移動
        performSegue(withIdentifier: "toDetail", sender: self)
    }

    //セグエを使って画面移動する時発動
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
        //次の画面のインスタンスを取得
        var dvc = segue.destination as! DetailView
        //次の画面のプロパティにタップされたセルのkeyを渡す
        dvc.getKeyDic = selectPinKeyDic
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}








//    //セルがタップされた時
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//        var dic = contentHotel[indexPath.row] as! NSDictionary
//        performSegue(withIdentifier: "toDetail", sender: nil)
//    }
//
//    //セグエのidentifierを指定して、画面移動
//    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//}
//
