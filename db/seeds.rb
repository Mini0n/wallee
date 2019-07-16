# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create admin user
wallet = Wallet.create(id: 0, balance: 0.0)
User.create(id: 0, name: 'rut', email: 'rut@rut.rut', password: 'sample_pass', wallet: wallet)
