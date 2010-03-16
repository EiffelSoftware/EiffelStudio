note
	description: "Event loop"
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_LOOP

create
	make_with_base

feature {NONE} -- Initialization

	make_with_base (a_base: EVENT_BASE)
			-- Create a loop with `a_base'
		require
			a_base_not_void: a_base /= Void
			a_base_exist: a_base.exists
		do
			event_base := a_base
			create events.make (2)
		end

feature -- Access

	event_base: EVENT_BASE
			-- The base relates to the loop.

feature -- Status report

	is_empty: BOOLEAN
			-- Has event added to the loop?
		do
			Result := events.is_empty
		end

	has_event (a_event: EVENT): BOOLEAN
			-- Does current loop have `a_event'?
		do
			Result := events.has (a_event)
		end

	called_exist: BOOLEAN
			-- Called `exit'?
			-- This function will return true for an event_base at every point after
			-- `exit' is called, until the event loop is next entered.
		do
			Result := {EVENT_EXTERNALS}.event_base_got_exit (event_base.item) /= 0
		end

	called_break: BOOLEAN
			-- Called `break'?
			-- This function will return true for an event_base at every point after
			-- `break' is called, until the event loop is next entere
		do
			Result := {EVENT_EXTERNALS}.event_base_got_break (event_base.item) /= 0
		end

feature -- Operation

	dispatch
			-- Dispatch events
		require
			base_is_ready: event_base.exists
			has_event: not is_empty
		local
			l_res: INTEGER
		do
			l_res := {EVENT_EXTERNALS}.event_base_dispatch (event_base.item)
		end

	start_loop (a_non_block: BOOLEAN; a_once: BOOLEAN)
			-- Start the loop.
			--
			-- `a_non_block', block the thread? libevent: EVLOOP_NONBLOCK
			-- `a_once', loop once? libevent: EVLOOP_ONCE
		require
			base_is_ready: event_base.exists
			has_event: not is_empty
		local
			l_flags: INTEGER
		do
			if a_non_block then
				l_flags := {EVENT_EXTERNALS}.EVLOOP_NONBLOCK
			end
			if a_once then
				l_flags := l_flags | {EVENT_EXTERNALS}.EVLOOP_ONCE
			end
			{EVENT_EXTERNALS}.event_base_loop (event_base.item, l_flags)
		end

	break
			-- Break the loop, typically invoked from this event's callback.
		do
			{EVENT_EXTERNALS}.event_base_loopbreak (event_base.item)
		end

	exit (a_time: EVENT_TIME)
			-- Exit the loop.
		require
			a_time_not_void: a_time /= Void
		local
			l_res: INTEGER
		do
			l_res := {EVENT_EXTERNALS}.event_base_loopexit (event_base.item, a_time.item)
		end

feature -- Element Change

	add_event (a_event: EVENT; a_time: EVENT_TIME)
			-- Add event to the loop.
		require
			a_event_not_void: a_event /= Void
			base_is_ready: event_base.exists
			a_event_exist: a_event.exists
			a_time_not_void: a_time /= Void
		do
			events.extend (a_event)
			a_event.prepare_event (event_base, a_time)
		end

	remove_event (a_event: EVENT)
			-- Remove `a_event' from the loop
		require
			a_event_not_void: a_event /= Void
		local
			l_events: like events
		do
			l_events := events
			l_events.start
			l_events.search (a_event)
			if not l_events.exhausted then
				a_event.delete
				l_events.remove
			end
		end

feature {NONE} -- Implementation

	events: ARRAYED_LIST [detachable EVENT]
			-- List of events
			-- Otherwise EVENT object will be freed without Eiffel references.

end
