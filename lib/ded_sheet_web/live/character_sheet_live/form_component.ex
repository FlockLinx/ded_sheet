defmodule DedSheetWeb.CharacterSheetLive.FormComponent do
  use DedSheetWeb, :live_component

  alias DedSheet.Game
  alias DedSheet.Game.CharacterSheet

  def mount(_params, _session, socket) do
    # Inicializa o formulário corretamente
    changeset = CharacterSheet.changeset(%CharacterSheet{}, %{})
    {:ok, assign(socket, form: to_form(changeset))}
  end

  @impl true
  def update(%{character_sheet: character_sheet} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Game.change_character_sheet(character_sheet))
     end)}
  end

  @impl true
  def handle_event("update_modifiers", %{"character_sheet" => params}, socket) do
    existing_data =
      Ecto.Changeset.apply_changes(socket.assigns.form.source) |> Map.from_struct() |> stringify_keys()
    # Mescla os novos parâmetros recebidos
    merged_params = Map.merge(existing_data, stringify_keys(params))
    # Converte os valores para inteiros e evita erro se estiverem vazios
    updated_params = calculate_modifiers(existing_data, merged_params)

    changeset = CharacterSheet.changeset(%CharacterSheet{}, updated_params)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  #   @impl true
  def handle_event("validate", %{"character_sheet" => character_sheet_params}, socket) do
    changeset =
      Game.change_character_sheet(socket.assigns.character_sheet, character_sheet_params)

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"character_sheet" => character_sheet_params}, socket) do
    save_character_sheet(socket, socket.assigns.action, character_sheet_params)
  end

  defp stringify_keys(map) when is_map(map) do
    map
    |> Enum.map(fn {key, value} -> {to_string(key), value} end)
    |> Enum.into(%{})
  end

  defp calculate_modifiers(character_sheet, params) do
    character_sheet_map = struct_to_map(character_sheet)

    merged_params = Map.merge(character_sheet_map, params)

    player_level =
      parse_int(
        Map.get(merged_params, "player_level", Map.get(merged_params, :player_level, "10"))
      )

    proficiency_bonus = calculate_proficiency_bonus(player_level)

    ability_scores = calculate_ability_scores(merged_params)
    modifiers = calculate_modifiers_from_scores(ability_scores)
    saving_throws = calculate_saving_throws(merged_params, modifiers, proficiency_bonus)
    skills = calculate_skills(merged_params, modifiers, proficiency_bonus)

    merged_params
    |> Map.put("player_level", player_level)
    |> Map.put("proficiency_bonus", proficiency_bonus)
    |> Map.merge(ability_scores)
    |> Map.merge(modifiers)
    |> Map.merge(saving_throws)
    |> Map.merge(skills)
    |> stringify_keys()
  end

  # Converte um struct para um mapa se necessário
  defp struct_to_map(struct) when is_struct(struct), do: Map.from_struct(struct)
  defp struct_to_map(map), do: map

  # Converte valores para inteiros com fallback
  defp parse_int(""), do: 1
  defp parse_int(nil), do: 1
  defp parse_int(v) when is_integer(v), do: v
  defp parse_int(v) when is_binary(v), do: String.to_integer(v)

  # Calcula o bônus de proficiência
  defp calculate_proficiency_bonus(player_level), do: div(player_level - 1, 4) + 2

  # Obtém os valores das habilidades principais
  defp calculate_ability_scores(params) do
    Enum.into(
      [
        :strength_score,
        :intelligence_score,
        :dexterity_score,
        :wisdom_score,
        :charisma_score,
        :constitution_score
      ],
      %{},
      fn key ->
        {key, parse_int(Map.get(params, to_string(key), Map.get(params, key, "10")))}
      end
    )
  end

  # Calcula os modificadores de habilidades
  defp calculate_modifiers_from_scores(scores) do
    result =
      Enum.into(scores, %{}, fn {key, score} -> {modifier_key(key), floor((score - 10) / 2)} end)

    result
  end

  def modifier_key(:strength_score), do: :strength_modifier
  def modifier_key(:intelligence_score), do: :intelligence_modifier
  def modifier_key(:dexterity_score), do: :dexterity_modifier
  def modifier_key(:wisdom_score), do: :wisdom_modifier
  def modifier_key(:charisma_score), do: :charisma_modifier
  def modifier_key(:constitution_score), do: :constitution_modifier

  # Calcula os testes de resistência
  defp calculate_saving_throws(params, modifiers, proficiency_bonus) do
    for attr <- [:strength, :intelligence, :dexterity, :wisdom, :charisma, :constitution],
        into: %{} do
      proficiency_key = "#{attr}_saving_throw_proficient"

      value =
        check_prof(
          Map.get(params, proficiency_key),
          Map.get(modifiers, modifier_key(:"#{attr}_score")),
          proficiency_bonus
        )

      {"#{attr}_saving_throw", value}
    end
  end

  # Calcula os valores das perícias
  defp calculate_skills(params, modifiers, proficiency_bonus) do
    skills_map = %{
      strength: [:athletics],
      intelligence: [:arcana, :history, :investigation, :nature, :religion],
      dexterity: [:acrobatics, :sleight_of_hands, :stealth],
      wisdom: [:animal_handling, :insight, :medicine, :perception, :survival],
      charisma: [:deception, :intimidation, :performance, :persuasion]
    }

    for {attr, skills} <- skills_map, skill <- skills, into: %{} do
      proficiency_key = "#{skill}_proficient"

      value =
        check_prof(
          Map.get(params, proficiency_key),
          Map.get(modifiers, modifier_key(:"#{attr}_score")),
          proficiency_bonus
        )

      {to_string(skill), value}
    end
  end

  defp save_character_sheet(socket, :edit, character_sheet_params) do
    case Game.update_character_sheet(socket.assigns.character_sheet, character_sheet_params) do
      {:ok, character_sheet} ->
        notify_parent({:saved, character_sheet})

        {:noreply,
         socket
         |> put_flash(:info, "Character sheet updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_character_sheet(socket, :new, character_sheet_params) do
    case Game.create_character_sheet(character_sheet_params) do
      {:ok, character_sheet} ->
        notify_parent({:saved, character_sheet})

        {:noreply,
         socket
         |> put_flash(:info, "Character sheet created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  def check_prof("true", mod, prof_bonus), do: mod + prof_bonus
  def check_prof(true, mod, prof_bonus), do: mod + prof_bonus
  def check_prof(nil, mod, _prof_bonus), do: mod
  def check_prof("false", mod, _prof_bonus), do: mod
  def check_prof(false, mod, _prof_bonus), do: mod
end
