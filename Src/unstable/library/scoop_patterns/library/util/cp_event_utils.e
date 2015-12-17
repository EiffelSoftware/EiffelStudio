note
	description: "Utility functions to access a separate CP_EVENT."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_EVENT_UTILS [D -> detachable TUPLE]

feature -- Status report

	is_event_subscribed (an_event: separate CP_EVENT [D]; action: separate PROCEDURE [D]): BOOLEAN
			-- Is `action' subscribed?
		do
			Result := an_event.is_subscribed (action)
		end

feature -- Subscription

	event_subscribe (an_event: separate CP_EVENT [D]; action: separate PROCEDURE [D])
			-- Subscribe to `an_event' with `action'.
		require
			not_subscribed: not an_event.is_subscribed (action)
		do
			an_event.subscribe (action)
		end

	event_unsubscribe (an_event: separate CP_EVENT [D]; action: separate PROCEDURE [D])
			-- Remove subscription  of `action' from `an_event'.
		require
			subscribed: an_event.is_subscribed (action)
		do
			an_event.unsubscribe (action)
		end

	event_unsubscribe_all (an_event: separate CP_EVENT [D])
			-- Remove all subscribers in `an_event'.
		do
			an_event.unsubscribe_all
		end

feature -- Publication

	event_publish (an_event: separate CP_EVENT [D]; arguments: D)
			-- Publish an event and notify all subscribers.
			-- Note: If `arguments' is attached, lock passing will happen.
		do
			an_event.publish (arguments)
		end


end
