defmodule DedSheetWeb.CharacterSheetLive.FormComponent do
  use DedSheetWeb, :live_component

  alias DedSheet.Game

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage character_sheet records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="character_sheet-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
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
        <.input field={@form[:strength_modifier]} type="number" label="Strength modifier" readonly />
        <.input
          field={@form[:strength_saving_throw_proficient]}
          type="checkbox"
          label="Strength saving throw proficient"
        />
        <.input field={@form[:strength_saving_throw]} type="number" label="Strength saving throw" />
        <.input field={@form[:athletics_proficient]} type="checkbox" label="Athletics proficient" />
        <.input field={@form[:athletics]} type="number" label="Athletics" />
        <.input field={@form[:intelligence_modifier]} type="number" label="Intelligence modifier" />
        <.input field={@form[:intelligence_score]} type="number" label="Intelligence score" />
        <.input
          field={@form[:intelligence_saving_throw_proficient]}
          type="checkbox"
          label="Intelligence saving throw proficient"
        />
        <.input
          field={@form[:intelligence_saving_throw]}
          type="number"
          label="Intelligence saving throw"
        />
        <.input field={@form[:arcana_proficient]} type="checkbox" label="Arcana proficient" />
        <.input field={@form[:arcana]} type="number" label="Arcana" />
        <.input field={@form[:history_proficient]} type="checkbox" label="History proficient" />
        <.input field={@form[:history]} type="number" label="History" />
        <.input
          field={@form[:investigation_proficient]}
          type="checkbox"
          label="Investigation proficient"
        />
        <.input field={@form[:investigation]} type="number" label="Investigation" />
        <.input field={@form[:nature_proficient]} type="checkbox" label="Nature proficient" />
        <.input field={@form[:nature]} type="number" label="Nature" />
        <.input field={@form[:religion_proficient]} type="checkbox" label="Religion proficient" />
        <.input field={@form[:religion]} type="number" label="Religion" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Character sheet</.button>
        </:actions>
      </.simple_form>
    </div>
    """
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
  def handle_event("validate", %{"character_sheet" => character_sheet_params}, socket) do
    changeset =
      Game.change_character_sheet(socket.assigns.character_sheet, character_sheet_params)

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"character_sheet" => character_sheet_params}, socket) do
    save_character_sheet(socket, socket.assigns.action, character_sheet_params)
  end

  @impl true
  def handle_event("update_modifiers", %{"character_sheet" => params}, socket) do
    # Converte os valores para inteiros e evita erro se estiverem vazios
    strength_score = String.to_integer(params["strength_score"] || "10")
    intelligence_score = String.to_integer(params["intelligence_score"] || "10")
    player_level = String.to_integer(params["player_level"] || "1")
    passive_perception = 10 + String.to_integer(params["wisdom_modifier"] || "0")

    # Calcula os modificadores
    strength_modifier = floor((strength_score - 10) / 2)
    intelligence_modifier = floor((intelligence_score - 10) / 2)
    proficiency_bonus = div(player_level - 1, 4) + 2
    athletics = strength_modifier

    # Atualiza o changeset
    updated_params =
      params
      |> Map.put("player_level", Integer.to_string(player_level))
      |> Map.put("proficiency_bonus", Integer.to_string(proficiency_bonus))
      |> Map.put("passive_perception", Integer.to_string(passive_perception))
      |> Map.put("strength_modifier", Integer.to_string(strength_modifier))
      |> Map.put("intelligence_modifier", Integer.to_string(intelligence_modifier))
      |> Map.put("athletics", Integer.to_string(athletics))

    changeset =
      socket.assigns.character_sheet |> DedSheet.Game.change_character_sheet(updated_params)

    {:noreply, assign(socket, :form, to_form(changeset))}
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
end
