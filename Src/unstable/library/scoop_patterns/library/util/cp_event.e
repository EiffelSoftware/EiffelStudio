note
	description: "An event source where clients can subscribe and unsubscribe actions."
	authors: "Volkan Arslan, Alexey Kolesnichenko, Andrey Rusakov, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	origin: "Class initially copied from https://github.com/xwat/tcl-eiffel and adapted to scoop_patterns library."


class
	CP_EVENT [D -> detachable TUPLE]

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current' with an empty list.
		do
			create actions.make
			actions.compare_objects
		end

feature -- Status report

	is_subscribed (action: separate PROCEDURE [D]): BOOLEAN
			-- Is `action' subscribed?
		do
			Result := actions.has (action)
		end

feature -- Subscription

	subscribe (an_action: separate PROCEDURE [D])
			-- Add `an_action' to the subscription list.
		require
			not_subscribed: not is_subscribed (an_action)
		do
			actions.extend (an_action)
		ensure
			correct_count:actions.count = old actions.count + 1
			subscribed: is_subscribed (an_action)
			index_at_same_position: actions.index = old actions.index
		end

	unsubscribe (an_action: separate PROCEDURE [D])
			-- Remove `an_action' from the subscription list.
		require
			subscribed: is_subscribed (an_action)
		do
			actions.prune (an_action)
		ensure
			correct_count: actions.count = old actions.count - 1
			not_subscribed: not is_subscribed (an_action)
		end

	unsubscribe_all
			-- Clear subscription list.
		do
			actions.wipe_out
		ensure
			empty: actions.is_empty
		end

feature -- Publication

	publish (arguments: D)
			-- Publish an event and notify all subscribers.
			-- Note: If `arguments' is attached, lock passing will happen.
		do
			actions.do_all (agent call_async (?, arguments))
		end

feature {NONE} -- Implementation

	actions: LINKED_LIST [separate PROCEDURE [D]]
			-- List of subscribed actions.

	call_async (an_action: separate PROCEDURE [D]; data: D)
			-- Wrapper for calling `an_action' separately.
		do
			an_action.call (data)
		end

invariant
	is_object_comparison: actions.object_comparison
end
