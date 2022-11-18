defmodule NoeticardsWeb.DeckLive.AddCardComponent do
  use NoeticardsWeb, :live_component
  alias Noeticards.Cards
  alias NoeticardsSchemas.Card

  @impl true
  def update(assigns, socket) do
    changeset = Cards.change_card(%Card{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:deck_id, assigns.id)}
  end

  @impl true
  def handle_event("validate", %{"card" => card_params}, socket) do
    changeset =
      %Card{}
      |> Cards.change_card(card_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"card" => params}, %{assigns: assigns} = socket) do
    IO.inspect(params, label: "here are the params in the event_handler")

    case Cards.create_card(params) do
      {:ok, _card} ->
        {:noreply,
         socket
         |> put_flash(:info, "Card created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp save_card(socket, :add_card, card_params) do
  end
end
