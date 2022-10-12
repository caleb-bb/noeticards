defmodule Noeticards.DecksTest do
  @moduledoc "Test for Decks context"
  use Noeticards.DataCase
  import Noeticards.DecksFixtures
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

  @invalid_attrs %{name: nil}

  describe "list decks/0" do
    test "returns all decks" do
      deck = deck_fixture()
      assert Decks.list_decks() == [deck]
    end
  end

  describe "get_deck!/1" do
    test "returns the deck with given id" do
      deck = deck_fixture()
      assert Decks.get_deck!(deck.id) == deck
    end

    test "raises on bad id" do
      assert_raise Ecto.NoResultsError, fn -> Decks.get_deck!(7237) end
    end
  end

  describe "create_deck/1" do
    test "creates a deck with valid data" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Deck{} = deck} = Decks.create_deck(valid_attrs)
      assert deck.name == "some name"
    end

    test "returns error changeset with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Decks.create_deck(@invalid_attrs)
    end
  end

  describe "update_deck/2" do
    test "updates the deck with valid data" do
      deck = deck_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Deck{} = deck} = Decks.update_deck(deck, update_attrs)
      assert deck.name == "some updated name"
    end

    test "returns error changeset with invalid data" do
      deck = deck_fixture()
      assert {:error, %Ecto.Changeset{}} = Decks.update_deck(deck, @invalid_attrs)
      assert deck == Decks.get_deck!(deck.id)
    end
  end

  describe "delete_deck/1" do
    test "deletes the deck" do
      deck = deck_fixture()
      assert {:ok, %Deck{}} = Decks.delete_deck(deck)
      assert_raise Ecto.NoResultsError, fn -> Decks.get_deck!(deck.id) end
    end
  end

  describe "change_deck/1" do
    test "returns a deck changeset" do
      deck = deck_fixture()
      assert %Ecto.Changeset{} = Decks.change_deck(deck)
    end
  end
end
