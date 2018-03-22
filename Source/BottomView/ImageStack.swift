import UIKit
import Photos

open class ImageStack {

  public struct Notifications {
    public static let imageDidPush = "imageDidPush"
    public static let imageDidDrop = "imageDidDrop"
    public static let stackDidReload = "stackDidReload"
  }

  open var assets = [ImagePickerAsset]()
  fileprivate let imageKey = "image"

  open func pushAsset(_ asset: ImagePickerAsset) {
    assets.append(asset)
    NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.imageDidPush), object: self, userInfo: [imageKey: asset])
  }

  open func dropAsset(_ asset: ImagePickerAsset) {
    assets = assets.filter {$0 != asset}
    NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.imageDidDrop), object: self, userInfo: [imageKey: asset])
  }

  open func resetAssets(_ assetsArray: [ImagePickerAsset]) {
    assets = assetsArray
    NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.stackDidReload), object: self, userInfo: nil)
  }

  open func containsAsset(_ asset: ImagePickerAsset) -> Bool {
    return assets.contains(asset)
  }
}
