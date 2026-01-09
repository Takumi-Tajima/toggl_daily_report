module Types
  class GithubPullRequestType < Types::BaseObject
    field :title, String, null: false
    field :url, String, null: false
    field :created_at, String, null: false
  end
end
