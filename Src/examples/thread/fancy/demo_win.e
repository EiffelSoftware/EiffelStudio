deferred class
	DEMO_WIN

inherit
	WEL_FRAME_WINDOW
		redefine	
			on_wm_close,
			closeable,
			class_background,
			on_size
		end
	
	WEL_SIZE_CONSTANTS
	
	THREAD_CONTROL
	EXIT_CONTROL
	
feature {NONE} -- Initialization

	make is
		do
			exit_mutex.lock
			make_top ("Ovals")
			resize (200,200)
			create  client_window.make (Current, "Client Window")
			ptr_window := client_window.item
			launch_demo
			resize (200,200)
			show
			demos_list.extend (Current)
			exit_mutex.unlock
		end

feature	-- Deferred

	launch_demo is
		deferred
		end

	fig_demo_cmd: DEMO_CMD is
		deferred
		end
	

feature -- Access

	ptr_window: POINTER
		-- Pointer to shared C client window.
		-- With the Eiffel Threads, we can only share
		-- flat Eiffel objects, but we share the encapsulated
		-- C client window for the Windows library.

	client_window: CLIENT_WINDOW
		-- Shared client window on which thread draws.


feature -- Threads

    stop_demo is
			-- Tell the thread to stop.
		do
		    fig_demo_cmd.stop
		end

    join_demo is
			-- Wait for the end of the thread
		do
		     fig_demo_cmd.join
		end

feature -- Redefined features

	on_size (a_size_type, a_width, a_height: INTEGER) is
			-- Reposition windows in the main window.
		do
			if (a_size_type /= Size_minimized) then
				if client_window /= Void then
					client_window.move_and_resize (2, 2,
						a_width - 5, a_height -4, True)
				end
			end
		end

	on_wm_close is
			-- Wm_close message.
			-- If `closeable' is False further processing is halted.
		do
			set_default_processing (closeable)
		end

	class_background: WEL_LIGHT_GRAY_BRUSH is
			-- Standard window background color
		once
			create  Result.make
		end

	closeable: BOOLEAN is
			-- Stop and join the thread, then return true.
		do
			exit_mutex.lock
			stop_demo
			join_demo
			demos_list.prune_all (Current)
			exit_mutex.unlock
			Result := True
		end


end -- class DEMO_WIN


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

