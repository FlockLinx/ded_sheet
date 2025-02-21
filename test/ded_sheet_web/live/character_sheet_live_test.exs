defmodule DedSheetWeb.CharacterSheetLiveTest do
  use DedSheetWeb.ConnCase

  import Phoenix.LiveViewTest
  import DedSheet.GameFixtures

  @create_attrs %{history: 42, strength_modifier: 42, strength_score: 42, strength_saving_throw_proficient: true, strength_saving_throw: 42, athletics_proficient: true, athletics: 42, intelligence_modifier: 42, intelligence_score: 42, intelligence_saving_throw_proficient: true, intelligence_saving_throw: 42, arcana_proficient: true, arcana: 42, history_proficient: true, investigation_proficient: true, investigation: 42, nature_proficient: true, nature: 42, religion_proficient: true, religion: 42}
  @update_attrs %{history: 43, strength_modifier: 43, strength_score: 43, strength_saving_throw_proficient: false, strength_saving_throw: 43, athletics_proficient: false, athletics: 43, intelligence_modifier: 43, intelligence_score: 43, intelligence_saving_throw_proficient: false, intelligence_saving_throw: 43, arcana_proficient: false, arcana: 43, history_proficient: false, investigation_proficient: false, investigation: 43, nature_proficient: false, nature: 43, religion_proficient: false, religion: 43}
  @invalid_attrs %{history: nil, strength_modifier: nil, strength_score: nil, strength_saving_throw_proficient: false, strength_saving_throw: nil, athletics_proficient: false, athletics: nil, intelligence_modifier: nil, intelligence_score: nil, intelligence_saving_throw_proficient: false, intelligence_saving_throw: nil, arcana_proficient: false, arcana: nil, history_proficient: false, investigation_proficient: false, investigation: nil, nature_proficient: false, nature: nil, religion_proficient: false, religion: nil}

  defp create_character_sheet(_) do
    character_sheet = character_sheet_fixture()
    %{character_sheet: character_sheet}
  end

  describe "Index" do
    setup [:create_character_sheet]

    test "lists all character_sheets", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/character_sheets")

      assert html =~ "Listing Character sheets"
    end

    test "saves new character_sheet", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/character_sheets")

      assert index_live |> element("a", "New Character sheet") |> render_click() =~
               "New Character sheet"

      assert_patch(index_live, ~p"/character_sheets/new")

      assert index_live
             |> form("#character_sheet-form", character_sheet: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#character_sheet-form", character_sheet: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/character_sheets")

      html = render(index_live)
      assert html =~ "Character sheet created successfully"
    end

    test "updates character_sheet in listing", %{conn: conn, character_sheet: character_sheet} do
      {:ok, index_live, _html} = live(conn, ~p"/character_sheets")

      assert index_live |> element("#character_sheets-#{character_sheet.id} a", "Edit") |> render_click() =~
               "Edit Character sheet"

      assert_patch(index_live, ~p"/character_sheets/#{character_sheet}/edit")

      assert index_live
             |> form("#character_sheet-form", character_sheet: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#character_sheet-form", character_sheet: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/character_sheets")

      html = render(index_live)
      assert html =~ "Character sheet updated successfully"
    end

    test "deletes character_sheet in listing", %{conn: conn, character_sheet: character_sheet} do
      {:ok, index_live, _html} = live(conn, ~p"/character_sheets")

      assert index_live |> element("#character_sheets-#{character_sheet.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#character_sheets-#{character_sheet.id}")
    end
  end

  describe "Show" do
    setup [:create_character_sheet]

    test "displays character_sheet", %{conn: conn, character_sheet: character_sheet} do
      {:ok, _show_live, html} = live(conn, ~p"/character_sheets/#{character_sheet}")

      assert html =~ "Show Character sheet"
    end

    test "updates character_sheet within modal", %{conn: conn, character_sheet: character_sheet} do
      {:ok, show_live, _html} = live(conn, ~p"/character_sheets/#{character_sheet}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Character sheet"

      assert_patch(show_live, ~p"/character_sheets/#{character_sheet}/show/edit")

      assert show_live
             |> form("#character_sheet-form", character_sheet: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#character_sheet-form", character_sheet: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/character_sheets/#{character_sheet}")

      html = render(show_live)
      assert html =~ "Character sheet updated successfully"
    end
  end
end
