import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let graf = Graph()
        let vertex0 = Vertex(id: 0, position: CGPoint(x: 93, y: 179))
        let vertex1 = Vertex(id: 1, position: CGPoint(x: 59, y: 237))
        let vertex2 = Vertex(id: 2, position: CGPoint(x: 111, y: 280))
        let vertex3 = Vertex(id: 3, position: CGPoint(x: 180, y: 324))
        let vertex4 = Vertex(id: 4, position: CGPoint(x: 313, y: 159))
        let vertex5 = Vertex(id: 5, position: CGPoint(x: 308, y: 268))
        let vertex6 = Vertex(id: 6, position: CGPoint(x: 171, y: 157))
        
        let vertices = [vertex0,
                        vertex1,
                        vertex2,
                        vertex3,
                        vertex4,
                        vertex5,
                        vertex6]
        graf.vertices = vertices
        let edges = [Edge(from: vertex1, to: vertex0),
                     Edge(from: vertex0, to: vertex2),
                     Edge(from: vertex1, to: vertex2),
                     Edge(from: vertex0, to: vertex6),
                     Edge(from: vertex0, to: vertex3),
                     Edge(from: vertex6, to: vertex3),
                     Edge(from: vertex3, to: vertex5),
                     Edge(from: vertex6, to: vertex4)]
        graf.edges = edges

        print(graf.X[0])
        graf.X1()
        print(graf.X[1])
        graf.X2()
        for vertex in graf.vertices {
            print(graf.D2(vertex: vertex))
        }
        print(graf.X[2])
        
        
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

