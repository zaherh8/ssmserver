defmodule Ssmserver.ReplenishmentsTest do
  use Ssmserver.DataCase

  alias Ssmserver.Replenishments

  describe "replenishment" do
    alias Ssmserver.Replenishments.Relplenishment

    @valid_attrs %{active: true, category: "some category", condition: "some condition", email: "some email", product: 42}
    @update_attrs %{active: false, category: "some updated category", condition: "some updated condition", email: "some updated email", product: 43}
    @invalid_attrs %{active: nil, category: nil, condition: nil, email: nil, product: nil}

    def relplenishment_fixture(attrs \\ %{}) do
      {:ok, relplenishment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Replenishments.create_relplenishment()

      relplenishment
    end

    test "list_replenishment/0 returns all replenishment" do
      relplenishment = relplenishment_fixture()
      assert Replenishments.list_replenishment() == [relplenishment]
    end

    test "get_relplenishment!/1 returns the relplenishment with given id" do
      relplenishment = relplenishment_fixture()
      assert Replenishments.get_relplenishment!(relplenishment.id) == relplenishment
    end

    test "create_relplenishment/1 with valid data creates a relplenishment" do
      assert {:ok, %Relplenishment{} = relplenishment} = Replenishments.create_relplenishment(@valid_attrs)
      assert relplenishment.active == true
      assert relplenishment.category == "some category"
      assert relplenishment.condition == "some condition"
      assert relplenishment.email == "some email"
      assert relplenishment.product == 42
    end

    test "create_relplenishment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Replenishments.create_relplenishment(@invalid_attrs)
    end

    test "update_relplenishment/2 with valid data updates the relplenishment" do
      relplenishment = relplenishment_fixture()
      assert {:ok, %Relplenishment{} = relplenishment} = Replenishments.update_relplenishment(relplenishment, @update_attrs)
      assert relplenishment.active == false
      assert relplenishment.category == "some updated category"
      assert relplenishment.condition == "some updated condition"
      assert relplenishment.email == "some updated email"
      assert relplenishment.product == 43
    end

    test "update_relplenishment/2 with invalid data returns error changeset" do
      relplenishment = relplenishment_fixture()
      assert {:error, %Ecto.Changeset{}} = Replenishments.update_relplenishment(relplenishment, @invalid_attrs)
      assert relplenishment == Replenishments.get_relplenishment!(relplenishment.id)
    end

    test "delete_relplenishment/1 deletes the relplenishment" do
      relplenishment = relplenishment_fixture()
      assert {:ok, %Relplenishment{}} = Replenishments.delete_relplenishment(relplenishment)
      assert_raise Ecto.NoResultsError, fn -> Replenishments.get_relplenishment!(relplenishment.id) end
    end

    test "change_relplenishment/1 returns a relplenishment changeset" do
      relplenishment = relplenishment_fixture()
      assert %Ecto.Changeset{} = Replenishments.change_relplenishment(relplenishment)
    end
  end

  describe "replenishment" do
    alias Ssmserver.Replenishments.Replenishment

    @valid_attrs %{active: true, category: "some category", condition: "some condition", email: "some email", product: 42}
    @update_attrs %{active: false, category: "some updated category", condition: "some updated condition", email: "some updated email", product: 43}
    @invalid_attrs %{active: nil, category: nil, condition: nil, email: nil, product: nil}

    def replenishment_fixture(attrs \\ %{}) do
      {:ok, replenishment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Replenishments.create_replenishment()

      replenishment
    end

    test "list_replenishment/0 returns all replenishment" do
      replenishment = replenishment_fixture()
      assert Replenishments.list_replenishment() == [replenishment]
    end

    test "get_replenishment!/1 returns the replenishment with given id" do
      replenishment = replenishment_fixture()
      assert Replenishments.get_replenishment!(replenishment.id) == replenishment
    end

    test "create_replenishment/1 with valid data creates a replenishment" do
      assert {:ok, %Replenishment{} = replenishment} = Replenishments.create_replenishment(@valid_attrs)
      assert replenishment.active == true
      assert replenishment.category == "some category"
      assert replenishment.condition == "some condition"
      assert replenishment.email == "some email"
      assert replenishment.product == 42
    end

    test "create_replenishment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Replenishments.create_replenishment(@invalid_attrs)
    end

    test "update_replenishment/2 with valid data updates the replenishment" do
      replenishment = replenishment_fixture()
      assert {:ok, %Replenishment{} = replenishment} = Replenishments.update_replenishment(replenishment, @update_attrs)
      assert replenishment.active == false
      assert replenishment.category == "some updated category"
      assert replenishment.condition == "some updated condition"
      assert replenishment.email == "some updated email"
      assert replenishment.product == 43
    end

    test "update_replenishment/2 with invalid data returns error changeset" do
      replenishment = replenishment_fixture()
      assert {:error, %Ecto.Changeset{}} = Replenishments.update_replenishment(replenishment, @invalid_attrs)
      assert replenishment == Replenishments.get_replenishment!(replenishment.id)
    end

    test "delete_replenishment/1 deletes the replenishment" do
      replenishment = replenishment_fixture()
      assert {:ok, %Replenishment{}} = Replenishments.delete_replenishment(replenishment)
      assert_raise Ecto.NoResultsError, fn -> Replenishments.get_replenishment!(replenishment.id) end
    end

    test "change_replenishment/1 returns a replenishment changeset" do
      replenishment = replenishment_fixture()
      assert %Ecto.Changeset{} = Replenishments.change_replenishment(replenishment)
    end
  end
end
