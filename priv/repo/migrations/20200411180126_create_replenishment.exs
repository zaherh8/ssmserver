defmodule Ssmserver.Repo.Migrations.CreateReplenishment do
  use Ecto.Migration

  def change do
    create table(:replenishment, prefix: "ssm") do
      add :email, :string
      add :active, :boolean, default: false, null: false
      add :condition, :string
      add :product, :string
      add :quantity, :integer
      add :quantitytoorder, :integer
      timestamps()
    end

  end
end
