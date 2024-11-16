defmodule PhoenixNestWeb.UserJSON do
  alias PhoenixNest.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      username: user.username,
      hashed_password: user.hashed_password
    }
  end
end
