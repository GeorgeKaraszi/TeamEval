json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :name, :description, :active_class_id, :start_time, :end_time
  json.url assignment_url(assignment, format: :json)
end
