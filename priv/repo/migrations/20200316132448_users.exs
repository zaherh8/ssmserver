defmodule Ssmserver.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table(:users, prefix: "ssm") do
      add :username, :string
      add :password, :string
      ## admin-user-manager
      add :role, :string
      add :email, :string

      ## Warehouse manager - Receiver - General Labor - Warehouse Associate - Forklift Operator -Distribution Center Manager - Inventory Control Manager
      add :position, :string
      timestamps()
    end

    create unique_index(:users, [:username], prefix: "ssm")
  end
end
