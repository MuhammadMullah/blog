defmodule BlogWeb.Schema do
  use Absinthe.Schema
  import_types(BlogWeb.Schema.Types)

  query do
    field :posts, list_of(:post) do
      resolve(&Blog.Blog.PostResolver.all/2)
    end
  end
end
