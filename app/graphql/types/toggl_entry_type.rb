module Types
  class TogglEntryType < Types::BaseObject
    field :id, ID, null: false
    field :description, String
    field :start, String, null: false
    field :stop, String
    field :duration, Int, null: false
    field :project_id, Int
  end
end
