//  DetailView.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/11/16.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.

import UIKit
import MapKit
import Foundation

class DetailView:UIViewController, UITableViewDataSource, UITableViewDelegate{//ここのエラーはテーブルビュー設定後消えるはず
    
    //plistの読み込み01--------------------------------------------------------
    //選択されたエリア名を保存するメンバ変数。前の画面から受け取る為のプロパティ
    var getKeyDic = NSDictionary()
    var keyList:[String] = []
    var dataList:[NSDictionary] = []

//宿情報タイトル〜住所-----------------------------------------------------------------------
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelComment: UITextView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBAction func tapFacorites(_ sender: UIButton) {
    }
    @IBOutlet weak var hotelMap: MKMapView!
    @IBOutlet weak var hotelAddress: UITextView!

////詳細情報-----------------------------------------------------------------------
    @IBOutlet weak var detailedInfoTableView: UITableView!
////予約方法-----------------------------------------------------------------------
    @IBOutlet weak var reservationTabelView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //plistの読み込み02--------------------------------------------------------
        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
        let path = Bundle.main.path(forResource: "hotel_list_Detail", ofType: "plist")

//TODO:使うか不明？
        //TableView Cellの高さ可変設定/
        detailedInfoTableView.estimatedRowHeight = 26
        detailedInfoTableView.rowHeight = UITableViewAutomaticDimension
        
//        //ホテル名
//        hotelName.text = getKeyDic["hotelName"] as! String
//        //紹介コメント
//        hotelComment.text = getKeyDic["comment"] as! String
//        hotelComment.sizeToFit()          // 文字数に合わせて縦に伸びます。
//
//        //TODO:01 画像を５枚入れてスワイプで切り替えたい(ライブラリ探し中)
//        //        hotelImageView.image = UIImage(named:getKeyDic["image"] as! String)
//
//        //TODO:02 お気に入りに追加のコード必要-------------------------------------------------
//
//        //地図
//        let latitude = getKeyDic["latitude"] as! String
//        let longitude = getKeyDic["longitude"] as! String
//        //座標オブジェクト
//        //型変換が必要。String型〜Double型へ。atof()でくくると変わる。
//        let coodineate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
//        //縮尺を設定
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        //範囲オブジェクトを作成
//        let region = MKCoordinateRegionMake(coodineate, span)
//        //地図にセット
//        hotelMap.setRegion(region,animated: true)
//        // 1.pinオブシェクトを生成（）内は不要
//        let myPin = MKPointAnnotation()
//        // 2.pinの座標を設定
//        myPin.coordinate = coodineate
//        // 3.タイトル、サブタイトルを設定（タップした時に出る、吹き出しの情報）
//        myPin.title = "\(hotelName)"
//        // 4.mapViewにPinを追加
//        hotelMap.addAnnotation(myPin)
//
//        //住所
//        hotelAddress.text = getKeyDic["address"] as! String
//        hotelAddress.sizeToFit() // 文字数に合わせて縦に伸びます。
    }

    //TableView行数の設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return 10
        default:
            return 8
        }
    }

    
    //TableView表示する文字列を決定（テーブルビュー２つ）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 1:
            switch indexPath.row {
            case 0:
                let detailedCell_G = tableView.dequeueReusableCell(withIdentifier: "DetailedCell_G", for: indexPath)
                detailedCell_G.textLabel?.text = "宿泊費（詳細情報はHPからご確認ください。）"
                return detailedCell_G
            case 1:
                let detailedCell_W = tableView.dequeueReusableCell(withIdentifier: "DetailedCell_W", for: indexPath)
                detailedCell_W.textLabel?.text = getKeyDic["accommodation"] as! String
                detailedCell_W.layoutIfNeeded()  //テスト////////////////
                return detailedCell_W
            case 2:
                let detailedCell_G = tableView.dequeueReusableCell(withIdentifier: "DetailedCell_G", for: indexPath)
                detailedCell_G.textLabel?.text = "部屋数"
                return detailedCell_G
            case 3:
                let detailedCell_W = tableView.dequeueReusableCell(withIdentifier: "DetailedCell_W", for: indexPath)
                detailedCell_W.textLabel?.text = "全\(getKeyDic["rooms"] as! String)部屋"
                return detailedCell_W
            case 4:
                let detailedCell_G = tableView.dequeueReusableCell(withIdentifier: "DetailedCell_G", for: indexPath)
                detailedCell_G.textLabel?.text = "Wi-Fi"
                return detailedCell_G
            case 5:
                let detailedCell_W = tableView.dequeueReusableCell(withIdentifier: "DetailedCell_W", for: indexPath)
                detailedCell_W.textLabel?.text = getKeyDic["wifi"] as! String
                return detailedCell_W
            case 6:
                let detailedCell_G = tableView.dequeueReusableCell(withIdentifier: "DetailedCell_G", for: indexPath)
                detailedCell_G.textLabel?.text = "送迎"
                return detailedCell_G
            case 7:
                let detailedCell_W = tableView.dequeueReusableCell(withIdentifier: "DetailedCell_W", for: indexPath)
                detailedCell_W.textLabel?.text = getKeyDic["pickup"] as! String
                return detailedCell_W
            case 8:
                let detailedCell_G = tableView.dequeueReusableCell(withIdentifier: "DetailedCell_G", for: indexPath)
                detailedCell_G.textLabel?.text = "施設設備"

                return detailedCell_G
            default:
                let detailedCell_W = tableView.dequeueReusableCell(withIdentifier: "DetailedCell_W", for: indexPath)
                detailedCell_W.textLabel?.text = getKeyDic["equipment"] as! String
                return detailedCell_W
            }
            
        default:
            switch indexPath.row {
            case 0:
                let reservation_G = tableView.dequeueReusableCell(withIdentifier: "ReservationCell_G", for: indexPath)
                reservation_G.textLabel?.text = "予約方法（リンクのHPよりご確認ください。）"
                return reservation_G
            case 1:
                let reservationCell_W = tableView.dequeueReusableCell(withIdentifier: "ReservationCell_W", for: indexPath)
                reservationCell_W.textLabel?.text = getKeyDic["reservation"] as! String
                //リンク　getKeyDic["reservation_URL"] as! String
                return reservationCell_W
            case 2:
                let reservation_G = tableView.dequeueReusableCell(withIdentifier: "ReservationCell_G", for: indexPath)
                reservation_G.textLabel?.text = "TEL"
                return reservation_G
            case 3:
                let reservationCell_W = tableView.dequeueReusableCell(withIdentifier: "ReservationCell_W", for: indexPath)
                reservationCell_W.textLabel?.text = getKeyDic["tel"] as! String
                return reservationCell_W
            case 4:
                let reservation_G = tableView.dequeueReusableCell(withIdentifier: "ReservationCell_G", for: indexPath)
                reservation_G.textLabel?.text = "E-Mail"
                return reservation_G
            case 5:
                let reservationCell_W = tableView.dequeueReusableCell(withIdentifier: "ReservationCell_W", for: indexPath)
                reservationCell_W.textLabel?.text = getKeyDic["email"] as! String
                return reservationCell_W
            case 6:
                let reservation_G = tableView.dequeueReusableCell(withIdentifier: "ReservationCell_G", for: indexPath)
                reservation_G.textLabel?.text = "公式HP"
                return reservation_G
            default:
                let reservationCell_W = tableView.dequeueReusableCell(withIdentifier: "ReservationCell_W", for: indexPath)
                reservationCell_W.textLabel?.text = getKeyDic["url"] as! String
                return reservationCell_W
            }
        }
    }
    
    
    
    
    //TODO:オートレイアウト謎のエラー？？？
//    //オートレイアウトの設定。下の順番で発動
//    //1.estimatedHeightForRowAtIndexPath セルの大体の位置を決める
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = generateCell(tableView, indexPath: indexPath)
//        return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
//    }
//
//    //2.heightForRowAtIndexPathで、初めて、ちゃんとした正確なセルのフレームをセット
//    //estimatedHeightForRowAtIndexPathで得た前情報とheightForRowAtIndexPathで得た値が離れている場合,エラーの危険性あり。（ものすごくずれる。上で返す値は、出来る限り０に近くする。）
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//        return generateCell(tableView, indexPath: indexPath)
//    }
//
//    //3.heightForRowAtIndexPath
//    //cellにデータを詰めるのはcellForRowAtIndexPath
//    //前段階で同じ型のセルに同じデータを当てはめて,高さを計算する必要あり。
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    func generateCell(tableView: UITableView, indexPath: NSIndexPath) -> VariableTableViewCell {
//        let cell: DetailedCell_W = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as! DetailedCell_W
//        let entity: Entity = array[indexPath.row]
//        cell.setValue(entity)
//        cell.contentView.layoutIfNeeded()
//
//        return cell
//    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

