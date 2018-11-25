defmodule Blog.Account.UserResolver do
  alias Blog.Account
  alias Blog.Helpers

  def create(args, _info) do
    Account.create_user(args) |> Helpers.response()
  end
end
