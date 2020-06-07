defmodule BdoApp.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string, null: false
      add :slug, :string, null: false
      add :buy_price, :integer
      add :sell_price, :integer

      timestamps()
    end

    create unique_index(:recipes, [:slug])
  end
end
