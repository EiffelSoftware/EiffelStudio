indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_background,
			on_control_command,
			on_left_button_down
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Make the main window and a button
		do
			make_top ("WEL xy")
			create clear_button.make (Current, "Clear",
				1, 1, 70, 40, 1)
		end

feature {NONE} -- Behaviors

	on_control_command (control: WEL_CONTROL) is
			-- Clear the window
		do
			if control = clear_button then
				invalidate
			end
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Write `x_pos' and `y_pos'
		local
			dc: WEL_CLIENT_DC
			position: STRING
		do
			create position.make (20)
			position.extend ('(')
			position.append_integer (x_pos)
			position.append (", ")
			position.append_integer (y_pos)
			position.extend (')')
			create dc.make (Current)
			dc.get
			dc.text_out (x_pos, y_pos, position)
			dc.release
		end

feature {NONE} -- Implementation

	clear_button: WEL_PUSH_BUTTON
			-- Clear button

	class_background: WEL_WHITE_BRUSH is
			-- White background
		once
			create Result.make
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


end -- class MAIN_WINDOW

