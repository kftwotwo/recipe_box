require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require('./lib/recipe')
require('./lib/tag')

after do
  ActiveRecord::Base.clear_active_connections!
end

get('/') do
  @tags = Tag.all()
  erb(:index)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end

get('/recipe/:id') do
  @recipes = Recipe.find(params.fetch("id").to_i)#finding the object with that id
  @tags = @recipes.tags
  @alltags = Tag.all
  erb(:recipe_detail)
end

#Create Recipe
post('/recipes') do
  p params
  new_name = params['recipe-name'] #[] are the same as .fetch but defult to nil or NULL
  new_ingedients = params['ingedients']
  new_instructions = params['instructions']
  new_rating = params['rating']
  new_tag = Tag.find(params['tag_id'].to_i)
  @recipes = Recipe.create({:name => new_name, :ingredients => new_ingedients, :instructions => new_instructions, :ratings => new_rating})
  @recipes.tags.push(new_tag)
  if @recipes.save
    redirect "/"
  else
    erb(:errors)
  end
end

#Update Recipe
patch('/recipe/:id') do
  new_recipe_name = params["new-name"]
  new_recipe_ingedients = params["new-ingedients"]
  new_recipe_instructions = params["new-instructions"]
  new_recipe_rating = params["new-rating"]
  @recipe = Recipe.find(params["id"].to_i)
  @recipe.update({:name => new_recipe_name, :ingredients => new_recipe_ingedients, :instructions => new_recipe_instructions, :ratings => new_recipe_rating})
  @recipes = Recipe.all()
  erb(:recipes)
end

delete('/recipe/:id') do
  Recipe.find(params['id'].to_i).destroy
  redirect '/recipes'
end

post('/tags') do
  new_tag = params['tag']
  @tag = Tag.new({:name  => new_tag})
  if @tag.save
    redirect "/"
  else
    erb(:errors)
  end
end

get('/tags') do
  @tags = Tag.all()
  erb(:tags)
end

get('/tags/:id') do
  @tags = Tag.find(params['id'].to_i)
  erb(:tag)
end

patch('/tags/:id') do
  new_tag_name = params['new_tag']
  @tags = Tag.find(params['id'].to_i)
  @tags.update({:name => new_tag_name})
  @tags = Tag.all()
  erb(:tags)
end
