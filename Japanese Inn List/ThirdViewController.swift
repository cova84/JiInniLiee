//
//  ThirdViewController.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/11/16.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.


import UIKit
import CoreData


class ThirdViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var favoriteTableView: UITableView!

    //toDitailセグエ用　plistの配列を保存するメンバ変数
    var getKeyDic = NSDictionary()
    //セル内の情報を保存するメンバ変数
    var selectPinKeyDic = NSDictionary()
    
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
                let id :String? = result.value(forKey:"id") as? String
                
                let dic = ["id":id!,"hotel":hotel!,"country":country!] as [String : Any]
                print("hotel:\(hotel) hotel:\(hotel!) country:\(country!) ")
                contentHotel.append(dic as NSDictionary)

            }
        }catch{
        }
        //TODO:おかゆままテスト
        //let test = ["id":"106","hotel":"わわわ","country":"ジャパン"]
        //contentHotel.append(test as NSDictionary)
        
        favoriteTableView.reloadData()
    }
    
    
    //TODO:スクロール改善後、動作確認。-----------------------------------------------------------------
    //TODO:本当は、削除設定カスタムセルにボタンをつけたい---------------------------------------------------
    
    @IBAction func tapAllDelete(_ sender: UIButton) {
        
        //部品となるアラート作成
        let alert = UIAlertController(
            title: "All Delete", message: "全ての登録が削除されます。よろしいですか？", preferredStyle: .alert)
        
        //アラートの表示
        //completion: 動作が完了した後に発動される処理を指示
        //present(alert, animated: true, completion: nil)
        present(alert, animated: true, completion: {() -> Void in print("選択画面が表示されました。")})
        
        //アラートにOKボタンを追加
        //handler : OKボタンが押された時に、行いたい処理に指定する場所
        //alert.addAction(UIAlertAction(title: "OPPAI", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in print("OKが押されました。")
        
            //AppDelegate使う準備をする（インスタンス化）
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            //エンティティを操作する為のオブジェクトを作成
            let viewContext = appDelegate.persistentContainer.viewContext
            //どのエンティティからデータを取得するか設定（Favoriteエンティティ）
            let query:NSFetchRequest<Favorite> = Favorite.fetchRequest()
    
            //削除したデータを取得（今回は全て取得）
            do{
                //削除するデータを取得(今回は全て)
                let fetchResulte = try viewContext.fetch(query)
                //１行ずつ（取り出した上で）削除
                for result:AnyObject in fetchResulte{
                    //削除処理を行うために型変換
                    let record = result as! NSManagedObject
                    viewContext.delete(record)
                }
                //削除した状態を保存
                try viewContext.save()
            }catch{
            }
            //再読み込み
            self.read()
        }))
    }

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
    
    //セルがタップされた時のイベント
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Key(ディクショナリー型で)値の保存
        let hotelDic = contentHotel[indexPath.row]
        let key = hotelDic["id"] as! String
        let dic = readPlist(key:key)
        print(dic)
        selectPinKeyDic = dic as! NSDictionary

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
    
    func readPlist(key: String) -> NSDictionary? {
        //plistの読み込み02--------------------------------------------------------
        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
        let path = Bundle.main.path(forResource: "hotel_list_Detail", ofType: "plist")
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: path!)
        
        return dic![key] as! NSDictionary
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

