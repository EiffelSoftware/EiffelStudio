note
	description: "Processor-local proxy to a {separate CP_EVENT} object."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_EVENT_PROXY [D -> detachable TUPLE]

inherit
	CP_PROXY [CP_EVENT [D], CP_EVENT_UTILS [D]]

create
	make

feature -- Status report

	is_subscribed (action: separate PROCEDURE [D]): BOOLEAN
			-- Is `action' subscribed?
		do
			Result := utils.is_event_subscribed (subject, action)
		end

feature -- Subscription

	subscribe (action: separate PROCEDURE [D])
			-- Subscribe with `action'.
			-- Blocks if already subscribed.
		do
			utils.event_subscribe (subject, action)
		end

	unsubscribe (action: separate PROCEDURE [D])
			-- Remove subscription  of `action'.
			-- Blocks if not yet subscribed.
		do
			utils.event_unsubscribe (subject, action)
		end

	unsubscribe_all
			-- Clear subscription list.
		do
			utils.event_unsubscribe_all (subject)
		end

feature -- Publication

	publish (arguments: D)
			-- Publish an event and notify all subscribers.
			-- Note: If `arguments' is attached, lock passing will happen.
		do
			utils.event_publish (subject, arguments)
		end

end
