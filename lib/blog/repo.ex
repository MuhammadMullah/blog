defmodule Blog.Repo do
  use Ecto.Repo,
    otp_app: :blog,
    adapter: Ecto.Adapters.Postgres

  import Ecto.Query, warn: false

  @per_page 1

  def paginate(query, offset) do
    from r in query, offset: ^offset, limit: @per_page
  end

  def count(query) do
    one(from(r in query, select: count("*")))
  end

  def fetch(query) do
    case all(query) do
      [] -> {:error, query}
      [obj] -> {:ok, obj}
    end
  end
end
