//
//  ViewController.swift
//  sharktop
//
//  Created by aluno on 11/04/19.
//  Copyright © 2019 Aluno. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    var nodes = [SCNNode]()
    var cuboNode = SCNNode()


    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
//        sceneView.debugOptions = [SCNDebugOptions.showFeaturePoints]
        
        createCube()
        
//        importHuman(qntdHuman: 50)
    }
    @IBAction func chooseLvl1(_ sender: UIButton) {
        for node in nodes{
            node.removeFromParentNode()
        }
        importHuman(qntdHuman: 15)
        
    }
    
    @IBAction func chooseLvl2(_ sender: UIButton) {
        for node in nodes{
            node.removeFromParentNode()
        }
        importHuman(qntdHuman: 20)
    }
    
    @IBAction func chooseLvl3(_ sender: UIButton) {
        for node in nodes{
            node.removeFromParentNode()
        }
        importHuman(qntdHuman: 30)
    }
    
    private func importHuman(qntdHuman: Int) {

    
        var inicio: Int!
        
        inicio = 1
        
        while inicio <= qntdHuman{
            let scene = SCNScene(named: "art.scnassets/lumberJack.DAE")!
            let numberZ = Int.random(in: -10 ..< 10)
            let numberY = Int.random(in: -20 ..< 20)
            let numberX = Int.random(in: -3 ..< 3)
            print(inicio)
            if let human = scene.rootNode.childNode(withName: "lumberJack", recursively: true) {
                human.position = SCNVector3(numberY, numberX, numberZ)
                sceneView.scene.rootNode.addChildNode(human)
                nodes.append(human)
                let animation = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi * 10), z: 0, duration: 2)
                let action = SCNAction.repeatForever(animation)
                
                human.runAction(action)
                
                let vector = SCNVector3(
                                        cuboNode.position.x,
                                        cuboNode.position.y,
                                        cuboNode.position.z
//                    cuboNode.worldTransform.cumns.3.x
                                    )
                
                human.runAction(SCNAction.move(to: vector, duration: 12))
                
                
            }
//            print(nodes)
            inicio = inicio + 1
        }
        
    }
    
    private func animation(velocidade: Int){
        
    }
    
    
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        if let anchor = anchor as? ARPlaneAnchor {
////            createPlane(node: node, anchor: anchor)
//
//
//        }
//    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            
            
            let newResults = sceneView.hitTest(touchLocation, options: nil)
            newResults.first?.node.removeFromParentNode()
            
            
            
//            if let hitResult = newResults.first {
//                //                print(hitResult)
//
//
////                let vector = SCNVector3(
////                    hitResult.node.worldTransform.columns.3.x,
////                    hitResult.worldTransform.columns.3.y,
////                    hitResult.worldTransform.columns.3.z
////                )
////
//                createCube(vector: newResults.first?.node)
//            }
        }
    }
    
    private func createCube() {
        // Creates a rectangle
        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        
        // Creates a material for the rectangle. The material is what is made of.
        let material = SCNMaterial()
        
        // Sets the material to be red. This will cause the cube to be all read
        material.diffuse.contents = UIColor.red
        
        // Then apply the materials to the cube
        cube.materials = [material]
        
        // Creates a node. This is a 3D position (x, y, z). Remember that when the Z is increased, it is coming towards.
        
        let node = SCNNode()
        node.position = SCNVector3(0, 0, -0.5)
        
        // Apply the node geometry it will be linked with
        node.geometry = cube
        
        self.cuboNode = node
        
        sceneView.scene.rootNode.addChildNode(node)
        
        sceneView.autoenablesDefaultLighting = true
    }

    
    private func createPlane(node: SCNNode, anchor: ARPlaneAnchor) {
        let plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
//        let ball = SCNSphere
        
        let planeNode = SCNNode()
        planeNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        
        planeNode.geometry = plane
        
        node.addChildNode(planeNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
