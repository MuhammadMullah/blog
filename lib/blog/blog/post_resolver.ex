defmodule Blog.Blog.PostResolver do
  alias Blog.Helpers
  alias Blog.Blog

  def all(%{offset: offset}, _info) do
    {:ok, Blog.list_posts(offset)}
  end

  def user_all(%{offset: offset}, %{context: %{current_user: current_user}}) do
    {:ok, Blog.get_user_posts(current_user, offset)}
  end

  def find(%{id: id}, _info) do
    case Blog.get_post(id) do
      nil ->
        {:error, "Post (#{id}) id is not found "}

      post ->
        {:ok, post}
    end
  end

  def create(args, %{context: %{current_user: current_user}}) do
    Blog.create_post(current_user, args) |> Helpers.response()
  end

  def update(%{id: id, post: post_params}, _info) do
    case Blog.get_post(id) do
      nil ->
        {:error, "Post (#{id}) id is not found "}

      post ->
        post |> Blog.update_post(post_params)
    end
  end

  def delete(%{id: id}, _info) do
    case Blog.get_post(id) do
      nil ->
        {:error, "Post (#{id}) id is not found "}

      post ->
        post |> Blog.delete_post()
    end
  end
end
