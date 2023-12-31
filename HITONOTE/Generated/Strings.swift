// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// パスワードが違います。
  internal static let appLockAlert = L10n.tr("Localizable", "app_lock_alert", fallback: "パスワードが違います。")
  /// https://apps.apple.com/jp/app/hitonote/id6471915200
  internal static let appUrl = L10n.tr("Localizable", "app_url", fallback: "https://apps.apple.com/jp/app/hitonote/id6471915200")
  /// yyyy年M月dd日
  internal static let dateFormat = L10n.tr("Localizable", "date_format", fallback: "yyyy年M月dd日")
  /// ja_JP
  internal static let dateLocale = L10n.tr("Localizable", "date_locale", fallback: "ja_JP")
  /// 「%@」さんを削除しますか？
  internal static func deleteButtonAlertTitle(_ p1: Any) -> String {
    return L10n.tr("Localizable", "delete_button_alert_title", String(describing: p1), fallback: "「%@」さんを削除しますか？")
  }
  /// 削除
  internal static let deleteButtonTitle = L10n.tr("Localizable", "delete_button_title", fallback: "削除")
  /// 男性
  internal static let genderMan = L10n.tr("Localizable", "gender_man", fallback: "男性")
  /// その他
  internal static let genderOther = L10n.tr("Localizable", "gender_other", fallback: "その他")
  /// 未設定
  internal static let genderUnknown = L10n.tr("Localizable", "gender_unknown", fallback: "未設定")
  /// 女性
  internal static let genderWoman = L10n.tr("Localizable", "gender_woman", fallback: "女性")
  /// 決定
  internal static let inputBirthdayDecision = L10n.tr("Localizable", "input_birthday_decision", fallback: "決定")
  /// 誕生日を設定する
  internal static let inputBirthdaySetting = L10n.tr("Localizable", "input_birthday_setting", fallback: "誕生日を設定する")
  /// 新しいグループ
  internal static let inputPersonGroup = L10n.tr("Localizable", "input_person_group", fallback: "新しいグループ")
  /// 「%@」さんを登録しました。
  internal static func inputSuccessAlertCreate(_ p1: Any) -> String {
    return L10n.tr("Localizable", "input_success_alert_create", String(describing: p1), fallback: "「%@」さんを登録しました。")
  }
  /// データを更新しました。
  internal static let inputSuccessAlertUpdate = L10n.tr("Localizable", "input_success_alert_update", fallback: "データを更新しました。")
  /// 名前は必須入力です。
  internal static let inputValidationTitle = L10n.tr("Localizable", "input_validation_title", fallback: "名前は必須入力です。")
  /// 無効なURLです。
  internal static let inputValidationUrlTitle = L10n.tr("Localizable", "input_validation_url_title", fallback: "無効なURLです。")
  /// Localizable.strings
  ///   HITONOTE
  /// 
  ///   Created by t&a on 2023/11/09.
  internal static let onboarding1Title = L10n.tr("Localizable", "onboarding1_title", fallback: "お客さんや友達、生徒さんなど\n人の情報を見やすく管理できるメモアプリ")
  /// 項目は表示/非表示を切り替えられるので
  /// 必要な情報のみにカスタマイズ可能
  internal static let onboarding2Title = L10n.tr("Localizable", "onboarding2_title", fallback: "項目は表示/非表示を切り替えられるので\n必要な情報のみにカスタマイズ可能")
  /// アプリにロックがかけられるので
  /// 大事な情報を外部に漏らさない
  internal static let onboarding3Title = L10n.tr("Localizable", "onboarding3_title", fallback: "アプリにロックがかけられるので\n大事な情報を外部に漏らさない")
  /// 次へ
  internal static let onboardingNext = L10n.tr("Localizable", "onboarding_next", fallback: "次へ")
  /// はじめる
  internal static let onboardingStart = L10n.tr("Localizable", "onboarding_start", fallback: "はじめる")
  /// 年齢
  internal static let personAge = L10n.tr("Localizable", "person_age", fallback: "年齢")
  /// %@歳
  internal static func personAgeView(_ p1: Any) -> String {
    return L10n.tr("Localizable", "person_age_view", String(describing: p1), fallback: "%@歳")
  }
  /// 誕生日
  internal static let personBirthday = L10n.tr("Localizable", "person_birthday", fallback: "誕生日")
  /// こんな人
  internal static let personCharacter = L10n.tr("Localizable", "person_character", fallback: "こんな人")
  /// 性別
  internal static let personGender = L10n.tr("Localizable", "person_gender", fallback: "性別")
  /// グループ
  internal static let personGroup = L10n.tr("Localizable", "person_group", fallback: "グループ")
  /// 画像
  internal static let personImagePath = L10n.tr("Localizable", "person_imagePath", fallback: "画像")
  /// メール
  internal static let personMail = L10n.tr("Localizable", "person_mail", fallback: "メール")
  /// メモ
  internal static let personMemo = L10n.tr("Localizable", "person_memo", fallback: "メモ")
  /// 名前
  internal static let personName = L10n.tr("Localizable", "person_name", fallback: "名前")
  /// ふりがな
  internal static let personRuby = L10n.tr("Localizable", "person_ruby", fallback: "ふりがな")
  /// 電話
  internal static let personTell = L10n.tr("Localizable", "person_tell", fallback: "電話")
  /// URL
  internal static let personUrl = L10n.tr("Localizable", "person_url", fallback: "URL")
  /// 職業
  internal static let personWork = L10n.tr("Localizable", "person_work", fallback: "職業")
  /// 登録
  internal static let settingAppLockEntry = L10n.tr("Localizable", "setting_app_lock_entry", fallback: "登録")
  /// パスワードを登録
  internal static let settingAppLockTitle = L10n.tr("Localizable", "setting_app_lock_title", fallback: "パスワードを登録")
  /// アプリ設定
  internal static let settingAppSetting = L10n.tr("Localizable", "setting_app_setting", fallback: "アプリ設定")
  /// アプリに関する設定を変更でき、変更した値は保存されます。
  /// 登録したロックパスワードはOFFにするとリセットされます。
  internal static let settingAppSettingDesc = L10n.tr("Localizable", "setting_app_setting_desc", fallback: "アプリに関する設定を変更でき、変更した値は保存されます。\n登録したロックパスワードはOFFにするとリセットされます。")
  /// ONにしている項目が詳細や登録ページに表示されます。
  /// OFFにしている項目は非表示になります。
  internal static let settingDisplayItemDesc = L10n.tr("Localizable", "setting_display_item_desc", fallback: "ONにしている項目が詳細や登録ページに表示されます。\nOFFにしている項目は非表示になります。")
  /// 項目
  internal static let settingDisplayItemLabel = L10n.tr("Localizable", "setting_display_item_label", fallback: "項目")
  /// 表示する項目のカスタマイズ
  internal static let settingDisplayItemTitle = L10n.tr("Localizable", "setting_display_item_title", fallback: "表示する項目のカスタマイズ")
  /// 友達や顧客、生徒など人の情報をメモしたい人におすすめだよ♪
  internal static let settingRecommendShareText = L10n.tr("Localizable", "setting_recommend_share_text", fallback: "友達や顧客、生徒など人の情報をメモしたい人におすすめだよ♪")
  /// 「HITONOTE」をオススメする
  internal static let settingRecommendTitle = L10n.tr("Localizable", "setting_recommend_title", fallback: "「HITONOTE」をオススメする")
  /// アプリをレビューする
  internal static let settingReviewTitle = L10n.tr("Localizable", "setting_review_title", fallback: "アプリをレビューする")
  /// ?action=write-review
  internal static let settingReviewUrlQuery = L10n.tr("Localizable", "setting_review_url_query", fallback: "?action=write-review")
  /// 利用規約とプライバシーポリシー
  internal static let settingTermsOfServiceTitle = L10n.tr("Localizable", "setting_terms_of_service_title", fallback: "利用規約とプライバシーポリシー")
  /// https://tech.amefure.com/app-terms-of-service
  internal static let settingTermsOfServiceUrl = L10n.tr("Localizable", "setting_terms_of_service_url", fallback: "https://tech.amefure.com/app-terms-of-service")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
