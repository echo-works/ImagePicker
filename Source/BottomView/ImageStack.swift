import UIKit
import Photos

open class ImageStack {

  public struct Notifications {
    public static let imageDidPush = "imageDidPush"
    public static let imageDidDrop = "imageDidDrop"
    public static let stackDidReload = "stackDidReload"
  }

  open var assets = [AssetRef]()
  fileprivate let imageKey = "image"

  open func pushAsset(_ asset: AssetRef) {
    assets.append(asset)
    NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.imageDidPush), object: self, userInfo: [imageKey: asset])
  }

  open func dropAsset(_ asset: AssetRef) {
    assets = assets.filter {$0 != asset}
    NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.imageDidDrop), object: self, userInfo: [imageKey: asset])
  }

  open func resetAssets(_ assetsArray: [AssetRef]) {
    assets = assetsArray
    NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.stackDidReload), object: self, userInfo: nil)
  }

  open func containsAsset(_ asset: AssetRef) -> Bool {
    return assets.contains(asset)
  }
}
