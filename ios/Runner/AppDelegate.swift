import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // if #available(iOS 13.0, *) {
    //   let appearance = UINavigationBarAppearance()
    //   appearance.configureWithOpaqueBackground()
    //   appearance.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.18, alpha: 1.0) 
    //   UINavigationBar.appearance().standardAppearance = appearance
    //   UINavigationBar.appearance().scrollEdgeAppearance = appearance
    // }
    GMSServices.provideAPIKey("AIzaSyAZbtxtkePXtOlAR9tQKnaGSmmNdLqtrtU")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
