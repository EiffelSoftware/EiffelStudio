indexing
	description: "Ancestor to windows that draw figures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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

	make (a_mutex: like display_mutex) is
		require
			a_mutex_not_void: a_mutex /= Void
		do
			exit_mutex.lock
			display_mutex := a_mutex
			make_top (title)
			resize (200,200)
			create  client_window.make (Current, "Client Window")
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
	
	title: STRING is
			-- Title of the window.
		deferred
		end

feature -- Access

	client_window: CLIENT_WINDOW
		-- Shared client window on which thread draws.

	display_mutex: MUTEX
			-- Since display is a bottleneck on Windows, serialization
			-- of the drawing operations are done through this mutex.

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


end -- class DEMO_WIN

