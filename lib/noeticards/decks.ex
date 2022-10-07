defmodule Noeticards.Decks do
  @moduledoc "Decks context"
  alias NoeticardsSchemas, as: Schemas
  alias Noeticards.Repo

  def add_new_deck(params) do
    %Schemas.Deck{}
    |> Schemas.Deck.changeset(params)
    |> Repo.insert()
  end
end
