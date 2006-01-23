indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class VISION_SOCKET_POLLER

inherit
	SOCKET_POLLER
		rename
			make as poller_make
		end -- inherit SOCKET_POLLER

	COMMAND

create
	make, make_active

feature -- Initialization

	make is
			-- Create timer and socket_poller.
		do
			poller_make
			create timer.make
		end

feature -- Activation

	set_active (a_poll_delay: INTEGER) is
            -- Set `a_poll_delay' to `delay_time'.
		do
			timer.set_regular_call_back (a_poll_delay, Current, Void)
		end

	set_inactive is
			-- Stop polling the socket.
		do
			timer.set_no_call_back
		end

	is_poller_active: BOOLEAN is
			-- Is the poller active?
		do
			Result := timer.is_call_back_set
		end 

feature -- Execute

	execute (arg: ANY) is
			-- Poll the socket.
		do
			poll
		end

feature {NONE} -- Timer

	timer: TIMER;
		-- Timer to poll socket 'on time'

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class VISION_SOCKET_POLLER

