# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.new( 
  login: 'Best',
  email: 'example@email.com',
  first_name: 'Maxim',
  middle_name: 'Middle name',
  last_name: 'Last name',
  birthday: Date.today
)
@user.password = 'password'
@user.token = GenerateTokenService.generate(@user)
@user.save

@categories_id = []
@categories_id << Category.find_or_create_by(name: 'first').id
@categories_id << Category.find_or_create_by(name: 'second').id
@categories_id << Category.find_or_create_by(name: 'third').id

@project = Project.create( 
  title: 'first',
  description: 'First description',
  image_url: 'https://riafan.ru/uploads/2018/05/12/orig-1526128107315bc0def6e8cdb0d4c0bf3b0a0ab23c.jpeg',
  end_time: Date.today + 15.day,
  sum_goal: 200,
  current_sum: 0,
  owner: @user,
  category_ids: @categories_id
)

@project = Project.create( 
  title: 'Second',
  description: 'Second description',
  image_url: 'https://riafan.ru/uploads/2018/05/12/orig-1526128107315bc0def6e8cdb0d4c0bf3b0a0ab23c.jpeg',
  end_time: Date.today + 15.day,
  sum_goal: 200,
  current_sum: 0,
  owner: @user,
  category_ids: @categories_id
)
