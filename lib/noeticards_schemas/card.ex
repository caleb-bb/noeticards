defmodule NoeticardsSchemas.Card do
  @moduledoc "Card schema"

  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :name, :string
    field :front_text, :string
    field :back_text, :string

    belongs_to(:deck, NoeticardsSchemas.Deck,
      foreign_key: :deck_id,
      references: :id
    )

    timestamps()
  end

  def changeset(card, attrs) do
    required = [:name, :front_text, :back_text, :deck_id]

    card
    |> cast(attrs, required)
    |> validate_required(required)
  end
end
