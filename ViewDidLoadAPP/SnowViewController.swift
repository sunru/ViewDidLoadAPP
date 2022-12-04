//
//  SnowViewController.swift
//  ViewDidLoadAPP
//
//  Created by 廖晨如 on 2022/12/3.
//

import UIKit

class SnowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //底層 view.layer.insertSublayer 繪入 view 最底
        setGradientBG()
        //第二層 view.addSubview 繪入 view
        maskImage()
        //第三層 view.addSubview 繪入 view
        snowEmitter()
        
        
    }
    private func maskImage(){//***Mask: 設計特別形狀的圖片
        let treeImageView = UIImageView(image: UIImage(named: "tree.png"))
        let shapeImageView = UIImageView(image: UIImage(named: "mask.png"))
        treeImageView.frame = CGRect(x: 85, y: 360, width: 220, height: 300)
        //讓 shapeImageView 的大小等於 treeImageView 的尺寸
        shapeImageView.frame = treeImageView.bounds
        //調整內容顯示
        shapeImageView.contentMode = .scaleAspectFill
        treeImageView.contentMode = .scaleAspectFill
        //設定 treeImageView 的遮罩(mask) 為 shapeImageView 的圖片
        treeImageView.mask = shapeImageView
        //設定treeImageView 為 view 的 subview
        view.addSubview(treeImageView)
    }
    
    private func setGradientBG(){//利用 CAGradientLayer 製作漸變色背景
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0/255, green: 191/255, blue: 255/255, alpha: 1).cgColor, UIColor(red: 230/255, green: 248/255, blue: 255/255, alpha: 1).cgColor]
        //讓漸變的大小等於  controller view 的尺寸(BG)
        gradientLayer.frame = view.bounds
        //調整漸層方向: 從 (0, 0) 到 (1, 1) 可實現從右下往左上的對角線方向
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        //調整漸層顏色分布的比例
        gradientLayer.locations = [0, 0.6]
        //insertSublayer: 將漸層的 layer 加在最底層(如果使用 view.layer.addSublayer 加入漸層，它將變成在最上層，覆蓋在 storyboard 設計的元件導致元件無法操作)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func snowEmitter(){//利用 CAEmitterLayer 製作 Xmas 的下雪動畫
        //CAEmitterLayer 發射的粒子其實是 CAEmitterCell，因此我們需要產生 CAEmitterCell 物件。
        let snowEmitterCell = CAEmitterCell()
        //contents 要求的型別是 CGImage
        snowEmitterCell.contents = UIImage(named: "snowflake")?.cgImage
        //設定每秒發射幾個雪花
        snowEmitterCell.birthRate = 20
        //雪花維持的秒數
        snowEmitterCell.lifetime = 100
        //scale 則控制雪花的大小(+-0.05)
        snowEmitterCell.scale = 0.1
        snowEmitterCell.scaleRange = 0.05
        //雪花大小改變的速度:小於 0 會愈來愈小，大於 0 會愈來愈大
        snowEmitterCell.scaleSpeed = -0.01
        //旋轉雪花:利用 spin 和 spinRange 設定雪花轉速的範圍為 -0.5(0.5–1) ~ 1.5(0.5+1)，單位為弧度。
        snowEmitterCell.spin = 0.5
        snowEmitterCell.spinRange = 1
        //雪花移動的速度
        snowEmitterCell.velocity = 300
        //雪花往下落下的加速度:yAcceleration > 0 時會向下移動，yAcceleration ＜ 0 時會向上移動
        snowEmitterCell.yAcceleration = 30
        //雪花發射的角度範圍:雪花不再是單純的直線落下，讓它們有些往左下，有些往右下
        snowEmitterCell.emissionRange = CGFloat.pi
        //產生 CAEmitterLayer，將它的 emitterCells 指定為剛剛產生的雪花粒子 snowEmitterCell
        let snowEmitterLayer = CAEmitterLayer()
        //雪花發射的路徑
        snowEmitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -50)
        snowEmitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        snowEmitterLayer.emitterShape = .line
        snowEmitterLayer.emitterCells = [snowEmitterCell]
        //利用 addSublayer 將 snowEmitterLayer 的下雪效果加到畫面上
        view.layer.addSublayer(snowEmitterLayer)
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
