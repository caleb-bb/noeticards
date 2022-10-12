defmodule NoeticardsSchemas.DeckTest do
  use Noeticards.DataCase
  alias NoeticardsSchemas.Deck

  describe "changeset/2" do
    test "returs a valid changeset with valid attrs" do
      attrs = %{name: "name"}
      changeset = Deck.changeset(%Deck{}, attrs)

      assert changeset.valid?
    end

    test "returns an invalid changeset with invalid attrs" do
      attrs = %{}
      changeset = Deck.changeset(%Deck{}, attrs)

      refute changeset.valid?

      assert %{name: ["can't be blank"]} == errors_on(changeset)
    end
  end
end
