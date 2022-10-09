defmodule NoeticardsWeb.Router do
  use NoeticardsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {NoeticardsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NoeticardsWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/decks", DeckLive.Index, :index
    live "/decks/:deck_id/show", DeckLive.Show, :show
    live "/decks/:deck_id/edit", DeckLive.Show, :edit
    live "/decks/:deck_id/index_edit", DeckLive.Index, :edit
    live "/decks/new", DeckLive.Index, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", NoeticardsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: NoeticardsWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
