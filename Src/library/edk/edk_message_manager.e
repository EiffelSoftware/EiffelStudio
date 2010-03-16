note
	description: "Summary description for {EDK_EVENT_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDK_MESSAGE_MANAGER

feature -- Access

	type_manager: EDK_TYPE_MANAGER
		deferred
		end

	display: EDK_DISPLAY
		deferred
		end

feature -- Message Handling

	get_message_from_queue (a_message: EDK_MESSAGE)
			-- Update `a_message' with the next EDK message in the queue.
		deferred
		ensure
			a_message_not_native: not a_message.native
		end

	process_message_from_queue (a_message: EDK_MESSAGE)
			-- Process message `a_message'.
		require
			a_message_not_native: not a_message.native
		deferred
		end

	put_message_on_queue (a_message: EDK_MESSAGE)
			-- Put EDK message to the message queue
		deferred
		end

	wait_for_next_message (a_max_millisecond_wait: NATURAL)
			-- Wait for a maximum `a_max_millisecond_wait' for the next native message.
			-- CPU time of calling thread will be relinquished.
		deferred
		end

	application_time: NATURAL_32
			-- Time in Milliseconds since the application began.
			-- Used for inserting in to events that don't have a native time set.
		deferred
		end

end
