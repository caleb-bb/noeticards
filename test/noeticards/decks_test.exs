defmodule Noeticards.DecksTest do
  @moduledoc "Test for Decks context"
  use Noeticards.DataCase
  alias Noeticards.Decks
  alias NoeticardsSchemas.Deck

  describe "add_new_deck/1" do
    test "it returns an :ok tuple with valid params" do
      params = %{name: "test deck"}

      return_value = Decks.add_new_deck(params)

      assert {:ok, %Deck{name: "test deck"}} = return_value
    end

    test "it returns an :error tuple with invalid params" do
      params = %{}

      return_value = Decks.add_new_deck(params)

      assert {:error, changeset} = return_value
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
