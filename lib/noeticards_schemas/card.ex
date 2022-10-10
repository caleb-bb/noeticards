defmodule NoeticardsSchemas.Card do
  @moduledoc "Card schema"

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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
    |> assoc_constraint(:deck)
  end

  # Composable queries for cards

  @doc """
  Returns a base query, which is required by all other composable query functions.
  """
  def base_query do
    from c in __MODULE__, as: :card
  end

  @doc """
  Limits results to those cards matching the deck_id.
  """
  def where_deck_id(query, id) do
    from [card: c] in query,
      where: c.deck_id == ^id
  end
end
