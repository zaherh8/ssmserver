defmodule Ssmserver.Repo.Migrations.Products do
  use Ecto.Migration

  def change do
    create table(:products, prefix: "ssm") do
      add :barcode, :string
      add :name, :string
      add :quantity, :integer
      add :price, :float
      add :whlocation, :string
      add :prlocation, :string
      add :brand, :string
      add :lastordered, :string
      add :lastscan, :string
      add :category, :string
      timestamps()
    end
  end
end
