# Development setup
git clone https://NyazJaff@github.com/NyazJaff/Pearlstone.git

rails server -e production    # Run rails in production
rails server -b 0.0.0.0       # Run rails to be accessed within same network
rake db:setup
rake db:migrate



- node_module
rm -rf node_modules
npm install
rails assets:precompile # generate webpack files
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
bundle exec cap production deploy 
sudo service nginx start          # Restart nginx
gem update --system               # Point bundler to latest installed

yarn add @rails/webpacker
bundle update webpacker
# Deployment
brew install awsebcli
