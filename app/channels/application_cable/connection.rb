module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # each user should have their own separate client-server connection
    identified_by :current_user

    # called after a connection
    # assigns to the current_user variable an instance of a logged user
    def connect
      self.current_user = find_verified_user
    end

    protected
      # devise uses warden - assigns to env warden variable all info about the session and authentication
      def find_verified_user
        if (current_user = env['warden'].user)
          current_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
