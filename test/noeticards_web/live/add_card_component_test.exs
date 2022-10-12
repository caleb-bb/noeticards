defmodule NoeticardsWeb.AddCardComponentTest do
  use NoeticardsWeb.ConnCase
  import Noeticards.Factory
  import Phoenix.LiveViewTest
  alias NoeticardsWeb.Router.Helpers, as: Routes

  describe "can add a new card" do
    test "card is visible after form submission", %{conn: conn} do
      deck = insert(:deck)
      path = Routes.deck_show_path(conn, :add_card, deck.id)
      {:ok, view_before_card_is_added, _html} = live(conn, path)

      {:ok, view_after_card_is_added, _html} =
        view_before_card_is_added
        |> form("#card-form", %{
          card: %{name: "TEST CARD", front_text: "this is my front", back_text: "this is my back"}
        })
        |> render_submit()
        |> follow_redirect(conn)

      card_info =
        view_after_card_is_added
        |> element("[data-role=\"card-info\"]")
        |> render

      assert card_info =~ "TEST CARD"
      assert card_info =~ "this is my front"
      assert card_info =~ "this is my back"
    end
  end
end
