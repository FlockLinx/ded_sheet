defmodule DedSheetWeb.CharacterSheetLive.Show do
  use DedSheetWeb, :live_view

  alias DedSheet.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:character_sheet, Game.get_character_sheet!(id))}
  end

  defp page_title(:show), do: "Show Character sheet"
  defp page_title(:edit), do: "Edit Character sheet"
end
