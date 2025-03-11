defmodule DedSheetWeb.CharacterSheetLive.FormComponent do
  use DedSheetWeb, :live_component

  alias DedSheet.Game
  alias DedSheet.Game.CharacterSheet

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage character_sheet records in your database.</:subtitle>
      </.header>

      <.simple_form for={@form} id="character_sheet-form" phx-target={@myself} phx-submit="save">
        <.input
          field={@form[:player_level]}
          type="number"
          label="Player Level"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input field={@form[:proficiency_bonus]} type="number" label="Proficiency Bonus" />
        <.input field={@form[:initiative]} type="number" label="Initiative" />
        <.input field={@form[:size]} type="text" label="Size" />
        <.input field={@form[:passive_perception]} type="number" label="Passive Perception" />
        <.input field={@form[:heroic_inspiration]} type="checkbox" label="Heroic Inspiration" />
        <.input
          field={@form[:strength_score]}
          type="number"
          label="Strength score"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input field={@form[:strength_modifier]} type="number" label="Strength modifier" />
        <.input
          field={@form[:strength_saving_throw_proficient]}
          type="checkbox"
          label="Strength saving throw proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:strength_saving_throw]}
          type="number"
          label="Strength saving throw"
          readonly
        />
        <.input
          field={@form[:athletics_proficient]}
          type="checkbox"
          label="Athletics proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input field={@form[:athletics]} type="number" label="Athletics" />
        <.input
          field={@form[:intelligence_score]}
          type="number"
          label="Intelligence score"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input field={@form[:intelligence_modifier]} type="number" label="Intelligence modifier" />
        <.input
          field={@form[:intelligence_saving_throw_proficient]}
          type="checkbox"
          label="Intelligence saving throw proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:intelligence_saving_throw]}
          type="number"
          label="Intelligence saving throw"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:arcana_proficient]}
          type="checkbox"
          label="Arcana proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:arcana]}
          type="number"
          label="Arcana"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:history_proficient]}
          type="checkbox"
          label="History proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:history]}
          type="number"
          label="History"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:investigation_proficient]}
          type="checkbox"
          label="Investigation proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:investigation]}
          type="number"
          label="Investigation"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:nature_proficient]}
          type="checkbox"
          label="Nature proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:nature]}
          type="number"
          label="Nature"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:religion_proficient]}
          type="checkbox"
          label="Religion proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:religion]}
          type="number"
          label="Religion"
          phx-change="update_modifiers"
          phx-target={@myself}
        />

        <.input
          field={@form[:dexterity_score]}
          type="number"
          label="Dexterity score"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input field={@form[:dexterity_modifier]} type="number" label="Dexterity modifier" />

        <.input
          field={@form[:dexterity_saving_throw_proficient]}
          type="checkbox"
          label="Dexterity saving throw proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:dexterity_saving_throw]}
          type="number"
          label="Dexterity saving throw"
          phx-change="update_modifiers"
          phx-target={@myself}
        />


        <.input
          field={@form[:acrobatics_proficient]}
          type="checkbox"
          label="Acrobatics proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:acrobatics]}
          type="number"
          label="Acrobatics"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:sleight_of_hands_proficient]}
          type="checkbox"
          label="Sleight of Hands proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:sleight_of_hands]}
          type="number"
          label="Sleight of Hands"
          phx-change="update_modifiers"
          phx-target={@myself}
        />

        <.input
          field={@form[:stealth_proficient]}
          type="checkbox"
          label="Stealth proficient"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <.input
          field={@form[:stealth]}
          type="number"
          label="Stealth"
          phx-change="update_modifiers"
          phx-target={@myself}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Character sheet</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

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
      Ecto.Changeset.apply_changes(socket.assigns.form.source)
      |> Map.from_struct()
      |> Map.new(fn {key, value} -> {Atom.to_string(key), value} end)

    # Mescla os novos parâmetros recebidos
    merged_params = Map.merge(existing_data, params)
    # Converte os valores para inteiros e evita erro se estiverem vazios
    {updated_params, _modifiers} = calculate_modifiers(existing_data, merged_params)

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

  defp calculate_modifiers(character_sheet, params) do
    character_sheet_map =
      if is_struct(character_sheet) do
        Map.from_struct(character_sheet)
      else
        character_sheet
      end

    # Mescla os parâmetros novos com os valores antigos
    merged_params = Map.merge(character_sheet_map, params)
    # Função auxiliar para converter valores em inteiros com fallback
    parse_int = fn
      "" -> 1
      nil -> 1
      v when is_integer(v) -> v
      v when is_binary(v) -> String.to_integer(v)
    end

    # Converte os valores corretamente
    player_level =
      parse_int.(
        Map.get(merged_params, "player_level", Map.get(merged_params, :player_level, "10"))
      )

    strength_score =
      parse_int.(
        Map.get(merged_params, "strength_score", Map.get(merged_params, :strength_score, "10"))
      )

    intelligence_score =
      parse_int.(
        Map.get(
          merged_params,
          "intelligence_score",
          Map.get(merged_params, :intelligence_score, "10")
        )
      )

    dexterity_score =
      parse_int.(
        Map.get(
          merged_params,
          "dexterity_score",
          Map.get(merged_params, :dexterity_score, "10")
        )
      )

    # Prof bonus
    proficiency_bonus = div(player_level - 1, 4) + 2

    # Calcula os modificadores
    strength_modifier = floor((strength_score - 10) / 2)
    intelligence_modifier = floor((intelligence_score - 10) / 2)
    dexterity_modifier = floor((dexterity_score - 10) / 2)
    # wisdom_modifier = floor((strength_score - 10) / 2)
    # constitution_modifier = floor((strength_score - 10) / 2)

    # Strength
    strength_saving_throw_proficient = Map.get(merged_params, "strength_saving_throw_proficient")
    athletics_proficient = Map.get(merged_params, "athletics_proficient")

    # Strength values
    strength_saving_throw_value =
      check_prof(strength_saving_throw_proficient, strength_modifier, proficiency_bonus)

    athletics_value = check_prof(athletics_proficient, strength_modifier, proficiency_bonus)

    # Intelligence
    intelligence_saving_throw_proficient =
      Map.get(merged_params, "intelligence_saving_throw_proficient")

    arcana_proficient = Map.get(merged_params, "arcana_proficient")
    history_proficient = Map.get(merged_params, "history_proficient")
    investigation_proficient = Map.get(merged_params, "investigation_proficient")
    nature_proficient = Map.get(merged_params, "nature_proficient")
    religion_proficient = Map.get(merged_params, "religion_proficient")

    # Intelligence values
    intelligence_saving_throw_value =
      check_prof(intelligence_saving_throw_proficient, intelligence_modifier, proficiency_bonus)

    arcana_value = check_prof(arcana_proficient, intelligence_modifier, proficiency_bonus)
    history_value = check_prof(history_proficient, intelligence_modifier, proficiency_bonus)

    investigation_value =
      check_prof(investigation_proficient, intelligence_modifier, proficiency_bonus)

    nature_value = check_prof(nature_proficient, intelligence_modifier, proficiency_bonus)
    religion_value = check_prof(religion_proficient, intelligence_modifier, proficiency_bonus)

    # Dexterity
    dexterity_saving_throw_proficient = Map.get(merged_params, "dexterity_saving_throw_proficient")
    acrobatics_proficient = Map.get(merged_params, "acrobatics_proficient")
    sleight_of_hands_proficient = Map.get(merged_params, "sleight_of_hands_proficient")
    stealth_proficient = Map.get(merged_params, "stealth_proficient")

    # Dexterity values
    dexterity_saving_throw_value = check_prof(dexterity_saving_throw_proficient, dexterity_modifier, proficiency_bonus)
    acrobatics_value = check_prof(acrobatics_proficient, dexterity_modifier, proficiency_bonus)
    sleight_of_hands_value = check_prof(sleight_of_hands_proficient, dexterity_modifier, proficiency_bonus)
    stealth_value = check_prof(stealth_proficient, dexterity_modifier, proficiency_bonus)

    # Atualiza os parâmetros com os valores calculados
    updated_params =
      merged_params
      |> Map.put("player_level", player_level)
      |> Map.put("proficiency_bonus", proficiency_bonus)
      |> Map.put("strength_modifier", strength_modifier)
      |> Map.put("intelligence_modifier", intelligence_modifier)
      |> Map.put("strength_saving_throw", strength_saving_throw_value)
      |> Map.put("athletics", athletics_value)
      |> Map.put("intelligence_saving_throw", intelligence_saving_throw_value)
      |> Map.put("arcana", arcana_value)
      |> Map.put("history", history_value)
      |> Map.put("investigation", investigation_value)
      |> Map.put("nature", nature_value)
      |> Map.put("religion", religion_value)
      |> Map.put("dexterity_modifier", dexterity_modifier)
      |> Map.put("dexterity_saving_throw", dexterity_saving_throw_value)
      |> Map.put("acrobatics", acrobatics_value)
      |> Map.put("sleight_of_hands", sleight_of_hands_value)
      |> Map.put("stealth", stealth_value)

    {updated_params,
     %{
       strength_modifier: strength_modifier,
       proficiency_bonus: proficiency_bonus
     }}
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
