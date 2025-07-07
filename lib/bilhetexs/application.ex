defmodule Bilhetexs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BilhetexsWeb.Telemetry,
      Bilhetexs.Repo,
      {DNSCluster, query: Application.get_env(:bilhetexs, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Bilhetexs.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Bilhetexs.Finch},
      # Start a worker by calling: Bilhetexs.Worker.start_link(arg)
      # {Bilhetexs.Worker, arg},
      # Start to serve requests, typically the last entry
      BilhetexsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bilhetexs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BilhetexsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
