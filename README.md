# Development setup

rails server -e production    # Run rails in production

rake db:setup
rake db:migrate


- node_module
rm -rf node_modules
npm install
rails assets:precompile # generate webpack files
./bin/webpack-dev-server     # Start WebPacker



webpack --display-error-details # Helps displaying errors


# Production 

 
yarn --check-files
npm install
rails assets:clobber
RAILS_ENV=production rake webpacker:compile
RAILS_ENV=production rails assets:precompile # For webpack changes not showing in production
bundle exec rails webpacker:install
bundle exec cap deploy production
sudo service nginx start          # Restart nginx
gem update --system   # Point bundler to latest installed
# Deployment
brew install awsebcli
