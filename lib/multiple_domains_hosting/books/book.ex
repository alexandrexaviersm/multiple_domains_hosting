defmodule Store.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
