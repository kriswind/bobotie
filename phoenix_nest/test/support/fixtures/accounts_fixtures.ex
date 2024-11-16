defmodule PhoenixNest.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixNest.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        hashed_password: "some hashed_password",
        username: "some username"
      })
      |> PhoenixNest.Accounts.create_user()

    user
  end
end
