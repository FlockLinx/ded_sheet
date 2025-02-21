defmodule DedSheetWeb.PageController do
  use DedSheetWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def sheet(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :sheet, layout: false)
  end
end
