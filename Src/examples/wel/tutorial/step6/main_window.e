note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_paint,
			closeable
		end

	WEL_STANDARD_COLORS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Make the main window.
		do
			create dc.make (create {WEL_FRAME_WINDOW}.make_top ("Dummy"))
			set_pen_width (1)
			create lines.make
			create current_line.make

			make_top ("My application")
			create dc.make (Current)
		end

feature -- Access

	dc: WEL_CLIENT_DC
			-- Device context associated to the current
			-- client window

	button_down: BOOLEAN
			-- Is the left mouse button down?

	pen: WEL_PEN
			-- Pen currently selected in `dc'

	line_thickness_dialog: ?LINE_THICKNESS_DIALOG
			-- Dialog box to change line thickness

	lines: LINKED_LIST [LINE]
			-- All lines drawn by the user

	current_line: LINE
			-- Line currently drawn by the user

feature -- Element change

	set_pen_width (new_width: INTEGER)
			-- Set pen width with `new_width'.
		do
			create pen.make_solid (new_width, black)
		end

feature {NONE} -- Implementation

	on_left_button_down (keys, x_pos, y_pos: INTEGER)
			-- Initiate the drawing process.
		do
			if not button_down then
				button_down := True
				dc.get
				dc.move_to (x_pos, y_pos)
				dc.select_pen (pen)
				create current_line.make
				current_line.set_width (pen.width)
				lines.extend (current_line)
				current_line.add (x_pos, y_pos)
			end
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER)
			-- Connect the points to make lines.
		do
			if button_down then
				dc.line_to (x_pos, y_pos)
				current_line.add (x_pos, y_pos)
			end
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER)
			-- Terminate the drawing process.
		do
			if button_down then
				button_down := False
				dc.release
			end
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER)
			-- Bring up `line_thickness_dialog' and set the
			-- new pen width.
		local
			l_dialog: like line_thickness_dialog
		do
			l_dialog := line_thickness_dialog
			if l_dialog = Void then
				create l_dialog.make (Current)
				line_thickness_dialog := l_dialog
			end
			l_dialog.activate
			if l_dialog.ok_pushed then
				set_pen_width (l_dialog.pen_width)
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Paint the lines.
		local
			a_line: LINE
			a_pen: WEL_PEN
			first_point: BOOLEAN
		do
			from
				lines.start
			until
				lines.off
			loop
				from
					first_point := True
					a_line := lines.item
					a_line.start
					create a_pen.make_solid (a_line.width, black)
					paint_dc.select_pen (a_pen)
				until
					a_line.off
				loop
					if first_point then
						first_point := False
						paint_dc.move_to (a_line.item.x,
							a_line.item.y)
					else
						paint_dc.line_to (a_line.item.x,
							a_line.item.y)
					end
					a_line.forth
				end
				lines.forth
			end
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

