import UIKit

class ScoreController: UIViewController {
    @IBOutlet weak var winnerScore: UILabel!
    @IBOutlet weak var winnerName: UILabel!
    var east:Int = UserDefaults.standard.integer(forKey: "eastScore")
    var west:Int = UserDefaults.standard.integer(forKey: "westScore")
    var name:String = UserDefaults.standard.string(forKey: "Name") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let isEast:Bool = UserDefaults.standard.bool(forKey: "isEast")
        if(west>east){
            if(isEast){
                winnerName.text = "PC"
            }else{
                winnerName.text = name
            }
            winnerScore.text = "Score: "+String(west)
        }else if(east>west){
            if(isEast){
                winnerName.text = name
            }else{
                winnerName.text = "PC"
            }
            winnerScore.text = "Score: "+String(east)
        }else{
            winnerName.text = "Tie"
            winnerScore.text = "Score: "+String(east)
        }
    }
}
