class CreateTags < ActiveRecord::Migration[5.0]
  def change

    create_table(:tag) do |t|
      t.column(:name, :string)
    end
  end
end
