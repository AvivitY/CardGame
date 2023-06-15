import UIKit


class PopUpController: UIViewController {
    weak var delegate:ResultDelegate?
    @IBAction func saveBtn(_ sender: UIButton) {
        //write to sp
        UserDefaults.standard.set(textField.text, forKey: "Name")
        sendResultToParent()
    }
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func sendResultToParent(){
        delegate?.handleResult(true)
        dismiss(animated: true,completion: nil)
    }
}
