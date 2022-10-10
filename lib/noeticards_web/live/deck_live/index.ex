defmodule NoeticardsWeb.DeckLive.Index do
  use NoeticardsWeb, :live_view

  alias Noeticards.Decks
  alias NoeticardsSchemas.Deck

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :decks, list_decks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"deck_id" => id}) do
    socket
    |> assign(:page_title, "Edit Deck")
    |> assign(:deck, Decks.get_deck!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Deck")
    |> assign(:deck, %Deck{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Decks")
    |> assign(:deck, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    deck = Decks.get_deck!(id)
    {:ok, _} = Decks.delete_deck(deck)

    {:noreply, assign(socket, :decks, list_decks())}
  end

  defp list_decks do
    Decks.list_decks()
  end
end
