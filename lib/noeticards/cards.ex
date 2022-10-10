defmodule Noeticards.Cards do
  @moduledoc "Cards context"
  alias NoeticardsSchemas.Card
  alias Noeticards.Repo

  def add_new_card(params) do
    %Card{}
    |> Card.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Returns the list of cards.

  ## Examples

      iex> list_cards()
      [%Deck{}, ...]

  """
  def list_cards do
    Repo.all(Card)
  end
end
