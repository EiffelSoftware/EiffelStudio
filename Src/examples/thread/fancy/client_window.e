class
	CLIENT_WINDOW

inherit
	WEL_CONTROL_WINDOW
		rename
			make as old_make,
			move_and_resize as old_move_and_resize
		redefine
			on_wm_destroy,
			on_wm_close,
			class_background,
			class_name,
			default_ex_style
		end

	OBJECT_CONTROL

creation
	make

feature -- Initialization

	make (win: WEL_COMPOSITE_WINDOW ; a_name: STRING) is
			-- Create client window with its two children, each with its own thread.
		do
			old_make (win, a_name)
		end



feature -- Behavior

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Handle window displacement and resizing.
		do
			old_move_and_resize (a_x, a_y, a_width, a_height, true)

				-- See if the threads were launched and send them
				-- a 'resize' message
		end

feature -- Redefine features

	on_wm_destroy is
			-- Wm_destroy message.
			-- Quit the application if `Current' is the
			-- application's main window.
		do
			on_destroy
			exists := False
			unregister_window (Current)
			--if application_main_window.is_application_main_window (Current) then
			--	cwin_post_quit_message (0)
			--end
		end

	on_wm_close is
			-- Wm_close message.
			-- If `closeable' is False further processing is halted.
		do
			set_default_processing (closeable)
		end

	class_background: WEL_GRAY_BRUSH is
--WEL_LIGHT_GRAY_BRUSH is
			-- Standard window background color
		once
			!! Result.make
		end

feature {NONE} -- Implementation

	default_ex_style: INTEGER is 768
			-- Style of Client Window.

	class_name: STRING is
		once
			Result := "Client Window"
		end

end -- class CLIENT_WINDOW
