defmodule NoeticardsWeb.DeckLive.QuizComponent do
  use NoeticardsWeb, :live_component
  alias Noeticards.Decks
  alias Phoenix.LiveView.JS

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> shuffle_cards()}
  end

  @impl true
  def handle_event("flip", _params, %{assigns: %{side: side}} = socket) do
    {:noreply,
     socket
     |> flip_card(side)}
  end

  @impl true
  def handle_event("shuffle", _params, socket) do
    {:noreply,
     socket
     |> shuffle_cards()}
  end

  @impl true
  def handle_event("next", _params, socket) do
    {:noreply,
     socket
     |> change_card(1)}
  end

  @impl true
  def handle_event("previous", _params, socket) do
    {:noreply,
     socket
     |> change_card(-1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
        <div>
            <%= display_card(@cards, @current_card, @side) %>
        </div>
        <div>
          <button phx-click={JS.push("flip", target: @myself, loading: ".container")}>Flip</button>
          <button phx-click={JS.push("shuffle", target: @myself, loading: ".container")}>Shuffle</button>
        </div>

        <div>
            <%= if @current_card > 0 do %> <button phx-click={JS.push("previous", target: @myself, loading: ".container")}>Previous</button><% end %>
            <%= if @current_card + 1 < @deck_size do %>
            <button phx-click={JS.push("next", target: @myself, loading: ".container")}>Next</button> <% end %>
        </div>
        <%= @current_card + 1 %> / <%= @deck_size %>
      </div>
    """
  end

  defp flip_card(socket, :front_text), do: assign(socket, :side, :back_text)
  defp flip_card(socket, :back_text), do: assign(socket, :side, :front_text)

  defp shuffle_cards(socket) do
    update(socket, :cards, &Enum.shuffle/1)
  end

  defp display_card(cards, current_card, side) do
    card = Enum.at(cards, current_card)

    Map.get(card, side)
  end

  defp change_card(socket, increment),
    do: update(socket, :current_card, fn card_index -> card_index + increment end)
end
