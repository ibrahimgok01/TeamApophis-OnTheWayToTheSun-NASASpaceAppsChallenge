//
//  ViewController.swift
//  NasaSpaceAPP
//
//  Created by Ibrahim Gok on 2.10.2022.
//
//
//
//
// On The Way To The Sun - Team Apophis - NASA Space Apps Challenge 2022

import UIKit
import SceneKit
import ARKit


class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var parker = SCNNode()
    var player : AVPlayer!
    var currentAngleY: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        let planeNode = SCNNode()

         planeNode.geometry = SCNPlane(width: 100, height: 100)
         planeNode.position.z = -5
         planeNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/8k_stars.jpeg")
         sceneView.pointOfView?.addChildNode(planeNode)
         
         let scene = SCNScene()
     
         let mySphere = SCNSphere(radius: 0.2)
         let sphereMaterial = SCNMaterial()
         sphereMaterial.diffuse.contents = UIImage(named: "art.scnassets/8k_sun.jpeg")
         mySphere.materials = [sphereMaterial]
         
         let sunNode = SCNNode()
        sunNode.position = SCNVector3(-1.5,0.2,-1.5)
         sunNode.geometry = mySphere
         scene.rootNode.addChildNode(sunNode)
         
         let Button1 = SCNSphere(radius: 0.02)
         let Button1Material = SCNMaterial()
         Button1Material.diffuse.contents = UIImage(named: "art.scnassets/white.jpeg")
         Button1Material.name = "Button1"
         Button1.materials = [Button1Material]
      
         let Button1Node = SCNNode()
        Button1Node.position = SCNVector3(-1,0.22,-1.5)
         Button1Node.geometry = Button1
         scene.rootNode.addChildNode(Button1Node)
      
         let Button2 = SCNSphere(radius: 0.02)
         let Button2Material = SCNMaterial()
         Button2Material.diffuse.contents = UIImage(named: "art.scnassets/white.jpeg")
         Button2Material.name = "Button2"
         Button2.materials = [Button2Material]
         
         let Button2Node = SCNNode()
        Button2Node.position = SCNVector3(-0.5,0.24,-1.5)
         Button2Node.geometry = Button2
         scene.rootNode.addChildNode(Button2Node)
        
         let Button3 = SCNSphere(radius: 0.02)
         let Button3Material = SCNMaterial()
         Button3Material.diffuse.contents = UIImage(named: "art.scnassets/white.jpeg")
         Button3Material.name = "Button3"
         Button3.materials = [Button3Material]
         
         let Button3Node = SCNNode()
        Button3Node.position = SCNVector3(0,0.26,-1.5)
         Button3Node.geometry = Button3
         scene.rootNode.addChildNode(Button3Node)
        
         let Button4 = SCNSphere(radius: 0.02)
         let Button4Material = SCNMaterial()
         Button4Material.diffuse.contents = UIImage(named: "art.scnassets/white.jpeg")
         Button4Material.name = "Button4"
         Button4.materials = [Button4Material]
         
         let Button4Node = SCNNode()
        Button4Node.position = SCNVector3(0.5,0.24,-1.5)
         Button4Node.geometry = Button4
         scene.rootNode.addChildNode(Button4Node)
        
         let Button5 = SCNSphere(radius: 0.02)
         let Button5Material = SCNMaterial()
         Button5Material.diffuse.contents = UIImage(named: "art.scnassets/white.jpeg")
         Button5Material.name = "Button5"
         Button5.materials = [Button5Material]
         
         let Button5Node = SCNNode()
        Button5Node.position = SCNVector3(1,0.22,-1.5)
         Button5Node.geometry = Button5
         scene.rootNode.addChildNode(Button5Node)
      
         let tiklamaYakala = UITapGestureRecognizer(target: self, action: #selector(tiklandi))
          self.sceneView.addGestureRecognizer(tiklamaYakala)

         let parkerScene = SCNScene(named: "ParkerSolarProbe.scn")
         guard let parkerNode = parkerScene?.rootNode.childNode(withName: "parkerModel", recursively: true) else {
             fatalError("parkerModel is not found")
         }
        parkerNode.position = SCNVector3(1.5, 0.2, -1.5)
        parkerNode.localRotate(by: SCNQuaternion.init(x: -1, y: 0, z: -1, w: 0))
         scene.rootNode.addChildNode(parkerNode)
         parker = parkerNode
         
         sceneView.scene = scene
    }
    
    @objc func tiklandi(algila: UIGestureRecognizer) {
    
    let ekran = algila.view as! SCNView
    
    let tiklamaBolgesi = algila.location(in: ekran)
    
    let tiklamaSonucu = ekran.hitTest(tiklamaBolgesi, options: [:])
        
        if tiklamaSonucu.isEmpty == false {
           
            let node = tiklamaSonucu[0].node
            if let nodeMaterial = node.geometry?.material(named: "Button1") {
                let moveNode = SCNAction.moveBy(x:-0.5,y:-0.05,z:0, duration:1)
                parker.runAction(moveNode)
                fradaycupVideo()
            }
            if let nodeMaterial = node.geometry?.material(named: "Button2") {
                let moveNode = SCNAction.moveBy(x:-0.5,y:-0.05,z:0, duration:1)
                parker.runAction(moveNode)
                magnetometersVideo()
            }
            if let nodeMaterial = node.geometry?.material(named: "Button3") {
                let moveNode = SCNAction.moveBy(x:-0.5,y:0.05,z:0, duration:1)
                parker.runAction(moveNode)
                electromangeticVideo()
            }
            if let nodeMaterial = node.geometry?.material(named: "Button4") {
                let moveNode = SCNAction.moveBy(x:-0.5,y:0.05,z:0, duration:1)
                parker.runAction(moveNode)
                antennaVideo()
            }
            if let nodeMaterial = node.geometry?.material(named: "Button5") {
                let moveNode = SCNAction.moveBy(x:-0.5,y:0.05,z:0, duration:1)
                parker.runAction(moveNode)
                solarpannelVideo()
            }
       }
   }
    
    func solarpannelVideo() {
        let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "solarpannel", ofType: "mp4")!)
        player = AVPlayer(url: fileURL)
        
        let tvGeo = SCNPlane(width: 1, height: 0.5)
        tvGeo.firstMaterial?.diffuse.contents = player
        tvGeo.firstMaterial?.isDoubleSided = true
        
        let tvNode = SCNNode(geometry: tvGeo)
        tvNode.position.z = -2
        
        sceneView.scene.rootNode.addChildNode(tvNode)
        player.play()
    }
    
    func heatshieldVideo() {
        let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "heatshield", ofType: "mp4")!)
        player = AVPlayer(url: fileURL)
        
        let tvGeo = SCNPlane(width: 1, height: 0.5)
        tvGeo.firstMaterial?.diffuse.contents = player
        tvGeo.firstMaterial?.isDoubleSided = true
        
        let tvNode = SCNNode(geometry: tvGeo)
        tvNode.position.z = -2
        
        sceneView.scene.rootNode.addChildNode(tvNode)
        player.play()
    }
    
    func antennaVideo() {
        let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "antenna", ofType: "mp4")!)
        player = AVPlayer(url: fileURL)
        
        let tvGeo = SCNPlane(width: 1, height: 0.5)
        tvGeo.firstMaterial?.diffuse.contents = player
        tvGeo.firstMaterial?.isDoubleSided = true
        
        let tvNode = SCNNode(geometry: tvGeo)
        tvNode.position.z = -2
        
        sceneView.scene.rootNode.addChildNode(tvNode)
        player.play()
    }
    
    func fradaycupVideo() {
        let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "faradaycup", ofType: "mp4")!)
        player = AVPlayer(url: fileURL)
        
        let tvGeo = SCNPlane(width: 1, height: 0.5)
        tvGeo.firstMaterial?.diffuse.contents = player
        tvGeo.firstMaterial?.isDoubleSided = true
        
        let tvNode = SCNNode(geometry: tvGeo)
        tvNode.position.z = -2
        
        sceneView.scene.rootNode.addChildNode(tvNode)
        player.play()
    }
    
    func electromangeticVideo() {
        let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "electromagnetic", ofType: "mp4")!)
        player = AVPlayer(url: fileURL)
        
        let tvGeo = SCNPlane(width: 1, height: 0.5)
        tvGeo.firstMaterial?.diffuse.contents = player
        tvGeo.firstMaterial?.isDoubleSided = true
        
        let tvNode = SCNNode(geometry: tvGeo)
        tvNode.position.z = -2
        
        sceneView.scene.rootNode.addChildNode(tvNode)
        player.play()
    }
    
    func magnetometersVideo() {
        let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "magnetometers", ofType: "mp4")!)
        player = AVPlayer(url: fileURL)
        
        let tvGeo = SCNPlane(width: 1, height: 0.5)
        tvGeo.firstMaterial?.diffuse.contents = player
        tvGeo.firstMaterial?.isDoubleSided = true
        
        let tvNode = SCNNode(geometry: tvGeo)
        tvNode.position.z = -2

        sceneView.scene.rootNode.addChildNode(tvNode)
        player.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    
}
