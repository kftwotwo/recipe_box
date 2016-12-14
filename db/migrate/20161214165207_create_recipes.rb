class CreateRecipes < ActiveRecord::Migration[5.0]
  def change

    create_table(:recipe) do |t|
      t.column(:name, :string)
      t.column(:ingredients, :string)
      t.column(:instructions, :string)
    end
  end
end
