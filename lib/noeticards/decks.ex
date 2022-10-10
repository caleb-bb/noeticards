defmodule Noeticards.Decks do
  @moduledoc "Decks context"
  alias NoeticardsSchemas, as: Schemas
  alias NoeticardsSchemas.Deck
  alias Noeticards.Repo

  def add_new_deck(params) do
    %Deck{}
    |> Deck.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Returns the list of decks.

  ## Examples

      iex> list_decks()
      [%Deck{}, ...]

  """
  def list_decks do
    Repo.all(Deck)
  end

  @doc """
  Gets a single deck.

  Raises `Ecto.NoResultsError` if the Deck does not exist.

  ## Examples

      iex> get_deck!(123)
      %Deck{}

      iex> get_deck!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deck!(id), do: Repo.get!(Deck, id)

  def get_deck_with_cards!(id), do: get_deck!(id) |> Repo.preload(:cards)

  @doc """
  Creates a deck.

  ## Examples

      iex> create_deck(%{field: value})
      {:ok, %Deck{}}

      iex> create_deck(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deck(attrs \\ %{}) do
    %Deck{}
    |> Deck.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deck.

  ## Examples

      iex> update_deck(deck, %{field: new_value})
      {:ok, %Deck{}}

      iex> update_deck(deck, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deck(%Deck{} = deck, attrs) do
    deck
    |> Deck.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deck.

  ## Examples

      iex> delete_deck(deck)
      {:ok, %Deck{}}

      iex> delete_deck(deck)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deck(%Deck{} = deck) do
    Repo.delete(deck)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deck changes.

  ## Examples

      iex> change_deck(deck)
      %Ecto.Changeset{data: %Deck{}}

  """
  def change_deck(%Deck{} = deck, attrs \\ %{}) do
    Deck.changeset(deck, attrs)
  end
end
