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
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"card" => card_params}, socket) do
    changeset =
      %Card{}
      |> Cards.change_card(card_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"card" => card_params}, %{assigns: assigns} = socket) do
    id_params =
      card_params
      |> Map.merge(%{"deck_id" => assigns.id})

    case Cards.create_card(id_params) do
      {:ok, _card} ->
        {:noreply,
         socket
         |> put_flash(:info, "Card created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
