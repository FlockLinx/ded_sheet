defmodule DedSheet.GameTest do
  use DedSheet.DataCase

  alias DedSheet.Game

  describe "character_sheets" do
    alias DedSheet.Game.CharacterSheet

    import DedSheet.GameFixtures

    @invalid_attrs %{history: nil, strength_modifier: nil, strength_score: nil, strength_saving_throw_proficient: nil, strength_saving_throw: nil, athletics_proficient: nil, athletics: nil, intelligence_modifier: nil, intelligence_score: nil, intelligence_saving_throw_proficient: nil, intelligence_saving_throw: nil, arcana_proficient: nil, arcana: nil, history_proficient: nil, investigation_proficient: nil, investigation: nil, nature_proficient: nil, nature: nil, religion_proficient: nil, religion: nil}

    test "list_character_sheets/0 returns all character_sheets" do
      character_sheet = character_sheet_fixture()
      assert Game.list_character_sheets() == [character_sheet]
    end

    test "get_character_sheet!/1 returns the character_sheet with given id" do
      character_sheet = character_sheet_fixture()
      assert Game.get_character_sheet!(character_sheet.id) == character_sheet
    end

    test "create_character_sheet/1 with valid data creates a character_sheet" do
      valid_attrs = %{history: 42, strength_modifier: 42, strength_score: 42, strength_saving_throw_proficient: true, strength_saving_throw: 42, athletics_proficient: true, athletics: 42, intelligence_modifier: 42, intelligence_score: 42, intelligence_saving_throw_proficient: true, intelligence_saving_throw: 42, arcana_proficient: true, arcana: 42, history_proficient: true, investigation_proficient: true, investigation: 42, nature_proficient: true, nature: 42, religion_proficient: true, religion: 42}

      assert {:ok, %CharacterSheet{} = character_sheet} = Game.create_character_sheet(valid_attrs)
      assert character_sheet.history == 42
      assert character_sheet.strength_modifier == 42
      assert character_sheet.strength_score == 42
      assert character_sheet.strength_saving_throw_proficient == true
      assert character_sheet.strength_saving_throw == 42
      assert character_sheet.athletics_proficient == true
      assert character_sheet.athletics == 42
      assert character_sheet.intelligence_modifier == 42
      assert character_sheet.intelligence_score == 42
      assert character_sheet.intelligence_saving_throw_proficient == true
      assert character_sheet.intelligence_saving_throw == 42
      assert character_sheet.arcana_proficient == true
      assert character_sheet.arcana == 42
      assert character_sheet.history_proficient == true
      assert character_sheet.investigation_proficient == true
      assert character_sheet.investigation == 42
      assert character_sheet.nature_proficient == true
      assert character_sheet.nature == 42
      assert character_sheet.religion_proficient == true
      assert character_sheet.religion == 42
    end

    test "create_character_sheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_character_sheet(@invalid_attrs)
    end

    test "update_character_sheet/2 with valid data updates the character_sheet" do
      character_sheet = character_sheet_fixture()
      update_attrs = %{history: 43, strength_modifier: 43, strength_score: 43, strength_saving_throw_proficient: false, strength_saving_throw: 43, athletics_proficient: false, athletics: 43, intelligence_modifier: 43, intelligence_score: 43, intelligence_saving_throw_proficient: false, intelligence_saving_throw: 43, arcana_proficient: false, arcana: 43, history_proficient: false, investigation_proficient: false, investigation: 43, nature_proficient: false, nature: 43, religion_proficient: false, religion: 43}

      assert {:ok, %CharacterSheet{} = character_sheet} = Game.update_character_sheet(character_sheet, update_attrs)
      assert character_sheet.history == 43
      assert character_sheet.strength_modifier == 43
      assert character_sheet.strength_score == 43
      assert character_sheet.strength_saving_throw_proficient == false
      assert character_sheet.strength_saving_throw == 43
      assert character_sheet.athletics_proficient == false
      assert character_sheet.athletics == 43
      assert character_sheet.intelligence_modifier == 43
      assert character_sheet.intelligence_score == 43
      assert character_sheet.intelligence_saving_throw_proficient == false
      assert character_sheet.intelligence_saving_throw == 43
      assert character_sheet.arcana_proficient == false
      assert character_sheet.arcana == 43
      assert character_sheet.history_proficient == false
      assert character_sheet.investigation_proficient == false
      assert character_sheet.investigation == 43
      assert character_sheet.nature_proficient == false
      assert character_sheet.nature == 43
      assert character_sheet.religion_proficient == false
      assert character_sheet.religion == 43
    end

    test "update_character_sheet/2 with invalid data returns error changeset" do
      character_sheet = character_sheet_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_character_sheet(character_sheet, @invalid_attrs)
      assert character_sheet == Game.get_character_sheet!(character_sheet.id)
    end

    test "delete_character_sheet/1 deletes the character_sheet" do
      character_sheet = character_sheet_fixture()
      assert {:ok, %CharacterSheet{}} = Game.delete_character_sheet(character_sheet)
      assert_raise Ecto.NoResultsError, fn -> Game.get_character_sheet!(character_sheet.id) end
    end

    test "change_character_sheet/1 returns a character_sheet changeset" do
      character_sheet = character_sheet_fixture()
      assert %Ecto.Changeset{} = Game.change_character_sheet(character_sheet)
    end
  end
end
