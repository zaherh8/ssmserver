defmodule Ssmserver.Repo.Migrations.Alerts do
  use Ecto.Migration

  def change do
    create table(:alerts, prefix: "ssm") do
      add :send, :string
      add :product, :int
      add :quantity, :int
      add :condition, :string
      add :category, :string
      timestamps()
    end
  end
end
