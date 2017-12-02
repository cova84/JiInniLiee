//
//  ParentsTableViewCell.swift
//  Expandable3
//
//  Created by MAC241 on 11/05/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.


import UIKit

class ParentsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageviewBackground: UIImageView!
    @IBOutlet weak var constraintLeadingLabelParent: NSLayoutConstraint!
    @IBOutlet weak var labelParentCell: UILabel!
    
    @IBOutlet weak var buttonState: UIButton!
    
    //plistの読み込み01--------------------------------------------------------
    //選択されたエリア名を保存するメンバ変数
    var selectedName = ""
    var keyList:[String] = []
    var dataList:[NSDictionary] = []
    
    //TODO:ck1 super.viewDidLoad()必要ない？
//    override func viewDidLoad() {
//        super.viewDidLoad()
    
    override func awakeFromNib() {
        super.awakeFromNib ()

        //plistの読み込み02--------------------------------------------------------
        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
        let path = Bundle.main.path(forResource: "hotel_list_Top", ofType: "plist")
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: path!)
        
        //TableView で扱いやすい配列の形(エリア名の入っている配列)を作成
        for (key,data) in dic! {
            
//            print(key)
//            print(data)
            keyList.append(key as! String)
            let detailInfo = dic![key] as! NSDictionary
            /* NSDictionaryからキー指定で取り出すと必ずAnyになるので、Dictionary型だと教えてやらないといけないので、ダウンキャスト必須 */
            
            dataList.append(detailInfo)
            
        imageviewBackground.layer.cornerRadius = 2.0
        imageviewBackground.layer.masksToBounds = true
        }
    }


//大陸色分け表示--------------------------------------------------------
//引数　indexParam: String, を削除
    func cellFillUp(continentTop: String) {

        //配列内の数字を
//        var rgbString = hotel_list_Top["red","green","blue"]
//
//        let red = hotel_list_Top["red"] as! String
//        let green = hotel_list_Top["green"] as! String
//        let blue = hotel_list_Top["blue"] as! String
//
//        let rgb = UIColor(atof(red), atof(green), atof(blue))

//        if continentTop == "北アメリカ" {
//            labelParentCell.text = "北アメリカ"
//            imageviewBackground.backgroundColor = UIColor(
//                red: CGFloat(atof(red)/255.0)
//                , green: 37/255.0
//                , blue: 255/255.0
//                , alpha: 1.0
//            )
        
        if continentTop == "北アメリカ" {
            labelParentCell.text = "北アメリカ"
            imageviewBackground.backgroundColor = UIColor(
                  red: 248/255.0
                , green: 37/255.0
                , blue: 255/255.0
                , alpha: 1.0
            )
        }else if continentTop == "中南米" {
            labelParentCell.text = "中南米"
            imageviewBackground.backgroundColor = UIColor(
                  red: 246/255.0
                , green: 49/255.0
                , blue: 241/255.0
                , alpha: 1.0
            )
        }else if "continentTop" == "ヨーロッパ" {
            labelParentCell.text = "ヨーロッパ"
            imageviewBackground.backgroundColor = UIColor(
                  red: 16/255.0
                , green: 107/255.0
                , blue: 20/255.0
                , alpha: 1.0
            )
        }else if continentTop == "アフリカ" {
            labelParentCell.text = "アフリカ"
            imageviewBackground.backgroundColor = UIColor(
                  red: 255/255.0
                , green: 193/255.0
                , blue: 37/255.0
                , alpha: 1.0
            )
        }else if continentTop == "アジア（北〜東〜東南アジア）" {
            labelParentCell.text = "アジア（北〜東〜東南アジア）"
            imageviewBackground.backgroundColor = UIColor(
                  red: 42/255.0
                , green: 37/255.0
                , blue: 255/255.0
                , alpha: 1.0
            )
        }else if continentTop == "アジア（中央〜西〜南アジア）" {
            labelParentCell.text = "アジア（中央〜西〜南アジア）"
            imageviewBackground.backgroundColor = UIColor(
                red: 39/255.0
                , green: 162/255.0
                , blue: 255/255.0
                , alpha: 1.0
            )
        }else if continentTop == "オーストラリア・オセアニア" {
            labelParentCell.text = "オーストラリア・オセアニア"
            imageviewBackground.backgroundColor = UIColor(
                red: 28/255.0
                , green: 190/255.0
                , blue: 34/255.0
                , alpha: 1.0
            )
        }
        labelParentCell.textColor = UIColor.white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
