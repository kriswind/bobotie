defmodule PhoenixNest.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :username, :string, null: false
      add :hashed_password, :string, null: false
      add :balance, :integer, default: 0

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
