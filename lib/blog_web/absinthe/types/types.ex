defmodule BlogWeb.Absinthe.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Blog.Repo

  object :user do
    field :id, :id
    field :username, :string
    field :email, :string
  end

  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :tags, :string
  end

  input_object :update_post_params do
    field :title, :string
    field :body, :string
    field :tags, :string
  end
end
