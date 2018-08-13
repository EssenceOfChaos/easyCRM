defmodule Easy.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :mobile, :string

      timestamps()
    end

  end
end
