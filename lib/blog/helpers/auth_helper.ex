defmodule Blog.Helpers.AuthHelper do
  alias Blog.Account

  import Comeonin.Bcrypt, only: [checkpw: 2]

  def login_with_email_password(email, given_pass) do
    user =
      email
      |> String.downcase()
      |> Account.get_user_by_email()

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, "Incorrect login credentials"}

      true ->
        {:error, "User not found"}
    end
  end
end
