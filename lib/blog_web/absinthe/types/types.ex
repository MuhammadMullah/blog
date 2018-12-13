defmodule BlogWeb.Absinthe.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Blog.Repo

  object :user do
    field :id, :id
    field :username, :string
    field :email, :string
    field(:inserted_at, :naive_datetime)
    field :post, list_of(:post), resolve: assoc(:posts)
  end

  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :tags, :string
    field(:inserted_at, :naive_datetime)
    field :user, type: :user, resolve: assoc(:user)
  end

  object :session do
    field :token, :string
  end

  input_object :update_post_params do
    field :title, :string
    field :body, :string
    field :tags, :string
  end
end
