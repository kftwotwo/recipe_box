require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require('./lib/recipe')
require('./lib/tag')

get('/') do
  erb(:index)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end

get('/recipe/:id') do
  @recipes = Recipe.find(params.fetch("id").to_i)
  erb(:recipe_detail)
end

post('/recipes') do
  new_name = params['new-recipe-name'] #[] are the same as .fetch but defult to nil or NULL
  new_ingedients = params['new-ingedients']
  new_instructions = params['new-instructions']
  new_rating = params['new-rating']
  @recipes = Recipe.new({:name => new_name, :ingredients => new_ingedients, :instructions => new_instructions, :ratings => new_rating})
  if @recipes.save
    redirect "/"
  else
    erb(:errors)
  end
end
