class
	CLIENT_WINDOW

inherit
	WEL_CONTROL_WINDOW
		rename
			make as old_make,
			move_and_resize as old_move_and_resize
		redefine
			on_wm_close,
			class_background,
			class_name,
			default_ex_style
		end

create
	make, make_by_pointer

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

	on_wm_close is
			-- Wm_close message.
			-- If `closeable' is False further processing is halted.
		do
			set_default_processing (closeable)
		end

	class_background: WEL_GRAY_BRUSH is
			-- Standard window background color
		once
			create Result.make
		end

feature {NONE} -- Implementation

	default_ex_style: INTEGER is 768
			-- Style of Client Window.

	class_name: STRING is
		once
			Result := "Client Window"
		end

end -- class CLIENT_WINDOW

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

