
puts 'Cleaning database...'
User.destroy_all
CheckIn.destroy_all
puts 'Creating Users & Check ins...'

require "faker"

names = ["John", "Jacob", "Jane", "George", "Michael"]
5.times do |i|
  email = "#{names[i-1]}@test.com"
  first_name = Faker::Name.first_name
  password = "123456"

  user = User.create!(email: email, first_name: first_name, password: password)

  7.times do |j|
    CheckIn.create(user: user, score: rand(1..10), created_at: j.days.ago)
 end

 end

Medium.create!(title: "Body Appreciation Meditation • Trauma-Sensitive Mindfulness", category: "Podcast", media_type: "Audio", media_url: "https://soundcloud.com/tsm-podcast/body-appreciation-meditation-trauma-sensitive-mindfulness?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing" , artwork_url: "https://i1.sndcdn.com/avatars-000630945204-w6p0si-t500x500.jpg")
Medium.create!(title: "Khalid - Therapy", category: "Music", media_type: "Audio", media_url: "https://soundcloud.com/thegreatkhalid/therapy?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing" , artwork_url: "https://i1.sndcdn.com/artworks-Wqkma6LcaqFd-0-t500x500.jpg")
Medium.create!(title: "Relaxing Music for Stress Relief", category: "Music", media_type: "Audio", media_url: "https://soundcloud.com/spiritualmoment/relaxing-music-for-stress-relief-calm-music-for-sleep-meditation-healing-therapy-study-spa-yoga?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing" , artwork_url: "https://i1.sndcdn.com/artworks-000340497561-i2zpyx-t500x500.jpg")
Medium.create!(title: "Eddie Nestor | Male Mental Health & Suicide", category: "Podcast", media_type: "Audio", media_url: "https://soundcloud.com/eddie-nestor-558883944/eddie-nestor-male-mental-health-suicide?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing" , artwork_url: "https://i1.sndcdn.com/artworks-000473849547-2jz7n9-t500x500.jpg")
Medium.create!(title: "Mindfulness", category: "Music", media_type: "Audio", media_url: "https://soundcloud.com/yoga-relax/mindfulness?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing", artwork_url: "https://i1.sndcdn.com/artworks-3TdkZ53Y0Ist-0-t500x500.jpg")

Puts 'finished'
