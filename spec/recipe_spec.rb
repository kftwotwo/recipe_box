require('spec_helper')

describe Recipe do
  it "will check if the tables are setup right" do
    new_recipe = Recipe.create({:name => 'Cookies', :ingredients => 'Flour sugar milk'})
      expect(Recipe.all).to eq [new_recipe]
  end

end
