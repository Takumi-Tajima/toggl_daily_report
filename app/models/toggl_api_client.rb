class TogglApiClient
  BASE_URL = 'https://api.track.toggl.com/api/v9'.freeze

  def initialize
    @api_token = Rails.application.credentials.toggl_track.api_token
  end

  def fetch_time_entries_for_today
    start_time = Time.current.beginning_of_day.iso8601
    end_time = Time.current.end_of_day.iso8601
    response = connection.get('me/time_entries', { start_date: start_time, end_date: end_time })
    response.body
  end

  private

  def connection
    @connection ||= Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :authorization, :basic, @api_token, 'api_token'
      faraday.request :json
      faraday.response :json
    end
  end
end
