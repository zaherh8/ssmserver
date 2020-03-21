defmodule Ssmserver.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  @schema_prefix "ssm"
  schema "users" do
    field :username, :string
    field :password, :string
    field :position, :string
    field :role, :string
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :position, :role])
    |> validate_required([:username, :password])
  end
end
