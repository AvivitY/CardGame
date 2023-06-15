import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var westLabel: UILabel!
    @IBOutlet weak var westImg: UIImageView!
    @IBOutlet weak var eastImg: UIImageView!
    @IBOutlet weak var eastLabel: UILabel!
    @IBOutlet weak var westPoints: UILabel!
    @IBOutlet weak var eastPoints: UILabel!
    var timer : Timer?
    var counter = 0
    var numOfRounds = 0
    var gameCards: [UIImage] = [#imageLiteral(resourceName: "ace"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "9"), #imageLiteral(resourceName: "10"), #imageLiteral(resourceName: "j"), #imageLiteral(resourceName: "q"),  #imageLiteral(resourceName: "k")]
    var back : UIImage = #imageLiteral(resourceName: "back")
    var isUpsidedown: Bool = true
    var eastPoint: Int = 0
    var westPoint: Int = 0
    @IBAction func killTimer(_ sender: AnyObject) {
       timer?.invalidate()
       timer = nil
    }

    @objc func prozessTimer() {
        counter += 1
        print("This is a second ", counter)
    }
    
    @objc func changeCard(){
        if(isUpsidedown){
            if(counter < 5){
                counter+=1
            }else{
                let westIndex = Int.random(in: 0..<13)
                westImg.image = gameCards[westIndex]
                let eastIndex = Int.random(in: 0..<13)
                eastImg.image = gameCards[eastIndex]
                if(westIndex > eastIndex){
                    westPoint+=1
                    westPoints.text = String(westPoint)
                } else if (eastIndex > westIndex){
                    eastPoint+=1
                    eastPoints.text = String(eastPoint)
                }
                numOfRounds+=1
                counter = 0
                isUpsidedown = false
            }
        }else{
            if(counter < 3){
                counter+=1
            }else{
                westImg.image = back
                eastImg.image = back
                counter = 0
                isUpsidedown = true
            }
        }
        if(numOfRounds == 10){
            timer?.invalidate()
            UserDefaults.standard.set(eastPoint, forKey: "eastScore")
            UserDefaults.standard.set(westPoint, forKey: "westScore")
            if let viewController = storyboard?.instantiateViewController(withIdentifier:"scores"){
                present(viewController,animated: true,completion: nil)
            }
        }
        seconds.text = String(counter)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.bool(forKey: "isEast")){
            eastLabel.text = UserDefaults.standard.string(forKey: "Name")
            westLabel.text = "PC"
        }else{
            westLabel.text = UserDefaults.standard.string(forKey: "Name")
            eastLabel.text = "PC"
        }
        timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:(#selector(changeCard)), userInfo: nil, repeats: true)
    }

}
    
