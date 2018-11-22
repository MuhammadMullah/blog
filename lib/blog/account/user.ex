defmodule Blog.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :token, :string
    field :username, :string

    has_many(:posts, Blog.Blog.Post, foreign_key: :user_id)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password_hash, :token])
    |> validate_required([:username, :email, :password_hash, :token])
  end
end
