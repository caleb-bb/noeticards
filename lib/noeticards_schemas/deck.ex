defmodule NoeticardsSchemas.Deck do
  @moduledoc "Deck schema"

  use Ecto.Schema
  import Ecto.Changeset

  schema "decks" do
    field :name, :string
    has_many :cards, NoeticardsSchemas.Card

    timestamps()
  end

  def changeset(card, attrs) do
    required = [:name]

    card
    |> cast(attrs, required)
    |> validate_required(required)
  end
end
