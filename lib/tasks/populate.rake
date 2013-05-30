namespace :db do
  desc "Erase and fill database"
  task :populate_users => :environment do
    require 'faker'
    50.times do |n|
      username = "#{Faker::Name.first_name}#{n}"
      user = User.new(
      :username => username,
      :role => 'provider',
      :password => 'password',
      :password_confirmation => 'password',
      :verified => false,
      :firstname => Faker::Name.first_name,
      :lastname => Faker::Name.last_name,
      :contractor_type => Faker::Company.name,
      :city => Faker::Address.city,
      :state => Faker::Address.state_abbr,
      :email => Faker::Internet.email,
      :phone => Faker::PhoneNumber.phone_number,
      :website => Faker::Internet.domain_name,
      :about_title => Faker::Lorem.sentence(word_count = 4, supplemental = false),
      :about_content => Faker::Lorem.paragraph(sentence_count = 3, supplemental = false)
      )
      user.save!
    end
  end
end