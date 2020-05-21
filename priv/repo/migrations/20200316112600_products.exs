defmodule Ssmserver.Repo.Migrations.Products do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false, prefix: "ssm") do
      add :barcode, :string, primary_key: true
      add :name, :string
      add :quantity, :integer
      add :price, :float
      add :whlocation, :string
      add :prlocation, {:array, :string}
      add :brand, :string
      add :lastordered, :string
      add :lastscan, :string
      add :category, :string
      add :supplier, :string
      timestamps()
    end
  end
end
