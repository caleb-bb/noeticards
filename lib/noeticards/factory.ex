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
end
