defmodule DedSheet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DedSheetWeb.Telemetry,
      DedSheet.Repo,
      {DNSCluster, query: Application.get_env(:ded_sheet, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DedSheet.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DedSheet.Finch},
      # Start a worker by calling: DedSheet.Worker.start_link(arg)
      # {DedSheet.Worker, arg},
      # Start to serve requests, typically the last entry
      DedSheetWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DedSheet.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DedSheetWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
