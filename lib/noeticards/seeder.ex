defmodule Noeticards.Seeder do
  alias Noeticards.Repo
  alias NoeticardsSchemas, as: Schemas

  def run do
    clear_database()
    seed_decks()
    seed_cards()
  end

  defp clear_database do
    [Schemas.Card, Schemas.Deck]
    |> Enum.each(&Repo.delete_all(&1))
  end

  defp seed_decks do
    decks = [%{name: "deck one"}, %{name: "deck two"}]

    decks
    |> Enum.map(&Noeticards.Decks.add_new_deck(&1))
  end

  defp seed_cards do
    Schemas.Deck
    |> Repo.all()
    |> Enum.map(&seed_deck_cards(&1))
  end

  defp seed_deck_cards(deck) do
    cards = [
      %{name: "A", front_text: "Front of A", back_text: "back of A"},
      %{name: "B", front_text: "Front of B", back_text: "back of B"},
      %{name: "C", front_text: "Front of C", back_text: "back of C"}
    ]

    cards
    |> Enum.map(&Map.merge(&1, %{deck_id: deck.id}))
    |> Enum.map(&Schemas.Card.changeset(%Schemas.Card{}, &1))
    |> Enum.each(&Repo.insert(&1))
  end
end
