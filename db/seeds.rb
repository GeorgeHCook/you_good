
puts 'Cleaning database...'
Chatroom.destroy_all
User.destroy_all
CheckIn.destroy_all
puts 'Creating Users & Check ins...'

require "faker"
require "rspotify"
require "open-uri"

names = ["George", "Francisco", "Michael", "Dareos"]
4.times do |i|
  email = "#{names[i - 1]}@test.com"
  first_name = names[i - 1].to_s
  password = "123456"

  user = User.create!(email: email, first_name: first_name, password: password)

  5.times do |j|
    check_in = CheckIn.create(user: user, score: rand(1..10), created_at: j.days.ago)
    keywords = ["candid", "daily", "lifestyle", "food", "social", "friend"]
    check_in.photo.attach(
        content_type: "image/jpg",
        filename: "#{keywords.sample}.jpg",
        io: URI.open("https://loremflickr.com/320/240/#{keywords.sample}")
    )
    puts "created Check-in"
  end

  puts "created #{user.first_name}"
end

puts 'finished'

















# Medium.all.each do |medium|
#   begin
#     Rspotify.authenticate(ENV 'SPOTIFY_ID', ENV 'SPOTIFY_SECRET' )
#     tracks = Rspotify::Track.search(medium[:title])
#     track = tracks.first_name
#   rescue NoMethodError => e

#   else
#     id = track.instance_variable_get('@id')
#     medium.update(spotify_id: id)
#   end
# end
