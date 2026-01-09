## フェーズ4: Toggl API連携 (1時間) 11:30-12:30
- [ ] credentials設定 `rails credentials:edit` で `toggl_api_token: your_token_here` を追加
- [ ] `app/services/toggl_api_client.rb`作成
- [ ] `app/services/daily_report_formatter.rb`作成
- [ ] `rails c`でToggl API動作確認
- [ ] フォーマット生成テスト

## 昼休憩 12:30-13:30

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
