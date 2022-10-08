defmodule Noeticards.DecksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Noeticards.Decks` context.
  """

  @doc """
  Generate a deck.
  """
  def deck_fixture(attrs \\ %{}) do
    {:ok, deck} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Noeticards.Decks.create_deck()

    deck
  end
end
