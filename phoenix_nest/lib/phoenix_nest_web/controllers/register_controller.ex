defmodule PhoenixNestWeb.RegisterController do
  use PhoenixNestWeb, :controller

  alias PhoenixNest.Accounts

  def create(conn, %{"email" => email, "username" => username, "password" => password}) do
    case Accounts.register_user(%{email: email, username: username, password: password}) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> json(%{message: "User registered successfully", user_id: user.id})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset_errors(changeset)})
    end
  end

  defp changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Gettext.dgettext(PhoenixNestWeb.Gettext, "errors", msg, opts)
    end)
  end
end
