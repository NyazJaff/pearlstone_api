# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
 User.create(
   first_name:           'Mike',
   last_name:            'Jone',
   email:                'test1@myport.ac.uk',
   building_name:        'Snowflakes',
   address_line_1:       '114 Way Street',
   address_line_2:        '',
   city:                  'Portsmouth',
   country:               'United Kingdome',
   postcode:              'PO5 3ER',
   password:              '123',
   password_confirmation: '123')


User.create(
  first_name:           'N',
  last_name:            'Jaff',
  email:                'test@myport.ac.uk',
  building_name:        'Snowflakes',
  address_line_1:       'Flat 12',
  address_line_2:        '',
  city:                  'Portsmouth',
  country:               'United Kingdome',
  postcode:              'PO1 ZER',
  password:              '123',
  password_confirmation: '123')
