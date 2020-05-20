defmodule SsmserverWeb.UserResolver do
  @moduledoc """
  This module is responsible for user management
  """
  alias Ssmserver.Users

  def create_user(args, _info) do
    Users.create_user(args)
    {:ok, args}
  end

  def get_users(_args, _info) do
    users = Users.list_users()
    {:ok, users}
  end

  def get_user(args, _info) do
    {:ok, Users.get_user!(Map.get(args, :id))}
  end

  def get_managers_emails do
    {:ok, Users.get_managers_emails}
  end
  def validate_user(args, _info) do
    user = Users.get_user(args)

    if is_nil(user) do
      {:ok, %{email: "0", id: 0}}
    else
      {:ok, user}
    end

    # {:ok, Users.get_user(Map.get(args,:id))}
  end

  def delete_user(args, _info) do
    Users.delete_user(Users.get_user!(Map.get(args, :id)))
  end

  def update_user(args, _info) do
    Users.update_user(Users.get_user!(Map.get(args, :id)), args)
  end
end
