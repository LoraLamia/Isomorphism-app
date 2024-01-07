import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let graf1 = Graph()
        let vertex0 = Vertex(id: 0, position: CGPoint(x: 101, y: 150))
        let vertex1 = Vertex(id: 1, position: CGPoint(x: 182, y: 144))
        let vertex2 = Vertex(id: 2, position: CGPoint(x: 271, y: 141))
        let vertex3 = Vertex(id: 3, position: CGPoint(x: 273, y: 216))
        let vertex4 = Vertex(id: 4, position: CGPoint(x: 181, y: 218))
        let vertex5 = Vertex(id: 5, position: CGPoint(x: 100, y: 223))
        
        let vertices = [vertex0,
                        vertex1,
                        vertex2,
                        vertex3,
                        vertex4,
                        vertex5]
        graf1.vertices = vertices
        let edges = [Edge(from: vertex5, to: vertex2),
                     Edge(from: vertex4, to: vertex2),
                     Edge(from: vertex5, to: vertex4),
                     Edge(from: vertex4, to: vertex3),
                     Edge(from: vertex3, to: vertex1),
                     Edge(from: vertex1, to: vertex4),
                     Edge(from: vertex0, to: vertex1),
                     Edge(from: vertex1, to: vertex2),
                     Edge(from: vertex0, to: vertex4)]
        graf1.edges = edges

        print("X[0] za graf 1: \(graf1.X[0])")
        graf1.X1()
        print("X[1] za graf 1: \(graf1.X[1])")
        graf1.X2()
        print("X[2] za graf 1: \(graf1.X[2])")
//        for vertex in graf1.vertices {
//            print(graf1.D2(vertex: vertex))
//        }
//        print(graf1.X[2])
        
        let graf2 = Graph()
        let TwoVertex0 = Vertex(id: 0, position: CGPoint(x: 122, y: 553))
        let TwoVertex1 = Vertex(id: 1, position: CGPoint(x: 182, y: 611))
        let TwoVertex2 = Vertex(id: 2, position: CGPoint(x: 124, y: 614))
        let TwoVertex3 = Vertex(id: 3, position: CGPoint(x: 118, y: 479))
        let TwoVertex4 = Vertex(id: 4, position: CGPoint(x: 180, y: 472))
        let TwoVertex5 = Vertex(id: 5, position: CGPoint(x: 248, y: 549))
        
        let TwoVertices = [TwoVertex0,
                           TwoVertex1,
                           TwoVertex2,
                           TwoVertex3,
                           TwoVertex4,
                           TwoVertex5]
        graf2.vertices = TwoVertices
        let TwoEdges = [Edge(from: TwoVertex3, to: TwoVertex0),
                     Edge(from: TwoVertex0, to: TwoVertex2),
                     Edge(from: TwoVertex3, to: TwoVertex1),
                     Edge(from: TwoVertex0, to: TwoVertex4),
                     Edge(from: TwoVertex4, to: TwoVertex5),
                     Edge(from: TwoVertex5, to: TwoVertex1),
                     Edge(from: TwoVertex0, to: TwoVertex1),
                     Edge(from: TwoVertex0, to: TwoVertex5),
                     Edge(from: TwoVertex2, to: TwoVertex5)]
        graf2.edges = TwoEdges
        
        print("X[0] za graf 2: \(graf2.X[0])")
        graf2.X1()
        print("X[1] za graf 2: \(graf2.X[1])")
        graf2.X2()
        print("X[2] za graf 2: \(graf2.X[2])")
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

