indexing
	description: "Abstract class for commands that draws figures in a window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	DEMO_CMD

inherit
	WEL_STANDARD_COLORS
	THREAD

feature {NONE} -- Initialization

	make_in (a_client: like client_window; a_mutex: like display_mutex) is
		require
			a_client_not_void: a_client /= Void
			a_mutex_not_void: a_mutex /= Void
		do
			client_window := a_client
			display_mutex := a_mutex
			create mutex_continue
			create thread_continue
			thread_continue.set_item (True)
		ensure
			client_window_set: client_window = a_client
			display_mutex_set: display_mutex = a_mutex
		end

feature -- Threads

	display_mutex: MUTEX
			-- Since display is a bottleneck on Windows, serialization
			-- of the drawing operations are done through this mutex.

	mutex_continue: MUTEX
			-- Protection lock for `thread_continue'.

	client_window: CLIENT_WINDOW
			-- Client window rebuilt from `ptr_window'.

	thread_continue: BOOLEAN_REF
			-- Flag, which indicates if the thread must continue.
			
feature -- Threads

	execute is
			-- Draw rectangles, until window closed.
		local
			l_msg: WEL_MSG
		do
				-- Rebuilt the shared client window from C.
			from
				create l_msg.make
			until 
				not is_thread_continue
			loop
				display_mutex.lock
				draw (client_window)
				display_mutex.unlock
			end
		end

	is_thread_continue: BOOLEAN is
			-- Must the thread continue?
		do
			mutex_continue.lock
			Result := thread_continue.item
			mutex_continue.unlock
		end

	stop is
			-- Tell the thread to stop.
		do
			mutex_continue.lock
			thread_continue.set_item (False)
			mutex_continue.unlock
		end

feature -- Basic operations

	draw (t_parent: CLIENT_WINDOW) is 
			-- Routine executed by new thread.
		require
			t_parent_not_void: t_parent /= Void
		deferred
		end

feature {NONE} -- Implementation

	std_colors: ARRAY [WEL_COLOR_REF] is
		once
			Result := <<
				grey,
				blue,
				cyan,
				green,
				yellow,
				red,
				magenta,
				white,
				black,
				dark_grey,
				dark_blue,
				dark_cyan,
				dark_green,
				dark_yellow,
				dark_red,
				dark_magenta>>
		ensure
			result_not_void: Result /= Void
		end

	random: RANDOM is
			-- Initialize a randon number
		once
			create Result.make
			random.start
		ensure
			result_not_void : Result /= Void
		end

	next_number (range: INTEGER): INTEGER is
			-- Random number between 1 and `range'
			--| Side effect function.
		do
			random.forth
			if range <= 0 then
				Result := 10
			else
				Result := random.item \\ range + 1
			end
		ensure
			valid_result_inf: Result > 0
		end

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


end -- class DEMO_CMD

