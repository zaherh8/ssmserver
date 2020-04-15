defmodule Ssmserver.Replenishments do
  @moduledoc """
  The Replenishments context.
  """

  import Ecto.Query, warn: false
  alias Ssmserver.Repo

  alias Ssmserver.Replenishments.Replenishment

  @doc """
  Returns the list of replenishment.

  ## Examples

      iex> list_replenishment()
      [%Replenishment{}, ...]

  """
  def list_replenishment do
    Repo.all(Replenishment)
  end

  @doc """
  Gets a single replenishment.

  Raises `Ecto.NoResultsError` if the Replenishment does not exist.

  ## Examples

      iex> get_replenishment!(123)
      %Replenishment{}

      iex> get_replenishment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_replenishment!(id), do: Repo.get!(Replenishment, id)

  @doc """
  Creates a replenishment.

  ## Examples

      iex> create_replenishment(%{field: value})
      {:ok, %Replenishment{}}

      iex> create_replenishment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_replenishment(attrs \\ %{}) do
    %Replenishment{}
    |> Replenishment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a replenishment.

  ## Examples

      iex> update_replenishment(replenishment, %{field: new_value})
      {:ok, %Replenishment{}}

      iex> update_replenishment(replenishment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_replenishment(%Replenishment{} = replenishment, attrs) do
    replenishment
    |> Replenishment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a replenishment.

  ## Examples

      iex> delete_replenishment(replenishment)
      {:ok, %Replenishment{}}

      iex> delete_replenishment(replenishment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_replenishment(%Replenishment{} = replenishment) do
    Repo.delete(replenishment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking replenishment changes.

  ## Examples

      iex> change_replenishment(replenishment)
      %Ecto.Changeset{source: %Replenishment{}}

  """
  def change_replenishment(%Replenishment{} = replenishment) do
    Replenishment.changeset(replenishment, %{})
  end
end
