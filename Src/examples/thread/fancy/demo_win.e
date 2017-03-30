note
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

	make (a_mutex: like display_mutex)
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

	launch_demo
		deferred
		end

	fig_demo_cmd: detachable DEMO_CMD
		deferred
		end

	title: STRING
			-- Title of the window.
		deferred
		end

feature -- Access

	client_window: detachable CLIENT_WINDOW
		-- Shared client window on which thread draws.

	display_mutex: MUTEX
			-- Since display is a bottleneck on Windows, serialization
			-- of the drawing operations are done through this mutex.

feature -- Threads

    stop_demo
			-- Tell the thread to stop.
		do
			if attached fig_demo_cmd as cmd then
				cmd.stop
			end
		end

    join_demo
			-- Wait for the end of the thread
		do
			if attached fig_demo_cmd as cmd then
				cmd.join
			end
		end

feature -- Redefined features

	on_size (a_size_type, a_width, a_height: INTEGER)
			-- Reposition windows in the main window.
		do
			if
				a_size_type /= Size_minimized and then
				attached client_window as win
			then
				win.move_and_resize (2, 2, a_width - 5, a_height -4, True)
			end
		end

	on_wm_close
			-- Wm_close message.
			-- If `closeable' is False further processing is halted.
		do
			set_default_processing (closeable)
		end

	class_background: WEL_LIGHT_GRAY_BRUSH
			-- Standard window background color
		once
			create  Result.make
		end

	closeable: BOOLEAN
			-- Stop and join the thread, then return true.
		do
			exit_mutex.lock
			stop_demo
			join_demo
			demos_list.prune_all (Current)
			exit_mutex.unlock
			Result := True
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
