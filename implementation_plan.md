# 日報自動生成アプリ 実装計画

## アプリ概要

Toggl Track（作業時間）と GitHub（コミット履歴）から情報を取得し、日報を自動生成するアプリ。

**GraphQL の利点**: チェックボックスで選択した情報だけを **1回のリクエスト** で取得できる

---

## 画面イメージ

```
┌─────────────────────────────────────────┐
│  日報作成                                │
├─────────────────────────────────────────┤
│  日付: [2026/01/09 ▼]                   │
│                                         │
│  ─── 自動取得する情報 ───                │
│  ☑ 作業時間（Toggl Track）              │
│  ☑ コミット履歴（GitHub）               │
│  ☑ 週間稼働サマリー                     │
│                                         │
│  [日報を自動生成]                        │
│                                         │
│  ─── 日報内容 ───                       │
│  ┌───────────────────────────────────┐  │
│  │ * やったこと                      │  │
│  │    * 9:00 ~ 9:30 朝会 30m         │  │
│  │    * 9:30 ~ 12:00 開発 2h30m      │  │
│  │       * fix: ログインバグ修正     │  │
│  │ * 今週の稼働時間                  │  │
│  │    * 朝会: 4h50m                  │  │
│  └───────────────────────────────────┘  │
│                                         │
│  [コピー]              [保存]           │
└─────────────────────────────────────────┘
```

---

## ファイル構成

| ファイル | 配置場所 | 役割 |
|---------|---------|------|
| `toggl_api_client.rb` | `app/models/` | Toggl API との通信 |
| `github_api_client.rb` | `app/models/` | GitHub API との通信 |
| `daily_report_helper.rb` | `app/helpers/` | 日報フォーマットに整形 |
| `query_type.rb` | `app/graphql/types/` | GraphQL クエリ定義 |
| `daily_report_form_controller.js` | `app/javascript/controllers/` | フロントエンド |

---

## 実装フェーズ

### Phase 1: 環境準備 ✅ 一部完了

- [x] Faraday gem 追加
- [ ] graphql-ruby gem 追加
- [ ] credentials に GitHub トークン追加

---

### Phase 2: API クライアント実装

#### Step 2-1: TogglApiClient

**ファイル:** `app/models/toggl_api_client.rb`

- [ ] クラス定義 + BASE_URL 定数
- [ ] `initialize`: credentials から API トークン取得
- [ ] `connection`: Faraday で Basic 認証設定
- [ ] `fetch_time_entries(date)`: 日付指定でエントリ取得
- [ ] `fetch_weekly_summary(start_date, end_date)`: 週間サマリー取得
- [ ] rails c で動作確認

#### Step 2-2: GithubApiClient

**ファイル:** `app/models/github_api_client.rb`

- [ ] クラス定義 + BASE_URL 定数
- [ ] `initialize`: credentials からトークン・ユーザー名取得
- [ ] `connection`: Faraday で Bearer 認証設定
- [ ] `fetch_commits(date)`: 日付指定でコミット取得
- [ ] rails c で動作確認

---

### Phase 3: GraphQL 実装

#### Step 3-1: gem インストール

- [ ] `gem 'graphql'` を Gemfile に追加
- [ ] `bundle install`
- [ ] `rails generate graphql:install`

#### Step 3-2: 型定義

**ファイル:** `app/graphql/types/`

- [ ] `toggl_entry_type.rb` 作成
  ```graphql
  type TogglEntry {
    id: ID!
    description: String
    startTime: String!
    endTime: String
    duration: Int!
    projectName: String
  }
  ```

- [ ] `github_commit_type.rb` 作成
  ```graphql
  type GithubCommit {
    sha: String!
    message: String!
    repository: String!
    committedAt: String!
  }
  ```

- [ ] `project_summary_type.rb` 作成
  ```graphql
  type ProjectSummary {
    projectName: String!
    totalSeconds: Int!
  }
  ```

#### Step 3-3: Query 定義

**ファイル:** `app/graphql/types/query_type.rb`

- [ ] `togglEntries(date: String!)` フィールド追加
- [ ] `githubCommits(date: String!)` フィールド追加
- [ ] `weeklySummary(startDate: String!, endDate: String!)` フィールド追加

#### Step 3-4: 動作確認

- [ ] `rails s` でサーバー起動
- [ ] GraphiQL (`http://localhost:3000/graphiql`) で各クエリをテスト

---

### Phase 4: Helper 実装

**ファイル:** `app/helpers/daily_report_helper.rb`

- [ ] `format_duration(seconds)`: 秒 → "Xh Ym" 形式
- [ ] `format_time_range(start_time, end_time)`: "9:00 ~ 10:30" 形式
- [ ] `format_time_entry(entry)`: Toggl エントリ1件の整形
- [ ] `format_commit(commit)`: コミット1件の整形
- [ ] `format_weekly_summary(summaries)`: 週間サマリーの整形
- [ ] `format_daily_report(toggl_entries, github_commits, weekly_summary)`: 全体整形

---

### Phase 5: フロントエンド実装

#### Step 5-1: ビュー修正

**ファイル:** `app/views/daily_reports/new.html.haml`

- [ ] チェックボックス追加（Toggl / GitHub / 週間サマリー）
- [ ] 「日報を自動生成」ボタン追加
- [ ] Stimulus controller を接続 (`data-controller="daily-report-form"`)

#### Step 5-2: Stimulus コントローラー

**ファイル:** `app/javascript/controllers/daily_report_form_controller.js`

- [ ] `connect()`: 初期化
- [ ] `generate()`: 生成ボタンクリック時の処理
  - [ ] チェックボックスの状態を取得
  - [ ] GraphQL クエリを動的に組み立て
  - [ ] fetch で `/graphql` に POST
  - [ ] 結果を日報フォーマットに整形
  - [ ] テキストエリアに表示
- [ ] `copy()`: コピーボタンの処理
- [ ] ローディング表示
- [ ] エラーハンドリング

---

### Phase 6: 動作確認・調整

- [ ] 新規作成画面で全機能テスト
  - [ ] Toggl のみチェック → 作業時間だけ表示
  - [ ] GitHub のみチェック → コミットだけ表示
  - [ ] 全部チェック → 全部表示
- [ ] 編集画面でも動作確認
- [ ] エラーケースの確認（API エラー、認証エラー等）
- [ ] UI 調整

---

## credentials 設定

```yaml
toggl_api_token: xxxxxxxxxxxx
github_token: ghp_xxxxxxxxxxxx
github_username: your-username
```

---

## API リファレンス

### Toggl Track API

**認証:** Basic認証
```
Username: {API Token}
Password: api_token
```

**タイムエントリ取得:**
```
GET https://api.track.toggl.com/api/v9/me/time_entries
Query: start_date={ISO8601}&end_date={ISO8601}
```

### GitHub API

**認証:** Bearer Token
```
Authorization: Bearer {Personal Access Token}
```

**ユーザーイベント取得:**
```
GET https://api.github.com/users/{username}/events
```

---

## GraphQL クエリ例

```graphql
# 全部取得
query {
  togglEntries(date: "2026-01-09") {
    startTime
    endTime
    duration
    projectName
    description
  }
  githubCommits(date: "2026-01-09") {
    message
    repository
    committedAt
  }
  weeklySummary(startDate: "2026-01-06", endDate: "2026-01-10") {
    projectName
    totalSeconds
  }
}

# Toggl だけ
query {
  togglEntries(date: "2026-01-09") {
    startTime
    endTime
    duration
    projectName
  }
}
```

---

## 出力フォーマット例

```
* やったこと
   * 9:00 ~ 9:30 朝会 30m
   * 9:30 ~ 12:00 b-soccer-accompany 2h30m
      * fix: ログインバグ修正 (GitHub)
      * feat: ユーザー一覧追加 (GitHub)
* 今日やること
   *
* 抱えているタスク
   *
* 今週(月〜金)の稼働時間
   * 朝会/KPT/レビュー等: 4h50m
   * b-soccer-accompany: 20h5m
* 相談
   * なし
```
