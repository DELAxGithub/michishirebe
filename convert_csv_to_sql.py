#!/usr/bin/env python3
import csv
import sys

def parse_documents(docs_str):
    """必要書類を配列形式に変換"""
    if not docs_str or docs_str == 'なし':
        return '{}'
    
    # カンマや・で区切られている場合を処理
    docs = docs_str.replace('・', ',').split(',')
    docs = [doc.strip() for doc in docs if doc.strip()]
    
    # PostgreSQL配列形式に変換
    formatted_docs = ','.join([f'"{doc}"' for doc in docs])
    return f'{{{formatted_docs}}}'

def convert_priority(priority_str):
    """優先度を英語に変換"""
    if priority_str == '高':
        return 'high'
    elif priority_str == '中':
        return 'medium'
    elif priority_str == '低':
        return 'low'
    return 'medium'  # デフォルト

def escape_sql_string(s):
    """SQL文字列のエスケープ処理"""
    if not s:
        return 'NULL'
    # シングルクォートをエスケープ
    s = s.replace("'", "''")
    return f"'{s}'"

def main():
    csv_file = 'michishirube-tasks-csv.txt'
    output_file = 'seed_procedures.sql'
    
    # ライフステージの順序マップ
    life_stage_order = {
        '元気なうち': 1,
        '介護開始時': 2,
        '入院時': 3,
        '施設入居時': 4,
        '看取り準備': 5,
        '逝去直後': 6,
        '葬儀後': 7,
        '相続手続き': 8,
        '実家管理': 9
    }
    
    with open(csv_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        
        insert_statements = []
        order_index = 1
        
        for row in reader:
            life_stage = row['ライフステージ']
            category = row['カテゴリ']
            name = row['タスク名']
            priority = convert_priority(row['優先度'])
            deadline = escape_sql_string(row['期限'])
            documents = parse_documents(row['必要書類'])
            office = escape_sql_string(row['担当窓口'])
            reason = escape_sql_string(row['理由・説明'])
            hint = escape_sql_string(row['メモ・ヒント'])
            
            insert = f"""INSERT INTO michi_procedures 
(life_stage, category, name, priority, default_deadline, required_documents, responsible_office, reason, hint, order_index) 
VALUES 
('{life_stage}', '{category}', '{name}', '{priority}', {deadline}, '{documents}', {office}, {reason}, {hint}, {order_index});"""
            
            insert_statements.append(insert)
            order_index += 1
    
    # SQLファイルに書き出し
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("-- Michi-shirube 手続きマスターデータ\n")
        f.write("-- 56件の手続きデータ\n\n")
        f.write("-- 既存データをクリア（開発環境のみ）\n")
        f.write("TRUNCATE TABLE michi_procedures RESTART IDENTITY CASCADE;\n\n")
        f.write("-- データ投入\n")
        
        for stmt in insert_statements:
            f.write(stmt + "\n")
        
        f.write("\n-- データ投入完了\n")
        f.write(f"-- 総件数: {len(insert_statements)}件\n")
    
    print(f"SQLファイルを生成しました: {output_file}")
    print(f"総レコード数: {len(insert_statements)}件")

if __name__ == "__main__":
    main()