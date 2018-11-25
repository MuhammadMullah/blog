defmodule BlogWeb.Plugs.AuthContext do
  @behaviour Plug
  alias Blog.Guardian
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      _ ->
        conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(conn) do
      {:ok, %{current_user: current_user, token: token}}
    end
  end

  # you can store the token in db to make sure the user only uses a single browser
  # 1 to 1 for token
  defp authorize(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        {:error, "Invalid token"}

      user ->
        {:ok, user}
    end
  end
end
