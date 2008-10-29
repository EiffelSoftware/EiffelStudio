indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class WEL_SOCKET_POLLER

inherit
	SOCKET_POLLER
		rename
			make as poller_make,
			make_active as poller_make_active
		end

	WEL_WM_CONSTANTS

	WEL_COMMAND

create
	make, make_active

feature -- Initialisation

	make (a_window: WEL_WINDOW; a_timer_id: INTEGER) is
			-- Create WEL_TIMER and socket_poller.
		require
			not_window_void: a_window /= Void
		do
			poller_make
			parent_window := a_window
			timer_id := a_timer_id
			parent_window.enable_commands
			parent_window.put_command (Current, Wm_timer, Void)
		ensure
			window: parent_window = a_window
			id: timer_id = a_timer_id			
		end
		
	make_active (a_window: WEL_WINDOW; a_timer_id: INTEGER; a_delay: INTEGER) is
			-- Enable timer and create active socket_poller.
		require
			not_window_void: a_window /= Void
		do
			poller_make_active (a_delay)
			parent_window := a_window
			timer_id := a_timer_id
			parent_window.enable_commands
			parent_window.put_command (Current, Wm_timer, Void)
		ensure
			window: parent_window = a_window
			id: timer_id = a_timer_id
			poller_active: is_poller_active
		end
		
feature -- Execute

	execute (arg: ANY) is
			-- Poll the socket.
		do
			poll
		end

feature -- Activation

	set_active (a_delay: INTEGER) is
            -- Set `a_poll_delay' to `delay_time'.
		do
			parent_window.set_timer (timer_id, a_delay)
			is_poller_active := True
		end 
		
	set_inactive is
            -- Stop polling the socket.
		do
			is_poller_active := False
			parent_window.kill_timer (timer_id)
		end
	
	is_poller_active: BOOLEAN
            -- Is the poller active?

feature {NONE}

	parent_window: WEL_WINDOW
		-- Window where timer is defined

	timer_id: INTEGER;
		-- From timer of parent_window

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




end -- class WEL_SOCKET_POLLER

