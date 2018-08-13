defmodule Easy.AccountsTest do
  use Easy.DataCase

  alias Easy.Accounts

  describe "employees" do
    alias Easy.Accounts.Employee

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", mobile: "some mobile"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", mobile: "some updated mobile"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, mobile: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Accounts.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Accounts.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Accounts.create_employee(@valid_attrs)
      assert employee.email == "some email"
      assert employee.first_name == "some first_name"
      assert employee.last_name == "some last_name"
      assert employee.mobile == "some mobile"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, employee} = Accounts.update_employee(employee, @update_attrs)
      assert %Employee{} = employee
      assert employee.email == "some updated email"
      assert employee.first_name == "some updated first_name"
      assert employee.last_name == "some updated last_name"
      assert employee.mobile == "some updated mobile"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_employee(employee, @invalid_attrs)
      assert employee == Accounts.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Accounts.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Accounts.change_employee(employee)
    end
  end
end
