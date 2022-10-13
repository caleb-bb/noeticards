defmodule Noeticards.CardsTest do
  @moduledoc "Test for cards context"
  use Noeticards.DataCase
  import Noeticards.Factory
  alias Noeticards.Cards
  alias Noeticards.TestUtils
  alias NoeticardsSchemas.Card
  alias NoeticardsSchemas.Deck

  describe "create_card/1" do
    test "it returns an :ok tuple with valid params" do
      %Deck{id: deck_id} = insert(:deck)

      params = %{
        name: "test card",
        front_text: "front of card",
        back_text: "back of card",
        deck_id: deck_id
      }

      return_value = Cards.create_card(params)

      assert {:ok,
              %Card{
                name: "test card",
                front_text: "front of card",
                back_text: "back of card",
                deck_id: ^deck_id
              }} = return_value
    end

    test "it returns an :error tuple with invalid params" do
      params = %{}

      return_value = Cards.create_card(params)

      assert {:error, changeset} = return_value

      assert %{
               name: ["can't be blank"],
               front_text: ["can't be blank"],
               back_text: ["can't be blank"],
               deck_id: ["can't be blank"]
             } = errors_on(changeset)
    end
  end

  describe "cards_in_deck!/1" do
    test "it returns all cards with the correct deck id" do
      first_deck = insert(:deck)
      second_deck = insert(:deck)

      TestUtils.insert_this_many(3, :card, %{deck: first_deck})
      TestUtils.insert_this_many(7, :card, %{deck: second_deck})

      cards_in_first_deck = Cards.cards_in_deck!(first_deck.id)
      cards_in_second_deck = Cards.cards_in_deck!(second_deck.id)

      assert Repo.preload(first_deck, :cards).cards == cards_in_first_deck
      assert Repo.preload(second_deck, :cards).cards == cards_in_second_deck
    end

    test "it returns an empty list for nonexistent or empty deck" do
      empty_deck = insert(:deck)

      assert Cards.cards_in_deck!(empty_deck.id) == []
      assert Cards.cards_in_deck!(7327) == []
    end
  end

  describe "delete_card/1" do
    test "deletes a card when given a valid id" do
      %Card{id: id} = insert(:card)
      Cards.delete_card!(id)
    end

    test "raises on a nonexistent id" do
      card = insert(:card)
      Cards.delete_card!(card.id)

      assert_raise(Ecto.StaleEntryError, fn ->
        Cards.delete_card!(card.id)
      end)
    end
  end
end
