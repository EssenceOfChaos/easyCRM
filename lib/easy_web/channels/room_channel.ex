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

  def join("room:" <> room_id, _params, socket) do
    {:ok, %{channel: "room:#{room_id}"}, assign(socket, :room_id, room_id)}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def handle_in("message:add", %{"message" => content}, socket) do
    room_id = socket.assigns[:room_id]
    broadcast!(socket, "room:#{room_id}:new_message", %{content: content})
    {:reply, :ok, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))

    {:ok, _} =
      Presence.track(socket, socket.assigns.current_user_id, %{
        id: socket.assigns.current_user_id,
        online_at: :os.system_time(:seconds)
      })

    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end
end
