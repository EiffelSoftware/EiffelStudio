indexing
	description: 
		"MAIN_WINDOW class of the hello world example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MAIN_WINDOW

inherit
	EV_WINDOW
		redefine	
			make_top_level
		end

	ARGUMENTS

	EV_BASIC_COLORS

create
	make_top_level

feature --Access

	main_box: EV_VERTICAL_BOX
	rich_window: RICH_WINDOW
			-- Push buttons
	tool_box: EV_HORIZONTAL_BOX
	save_button: EV_BUTTON
	toggle_highlight_button: EV_BUTTON
	toggle_basic_auto_intending_button: EV_BUTTON
	test_button: EV_BUTTON

	draw_box: EV_DRAWING_AREA
	
feature -- Initialization

	test_draw is
		do
			create draw_box.make (main_box)
			draw_box.set_minimum_size (250,150)
			draw_box.set_background_color (red)
	
		end	

	make_top_level is
			-- Creation of the window.
		do
--			print ("%N")
			Precursor {EV_WINDOW}
			--maximize
			create main_box.make (Current)
			create tool_box.make (main_box)

			create save_button.make_with_text (tool_box, "Save")
			create toggle_highlight_button.make_with_text (tool_box, "Toggle Highlight")
			create toggle_basic_auto_intending_button.make_with_text (tool_box, "Basic auto intending")
			create test_button.make_with_text (tool_box, "test")

			main_box.set_child_expandable (tool_box, False)

			create rich_window.make (main_box)
--			test_draw

			rich_window.enable_syntax_highlighting
			if
				argument_count >= 1
			then
				load_file (argument (1))
				rich_window.set_position (get_pos)
				rich_window.set_focus
			end
			add_my_commands
		end

feature -- Status setting

feature {NONE} -- Implementation

	add_my_commands is
		local
			cmd: EV_COMMAND
			accelerator: EV_ACCELERATOR
		do
			create accelerator.make (rich_window.Key_s, False, False, True)
--			create {EV_ROUTINE_COMMAND} cmd.make (~on_save)
			--add_accelerator_command (accelerator, cmd, Void)

			create {EV_ROUTINE_COMMAND} cmd.make (agent on_save)
			save_button.add_click_command (cmd, Void)

			create {EV_ROUTINE_COMMAND} cmd.make (agent on_toggle_highlight)
			toggle_highlight_button.add_click_command (cmd, Void)

			create {EV_ROUTINE_COMMAND} cmd.make (agent on_basic_auto_intending)
			toggle_basic_auto_intending_button.add_click_command (cmd, Void)

			create {EV_ROUTINE_COMMAND} cmd.make (agent on_test)
			test_button.add_click_command (cmd, Void)
			
--			create {EV_ROUTINE_COMMAND} cmd.make (~on_draw_box)
--			draw_box.add_paint_command (cmd, Void)

		end

	get_pos: INTEGER is
		do
			if
				argument_count >= 2 and then argument (2).is_integer
			then
				Result := rich_window.first_cursor_position_from_line_number (argument (2).to_integer)
			else
				Result := 1
			end
		end


	on_save (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make_create_read_write (file_name)
			file.put_string (rich_window.text)
			file.close
		end

	on_toggle_highlight (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			if
				rich_window.syntax_highlighting_enabled
			then
				rich_window.disable_syntax_highlighting
			else
				rich_window.enable_syntax_highlighting
			end
		end

	on_basic_auto_intending (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			if
				rich_window.basic_auto_intending_enabled
			then
				rich_window.disable_basic_auto_intending
			else
				rich_window.enable_basic_auto_intending
			end
		end

	on_test (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			t: STRING
			ln, ln2: STRING
		do
			debug		
				t:= rich_window.text
				ln := rich_window.line (rich_window.current_line_number)
				ln2 := rich_window.text.substring (rich_window.first_character_position_from_line_number (rich_window.current_line_number),
					rich_window.last_character_position_from_line_number (rich_window.current_line_number))
				print (t)
				print ("tot txt size%N")
				print (rich_window.text_length)
				print ("%Ntot line:")
				print (rich_window.line_count)
				print ("%Ncur pos:")
				print (rich_window.position.out)
				print ("%Ncur line:")
				print (rich_window.current_line_number)
				print ("%Nfirst pos:")
				print (rich_window.first_cursor_position_from_line_number (rich_window.current_line_number))
				print ("%Nlast pos:")
				print (rich_window.last_cursor_position_from_line_number (rich_window.current_line_number))
				print ("%N")
			end

			rich_window.select_region (3, 5)

		end
		
	on_draw_box (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			pt: EV_COORDINATES
		do
			draw_box.clear
			create pt.set (10,10)
			draw_box.draw_text (pt, "muhahahahha")
			create pt.set (6,6)
			draw_box.draw_rectangle (pt, draw_box.width - 10, draw_box.height - 10, 0)
		end
			
	file_name: STRING
	
	load_file (new_file_name: STRING) is
		local
			file: PLAIN_TEXT_FILE
			buffer : STRING
		do
			create file.make_open_read (new_file_name)
			set_title (new_file_name)
			file.read_stream (file.count)
			buffer := file.last_string
			remove_carrige_return_from_string (buffer)
			rich_window.set_text (buffer)
			rich_window.update_highlighting_all
			--rich_window.format_all
			file_name := clone (new_file_name)
			file.close
		end

	remove_carrige_return_from_string (s: STRING) is
			-- Remove all '%R' characters from `s'.
		do
			s.prune_all ('%R')
		ensure
			no_carrige_return_in_s: not s.has ('%R')
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

