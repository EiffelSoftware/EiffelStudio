indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	RICH_WINDOW

inherit
	DEMO_WINDOW

	EV_RICH_TEXT
		redefine
			make
		end

	EV_COMMAND
	WIDGET_COMMANDS
	TEXT_COMPONENT_COMMANDS
	

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			color: EV_COLOR
			cmd: EV_ROUTINE_COMMAND
		do
			{EV_RICH_TEXT} Precursor (Void)
			add_button_release_command (3, Current, Void)
			set_minimum_size (200, 200)
			set_text ("Hello,%N%NThis is a rich edit.%N%
			%You can choose the color, the font, the size...%
			%%Nof each word.%N%NHave a good day.%N")
			apply_format (make_format)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "rich edit")
			add_text_component_commands (Current, event_window, "Rich window")
			create cmd.make (~insert_text_command)
			add_insert_text_command (cmd, Void)
			create cmd.make (~delete_text_command)
			add_delete_text_command (cmd, Void)
			create cmd.make (~delete_right_character_command)
			add_delete_right_character_command (cmd, Void)
			create cmd.make (~undo_command)
			add_undo_command (cmd, Void)
			create cmd.make (~redo_command)
			add_redo_command (cmd, Void)
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			set_primitive_tabs
			tab_list.extend(text_component_tab)
			tab_list.extend(text_tab)
			tab_list.extend(rich_tab)
			create action_window.make (Current, tab_list)
		end

feature -- Access

	format: EV_CHARACTER_FORMAT
			-- A format for the text

feature -- Basic operation

	make_format: EV_TEXT_FORMAT is
			-- Create a text format.
		local
			s, e: ARRAYED_LIST [INTEGER]
			color: EV_COLOR
			font: EV_FONT
		do
			!! Result.make

			!! format.make
			!! color.make_rgb (0, 0, 255)
			format.set_color (color)
			set_character_format (format)
			Result.add_character_format_with_regions (format, <<1, 8, 86, 89, 93, 108>>)		

			!! format.make
			!! font.make_by_system_name ("tahoma,24,400,,default,dontcare,ansi,0,0,0,draft,stroke,default")
			format.set_font (font)
			!! color.make_rgb (255, 0, 0)
			format.set_color (color)
			format.set_italic (True)
			set_character_format (format)
			Result.add_character_format_with_regions (format, <<9, 84, 90, 90>>)
		end

feature -- Command execution

	
	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when the mouse button is released.
		local
			ft: EV_FONT
			colors: EV_BASIC_COLORS
		do
			format.set_bold (False)
			format.set_italic (False)
		--	!! ft.make_by_name ("Symbol")
			create ft.make_by_name ("Times New Roman")
			!! colors
			format.set_color (colors.black)
			format.set_font (ft)
			set_character_format (format)
		end
	
	insert_text_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			ev: EV_INSERT_TEXT_EVENT_DATA
			temp_string: STRING
		do
			ev ?= data
			event_window.display ("Insert text command in rich edit.")
			temp_string := "Text : "
			temp_string.append_string (ev.text)
			temp_string.append_string (" at position : ")
			temp_string.append_string (ev.position.out)
			event_window.displayi (temp_string)
		end

	delete_text_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When text is to be deleted then inform the user in `event_window'.
		do
			event_window.display ("Delete text command in rich edit.")
		end

	delete_right_character_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When the right charcter is to be deleted then inform the user
			-- in `event_window'.
		do
			event_window.display ("Delete right character command in rich edit.")
		end
	
	undo_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When an undo command is to be performed then inform the user
			-- in `event_window'.
		do
			event_window.display ("Undo command in rich edit.")
		end

	redo_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When a redo command is to be performed then inform the user
			-- in `event_window'
		do
			event_window.display ("Redo command in rich edit.")
		end

	

end -- class BUTTON_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

