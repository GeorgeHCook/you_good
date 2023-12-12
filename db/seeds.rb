
puts 'Cleaning database...'
Chatroom.destroy_all
User.destroy_all
CheckIn.destroy_all
puts 'Creating Users & Check ins...'

require "faker"
require "rspotify"

names = ["George", "Francisco", "Michael", "Jamie", "Thomas", "Constantine", "Will", "Havish", "Dareos", "Arbi", "Luca"]
11.times do |i|
  email = "#{names[i - 1]}@test.com"
  first_name = names[i - 1].to_s
  password = "123456"

  user = User.create!(email: email, first_name: first_name, password: password)

  7.times do |j|
    CheckIn.create(user: user, score: rand(1..10), created_at: j.days.ago)
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
