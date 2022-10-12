defmodule NoeticardsSchemas.CardTest do
  use Noeticards.DataCase
  import Noeticards.Factory
  alias Ecto.Query
  alias NoeticardsSchemas.Card

  describe "changeset/2" do
    test "returs a valid changeset with valid attrs" do
      attrs = %{name: "name", front_text: "front", back_text: "back", deck_id: 0}
      changeset = Card.changeset(%Card{}, attrs)

      assert changeset.valid?
    end

    test "returns an invalid changeset with invalid attrs" do
      attrs = %{}
      changeset = Card.changeset(%Card{}, attrs)

      refute changeset.valid?

      assert %{
               back_text: ["can't be blank"],
               deck_id: ["can't be blank"],
               front_text: ["can't be blank"],
               name: ["can't be blank"]
             } == errors_on(changeset)
    end
  end

  describe "base_query/0" do
    test "returns an Ecto.Query struct" do
      assert %Query{} = Card.base_query()
    end

    test "adds a named binding for the Card struct" do
      assert Card.base_query() |> Query.has_named_binding?(:card)
    end
  end

  describe "where_deck_id/2" do
    test "limits results to cards in a certain deck" do
      %Card{deck_id: deck_id} = insert(:card)
      _non_matching_card = insert(:card)

      assert [%Card{deck_id: ^deck_id}] =
               Card.base_query()
               |> Card.where_deck_id(deck_id)
               |> Repo.all()
    end
  end
end
