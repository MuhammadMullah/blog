defmodule Blog.Blog.PostResolver do
  alias Blog.Blog

  def all(_args, _info) do
    {:ok, Blog.list_posts()}
  end
end
