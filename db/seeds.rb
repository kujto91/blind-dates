puts 'Create departments'
departments = %w[IT Human-Resources Product-Management Accounting Marketing].map do |departament_name|
  Department.find_or_create_by!(
    name: departament_name,
    descripton: Forgery('basic').text
  )
end

puts 'Create admin user'
admin_user = User.create_with(
  password: 'password!'
).find_or_create_by!(
  department: departments.first,
  first_name: Forgery('name').first_name,
  last_name: Forgery('name').last_name,
  email: 'test@test.de',
  admin: true
)

puts 'Create employees'
employees = departments.map do |department|
  rand(3..7).times do
    department.users.create_with(
      password: 'password!'
    ).find_or_create_by!(
      first_name: Forgery('name').first_name,
      last_name: Forgery('name').last_name,
      email: Forgery('internet').email_address
    )
  end
end

puts 'Create restorants'
restorants = 5.times do
  Restorant.find_or_create_by!(
    name: Forgery(:name).company_name,
    descripton: Forgery('basic').text,
    phone: Forgery('address').phone,
    address_street: Forgery('address').street_name,
    address_number: Forgery('address').street_number,
    address_postcode: Forgery('address').zip,
    address_town: Forgery('address').city
  )
end
