json.array! @tweets do |tweet|
  json.id tweet.id
  json.text tweet.text
  json.image tweet.image
  json.user_id tweet.user_id
  json.name tweet.user.name
  json.time tweet.time
  json.user_sign_in current_user
end