defmodule Store.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string

      timestamps()
    end
  end
end
