defmodule Noeticards.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Noeticards.Repo,
      # Start the Telemetry supervisor
      NoeticardsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Noeticards.PubSub},
      # Start the Endpoint (http/https)
      NoeticardsWeb.Endpoint
      # Start a worker by calling: Noeticards.Worker.start_link(arg)
      # {Noeticards.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Noeticards.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NoeticardsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
