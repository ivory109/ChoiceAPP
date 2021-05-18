import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var finalImageView: UIImageView!
    
    //接收上一頁的分數
    var totalScore: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        totalScoreLabel.text = String(totalScore!)
        
        if totalScore! == 100 {
            finalImageView.image = UIImage(named: "winnerImage")
        }else{
            finalImageView.image = UIImage(named: "loswerImage")
        }
    }
    
    //分享Button
    @IBAction func share(_ sender: UIButton) {
        let controller = UIActivityViewController(activityItems: ["我的分數是\(totalScore!)分"], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
    }
    
}
