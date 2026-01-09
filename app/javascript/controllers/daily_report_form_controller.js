import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["togglCheckbox", "githubCheckbox", "contentTextarea"]

  async generate() {
    // 1. チェックボックスの状態を取得

    // 2. GraphQL クエリを動的に組み立て

    // 3. /graphql に POST

    // 4. 結果をテキストエリアに表示
  }

  // GraphQL クエリを組み立てる
  buildQuery(includeToggl, includeGithub) {
    // TODO: チェック状態に応じてクエリを組み立て
  }

  // 結果を日報フォーマットに整形
  formatResult(data) {
    // TODO: 取得したデータを日報形式の文字列に変換
  }
}