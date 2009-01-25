note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_left_button_down,
			on_right_button_down,
			closeable
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Make the main window.
		do
			make_top ("My application")
		end

feature {NONE} -- Implementation

	on_left_button_down (keys, x_pos, y_pos: INTEGER)
			-- Write `x_pos' and `y_pos' when the user presses
			-- the left mouse button.
		local
			position: STRING
			dc: WEL_CLIENT_DC
		do
			create dc.make (Current)
			position := "("
			position.append_integer (x_pos)
			position.append (", ")
			position.append_integer (y_pos)
			position.extend (')')
			dc.get
			dc.text_out (x_pos, y_pos, position)
			dc.release
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER)
			-- Invalidate window.
		do
			invalidate
		end

	closeable: BOOLEAN
			-- Does the user want to quit?
		local
			msg_box: WEL_MSG_BOX
		do
			create msg_box.make
			msg_box.question_message_box (Current, "Do you want to quit?",
				"Quit")
			Result := msg_box.message_box_result = Idyes
		end

note
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

