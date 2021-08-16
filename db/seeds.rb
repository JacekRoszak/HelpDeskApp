# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create(name: 'admin', password: 'admin', admin?: true)

RequestStatus.destroy_all
statuses = [
  { name: 'Waiting', color: '', background: '' },
  { name: 'Assigned', color: '', background: '' },
  { name: 'In progress', color: '', background: '' },
  { name: 'On hold', color: '', background: '' },
  { name: 'Finished', color: '', background: '' },
  { name: 'Cancelled', color: '', background: '' }
]
statuses.each { |status_params| RequestStatus.create(status_params) }
