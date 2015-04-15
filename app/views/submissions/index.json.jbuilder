json.array!(@submissions) do |submission|
  json.extract! submission, :id, :active_class_id, :group_id, :user_id, :assignment_id, :answer, :complete
  json.url submission_url(submission, format: :json)
end
