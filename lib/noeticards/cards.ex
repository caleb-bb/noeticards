defmodule Noeticards.Cards do
  @moduledoc "Cards context"
  alias NoeticardsSchemas, as: Schemas
  alias Noeticards.Repo

  def add_new_card(params) do
    %Schemas.Card{}
    |> Schemas.Card.changeset(params)
    |> Repo.insert()
  end
end
