# Development setup
git clone https://NyazJaff@github.com/NyazJaff/Pearlstone.git

rails server -e production    # Run rails in production
rails server -b 0.0.0.0       # Run rails to be accessed within same network
rake db:setup
rake db:migrate



- node_module
rm -rf node_modules
npm install
rails assets:precompile      # generate webpack files
./bin/webpack-dev-server     # Start WebPacker



webpack --display-error-details # Helps displaying errors


# Production 

/home/deploy/pearlstone_api/ # Project dir
yarn --check-files
npm install
rails assets:clobber
RAILS_ENV=production rake webpacker:compile
RAILS_ENV=production rails assets:precompile # For webpack changes not showing in production
bundle exec rails webpacker:install
bundle exec cap production deploy # Deploy using Cap
sudo service nginx start          # Restart nginx
gem update --system               # Point bundler to latest installed
RAILS_ENV=production rails c      # Access rails c, might have to run 'gem install rails' if first time

yarn add @rails/webpacker
bundle update webpacker
# Deployment
brew install awsebcli


- Database Command line snipped 
Create Database 
 createdb <NEW_DATABASE_NAME> --host=<HOST> --port=5432 --username=<USER_THE_RDS_WAS_CREATED_WITH>

Access database
 psql --host=<HOST> --port=5432 --username=<USER_THE_RDS_WAS_CREATED_WITH> --password --dbname=<DATABASE_NAME>
 
Make sure database has 'Public Accessibility = true'