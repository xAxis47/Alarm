//
//  EditorialType.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2024/06/20.
//

import Foundation

enum Constant {
    
    static let alarm = "アラーム"
    static let blank = ""
    static let cancel = "キャンセル"
    static let conflictAlertBody = "この時間は登録できません。別の時間を登録してください。"
    static let conflictAlertTitle = "すでに同じ時間が登録されています。"
    static let delete = "削除する"
    static let deleteEnglish = "delete"
    static let everyday = "毎日"
    static let goodMorning = "起床"
    static let initialDate = Date(timeIntervalSince1970: 0)
    static let initialTitle = ""
    static let isOn = "アラームをかける"
    static let japaneseIdentifier = "ja_JP"
    static let letsStart = "始ましょう"
    static let limitAlertTitle = "登録出来る上限を超えたアラームを登録しようとしています。"
    static let limitAlertBody = "登録しているアラームを整理してください。"
    static let nextDay = 1
    static let other = "その他"
    static let refreshIdentifier = "com.gmail.dev.kawagoe.wataru.schedule"
    static let repetition = "繰り返し"
    static let today = 0
    static let timeSetting = "時間の設定"
    static let title = "タイトル"
    static let save = "保存"
    static let silence = "forsilence.mp3"
    static let snooze = "スヌーズ"
    static let snoozeTimeInterval = 60 * 1
    static let soundLength = 29
    static let suffix00 = "00"
    static let suffix01 = "01"
    static let suffix02 = "02"
    static let suffix03 = "03"
    static let suffix04 = "04"
    static let suffix05 = "05"
    static let testSound = "sound.mp3"
    static let timeHasCome = "時間になりました"
    static let zeroTrueAlertBody = "どれか一つの曜日を必ず選択してください。"
    static let zeroTrueAlertTitle = "最低限一つの曜日を選択する必要があります。"
    
    static let singleComma = ","
    
    static let falseFlag = Flag(bool: false)
    static let trueFlag = Flag(bool: true)
    
    static let falseArray = [falseFlag, falseFlag, falseFlag, falseFlag, falseFlag, falseFlag, falseFlag]
    static let trueArray = [trueFlag, trueFlag, trueFlag, trueFlag, trueFlag, trueFlag, trueFlag]
    
    static let dayArray = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
    static let dayInitialsArray = ["日", "月", "火", "水", "木", "金", "土"]
    
}

enum EditorialType: String {
    
    case add
    case edit
    
}
