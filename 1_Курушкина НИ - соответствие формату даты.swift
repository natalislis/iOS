import Foundation
import Swift

class TaskOne {
	var result = false
	var mdate = ""
	var myDD = ""
	var myMM = ""
	var myYYYY = ""
	var myHH = ""
	var myMIN = ""

	static func checkForValidity(dateString: String) -> Bool
	{
		var result = false
		// вызываем необходимую функцию в зависимости от формата строки
		if  !(dateString.isEmpty)  {
			// 1 - если строка xx.xx.xxxx
			if (dateString[dateString.index(dateString.startIndex, offsetBy: 2)] == "." 
				 && dateString[dateString.index(dateString.startIndex, offsetBy: 5)] == "."
				 && dateString.count == 10 )
			{
				result = TaskOne().checkForValidity_dd(stringdd: dateString)
			} 
			
			// 2 - если строка xx.xx.xxxx xx:xx
			else if (dateString[dateString.index(dateString.startIndex, offsetBy: 2)] == "." 
					&& dateString[dateString.index(dateString.startIndex, offsetBy: 5)] == "."
					&& dateString[dateString.index(dateString.startIndex, offsetBy: 10)] == " "
					&& dateString[dateString.index(dateString.startIndex, offsetBy: 13)] == ":"
					&& dateString.count == 16 )  
			{
				result = TaskOne().checkForValidity_dd(stringdd: String(dateString[dateString.index(dateString.startIndex, offsetBy: 0)..<dateString.index(dateString.startIndex, offsetBy: 10)])) 
						&& TaskOne().checkForValidity_tt(stringtt: String(dateString[dateString.index(dateString.startIndex, offsetBy: 11)..<dateString.index(dateString.startIndex, offsetBy: 16)]))
			}
			
			// 3 - если строка xx:xx
			else if (dateString[dateString.index(dateString.startIndex, offsetBy: 2)] == ":" 
					&& dateString.count == 5 )  
			{
				result = TaskOne().checkForValidity_tt(stringtt: dateString)
			}
		}

	return result
	}

	// функция для определения: строка xx.xx.xxxx - это дата в формате dd.mm.yyyy ?
	func checkForValidity_dd(stringdd: String) -> Bool{
		result = false
		mdate = stringdd
		
		//удаляем точки
		mdate.remove(at: mdate.index(mdate.startIndex, offsetBy: 2))
		mdate.remove(at: mdate.index(mdate.startIndex, offsetBy: 4))

		if let isDate = Int(mdate) { 
			//выделяем месяц
			myMM = String(stringdd[stringdd.index(stringdd.startIndex, offsetBy: 3)..<stringdd.index(stringdd.startIndex, offsetBy: 5)])
			if let m = Int(myMM) { 
				if (m <= 12 ) { 
				
					//выделяем год
					myYYYY = String(stringdd[stringdd.index(stringdd.startIndex, offsetBy: 6)..<stringdd.endIndex])
					if let y = Int(myYYYY) { 
						// определяем максимальное количество дней в феврале 
						var maxday02 = 28 
						// если високосный год
						if  (y < 1582 && y%4 == 0) || (y >= 1582 && (y%400 == 0 || (y%4 == 0 && y%100 != 0)))  {
							maxday02 = 29
						}
						
						//выделяем число
						myDD = String(stringdd[stringdd.index(stringdd.startIndex, offsetBy: 0)..<stringdd.index(stringdd.startIndex, offsetBy: 2)])
						if  let d = Int(myDD) { 
							if (d <= 30 && (m == 4 || m == 6 || m == 9 || m == 11)) || 
							   (d <= 31 && (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12)) ||
							   (d <= maxday02 && m == 2){ 
									result = true
							}		
						}
					}
				}		
			}
		} 
		return result	
	}

	// функция для определения: строка xx:xx - это дата/время в формате hh:mm ?
	func checkForValidity_tt(stringtt: String) -> Bool{
        result = false
		mdate = stringtt
		
		//удаляем двоеточие
		mdate.remove(at: mdate.index(mdate.startIndex, offsetBy: 2))
		
		if let isTime = Int(mdate) {
			//выделяем часы
			myHH = String(stringtt[stringtt.index(stringtt.startIndex, offsetBy: 0)..<stringtt.index(stringtt.startIndex, offsetBy: 2)])
			if  let h = Int(myHH) { 
				if (h > 0 && h < 13){  // т.к. формат hh, а не HH
					//выделяем минуты
					myMIN = String(stringtt[stringtt.index(stringtt.startIndex, offsetBy: 3)..<stringtt.index(stringtt.startIndex, offsetBy: 5)])
					if  let mi = Int(myMIN) { 
						if (mi < 60){ 
							result = true 
						}		
					}
				}		
			}
		}
		return result
	}
}

//Experiment
var string = "10.12.2009 01:49"
let res = TaskOne.checkForValidity(dateString: string)
print(res) 
