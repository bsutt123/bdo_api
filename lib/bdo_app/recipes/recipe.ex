defmodule BdoApp.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :buy_price, :integer
    field :sell_price, :integer
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :buy_price, :sell_price])
    |> validate_required([:name])
    |> generate_slug
    |> unique_constraint(:slug, message: "Slug must be unique")
  end

  defp generate_slug(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{name: name}} ->
        put_change(changeset, :slug, slug(name))

      _ ->
        changeset
    end
  end

  defp slug(name) do
    name
    |> String.downcase()
    |> String.split([" ", "-", "."], trim: true)
    |> Enum.join("_")
  end
end
