# コンテキスト

Rails + GraphQL + Toggl Track APIを使った日報自動生成アプリを開発中です。

## アプリ概要
- 日報のCRUD機能(Rails標準)
- 日報新規作成画面で「日報フォーマットを生成」ボタンを押すと、Toggl Track APIからデータを取得し、日報フォーマットに整形してフォームに表示する(GraphQL Query使用)
- コピーボタンでGoogleドキュメントに貼り付け可能

## 技術スタック
- Rails 8.1
- PostgreSQL
- GraphQL(graphql-ruby gem) - Toggl API連携部分のみ
- Hotwire(Stimulus) - フロントエンド
- Faraday - HTTP通信

## データモデル
```ruby
# DailyReport
- id: integer
- report_date: date (not null, unique)
- content: text (not null)
- created_at: datetime
- updated_at: datetime
```

## 現在の進捗状況
- toggl apiに向けて通信を行うところから

## これから実装する内容(フェーズ4)
Toggl Track API連携部分を実装します。

### 必要なファイル
1. `app/services/toggl_api_client.rb` - Toggl API通信クライアント
2. `app/services/daily_report_formatter.rb` - APIレスポンスを日報フォーマットに整形

### credentials設定
`rails credentials:edit`で以下を追加済み:
```yaml
toggl_api_token: [実際のトークン]
```

### 期待する日報フォーマット例
```
* やったこと
   * 9:00 ~ 9:30 朝会 30m
   * 9:30 ~ 12:00 b-soccer-accompany 2h30m
      * 動作確認
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

# 依頼内容
フェーズ4のToggl API連携部分を実装してください。実装後、`rails c`でAPIが正しく動作するか確認できるコードも提示してください。


## フェーズ4: Toggl API連携 (1時間) 11:30-12:30
- [X] *credentials設定 `rails credentials:edit` で `toggl_api_token: your_token_here` を追加*
- [ ] `app/services/toggl_api_client.rb`作成
  - [ ] なぜservices/toggl_api_client.rbを作るのか？
    - 私はあまりRailsアプリでapi通信を行ったことがないので、基本がわかってない
  - [ ] model/toggl_api_client.rbではダメなのか？
- [ ] `rails c`でToggl API動作確認
- [ ] フォーマット生成テスト

## フェーズ5: GraphQL Query実装 (1時間) 13:30-14:30
- [ ] `app/graphql/types/query_type.rb`に`generate_daily_report_content`フィールド追加
- [ ] GraphiQL起動 `http://localhost:3000/graphiql`
- [ ] GraphiQLでクエリテスト
- [ ] エラーハンドリング確認
- [ ] 正常系・異常系テスト

## フェーズ6: Stimulus連携 (1.5時間) 14:30-16:00
- [ ] `app/javascript/controllers/daily_report_form_controller.js`作成
- [ ] new.html.erbに`data-controller`追加
- [ ] edit.html.erbに`data-controller`追加
- [ ] 「日報フォーマットを生成」ボタン実装
- [ ] GraphQL Query呼び出し実装
- [ ] コピーボタン実装
- [ ] ローディング表示追加
- [ ] エラー表示追加

## フェーズ7: 動作確認・調整 (1時間) 16:00-17:00
- [ ] 全体の動作確認
  - [ ] 一覧表示
  - [ ] 新規作成(手動入力)
  - [ ] 新規作成(生成ボタン)
  - [ ] 編集
  - [ ] 削除
  - [ ] コピー機能
- [ ] UI調整(Bootstrap等)
- [ ] エラーハンドリング確認
- [ ] バグ修正
- [ ] Git commit

## フェーズ8: 発表準備 (17:00-18:00)
- [ ] README作成
- [ ] デモ用データ準備
- [ ] スクリーンショット撮影
- [ ] 発表スライド作成(簡易)
- [ ] デモシナリオ確認

## チェックポイント

### 14:30時点で確認
- [ ] Toggl APIからデータ取得できているか?
- [ ] GraphiQLでクエリが成功するか?

### 16:00時点で確認
- [ ] フロントエンドから生成ボタンが動くか?
- [ ] コピーボタンが動くか?
