PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS alert_events;
DROP TABLE IF EXISTS alerts;
DROP TABLE IF EXISTS projects;

CREATE TABLE projects (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  key TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL
);

CREATE TABLE alerts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  project_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  severity TEXT NOT NULL CHECK (severity IN ('low','medium','high')),
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE TABLE alert_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  alert_id INTEGER NOT NULL,
  type TEXT NOT NULL,
  payload TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  FOREIGN KEY (alert_id) REFERENCES alerts(id) ON DELETE CASCADE
);

CREATE INDEX idx_projects_key ON projects(key);
CREATE INDEX idx_alerts_project_id ON alerts(project_id);
CREATE INDEX idx_alert_events_alert_id ON alert_events(alert_id);

INSERT INTO projects (key, name) VALUES
  ('first', 'First project'),
  ('second', 'Second project'),
  ('third', 'Third project');

INSERT INTO alerts (project_id, title, severity, created_at) VALUES
  (1, 'First alert with test title', 'high',   datetime('now','-2 hours')),
  (1, 'First alert with medium severity', 'medium', datetime('now','-1 hours')),
  (1, 'Second alert with medium severity', 'medium', datetime('now','-1 hours')),
  (1, 'Third alert with medium severity', 'medium', datetime('now','-1 hours')),
  (2, 'One more alert',     'low',    datetime('now','-30 minutes'));

INSERT INTO alert_events (alert_id, type, payload, created_at) VALUES
  (1, 'created', '{"source":"seed"}', datetime('now','-2 hours')),
  (1, 'acked',   '{"user":"demo"}',   datetime('now','-110 minutes')),
  (2, 'created', '{"source":"seed"}', datetime('now','-1 hours')),
  (3, 'created', '{"source":"seed"}', datetime('now','-30 minutes'));
