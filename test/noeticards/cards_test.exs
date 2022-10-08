defmodule Noeticards.CardsTest do
  @moduledoc "Test for cards context"
  use Noeticards.DataCase
  import Noeticards.Factory
  alias Noeticards.Cards
  alias NoeticardsSchemas.Card
  alias NoeticardsSchemas.Deck

  describe "add_new_card/1" do
    test "it returns an :ok tuple with valid params" do
      %Deck{id: deck_id} = insert(:deck)

      params = %{
        name: "test card",
        front_text: "front of card",
        back_text: "back of card",
        deck_id: deck_id
      }

      return_value = Cards.add_new_card(params)

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

      return_value = Cards.add_new_card(params)

      assert {:error, changeset} = return_value

      assert %{
               name: ["can't be blank"],
               front_text: ["can't be blank"],
               back_text: ["can't be blank"],
               deck_id: ["can't be blank"]
             } = errors_on(changeset)
    end
  end
end
