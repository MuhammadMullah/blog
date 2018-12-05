defmodule Blog.Account.UserResolver do
  alias Blog.Account

  def create(args, _info) do
    Account.create_user(args) |> Blog.Helpers.response()
  end

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- Blog.Helpers.AuthHelper.login_with_email_password(email, password),
         {:ok, jwt, _} <- Blog.Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt}}
    end
  end

  def view(_args, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end
end
