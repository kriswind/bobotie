defmodule PhoenixNest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixNestWeb.Telemetry,
      PhoenixNest.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_nest, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixNest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixNest.Finch},
      # Start a worker by calling: PhoenixNest.Worker.start_link(arg)
      # {PhoenixNest.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixNestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixNest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixNestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
