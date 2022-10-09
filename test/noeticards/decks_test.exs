defmodule Noeticards.DecksTest do
  @moduledoc "Test for Decks context"
  use Noeticards.DataCase
  alias Noeticards.Decks
  alias Noeticards.Decks.Deck

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

  describe "decks" do
    alias Noeticards.Decks.Deck

    import Noeticards.DecksFixtures

    @invalid_attrs %{name: nil}

    test "list_decks/0 returns all decks" do
      deck = deck_fixture()
      assert Decks.list_decks() == [deck]
    end

    test "get_deck!/1 returns the deck with given id" do
      deck = deck_fixture()
      assert Decks.get_deck!(deck.id) == deck
    end

    test "create_deck/1 with valid data creates a deck" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Deck{} = deck} = Decks.create_deck(valid_attrs)
      assert deck.name == "some name"
    end

    test "create_deck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Decks.create_deck(@invalid_attrs)
    end

    test "update_deck/2 with valid data updates the deck" do
      deck = deck_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Deck{} = deck} = Decks.update_deck(deck, update_attrs)
      assert deck.name == "some updated name"
    end

    test "update_deck/2 with invalid data returns error changeset" do
      deck = deck_fixture()
      assert {:error, %Ecto.Changeset{}} = Decks.update_deck(deck, @invalid_attrs)
      assert deck == Decks.get_deck!(deck.id)
    end

    test "delete_deck/1 deletes the deck" do
      deck = deck_fixture()
      assert {:ok, %Deck{}} = Decks.delete_deck(deck)
      assert_raise Ecto.NoResultsError, fn -> Decks.get_deck!(deck.id) end
    end

    test "change_deck/1 returns a deck changeset" do
      deck = deck_fixture()
      assert %Ecto.Changeset{} = Decks.change_deck(deck)
    end
  end
end
