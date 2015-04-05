json.array!(@team_names) do |team_name|
  json.extract! team_name, :id, :name
  json.url team_name_url(team_name, format: :json)
end
