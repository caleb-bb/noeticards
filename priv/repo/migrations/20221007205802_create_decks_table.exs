defmodule Noeticards.Repo.Migrations.CreateDecksTable do
  use Ecto.Migration

  def change do
    create table("decks") do
      add :name, :string, null: false

      timestamps()
    end
  end
end
