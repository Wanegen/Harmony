puts "Clearing database..."

Vinyl.destroy_all
User.destroy_all

puts "Database cleared!"

puts "Creating user..."
u = User.create!(
  email: "test@test.com",
  password: "123456"
)

puts "Creating Vinyls..."
puts "Creating scans..."

scan = Scan.create
scan.image.attach(io: File.open('app/assets/images/iron_maiden.webp'), filename: 'iron_maiden.webp', content_type: 'image/webp')

vinyl = Vinyl.create(
  title: 'Meteora',
  artist_name: "Linkin Park",
  year: 2003,
  user: u
)
vinyl.cover.attach(io: File.open('app/assets/images/iron_maiden.webp'), filename: 'iron_maiden.webp', content_type: 'image/webp')
vinyl.save

Vinyl.create(
  title: 'XX',
  artist_name: "The XX",
  year: 2009,
  user: u
)

Vinyl.create(
  title: "Revolver",
  artist_name: "The Beatles",
  year: 1966,
  user: u
)

Vinyl.create(
  title: "Thriller",
  artist_name: "Michael Jackson",
  year: 1982,
  user: u
)

Vinyl.create(
  title: "The Dark Side of the Moon",
  artist_name: "Pink Floyd",
  year: 1973,
  user: u
)
Vinyl.create(
  title: "The Wall",
  artist_name: "Pink Floyd",
  year: 1979,
  user: u
)

Vinyl.create(
  title: "Abbey Road",
  artist_name: "The Beatles",
  year: 1969,
  user: u
)

puts "Vinyls generated!"
