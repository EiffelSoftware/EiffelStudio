deferred class
	DEMO_WIN

inherit
	WEL_FRAME_WINDOW
		redefine	
			on_wm_destroy,
			on_wm_close,
			closeable,
			class_background,
			on_size
		end
	
	WEL_SIZE_CONSTANTS
	
	THREAD_CONTROL

feature {NONE} -- Initialization

	make is
		do
			make_top ("Ovals")
			resize (200,200)
			initialize
			launch_demo
			resize (200,200)
			show
		end

	initialize is
		do
			!! client_window.make (Current, "Client Window")
			!! px_window.put (client_window)
		end

	client_window: CLIENT_WINDOW

	launch_demo is
		deferred
		end

	fig_demo_cmd: DEMO_CMD is
		deferred
		end
	

feature -- threads

	px_window: PROXY [like client_window]

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

feature -- Redefine features

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

	on_wm_destroy is
			-- Wm_destroy message.
			-- Quit the application if `Current' is the
			-- application's main window.
		do
			on_destroy
			exists := False
			unregister_window (Current)
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
			!! Result.make
		end

	closeable: BOOLEAN is
			-- Show the standard dialog box
		do
			stop_demo
			join_demo
			Result := True
		end


end -- class DEMO_WIN

