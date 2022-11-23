import Foundation

extension Date {
   
    
    func formatIso(input: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date1 = formatter.date(from: input)
        formatter.formatOptions = [.withFullDate,
                                   .withDashSeparatorInDate]
        let date2 = formatter.string(from: date1!)
        return date2
    }
    
    
    func dateFormatter(format: String, input: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: input)
        
        return date!
    }

    
    func stringDateFromatter(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: self)
    }
    
    
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"
        

         return convertDateFormatter.string(from: oldDate!)
    }
    
    
}
