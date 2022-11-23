import Foundation

extension NSNotification.Name {
    static let favorites: NSNotification.Name = NSNotification.Name(rawValue: "kFavoritesNotificationName")
    
    static let downloadAdded: NSNotification.Name = NSNotification.Name(rawValue: "kDownloadAddedNotificationName")
    static let downloadProgress: NSNotification.Name = NSNotification.Name(rawValue: "kDownloadProgressNotificationName")
    static let downloadComplete: NSNotification.Name = NSNotification.Name(rawValue: "kDownloadCompleteNotificationName")
}
