deferred class
	DEMO_CMD

inherit
	WEL_STANDARD_COLORS
	THREAD
	MEMORY

feature {NONE} -- Initialization

	make_in (ptr: POINTER) is
		do
			ptr_window := ptr
			create mutex_continue.make
			create thread_continue
			thread_continue.set_item (True)
			create proxy_continue.put (thread_continue)
		end

feature -- Threads
	ptr_window: POINTER
			-- Pointer to the shared client window, on
			-- which the thread draws.
	mutex_continue: MUTEX
			-- Protection lock for `proxy_continue'.
	client_window: CLIENT_WINDOW
			-- Client window rebuilt from `ptr_window'.
	proxy_continue: PROXY[like thread_continue]
			-- Proxy to `thread_continue'.
	thread_continue: BOOLEAN_REF
			-- Flag, which indicates if the thread must continue.
			
feature -- Threads

	execute is
			-- Draw rectangles, until window closed.
		do
				-- Rebuilt the shared client window from C.
			create client_window.make_by_pointer (ptr_window)
			from
			until 
				is_thread_continue
			loop
				draw (client_window)
			end
		end

	is_thread_continue: BOOLEAN is
			-- Must the thread continue?
		do
			mutex_continue.lock
			Result := proxy_continue.item.item = False
			mutex_continue.unlock
		end

	stop is
			-- Tell the thread to stop.
		do
			mutex_continue.lock
			proxy_continue.item.set_item (False)
			mutex_continue.unlock
		end

feature -- Basic operations

	draw (t_parent: CLIENT_WINDOW) is 
			-- Routine executed by new thread.
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

end -- class DEMO_CMD


--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

