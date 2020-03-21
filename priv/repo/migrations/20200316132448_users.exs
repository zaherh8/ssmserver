defmodule Ssmserver.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table(:users, prefix: "ssm") do
      add :username, :string
      add :password, :string
      add :role, :string
      add :position, :string
      timestamps()
    end
  end

end
