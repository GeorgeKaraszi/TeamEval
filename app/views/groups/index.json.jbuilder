json.array!(@groups) do |group|
  json.extract! group, :id, :user_id, :team_name_id, :active_class_id
  json.url group_url(group, format: :json)
end
