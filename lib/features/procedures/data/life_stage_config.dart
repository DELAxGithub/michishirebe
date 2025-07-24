// ライフステージの設定情報
class LifeStageConfig {
  static const Map<String, Map<String, dynamic>> config = {
    '元気なうち': {
      'iconName': 'health_and_safety',
      'description': '事前の準備と情報収集',
      'order': 1,
    },
    '介護開始時': {
      'iconName': 'accessibility',
      'description': '介護保険の申請と手続き',
      'order': 2,
    },
    '入院時': {
      'iconName': 'local_hospital',
      'description': '入院に必要な手続きと準備',
      'order': 3,
    },
    '施設入居時': {
      'iconName': 'home',
      'description': '介護施設の選定と入居手続き',
      'order': 4,
    },
    '看取り準備': {
      'iconName': 'favorite',
      'description': '終末期の準備と意思確認',
      'order': 5,
    },
    '逝去直後': {
      'iconName': 'sentiment_very_dissatisfied',
      'description': '葬儀と死亡手続き',
      'order': 6,
    },
    '葬儀後': {
      'iconName': 'account_balance',
      'description': '行政手続きと保険関係',
      'order': 7,
    },
    '相続手続き': {
      'iconName': 'description',
      'description': '相続に関する各種手続き',
      'order': 8,
    },
    '実家管理': {
      'iconName': 'house',
      'description': '空き家の管理と処分',
      'order': 9,
    },
  };
}