//
//  ViewController.swift
//  Demo_CoreApi
//
//  Created by Khánh Vỹ Đinh on 14/06/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableStudent: UITableView!
    var arr_student:[Student]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableStudent.delegate=self
        tableStudent.dataSource=self
        let nib=UINib(nibName: "TableViewCell", bundle: Bundle.main)
        tableStudent.register(nib, forCellReuseIdentifier: "cell")
        APIManager.Student.getAllStudents(competion: {
            [tableStudent]
            result in
            switch result{
            case .success(let result):self.arr_student=result.student;DispatchQueue.main.async {
                tableStudent?.reloadData()
            }
            case .failure(_):break
            }
        })
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arr_student.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let student=arr_student[indexPath.row]
        cell.ageLabel.text="\(student.age)"
        cell.nameLabel.text=student.name
        APIManager.Downloader.dowloadImage(imageUrl: student.imageUrl, completion: {
            [cell]
            result in
            switch result{
            case .success(let data):
                if let data=data{
                    DispatchQueue.main.async {
                        cell.avatarImage.image=UIImage(data: data)
                    }
                }
            case .failure(_): break
                
            }
        })
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
