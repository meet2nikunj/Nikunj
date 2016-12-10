
//

import UIKit

class GetStartedVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    // Paging Group of Button
    @IBOutlet var btnPaging: [UIButton]!
    
    // View Top Images of CollectionView
    @IBOutlet var collViewHelp: UICollectionView!
    
    // View Title and Description of CollectionView
    @IBOutlet var collDesViewHelp: UICollectionView!
    
    // Build Version No
    @IBOutlet var lblVersionNo : UILabel!
    
    var aTitle = ["LOREM","LOREM","LOREM","LOREM"]
    var aDesc = ["There ","There","There.","There."]
    
    // MARK:- Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doInitialSettings()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Collection View Delegate and DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == collViewHelp
        {
            var aCell: GetStartedCell
            aCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GetStartedCell", for: indexPath as IndexPath) as! GetStartedCell
            aCell.imgView?.image=UIImage(named: "help_screen")
            return aCell
        }
        else
        {
            var aCell: GetStartedDesCell
            aCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GetStartedDesCell", for: indexPath as IndexPath) as! GetStartedDesCell
            aCell.lblTitle!.text! = "\(aTitle[indexPath.row])"
            aCell.lblDesc!.text! = "\(aDesc[indexPath.row])"
            return aCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    {
        if collectionView == collViewHelp
        {
            return CGSize(width: Constants.kScreenWidth,height: collViewHelp.frame.size.height)
        }
        else
        {
            return CGSize(width: Constants.kScreenWidth,height: collDesViewHelp.frame.size.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        // Get index page when scroll the view
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        selectPagingButton(page)
    }
    
    // MARK: - Action Method
    @IBAction func btnPagingTapped(_ sender: UIButton)
    {
        selectPagingButton(sender.tag)
    }
    @IBAction func btnGetStartedTapped(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
    // MARK: - Class Methods
    func doInitialSettings()
    {
        // Build Version No
        
        if let versionNO = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            print(versionNO)
             lblVersionNo.text="Version : \(versionNO)"
        }
        
        // By Default set 0 Index page
        btnPaging[0].isSelected = true
        
        for btnPage in btnPaging
        {
            
            if btnPage.isSelected
            {
                btnPage.backgroundColor = UIColor(red: 40.0/255.0, green: 142.0/255.0, blue: 206.0/255.0, alpha: 1.0)
            }
            else
            {
                btnPage.backgroundColor = UIColor.clear
            }
            
        }
    }
    //Managing Button Selection For Paging
    func selectPagingButton(_ indx : Int)
    {
        // Collection view scroll at index page
        
        self.collViewHelp!.scrollToItem(at: IndexPath(item: indx, section: 0), at: UICollectionViewScrollPosition(), animated: true)
        self.collDesViewHelp!.scrollToItem(at: IndexPath(item: indx, section: 0), at: UICollectionViewScrollPosition(), animated: true)
        
        for btnPage in btnPaging
        {
            if indx == btnPage.tag
            {
                btnPage.isSelected = true
                btnPage.backgroundColor = UIColor(red: 40.0/255.0, green: 142.0/255.0, blue: 206.0/255.0, alpha: 1.0)
            }
            else
            {
                btnPage.isSelected = false
                btnPage.backgroundColor = UIColor.clear
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
