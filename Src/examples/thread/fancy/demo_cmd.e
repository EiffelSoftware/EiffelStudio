deferred class
	DEMO_CMD

inherit
	WEL_STANDARD_COLORS
	THREAD

feature {NONE} -- Initialization

	make_in (p_window: PROXY[CLIENT_WINDOW]) is
		do
			proxy_window := p_window
			!! mutex_continue.make
			!! thread_continue
			thread_continue.set_item (True)
			!! proxy_continue.put (thread_continue)
		end

feature -- Threads

	mutex_continue: MUTEX
	proxy_window: PROXY[CLIENT_WINDOW]
	proxy_continue: PROXY[like thread_continue]
	thread_continue: BOOLEAN_REF
			-- If `True' the thread continues.


feature -- Threads

	execute is
			-- Draw rectangles, until window closed.
		do
			from
			until 
				is_thread_continue
			loop
				draw (proxy_window.item)
			end
		end

	is_thread_continue: BOOLEAN is
			-- Is the thread can continue.
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
			!! Result.make
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

