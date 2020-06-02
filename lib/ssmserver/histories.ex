defmodule Ssmserver.Histories do
  @moduledoc """
  The Histories context.
  """

  import Ecto.Query, warn: false
  alias Ssmserver.Repo
  alias Ssmserver.Products.Product
  alias Ssmserver.Histories.History

  @doc """
  Returns the list of histories.

  ## Examples

      iex> list_histories()
      [%History{}, ...]

  """
  def list_histories do
    Repo.all(History)
  end

  @doc """
  Gets a single history.

  Raises `Ecto.NoResultsError` if the History does not exist.

  ## Examples

      iex> get_history!(123)
      %History{}

      iex> get_history!(456)
      ** (Ecto.NoResultsError)

  """
  def get_history!(id), do: Repo.get!(History, id)

  @doc """
  Creates a history.

  ## Examples

      iex> create_history(%{field: value})
      {:ok, %History{}}

      iex> create_history(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_history(attrs \\ %{}) do
    %History{}
    |> History.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a history.

  ## Examples

      iex> update_history(history, %{field: new_value})
      {:ok, %History{}}

      iex> update_history(history, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_history(%History{} = history, attrs) do
    history
    |> History.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a history.

  ## Examples

      iex> delete_history(history)
      {:ok, %History{}}

      iex> delete_history(history)
      {:error, %Ecto.Changeset{}}

  """
  def delete_history(%History{} = history) do
    Repo.delete(history)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking history changes.

  ## Examples

      iex> change_history(history)
      %Ecto.Changeset{source: %History{}}

  """
  def change_history(%History{} = history) do
    History.changeset(history, %{})
  end

  def get_total_scans do
    Enum.count(Repo.all(
      from h in History, distinct: (h.date)
    ))
  end
  def scans_sorted_by_date_total do
    date =
    Repo.all(
     from h in History, select: h.date, distinct: (h.date)
    )
    results =
    Repo.all(
     from h in History, join: p in Product, on: p.barcode == h.product, select: %{date: h.date, name: p.name, product: h.product}
    )
    |> Enum.reduce(%{}, fn hist, acc->
      acc = case IO.inspect(Map.get(acc, hist.date), label: "case") do
        nil -> Map.put(acc, hist.date, hist.name)
        product -> Map.put(acc, hist.date, hist.name <> ", " <> product)
      end
      acc
    end)
    |>IO.inspect(label: "result")
    Repo.all(
     from h in History, group_by: (h.date), select: %{total: sum(h.quantity), date: h.date}
    )
    |> Enum.map(fn hist ->
      Map.merge(hist, %{products: Map.get(results, hist.date)})
    end)
  end
end
