defmodule Blog.Helpers.ErrorHelper do
  def format_changeset(%Ecto.Changeset{errors: errors}) do
    errors =
      errors
      |> Enum.map(fn {key, {value, _context}} ->
        [message: "#{key} #{value}"]
      end)

    {:error, errors}
  end
end
