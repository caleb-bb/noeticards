defmodule NoeticardsWeb.DeckLive.Show do
  use NoeticardsWeb, :live_view

  alias Noeticards.Cards
  alias Noeticards.Cards
  alias Noeticards.Decks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"deck_id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign_deck(id)
     |> assign_card(id)}
  end

  defp page_title(:show), do: "Show Deck"
  defp page_title(:edit), do: "Edit Deck"
  defp page_title(:add_card), do: "Add a Card"

  defp assign_deck(socket, id), do: assign(socket, :deck, Decks.get_deck!(id))
  defp assign_card(socket, id), do: assign(socket, :cards, Cards.cards_in_deck!(id))
end
