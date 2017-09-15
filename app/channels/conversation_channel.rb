class ConversationChannel < ApplicationCable::Channel
  # adds users to channels (only those users who should see notification will see it)
  def subscribed
    # stream_from "some_channel"
    #create unique channel for each user
    stream_from "conversations-#{current_user.id}"
  end

  # removes users from channels
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  # creates a record and later renders a part of view
  # can do whatever we wish
  def speak(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end

    Message.create(message_params)
    # ActionCable.server.broadcast(
    #   "conversations-#{current_user.id}",
    #   message: message_params
    # )
  end
end