json.array!(@stories) do |story|
  json.extract! story, :id, :sentences
  json.url story_url(story, format: :json)
end
