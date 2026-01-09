class GithubApiClient
  BASE_URL = 'https://api.github.com'.freeze

  def initialize
    @token = Rails.application.credentials.github.personal_access_token
  end

  # 今日自分が作成したPRの一覧を取得する
  def fetch_todays_pull_requests
    today = Date.current.to_s
    query = "is:pr author:@me created:>=#{today}"

    response = connection.get('search/issues', { q: query })

    response.body['items'].map do |item|
      {
        title: item['title'],
        url: item['html_url'],
        created_at: item['created_at'],
      }
    end
  end

  private

  def connection
    @connection ||= Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :authorization, :token, @token
      faraday.request :json
      faraday.response :json
      faraday.headers['User-Agent'] = 'TogglDailyReportApp'
    end
  end
end
