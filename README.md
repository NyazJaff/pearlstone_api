# Development setup

rails server -e production    # Run rails in production

rake db:setup
rake db:migrate


- node_module
rm -rf node_modules
npm install
./bin/webpack-dev-server     # Start WebPacker



webpack --display-error-details # Helps displaying errors


# Production 

 
yarn --check-files
npm install
rails assets:clobber
rails assets:precompile # generate webpack files
RAILS_ENV=production rake webpacker:compile

bundle exec rails webpacker:install
bundle exec cap deploy production
sudo service nginx start          # Restart nginx
gem update --system   # Point bundler to latest installed
# Deployment
brew install awsebcli
