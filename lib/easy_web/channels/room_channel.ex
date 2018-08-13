defmodule EasyWeb.RoomChannel do
  @moduledoc """
  Defines the Room Channel
  """
  use Phoenix.Channel
  alias EasyWeb.Presence

  def join("room:lobby", _message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))

    {:ok, _} =
      Presence.track(socket, socket.assigns.current_user.id, %{
        username: socket.assigns.current_user.name,
        online_at: :os.system_time(:seconds)
      })

    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end
end
