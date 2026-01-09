# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true, description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # 今日のTogglタイムエントリを取得
    field :todays_toggl_entries, [Types::TogglEntryType], null: false,
                                                          description: "Fetch today's Toggl time entries"

    def todays_toggl_entries
      client = TogglApiClient.new
      client.fetch_time_entries_for_today
    end

    # 今日作成したGitHub PRを取得
    field :todays_github_pull_requests, [Types::GithubPullRequestType], null: false,
                                                                        description: "Fetch today's GitHub pull requests"

    def todays_github_pull_requests
      client = GithubApiClient.new
      client.fetch_todays_pull_requests
    end
  end
end
