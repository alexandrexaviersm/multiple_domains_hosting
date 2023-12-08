defmodule Store.Albums.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
