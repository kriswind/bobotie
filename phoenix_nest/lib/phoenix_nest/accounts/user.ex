defmodule PhoenixNest.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :balance, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> validate_email()
    |> validate_username()
    |> validate_password()
    |> hash_password()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, PhoenixNest.Repo)
    |> unique_constraint(:email)
  end

  defp validate_username(changeset) do
    changeset
    |> validate_required([:username])
    |> validate_length(:username, min: 3, max: 20)
    |> unsafe_validate_unique(:username, PhoenixNest.Repo)
    |> unique_constraint(:username)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 72)
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :hashed_password, Bcrypt.hash_pwd_salt(password))
      _ ->
        changeset
    end
  end
end
