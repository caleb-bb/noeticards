defmodule NoeticardsSchemas.Deck do
  @moduledoc "Deck schema"

  use Ecto.Schema

  schema "decks" do
    field :name, :string
    has_many :cards, NoeticardsSchemas.Card

    timestamps()
  end
end
