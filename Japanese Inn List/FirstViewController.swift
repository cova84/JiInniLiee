//
//  FirstViewController.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/11/16.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.
//

import UIKit
import KJExpandableTableTree

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    // KJ Tree instances -------------------------
    var arrayTree:[Parent] = []
    var kjtreeInstance: KJTree = KJTree()
    
    //plistの読み込み01--------------------------------------------------------
    //選択されたエリア名を保存するメンバ変数
    var selectedName = ""
    var keyList:[String] = []
    var dataList:[NSDictionary] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //plistの読み込み02--------------------------------------------------------
        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
        let path = Bundle.main.path(forResource: "hotel_list_Detail", ofType: "plist")
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
            
        }
        
        //----------------------------------------------------------------------------------------
        //        北アメリカ northAmerican
        //        中南米   latinAmerica
        //        アジア（北〜東〜東南アジア）  asia_north_east_southeast
        //        アジア（中央〜西〜南アジア）    asia_center_west_south
        //        アフリカ  africa
        //        ヨーロッパ europe
        //        オーストラリア・オセアニア australia_oceania
        //----------------------------------------------------------------------------------------

        let northAmerican = Parent(expanded: true) { () -> [Child] in
            let child1 = Child(expanded: true, subChilds: { () -> [Child] in
                let subchild1 = Child()
                return [subchild1]
            })
            return [child1]
        }
        
        let latinAmerica = Parent(expanded: true) { () -> [Child] in
            let child1 = Child(expanded: true, subChilds: { () -> [Child] in
                let subchild1 = Child()
                return [subchild1]
            })
            return [child1]
        }
        
        let asia_north_east_southeast = Parent(expanded: true) { () -> [Child] in
            let child1 = Child(expanded: true, subChilds: { () -> [Child] in
                let subchild1 = Child()
                return [subchild1]
            })
            return [child1]
        }
        
        let asia_center_west_south = Parent(expanded: true) { () -> [Child] in
            let child1 = Child(expanded: true, subChilds: { () -> [Child] in
                let subchild1 = Child()
                return [subchild1]
            })
            return [child1]
        }
        
        let africa = Parent(expanded: true) { () -> [Child] in
            let child1 = Child(expanded: true, subChilds: { () -> [Child] in
                let subchild1 = Child()
                return [subchild1]
            })
            return [child1]
        }
        
        let europe = Parent(expanded: true) { () -> [Child] in
            let child1 = Child(expanded: true, subChilds: { () -> [Child] in
                let subchild1 = Child()
                return [subchild1]
            })
            return [child1]
        }
        
        let australia_oceania = Parent(expanded: true) { () -> [Child] in
            let child1 = Child(expanded: true, subChilds: { () -> [Child] in
                let subchild1 = Child()
                return [subchild1]
            })
            return [child1]
        }
        
        arrayTree.append(northAmerican)
        arrayTree.append(latinAmerica)
        arrayTree.append(asia_north_east_southeast)
        arrayTree.append(asia_center_west_south)
        arrayTree.append(africa)
        arrayTree.append(europe)
        arrayTree.append(australia_oceania)
        kjtreeInstance = KJTree(Parents: arrayTree)
        kjtreeInstance.isInitiallyExpanded = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView(frame: .zero)
        
    }

//MiniGauideBook代入---情報を次のページに渡す-------------------------------------------------------------------
//
//    //セルがタップされた時
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        //タップされた行のエリア名を保存
//        //areList[indexPath.row]はタップされた行番号の情報
//        selectedName = hotel_list[indexPath.row]
//
//        //セグエのidentifierを指定して、画面移動
//        performSegue(withIdentifier: "showTopToDetail", sender: nil)
//    }
//
//    //セグエを使って画面移動する時発動
//    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
//
//        //次の画面のインスタンスを取得
//        var dvc = segue.destination as! DetailViewController
//
//        //次の画面のプロパティにタップされた行のエリア名を渡す
//        dvc.getAreaName = selectedName
//
//    }
//MiniGauideBook代入---情報を次のページに渡す-------------------------------------------------------------------


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
//TODO:ck これをカブリの為、削除 : UITableViewDataSource, UITableViewDelegate
extension FirstViewController {
    //行数の設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let total = kjtreeInstance.tableView(tableView, numberOfRowsInSection: section)
        return total
    }
    
    //リストに表示する文字列
    //indexPath 行番号とかいろいろ入っている　セルを指定する時によく使う
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //文字列を表示するセルの取得（セルの再利用）
        //表示したい文字の設定？？
        let node = kjtreeInstance.cellIdentifierUsingTableView(tableView, cellForRowAt: indexPath)
        
        //TODO:ck indexTuplesのデータがどこにあるかわからない。なので、何をしてるかわからない。
        let indexTuples = node.index.components(separatedBy: ".")
        
        if indexTuples.count == 1  || indexTuples.count == 4 {
            
            // Parents
            let cellIdentifierParents = "ParentsTableViewCellIdentity"
            var cellParents: ParentsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierParents) as? ParentsTableViewCell
            if cellParents == nil {
                tableView.register(UINib(nibName: "ParentsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierParents)
                cellParents = tableView.dequeueReusableCell(withIdentifier: cellIdentifierParents) as? ParentsTableViewCell
            }
            
            //TODO:ck ママ編集。実相するための応急処置
            //cellParents?.cellFillUp(indexParam: node.index, key: indexTuples.count)
            cellParents?.selectionStyle = .none
            
            if node.state == .open {
                cellParents?.buttonState.setImage(UIImage(named: "minus"), for: .normal)
            }else if node.state == .close {
                cellParents?.buttonState.setImage(UIImage(named: "plus"), for: .normal)
            }else{
                cellParents?.buttonState.setImage(nil, for: .normal)
            }
            
            return cellParents!
            
        }else if indexTuples.count == 2{
            
            // Parents
            let cellIdentifierChilds = "Childs2ndStageTableViewCellIdentity"
            var cellChild: Childs2ndStageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? Childs2ndStageTableViewCell
            if cellChild == nil {
                tableView.register(UINib(nibName: "Childs2ndStageTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierChilds)
                cellChild = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? Childs2ndStageTableViewCell
            }
            cellChild?.cellFillUp(indexParam: node.index)
            cellChild?.selectionStyle = .none
            
            if node.state == .open {
                cellChild?.buttonState.setImage(UIImage(named: "minus"), for: .normal)
            }else if node.state == .close {
                cellChild?.buttonState.setImage(UIImage(named: "plus"), for: .normal)
            }else{
                cellChild?.buttonState.setImage(nil, for: .normal)
            }
            
            return cellChild!
            
        }else if indexTuples.count == 3 || indexTuples.count == 5 || indexTuples.count == 6 || indexTuples.count == 7{
            
            // Parents
            let cellIdentifierChilds = "Childs3rdStageTableViewCellIdentity"
            var cellChild: Childs3rdStageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? Childs3rdStageTableViewCell
            if cellChild == nil {
                tableView.register(UINib(nibName: "Childs3rdStageTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierChilds)
                cellChild = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? Childs3rdStageTableViewCell
            }
            cellChild?.cellFillUp(indexParam: node.index, tupleCount: indexTuples.count)
            cellChild?.selectionStyle = .none
            
            if node.state == .open {
                cellChild?.buttonState.setImage(UIImage(named: "minus"), for: .normal)
            }else if node.state == .close {
                cellChild?.buttonState.setImage(UIImage(named: "plus"), for: .normal)
            }else{
                cellChild?.buttonState.setImage(nil, for: .normal)
            }
            
            return cellChild!
            
        }else{
            // Childs
            // grab cell
            var tableviewcell = tableView.dequeueReusableCell(withIdentifier: "cellidentity")
            if tableviewcell == nil {
                tableviewcell = UITableViewCell(style: .default, reuseIdentifier: "cellidentity")
            }
            
            tableviewcell?.backgroundColor = UIColor.lightGray
            tableviewcell?.textLabel?.text = node.index
            tableviewcell?.selectionStyle = .none
            return tableviewcell!
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let node = kjtreeInstance.tableView(tableView, didSelectRowAt: indexPath)
        print(node.index)
        print(node.key)
        // if you've added any identifier or used indexing format
        print(node.givenIndex)
    }
}
