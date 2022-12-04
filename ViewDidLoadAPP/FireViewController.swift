//
//  FireViewController.swift
//  ViewDidLoadAPP
//
//  Created by 廖晨如 on 2022/12/3.
//

import UIKit
import SpriteKit

class FireViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //第二層 view.layer.insertSublayer 繪入 view 最底
        fireSpriteKit()
        //底層 view.layer.insertSublayer 繪入 view 最底
        setGradientBG()
        //第三層 view.addSubview 繪入 view
        maskImage()
        
        
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
        gradientLayer.colors = [UIColor(red: 209/255, green: 52/255, blue: 0, alpha: 1).cgColor, UIColor(red: 241/255, green: 236/255, blue: 21/255, alpha: 1).cgColor]
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
    
    private func fireSpriteKit(){//利用 SpriteKit Particle File 製造火焰效果
        //產生 SKView 物件，然後利用 insertSubview 將它加到 view 的底層，讓它成為背景
        let fireSKView = SKView(frame: view.frame)
        //insertSublayer: 將漸層的 layer 加在最底層(如果使用 view.layer.addSublayer 加入漸層，它將變成在最上層，覆蓋在 storyboard 設計的元件導致元件無法操作)
        view.insertSubview(fireSKView, at: 0)
        //設定背景為透明
        fireSKView.backgroundColor = UIColor.clear
        //SKView 顯示的內容由 SKScene 控制，因此產生 SKScene，然後從 skView 呼叫 presentScene 顯示 SKScene 的內容
        let scene = SKScene(size: fireSKView.frame.size)
        fireSKView.presentScene(scene)
        //SKEmitterNode 專門呈現粒子效果。我們在產生 SKEmitterNode 時傳入 SpriteKit Particle File 的檔名，SKEmitterNode，然從再從 scene 呼叫 addChild 加入 SKEmitterNode，讓 scene 顯示粒子效果。
        let emitterNode = SKEmitterNode(fileNamed: "MyFireParticle")
        scene.addChild(emitterNode!)
        //控制 scene 內容呈現的位置，型別是 CGPoint，畫面的左下角為 (0, 0)，右上角為 (1, 1)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.1)
        //設定背景為透明讓漸變背景可以出來
        scene.backgroundColor = UIColor.clear
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
