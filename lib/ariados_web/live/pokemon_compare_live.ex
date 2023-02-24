defmodule AriadosWeb.PokemonCompareLive do
  use AriadosWeb, :live_view

  def mount(_params, _session, socket) do
    {_, pkmn} = RareCandy.Api.find_pokemon("ariados")
    {:ok, assign(socket, name: pkmn.name, img: pkmn.img, error_message: "")}
  end

  def render(assigns) do
    ~H"""
    <center>Hey, that's <strong><%= @name |> String.capitalize() %>!</strong></center>

    <hr/>
    <hr/>
    <hr/>

    <div style="display: flex; flex-direction: row; align-items: flex-start;">
      <.form :let={f} for={:search_form} phx-submit="send_query" style="width: 100%; display: inline-flex; justify-content: center; flex-direction: row;">
        <.input field={{f, :new_query}} style="width: 50vw; margin-right: 5px;" />
        <.button style="background: #4a5069; margin-top: 8px; margin-bottom: 1px;">Search</.button>
      </.form>
    </div>

    <center>
      <img src={@img}>
    </center>

    <h2 style="color: #ff0000;"><%= @error_message %></h2>
    """
  end

  def handle_event("send_query", %{"search_form" => %{"new_query" => query}}, socket) do
    {s, pkmn} = RareCandy.Api.find_pokemon(query)
    case s do
      :ok ->
        {:noreply, assign(socket, name: pkmn.name, img: pkmn.img, error_message: "")}
      _ ->
        err = "An error has occurred -- Could not find #{query}!"
        {:noreply, assign(socket, name: "", img: "", error_message: err)}
    end
  end
end
