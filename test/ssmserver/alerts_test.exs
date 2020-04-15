defmodule Ssmserver.AlertsTest do
  use Ssmserver.DataCase

  alias Ssmserver.Alerts

  describe "alerts" do
    alias Ssmserver.Alerts.Alert

    @valid_attrs %{
      category: "some category",
      condition: "some condition",
      product: 42,
      quantity: 42,
      send: "some send"
    }
    @update_attrs %{
      category: "some updated category",
      condition: "some updated condition",
      product: 43,
      quantity: 43,
      send: "some updated send"
    }
    @invalid_attrs %{category: nil, condition: nil, product: nil, quantity: nil, send: nil}

    def alert_fixture(attrs \\ %{}) do
      {:ok, alert} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Alerts.create_alert()

      alert
    end

    test "list_alerts/0 returns all alerts" do
      alert = alert_fixture()
      assert Alerts.list_alerts() == [alert]
    end

    test "get_alert!/1 returns the alert with given id" do
      alert = alert_fixture()
      assert Alerts.get_alert!(alert.id) == alert
    end

    test "create_alert/1 with valid data creates a alert" do
      assert {:ok, %Alert{} = alert} = Alerts.create_alert(@valid_attrs)
      assert alert.category == "some category"
      assert alert.condition == "some condition"
      assert alert.product == 42
      assert alert.quantity == 42
      assert alert.send == "some send"
    end

    test "create_alert/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Alerts.create_alert(@invalid_attrs)
    end

    test "update_alert/2 with valid data updates the alert" do
      alert = alert_fixture()
      assert {:ok, %Alert{} = alert} = Alerts.update_alert(alert, @update_attrs)
      assert alert.category == "some updated category"
      assert alert.condition == "some updated condition"
      assert alert.product == 43
      assert alert.quantity == 43
      assert alert.send == "some updated send"
    end

    test "update_alert/2 with invalid data returns error changeset" do
      alert = alert_fixture()
      assert {:error, %Ecto.Changeset{}} = Alerts.update_alert(alert, @invalid_attrs)
      assert alert == Alerts.get_alert!(alert.id)
    end

    test "delete_alert/1 deletes the alert" do
      alert = alert_fixture()
      assert {:ok, %Alert{}} = Alerts.delete_alert(alert)
      assert_raise Ecto.NoResultsError, fn -> Alerts.get_alert!(alert.id) end
    end

    test "change_alert/1 returns a alert changeset" do
      alert = alert_fixture()
      assert %Ecto.Changeset{} = Alerts.change_alert(alert)
    end
  end
end
