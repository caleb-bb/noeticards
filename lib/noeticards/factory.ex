defmodule Noeticards.Factory do
  @moduledoc "Test factories"

  use ExMachina.Ecto, repo: Noeticards.Repo
  alias NoeticardsSchemas, as: Schemas

  @doc """
  Generates a deck
  """
  def deck_factory do
    %Schemas.Deck{name: sequence(:name, &"Deck #{&1}", start_at: 1)}
  end

  @doc """
  Generates a deck
  """
  def card_factory do
    %Schemas.Card{
      name: sequence(:name, &"Card #{&1}", start_at: 1),
      back_text: "back",
      front_text: "Front",
      deck: build(:deck)
    }
  end
end
