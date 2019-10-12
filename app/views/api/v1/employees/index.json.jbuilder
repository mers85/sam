json.array! @employees do |employee|
  json.id employee.id
  json.email employee.email
  json.first_name employee.first_name
  json.last_name employee.last_name
  json.created_at employee.created_at
end