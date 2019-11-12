//
// Copyright (c) 2019, mycompany All rights reserved. 
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textView: UITextView!

  struct FontFamily{
    var familyName:String
    var fontNames:[String]
  }
  var fontFamilies:[FontFamily] = []

  var dispText:String = "0123456789\nABCDEFG" {
    didSet{
      print(dispText)
      self.tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource  = self
    tableView.keyboardDismissMode = .onDrag
    initAllFonts()
    textView.text = dispText
    textView.delegate = self
  }


  private func initAllFonts(){
    fontFamilies = []
    UIFont.familyNames.sorted().forEach{ (familyName) in
//      print("*** \(familyName) ***")

      let fontNames = UIFont.fontNames(forFamilyName: familyName).sorted()
      fontFamilies.append( FontFamily(familyName: familyName,
                                  fontNames:fontNames))
//
//
//        fontNames.forEach({ (fontName) in
//            print(fontName)
////            let label = UILabel()
////            label.text = "フォント：" + fontName
////            label.font = UIFont(name: fontName, size: UIFont.labelFontSize())
////            label.sizeToFit()
////            label.frame.origin.y = view.contentSize.height
////            view.contentSize.width = max(view.contentSize.width, label.frame.width)
////            view.contentSize.height += label.frame.height + 10
////            view.addSubview(label)
//        })
//      print("")
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
     }

}

extension ViewController:UITableViewDelegate{

  func tableView(_ tableView: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight = 20 //セルの高さ
    return UITableView.automaticDimension //自動設定
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return  "\(section + 1) " + fontFamilies[section].familyName
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {



    let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)

    // Configure the cell’s contents.
    let fontName = fontFamilies[indexPath.section].fontNames[indexPath.row]
    cell.textLabel!.text = "\(indexPath.row + 1) \(fontName)"
    cell.detailTextLabel?.text = dispText
    cell.detailTextLabel?.numberOfLines = 0
    cell.detailTextLabel?.font = UIFont(name: fontName, size: UIFont.labelFontSize)

    return cell

  }
}

extension ViewController:UITableViewDataSource{
  func numberOfSections(in _: UITableView) -> Int {
    return fontFamilies.count
  }

//  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
//    return 30 // last row expand for transparent menu height.
//  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fontFamilies[section].fontNames.count
  }
}


extension ViewController:UITextViewDelegate{
  func textViewDidChange(_ textView: UITextView) {
    self.dispText = textView.text
  }
  func textViewDidEndEditing(_ textView: UITextView) {
self.view.endEditing(true)
  }
}
