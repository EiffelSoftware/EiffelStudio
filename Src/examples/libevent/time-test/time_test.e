note
	description : "event-test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TIME_TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_event_base: EVENT_BASE
			l_loop: EVENT_LOOP
			l_event: EVENT
		do
			create l_event_base.make
			create l_event.make (-1, {EVENT}.ev_timeout | {EVENT}.ev_persist)
			l_event.actions.extend (agent file_handler)

			create l_loop.make_with_base (l_event_base)
			l_loop.add_event (l_event, create {EVENT_TIME}.make (1, 0))
			l_loop.dispatch
		end

	file_handler (a_type: INTEGER; a_event: EVENT)
			-- Handler to file event.
		do
			times := times + 1
			print ("Timer: " + times.out + "%N")
		end

	times: INTEGER

end
