defmodule Easy.Accounts.Employee do
  use Ecto.Schema
  import Ecto.Changeset


  schema "employees" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :mobile, :string

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :email, :mobile])
    |> validate_required([:first_name, :last_name, :email, :mobile])
  end
end
