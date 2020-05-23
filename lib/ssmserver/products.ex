defmodule Ssmserver.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias Ssmserver.Repo

  alias Ssmserver.Products.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  def list_available_products do
    Repo.all(
      from p in Product,
        where: p.quantity > 0,
        select: p
    )
  end

  def get_products_total do
    Repo.one(from p in Product, select: sum(p.quantity))
  end

  def get_brands_total do
    Repo.one(from p in Product, select: count(p.barcode))
  end

  def get_products_sorted do
    Repo.all(from p in Product, select: p, order_by: [desc: :quantity])
  end


  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def all_product_to_zero(_args) do
    from(p in Product, select: p)
    |> Repo.update_all(set: [quantity: 0])

    {:ok, "done"}
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{source: %Product{}}

  """
  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end

  def get_product_by(params) do
    Repo.get_by(Product, params)
  end
end
