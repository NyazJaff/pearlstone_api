# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# ENV['RAILS_MASTER_KEY'] = '775122412ca348a6a31a331e22154700b245a46a9eec21a362a7981861accebba72b28ffa5d73197af7f3321c91734ed6c1b4fb151753b4487f772b7d0eefe56'

unless Rails.env.production?
  ENV['AWS_REGION'] = 'eu-west-2'
  ENV['AWS_ACCESS_KEY_ID'] = 'AKIAW4ZT2Q2FY3LPWAWZ'
  ENV['AWS_SECRET_ACCESS_KEY'] = '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'
  ENV['AWS_BUCKET_NAME'] = 'pdf-storage-test-pearlstone'
end