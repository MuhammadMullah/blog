defmodule Blog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :tags, :string
    field :title, :string

    belongs_to(:user, Blog.Account.User, foreign_key: :user_id)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :tags])
    |> validate_required([:title, :body, :tags])
  end
end
