// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// https://apps.apple.com/jp/app/stock-持ち物リスト/id6466220771
  internal static let appUrl = L10n.tr("Localizable", "app_url", fallback: "https://apps.apple.com/jp/app/stock-持ち物リスト/id6466220771")
  /// 広告を視聴できるのは1日に1回までです。
  internal static let dialogAdmobText = L10n.tr("Localizable", "dialog_admob_text", fallback: "広告を視聴できるのは1日に1回までです。")
  /// お知らせ
  internal static let dialogAdmobTitle = L10n.tr("Localizable", "dialog_admob_title", fallback: "お知らせ")
  /// 男性
  internal static let genderMan = L10n.tr("Localizable", "gender_man", fallback: "男性")
  /// その他
  internal static let genderOther = L10n.tr("Localizable", "gender_other", fallback: "その他")
  /// 未設定
  internal static let genderUnknown = L10n.tr("Localizable", "gender_unknown", fallback: "未設定")
  /// 女性
  internal static let genderWoman = L10n.tr("Localizable", "gender_woman", fallback: "女性")
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
  /// Localizable.strings
  ///   HITONOTE
  /// 
  ///   Created by t&a on 2023/11/09.
  internal static let personName = L10n.tr("Localizable", "person_name", fallback: "名前")
  /// ふりがな
  internal static let personRuby = L10n.tr("Localizable", "person_ruby", fallback: "ふりがな")
  /// 電話
  internal static let personTell = L10n.tr("Localizable", "person_tell", fallback: "電話")
  /// 職業
  internal static let personWork = L10n.tr("Localizable", "person_work", fallback: "職業")
  /// 広告を視聴して容量を追加する
  internal static let settingAdmobTitle = L10n.tr("Localizable", "setting_admob_title", fallback: "広告を視聴して容量を追加する")
  /// 広告の準備ができていません
  internal static let settingAdmobTitleDisable = L10n.tr("Localizable", "setting_admob_title_disable", fallback: "広告の準備ができていません")
  /// ・追加される容量は3個です。
  /// ・容量の追加は1日に1回までです。
  internal static let settingCapacitySectionFooter = L10n.tr("Localizable", "setting_capacity_section_footer", fallback: "・追加される容量は3個です。\n・容量の追加は1日に1回までです。")
  /// 広告
  internal static let settingCapacitySectionTitle = L10n.tr("Localizable", "setting_capacity_section_title", fallback: "広告")
  /// 現在の容量: %@個
  internal static func settingCapacityText(_ p1: Any) -> String {
    return L10n.tr("Localizable", "setting_capacity_text_%@", String(describing: p1), fallback: "現在の容量: %@個")
  }
  /// お出かけ前の忘れ物チェックにはこのアプリがおすすめ！
  internal static let settingRecommendShareText = L10n.tr("Localizable", "setting_recommend_share_text", fallback: "お出かけ前の忘れ物チェックにはこのアプリがおすすめ！")
  /// 「Stock」をオススメする
  internal static let settingRecommendTitle = L10n.tr("Localizable", "setting_recommend_title", fallback: "「Stock」をオススメする")
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
