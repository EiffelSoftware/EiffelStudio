class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_left_button_down,
			on_left_button_up,
			on_mouse_move,
			on_menu_command,
			on_paint,
			closeable
		end

	WEL_STANDARD_COLORS
		export
			{NONE} all
		end

	WEL_OFN_CONSTANTS
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make the main window.
		do
			make_top ("My application")
			create dc.make (Current)
			set_pen_width (1)
			create lines.make
			set_menu (main_menu)
		end

feature -- Access

	dc: WEL_CLIENT_DC
			-- Device context associated to the current
			-- client window

	button_down: BOOLEAN
			-- Is the left mouse button down?

	pen: WEL_PEN
			-- Pen currently selected in `dc'

	line_thickness_dialog: LINE_THICKNESS_DIALOG
			-- Dialog box to change line thickness

	lines: LINES
			-- All lines drawn by the user

	current_line: LINE
			-- Line currently drawn by the user

	open_dialog: WEL_OPEN_FILE_DIALOG
			-- Standard dialog box to open a file

	save_dialog: WEL_SAVE_FILE_DIALOG
			-- Standard dialog box to save a file

feature -- Element change

	set_pen_width (new_width: INTEGER) is
			-- Set pen width with `new_width'.
		do
			create pen.make_solid (new_width, black)
		end

feature {NONE} -- Implementation

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
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

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Connect the points to make lines.
		do
			if button_down then
				dc.line_to (x_pos, y_pos)
				current_line.add (x_pos, y_pos)
			end
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Terminate the drawing process.
		do
			if button_down then
				button_down := False
				dc.release
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
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

	on_menu_command (menu_id: INTEGER) is
			-- `menu_id' has been selected.
		do
			inspect
				menu_id
			when Cmd_new then
				lines.wipe_out
				invalidate
			when Cmd_open then
				if open_dialog = Void then
					create open_dialog.make
					open_dialog.set_filter (<<"Draw file">>, <<"*.drw">>)
					open_dialog.set_default_extension ("drw")
					open_dialog.add_flag (Ofn_filemustexist)
				end
				open_dialog.activate (Current)
				if open_dialog.selected then
					lines ?= lines.retrieve_by_name (open_dialog.file_name)
					invalidate
				end
			when Cmd_save then
				if save_dialog = Void then
					create save_dialog.make
					save_dialog.set_filter (<<"Draw file">>, <<"*.drw">>)
					save_dialog.set_default_extension ("drw")
				end
				save_dialog.activate (Current)
				if save_dialog.selected then
					lines.store_by_name (save_dialog.file_name)
				end
			when Cmd_exit then
				if closeable then
					destroy
				end
			when Cmd_line_thickness then
				if line_thickness_dialog = Void then
					create line_thickness_dialog.make (Current)
				end
				line_thickness_dialog.activate
				if line_thickness_dialog.ok_pushed then
					set_pen_width (line_thickness_dialog.pen_width)
				end
			end
		end

	closeable: BOOLEAN is
			-- Does the user want to quit?
		local
			msg_box: WEL_MSG_BOX
		do
			create msg_box.make
			msg_box.question_message_box (Current, "Do you want to quit?",
				"Quit")
			Result := msg_box.message_box_result = Idyes
		end

	main_menu: WEL_MENU is
			-- Window's menu
		once
			create Result.make_by_id (Main_menu_id)
		end

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
