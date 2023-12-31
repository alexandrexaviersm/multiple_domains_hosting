defmodule Store.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      StoreWeb.Telemetry,
      # Start the Ecto repository
      Store.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Store.PubSub},
      # Start Finch
      {Finch, name: Store.Finch},
      # Start the Endpoint (http/https)
      StoreWeb.Endpoint,
      # Start a worker by calling: Store.Worker.start_link(arg)
      # {Store.Worker, arg}
     {Beacon, sites: [[site: :books, endpoint: StoreWeb.Endpoint, data_source: Store.BeaconDataSource]]}
]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Store.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
