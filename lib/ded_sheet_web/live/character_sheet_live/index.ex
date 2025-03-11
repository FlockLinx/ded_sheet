defmodule DedSheetWeb.CharacterSheetLive.Index do
  use DedSheetWeb, :live_view

  alias DedSheet.Game
  alias DedSheet.Game.CharacterSheet

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :character_sheets, Game.list_character_sheets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Character sheet")
    |> assign(:character_sheet, Game.get_character_sheet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Character sheet")
    |> assign(:character_sheet, %CharacterSheet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Character sheets")
    |> assign(:character_sheet, nil)
  end

  @impl true
  def handle_info(
        {DedSheetWeb.CharacterSheetLive.FormComponent, {:saved, character_sheet}},
        socket
      ) do
    {:noreply, stream_insert(socket, :character_sheets, character_sheet)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    character_sheet = Game.get_character_sheet!(id)
    {:ok, _} = Game.delete_character_sheet(character_sheet)

    {:noreply, stream_delete(socket, :character_sheets, character_sheet)}
  end
end
