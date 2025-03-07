defmodule DedSheetWeb.Router do
  use DedSheetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DedSheetWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DedSheetWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/sheet", PageController, :sheet

    live "/character_sheets", CharacterSheetLive.Index, :index
    live "/character_sheets/new", CharacterSheetLive.Index, :new
    live "/character_sheets/:id/edit", CharacterSheetLive.Index, :edit
    live "/character_sheets/:id", CharacterSheetLive.Show, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", DedSheetWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ded_sheet, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DedSheetWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
