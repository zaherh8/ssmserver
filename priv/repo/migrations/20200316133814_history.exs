defmodule Ssmserver.Repo.Migrations.History do
  use Ecto.Migration

  def change do
    create table(:history, prefix: "ssm") do
      add :product, references(:products, column: :barcode, type: :string)
      add :date, :string
      add :quantity, :integer
      timestamps()
    end
  end
end
