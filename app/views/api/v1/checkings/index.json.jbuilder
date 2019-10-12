json.array! @checkings do |checking|
  json.id checking.id
  json.happend_at checking.happend_at
  json.check_type checking.check_type

  json.created_at checking.created_at
end