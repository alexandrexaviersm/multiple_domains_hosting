defmodule Store.AlbumsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Store.Albums` context.
  """

  @doc """
  Generate a album.
  """
  def album_fixture(attrs \\ %{}) do
    {:ok, album} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Store.Albums.create_album()

    album
  end
end
