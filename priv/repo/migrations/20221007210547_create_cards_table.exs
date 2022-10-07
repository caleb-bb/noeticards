defmodule Noeticards.Repo.Migrations.CreateCardsTable do
  use Ecto.Migration

  def change do
    create table("cards") do
      add :name, :string, null: false
      add :front_text, :string, null: false
      add :back_text, :string, null: false
      add :deck_id, references(:decks, type: :bigint), null: false

      timestamps()
    end
  end
end
