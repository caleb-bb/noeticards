defmodule Noeticards.Cards do
  @moduledoc "Cards context"

  import Ecto.Changeset
  import Ecto.Query

  alias NoeticardsSchemas.Card
  alias Noeticards.Repo

  @doc """
  Create a new card from empty card struct and params and insert into the db.
  """
  def create_card(params) do
    %Card{}
    |> Card.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Returns all cards in the deck identified by deck_id.
  """
  def cards_in_deck!(deck_id) do
    Card.base_query()
    |> Card.where_deck_id(deck_id)
    |> Repo.all()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card changes.

  ## Examples

      iex> change_card(card)
      %Ecto.Changeset{data: %Card{}}

  """
  def change_card(%Card{} = card, attrs \\ %{}) do
    Card.changeset(card, attrs)
  end
end
