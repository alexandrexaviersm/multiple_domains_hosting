defmodule Store.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Store.Books` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Store.Books.create_book()

    book
  end
end
