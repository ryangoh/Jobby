json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :duration, :budget, :description, :skill, :status, :create_by
  json.url job_url(job, format: :json)
end
