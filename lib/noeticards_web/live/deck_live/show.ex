defmodule NoeticardsWeb.DeckLive.Show do
  use NoeticardsWeb, :live_view

  alias Noeticards.Cards
  alias Noeticards.Cards
  alias Noeticards.Decks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(filter: "")}
  end

  @impl true
  def handle_event("search", %{"search_field" => %{"filter" => filter}}, socket),
    do: {:noreply, assign(socket, filter: filter)}

  @impl true
  def handle_params(%{"deck_id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign_deck(id)
     |> assign_cards(id)
     |> assign_deck_size()}
  end

  @impl true
  def handle_params(%{"card_id" => id}, _, socket) do
    id
    |> String.to_integer()
    |> Cards.delete_card!()

    {:noreply,
     socket
     |> assign_cards(socket.assigns.deck.id)}
  end

  defp page_title(:show), do: "Show Deck"
  defp page_title(:edit), do: "Edit Deck"
  defp page_title(:add_card), do: "Add a Card"
  defp page_title(:quiz), do: "Quiz Time!"

  defp apply_filter(card, filter) do
    text = card.front_text <> card.back_text <> card.name
    String.downcase(text) |> String.contains?(String.downcase(filter))
  end

  defp assign_deck(socket, id), do: assign(socket, :deck, Decks.get_deck!(id))
  defp assign_cards(socket, id), do: assign(socket, :cards, Cards.cards_in_deck!(id))

  defp assign_deck_size(%{assigns: %{cards: cards}} = socket) do
    deck_size = Enum.count(cards)
    assign(socket, :deck_size, socket.assigns.cards |> Enum.count())
  end
end
