-- Michi-shirube 手続きマスターデータ
-- 56件の手続きデータ

-- 既存データをクリア（開発環境のみ）
TRUNCATE TABLE michi_procedures RESTART IDENTITY CASCADE;

-- データ投入
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('元気なうち', '準備', '家族で介護方針を話し合う', 'high', 'なし', '{}', '家族', '緊急時の連絡体制や役割分担を決めておくため', '特に遠方に住んでいる場合は重要', 1);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('元気なうち', '準備', '親の希望を確認する', 'high', 'なし', '{}', '本人・家族', '介護場所や延命措置の意思確認のため', 'エンディングノートの活用も検討', 2);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('元気なうち', '情報収集', '公的制度や選択肢の情報収集', 'medium', 'なし', '{}', '地域包括支援センター', '要介護認定や施設の基礎知識を得るため', '自治体窓口の連絡先も把握', 3);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('元気なうち', '準備', '緊急連絡先リストの作成', 'high', 'なし', '{}', '家族', '親戚・かかりつけ医・ケアマネなどの連絡先整理', 'すぐ取り出せる場所に保管', 4);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('元気なうち', '準備', '重要書類と資産情報の整理', 'high', 'なし', '{"保険証券","年金手帳","通帳等"}', '家族', '相続時に必要な情報を事前整理', 'デジタルアカウントのID・パスワードも', 5);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('元気なうち', '準備', '遺言書作成の検討', 'medium', 'なし', '{"印鑑","財産目録"}', '公証役場・司法書士', '相続手続きを円滑にするため', '自筆証書遺言は要件に注意', 6);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('介護開始時', '手続き', '要介護認定の申請', 'high', '速やかに', '{"介護保険証","印鑑"}', '市区町村介護保険課', '介護サービスを受けるための必須手続き', '認定まで約1ヶ月かかる', 7);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('介護開始時', '手続き', '認定調査への同席', 'high', '調査日', '{}', '自宅等', '適切な介護度判定を受けるため', '本人は「できる」と答えがち', 8);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('介護開始時', '連絡調整', 'ケアマネージャーとの相談', 'high', '認定後速やかに', '{"介護保険証"}', 'ケアマネ事務所', 'ケアプラン作成のため', 'メール等で連絡が取れるか確認', 9);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('介護開始時', '準備', '住宅の安全確認と改修', 'medium', 'なし', '{}', '福祉用具業者', '転倒防止のため', '手すり設置や段差解消', 10);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('介護開始時', '金銭管理', '介護費用の確認', 'medium', 'なし', '{"年金額","預金残高"}', '家族', '家計の見直しのため', '高額介護サービス費の確認も', 11);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('入院時', '手続き', '救急対応と情報提供', 'high', '即時', '{"保険証","お薬手帳"}', '救急隊・医療機関', '迅速・的確な処置のため', '黒い便など気になる症状は必ず伝える', 12);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('入院時', '手続き', '入院手続きと書類記入', 'high', '入院当日', '{"健康保険証","印鑑"}', '病院受付', '入院契約や同意書の記入', '同じ情報を何度も書くことが多い', 13);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('入院時', '連絡調整', '他の親族のケア手配', 'high', '速やかに', '{}', 'ケアマネージャー', '配偶者等の介護継続のため', 'ショートステイの活用を検討', 14);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('入院時', '情報収集', '治療方針の確認と共有', 'high', '説明後速やかに', '{}', '主治医', '家族で情報共有するため', '余命の目安なども正確に理解', 15);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('入院時', '金銭管理', '入院費用の確認と保険請求', 'medium', '退院後', '{"診断書","保険証券"}', '保険会社', '医療費負担軽減のため', '高額療養費制度の確認も', 16);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('入院時', '準備', '退院後の計画準備', 'medium', '退院前', '{}', '退院支援担当者', 'スムーズな退院のため', '転院か在宅介護か検討', 17);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('施設入居時', '情報収集', '希望条件の整理', 'high', 'なし', '{}', '家族', '適切な施設選びのため', '予算・立地・サービス内容を明確化', 18);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('施設入居時', '情報収集', '施設種類と受け入れ要件の確認', 'high', 'なし', '{}', 'ケアマネージャー', '親の状態に合った施設選定のため', '特養・老健・有料の違いを理解', 19);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('施設入居時', '情報収集', '情報収集と資料請求', 'medium', 'なし', '{}', '各施設', '比較検討のため', '直接問い合わせがお得', 20);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('施設入居時', '準備', '施設見学と評価', 'high', '入居前', '{}', '各施設', '雰囲気や実態確認のため', '食事時間帯の見学がおすすめ', 21);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('施設入居時', '手続き', '入居申込みと面談', 'high', '見学後', '{"診療情報提供書"}', '施設', '入居可否判定のため', '医療依存度の確認あり', 22);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('施設入居時', '手続き', '入居契約と引越し準備', 'high', '入居前', '{"印鑑","身分証明書"}', '施設', '正式な入居手続き', '身元引受人が必要', 23);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('看取り準備', '準備', '延命治療の意思確認', 'high', '元気なうちに', '{}', '本人・家族', '最期の医療方針決定のため', '書面で残すことも検討', 24);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('看取り準備', '準備', '葬儀社の選定・事前相談', 'medium', 'なし', '{}', '葬儀社', 'いざという時に慌てないため', '複数社で見積もり比較', 25);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('看取り準備', '準備', '訃報連絡リストの整備', 'medium', 'なし', '{}', '家族', '速やかな連絡のため', '電話番号の再確認', 26);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('看取り準備', '連絡調整', '最期の付き添い体制', 'high', '容態悪化時', '{}', '家族・施設', '看取りのため', '交代で付き添える体制を', 27);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('逝去直後', '手続き', '死亡診断書の受領', 'high', '逝去後即時', '{}', '医師', '以降の手続きに必須', '原本を複数コピー', 28);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('逝去直後', '連絡調整', '親族への訃報連絡', 'high', '逝去後速やかに', '{"連絡先リスト"}', '家族', '葬儀参列確認のため', '深夜早朝は配慮', 29);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('逝去直後', '手続き', '遺体の搬送と安置', 'high', '逝去後即時', '{}', '葬儀社', '適切な遺体管理のため', '葬儀社への連絡', 30);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('逝去直後', '手続き', '死亡届の提出', 'high', '7日以内', '{"死亡診断書","印鑑"}', '市区町村役場', '法的義務', '火葬許可証も同時取得', 31);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('逝去直後', '準備', '葬儀日程の調整', 'high', '死亡届提出後', '{}', '葬儀社・火葬場', '火葬場予約のため', '親族の都合も考慮', 32);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('逝去直後', '準備', '葬儀形式と規模の決定', 'high', '葬儀前', '{"遺影写真"}', '葬儀社・寺院', '適切な葬儀執行のため', '家族葬か一般葬か', 33);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('葬儀後', '手続き', '健康保険の資格喪失手続き', 'high', '14日以内', '{"保険証","印鑑"}', '市区町村役場', '法的義務', '埋葬料の申請も確認', 34);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('葬儀後', '手続き', '介護保険証の返却', 'high', '14日以内', '{"介護保険証"}', '市区町村介護保険課', '法的義務', '未精算分の確認も', 35);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('葬儀後', '手続き', '年金受給停止手続き', 'high', '厚年10日・国年14日以内', '{"年金証書","戸籍謄本"}', '年金事務所', '過払い防止のため', '遺族年金の申請も', 36);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('葬儀後', '手続き', '世帯主変更届', 'high', '14日以内', '{"印鑑","身分証明書"}', '市区町村役場', '世帯構成変更のため', '公共料金の引落口座変更も', 37);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('葬儀後', '手続き', '公共料金の名義変更', 'medium', '速やかに', '{}', '各事業者', '継続利用のため', '故人名義は解約か変更', 38);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('葬儀後', '準備', '未払い費用の清算', 'medium', '請求後速やかに', '{"請求書"}', '各機関', '債務整理のため', '領収書は相続税申告用に保管', 39);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '準備', '相続人の確定', 'high', '速やかに', '{"戸籍謄本"}', '市区町村役場', '相続手続きの前提', '出生から死亡まで連続した戸籍', 40);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '準備', '遺言書の確認', 'high', '速やかに', '{"遺言書"}', '家庭裁判所', '遺産分割方針決定のため', '自筆証書遺言は検認必要', 41);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '手続き', '相続放棄・限定承認の判断', 'high', '3ヶ月以内', '{"戸籍謄本","印鑑"}', '家庭裁判所', '債務超過の場合の選択', '期限厳守', 42);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '準備', '遺産目録の作成', 'high', '速やかに', '{"通帳","証券","権利証等"}', '家族', '遺産総額把握のため', '債務も含めて整理', 43);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '準備', '遺産分割協議', 'high', 'なし', '{"印鑑証明書"}', '相続人全員', '遺産分配決定のため', '協議書作成が必要', 44);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '手続き', '預貯金の名義変更・払い戻し', 'medium', 'なし', '{"戸籍謄本","遺産分割協議書"}', '各金融機関', '相続財産の処理', '各行で必要書類が異なる', 45);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '手続き', '不動産の相続登記', 'high', '死亡後3年以内', '{"戸籍謄本","遺産分割協議書","登記申請書"}', '法務局', '2024年より義務化', '登録免許税の計算必要', 46);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '手続き', '自動車の名義変更', 'medium', 'なし', '{"戸籍謄本","車検証"}', '運輸支局', '所有権移転のため', '廃車の場合も名義変更後', 47);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '金銭管理', '生命保険金の請求', 'medium', '3年以内', '{"死亡診断書","保険証券"}', '保険会社', '保険金受領のため', 'みなし相続財産として課税対象', 48);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '手続き', '準確定申告', 'high', '4ヶ月以内', '{"源泉徴収票","医療費領収書"}', '税務署', '所得税精算のため', '医療費控除の適用可能', 49);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('相続手続き', '手続き', '相続税申告・納付', 'high', '10ヶ月以内', '{"各種評価資料"}', '税務署', '基礎控除超過時の義務', '3000万+600万×法定相続人数', 50);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('実家管理', '手続き', '電気・ガス・水道の停止', 'medium', '退去時', '{}', '各事業者', '空き家の安全管理', '水道は最低限維持も検討', 51);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('実家管理', '手続き', '固定電話・ネット回線の解約', 'medium', '退去時', '{}', '通信事業者', '不要な支出削減', '機器返却の立ち会い必要', 52);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('実家管理', '手続き', '郵便物の転送届', 'high', '退去前', '{"印鑑"}', '郵便局', '重要書類の見逃し防止', '1年間有効・更新可能', 53);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('実家管理', '準備', '防犯対策', 'medium', '退去後', '{}', '家族', '空き家の安全確保', '定期的な見回り必要', 54);
INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('実家管理', '手続き', '各種サービスの解約', 'low', 'なし', '{}', '各事業者', '新聞・NHK・サブスク等', '二段階認証は回線停止前に', 55);

-- データ投入完了
-- 総件数: 55件
