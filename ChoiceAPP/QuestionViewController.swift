import UIKit

class QuestionViewController: UIViewController {
    var questions:[Data] = [
        Data(question: "太陽系中，哪個行星最接近太陽？", choices:["火星","金星","木星","水星"], answer: "水星"),
        Data(question: "觀看次數最多的YouTube影片？", choices:["Shape of you","Gangnam style","Baby shark dance","Despacito"], answer: "Baby shark dance"),
        Data(question: "哪個國家曾有種職業是代替別人承認放屁？", choices:["印尼","日本","中國","烏克蘭"], answer: "日本"),
        Data(question: "聖誕老人村位於哪一個國家？", choices:["芬蘭","荷蘭","美國","冰島"], answer: "芬蘭"),
        Data(question: "以下哪一個國家禁止人民安裝冷氣機？", choices:["阿富汗","瑞士","梵蒂岡","北韓"], answer: "瑞士"),
        Data(question: "日本目前最高電影票房紀錄是哪部？", choices:["神隱少女","鐵達尼號","鬼滅之刃劇場版 無限列車篇","冰雪奇緣"], answer: "鬼滅之刃劇場版 無限列車篇"),
        Data(question: "以下哪一位被稱為鋼琴詩人？", choices:["蕭邦","莫札特","郎朗","貝多芬"], answer: "蕭邦"),
        Data(question: "魚蝦蟹打架，哪一個會輸？", choices:["魚","蝦","蟹","全部"], answer: "蝦"),
        Data(question: "日本人會在平安夜吃什麼？", choices:["Pizza Hut","KFC炸雞","一蘭拉麵","吉野家牛丼"], answer: "KFC炸雞"),
        Data(question: "卡通哆啦A夢中，哪個描述是正確的呢？", choices:["靜香因狐臭而喜歡洗澡","哆啦A夢有手指","小夫被胖虎進來了","哆啦A夢原本是紅色的"], answer: "哆啦A夢有手指"),
        Data(question: "米奇老鼠有多少隻手指呢？", choices:["5隻","4隻","3隻","沒有"], answer: "4隻"),
        Data(question: "天線寶寶中的紅色小波(Po)懂哪種語言？", choices:["法語","日語","廣東話","普通話"], answer: "廣東話"),
        Data(question: "世界上最長壽的動物是？", choices:["小頭睡鯊","加拉帕戈斯象龜","錦鯉","燈塔水母"], answer: "燈塔水母"),
        Data(question: "阿拉伯數字是由哪一個國家的人發明？", choices:["阿拉伯","羅馬","印度","西班牙"], answer: "印度"),
        Data(question: "美國隊長3：英雄內戰，有哪位英雄沒有參與這部？", choices:["奇異博士","鷹眼","幻視","黑豹"], answer: "奇異博士")]
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var numberOfQuestionLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    
    //存放隨機亂數完的那10題
    var list:[Data] = []
    //選到的題數
    var index = 0
    //分數
    var score = 0
    //倒數計時時間
    var timer = Timer()
    var time = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        questions.shuffle()
        //將產生完隨機亂數的10題後加入listArray
        for i in 0...9 {
            list.append(questions[i])
        }
        update()
        answerImageView.isHidden = true
        countdownTime()
        updateTimer()
    }
    
    func update() {
        //設定問題questionLabel
        questionLabel.text = list[index].question
        //讓每個題目的選項亂數
        list[index].choices.shuffle()
        //設定對應到的Button
        aButton.setTitle(list[index].choices[0], for: .normal)
        bButton.setTitle(list[index].choices[1], for: .normal)
        cButton.setTitle(list[index].choices[2], for: .normal)
        dButton.setTitle(list[index].choices[3], for: .normal)
        //設定當前的題目數numberOfQuestionLabel
        numberOfQuestionLabel.text = "\(index+1) / 10"
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        //先判斷選項是否正確，並顯示imageView
        if sender.titleLabel?.text == list[index].answer {
            answerImageView.isHidden = false
            answerImageView.image = UIImage(named: "correctAnswerImage")
            score += 10
        }else{
            answerImageView.isHidden = false
            answerImageView.image = UIImage(named: "wrongAnswerImage")
        }
        //再判斷index是否有超出10題
        if index < list.count - 1 {
            index += 1
            update()
        }else{
            index = 0
            alertForQuestionOver()
        }
    }
    
    //答完10題後跳出alert
    func alertForQuestionOver() {
        let controller = UIAlertController(title: "測驗結束！", message: "看分數囉", preferredStyle: .alert)
        let goAction = UIAlertAction(title: "GO", style: .default, handler: nextPage(alert:))
        controller.addAction(goAction)
        present(controller, animated: true, completion: nil)
    }
    
    //按下goAction的alert後，到ScoreViewController
    func nextPage(alert:UIAlertAction) {
        //先停止倒數，很重要！
        timer.invalidate()
        performSegue(withIdentifier: "goScoreViewController", sender: self)
    }
    
    //將score準備傳送到下一頁的totalScore
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goScoreViewController" {
            let vc = segue.destination as! ScoreViewController
            vc.totalScore = score
        }
    }
    
    
    
    //時間先結束，跳出alertForTimeOver alert
    func alertForTimeOver() {
        let controller = UIAlertController(title: "時間到了！", message: "未在時間內完成", preferredStyle: .alert)
        let goToScoreAction = UIAlertAction(title: "看分數哭哭", style: .default, handler: nextPage(alert:))
        let restartAction = UIAlertAction(title: "重新開始", style: .default, handler: backToFirstPage(alert:))
        controller.addAction(goToScoreAction)
        controller.addAction(restartAction)
        present(controller, animated: true, completion: nil)
    }
    
    //時間先結束，按下重新開始的restartAction alert
    func backToFirstPage(alert:UIAlertAction) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //設定倒數
    func countdownTime() {
        if index < 10 {
            time = 16
            //設定Timer的預定計時器(時間間隔：秒數, 觸發對象：Any, Timer的觸發事件：func, 傳入Timer觸發事件的資料, 重複：Bool)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    //更新Timer
    @objc func updateTimer() {
        time -= 1
        if time != 0{
            countDownLabel.text = String(time)
        } else {
            //先停止倒數，很重要！
            timer.invalidate()
            countDownLabel.text = "0"
            alertForTimeOver()
        }
    }
    
}
