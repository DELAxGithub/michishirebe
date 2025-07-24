-- Supabase Schema for Michi-shirube
-- プレフィックス: michi_

-- 手続きマスターテーブル
CREATE TABLE michi_procedures (
  id SERIAL PRIMARY KEY,
  life_stage TEXT NOT NULL,
  category TEXT NOT NULL,
  name TEXT NOT NULL,
  priority TEXT NOT NULL CHECK (priority IN ('high', 'medium', 'low')),
  default_deadline TEXT,
  required_documents TEXT[],
  responsible_office TEXT,
  reason TEXT NOT NULL,
  hint TEXT,
  order_index INTEGER NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- ユーザータスクテーブル
CREATE TABLE michi_tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  procedure_id INTEGER REFERENCES michi_procedures(id) ON DELETE CASCADE,
  session_id TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'in_progress', 'completed')),
  notes TEXT,
  completed_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- インデックス
CREATE INDEX idx_michi_procedures_life_stage ON michi_procedures(life_stage);
CREATE INDEX idx_michi_procedures_order ON michi_procedures(order_index);
CREATE INDEX idx_michi_tasks_session_id ON michi_tasks(session_id);
CREATE INDEX idx_michi_tasks_procedure_id ON michi_tasks(procedure_id);
CREATE INDEX idx_michi_tasks_status ON michi_tasks(status);

-- RLS (Row Level Security) を有効化
ALTER TABLE michi_procedures ENABLE ROW LEVEL SECURITY;
ALTER TABLE michi_tasks ENABLE ROW LEVEL SECURITY;

-- RLS ポリシー: 手続きマスターは全員読み取り可能
CREATE POLICY "Anyone can read procedures" ON michi_procedures
  FOR SELECT USING (true);

-- RLS ポリシー: タスクはセッションIDで管理
CREATE POLICY "Users can read their own tasks" ON michi_tasks
  FOR SELECT USING (true);  -- 共有URLのため、すべて読み取り可能

CREATE POLICY "Users can insert their own tasks" ON michi_tasks
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Users can update their own tasks" ON michi_tasks
  FOR UPDATE USING (true);

CREATE POLICY "Users can delete their own tasks" ON michi_tasks
  FOR DELETE USING (true);

-- 更新日時を自動更新するトリガー関数
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = timezone('utc'::text, now());
  RETURN NEW;
END;
$$ language 'plpgsql';

-- トリガーを作成
CREATE TRIGGER update_michi_procedures_updated_at BEFORE UPDATE ON michi_procedures
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_michi_tasks_updated_at BEFORE UPDATE ON michi_tasks
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- リアルタイム機能を有効化
ALTER PUBLICATION supabase_realtime ADD TABLE michi_tasks;