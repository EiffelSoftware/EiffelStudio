note
	description : "event-test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	EVENT_TEST

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
			l_file: EVENT_UNBLOCK_NAMED_PIPE
		do
			create l_file.make ("my_pipe")
			l_file.create_read

			create l_event_base.make
			create l_event.make (l_file.read_descriptor, {EVENT}.ev_read)
			l_event.actions.extend (agent file_handler)

			create l_loop.make_with_base (l_event_base)
			l_loop.add_event (l_event, create {EVENT_TIME}.make_infinite)
			l_loop.dispatch

			l_file.close
		end

	file_handler (a_type: INTEGER; a_event: EVENT)
			-- Handler to file event.
		do
			print ("Event received.%N")
		end

	make_file: INTEGER
		external
			"C inline use <stdio.h>"
		alias
			"[
				FILE *fp;
				fp=fopen("test", "w+");
				int fd = fileno (fp);
				return fd
			]"
		end

end
