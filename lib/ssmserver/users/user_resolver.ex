defmodule SsmserverWeb.UserResolver do
  @moduledoc """
  This module is responsible for user management
  """
  alias Ssmserver.Users
  def create_user(args, _info) do
    Users.create_user(args)
    {:ok, args}
  end
  def get_users(_args,_info) do
    users = Users.list_users()
    {:ok, users}
  end
end
