defmodule Blog.Helpers do
  alias Blog.Helpers.ErrorHelper

  def response(res) do
    case res do
      {:error, %Ecto.Changeset{} = changeset} ->
        changeset |> ErrorHelper.format_changeset()

      _ ->
        res
    end
  end
end
