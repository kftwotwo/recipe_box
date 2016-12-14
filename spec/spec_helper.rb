ENV['RACK_ENV'] = 'test'
require('rspec')
require('pg')
require('sinatra/activerecord')
require('./lib/recipe')
require('./lib/tag')

RSpec.configure do |config|
  config.after(:each) do

    Recipe.all().each() do |recipe|
      recipe.destroy()
    end

    Tag.all().each() do |tag|
      tag.destroy()
    end
  end
end
