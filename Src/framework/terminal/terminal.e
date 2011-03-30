note
	description: "[
		Augments the facilities of the standard input/output consoles ({CONSOLE}) with functions to
		manipulate the appearance and cursor of the terminal.
		
		The implementation is based on the ANSI/VT100 terminal command interface.
		
		Note: All input and output/error operations should be done using the existing EiffelBase APIs,
		      {TERMINAL} only provides methods to manipulate the terminal. Clients may use either the
		      standard output or the standard error output stream during creation. It is not necessary
		      to create an instance of both output and error streams unless they are directed to
		      different terminal windows.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TERMINAL

create
	make

feature {NONE} -- Initialization

	make (a_terminal: like terminal)
			-- Initializes a terminal using a medium.
			--
			-- `a_terminal' Terminal source (output or error output) to manipulate.
		require
			a_terminal_attached: attached a_terminal
			a_terminal_exists: a_terminal.exists
			a_terminal_is_open_write: a_terminal.is_open_write
		do
			terminal := a_terminal
		ensure
			a_terminal_set: terminal = a_terminal
		end

feature -- Access

	terminal: FILE
			-- Terminal to output manipulation command information to.

feature -- Access

	foreground_color: TERMINAL_COLOR assign set_foreground_color
			-- Terminal foreground (text) color.
		attribute
			create Result.make ({TERMINAL_COLOR}.none)
		end

	background_color: TERMINAL_COLOR assign set_background_color
			-- Terminal background color.
		attribute
			create Result.make ({TERMINAL_COLOR}.none)
		end

	text_style: TERMINAL_TEXT_STYLE assign set_text_style
			-- Style of terminal text.
		attribute
			create Result.make ({TERMINAL_TEXT_STYLE}.none)
		end

feature -- Element change

	set_foreground_color (a_color: like foreground_color)
			-- Sets foreground color index.
			--
			-- `a_color': Color index from the terminal color palette.
			--            Use either {TERMINAL_COLOR} or a custom value 0-255
		require
			is_writable: is_writable
		do
			foreground_color := a_color
			set_display
		ensure
			foreground_color_set: foreground_color = a_color
		end

	set_background_color (a_color: like background_color)
			-- Sets background color index.
			--
			-- `a_color': Color index from the terminal color palette.
			--            Use either {TERMINAL_COLOR} or a custom value 0-255
		require
			is_writable: is_writable
		do
			background_color := a_color
			set_display
		ensure
			background_color_set: background_color = a_color
		end

	set_text_style (a_style: like text_style)
			-- Sets terminal text style.
			--
			-- `a_style': A new text style. Styles may be combined.
		require
			is_writable: is_writable
		do
			text_style := a_style
			set_display
		ensure
			text_style_set: text_style = a_style
		end

feature -- Measurement

	rows: NATURAL
			-- Maximum number of rows supported by the terminal.
		do
			Result := c_rows (terminal.file_pointer)
		ensure
			result_positive: Result >= 0
		end

	columns: NATURAL
			-- Maximum number of columns supported by the terminal.
		do
			Result := c_columns (terminal.file_pointer)
		ensure
			result_positive: Result >= 0
		end

feature -- Status report

	is_readable: BOOLEAN
			-- Indicates if the terminal supports user input.
		do
			Result := terminal.is_open_read
		ensure
			terminal_is_open_read: terminal.is_open_read
		end

	is_writable: BOOLEAN
			-- Indicates if the terminal supports output.
		do
			Result := terminal.is_open_write
		ensure
			terminal_is_open_write: terminal.is_open_write
		end

feature -- Basic operations

	ring_bell
			-- Rings the terminal bell and produces and audio or visual response.
		require
			is_writable: is_writable
		do
			terminal.put_character ('%/007/')
		end

feature -- Basic operations: Display

	set_display
			-- Forces the display to reapply all display properties.
			-- Call to reapply any configured display properties, which may have been overwritten and not
			-- restored by other processes.
		require
			is_writable: is_writable
		do
				-- Reset the display
			put_command (display_reset_cmd)

				-- Update the colors
			update_color (foreground_color, False)
			update_color (background_color, True)

				-- Update the text style
			update_text_style (text_style)
		end

	reset_display
			-- Clears the display parameters and resets the terminal to its defaults.
		require
			is_writable: is_writable
		do
				-- Reset the display
			put_command (display_reset_cmd)

			create foreground_color
			create background_color
			create text_style
		ensure
			foreground_color_reset: foreground_color ~ (create {TERMINAL_COLOR})
			background_color_reset: background_color ~ (create {TERMINAL_COLOR})
			text_style_reset: text_style ~ (create {TERMINAL_TEXT_STYLE})
		end

feature -- Basic operations: Cursor Movement

	move_cursor_to (a_row: NATURAL; a_column: NATURAL)
			-- Moves a cursor to a specific position.
			-- Note: See `save_cursor' and `restore_cursor' for better control.
			--
			-- `a_row': Row to move the cursor to.
			-- `a_column': Column to move the cursor to.
		require
			is_writable: is_writable
			a_row_positive: a_row > 0
			a_row_small_enough: a_row <= rows
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= columns
		local
			l_command: STRING
		do
			create l_command.make (7)
			l_command.append_natural_32 (a_row)
			l_command.append_character (attribute_separator)
			l_command.append_natural_32 (a_column)
			l_command.append_character ('H')
			put_command (l_command)
		end

	move_cursor_up (a_count: NATURAL)
			-- Moves cursor up.
			-- Note: See `save_cursor' and `restore_cursor' for better control.
			--
			-- `a_count': Number of rows to move the cursor by.
		require
			is_writable: is_writable
			a_count_positive: a_count > 0
		local
			l_command: STRING
		do
			create l_command.make (4)
			l_command.append_natural_32 (a_count)
			l_command.append_character ('A')
			put_command (l_command)
		end

	move_cursor_down (a_count: NATURAL)
			-- Moves cursor down.
			-- Note: See `save_cursor' and `restore_cursor' for better control.
			--
			-- `a_count': Number of rows to move the cursor by.
		require
			is_writable: is_writable
			a_count_positive: a_count > 0
		local
			l_command: STRING
		do
			create l_command.make (4)
			l_command.append_natural_32 (a_count)
			l_command.append_character ('B')
			put_command (l_command)
		end

	move_cursor_forward (a_count: NATURAL)
			-- Moves cursor forward.
			-- Note: See `save_cursor' and `restore_cursor' for better control.
			--
			-- `a_count': Number of columns to move the cursor by.
		require
			is_writable: is_writable
			a_count_positive: a_count > 0
		local
			l_command: STRING
		do
			create l_command.make (4)
			l_command.append_natural_32 (a_count)
			l_command.append_character ('C')
			put_command (l_command)
		end

	move_cursor_backward (a_count: NATURAL)
			-- Moves cursor backward.
			-- Note: See `save_cursor' and `restore_cursor' for better control.
			--
			-- `a_count': Number of columns to move the cursor by.			
		require
			is_writable: is_writable
			a_count_positive: a_count > 0
		local
			l_command: STRING
		do
			create l_command.make (4)
			l_command.append_natural_32 (a_count)
			l_command.append_character ('D')
			put_command (l_command)
		end

	save_cursor (a_attributes: BOOLEAN)
			-- Saves the current cursor position.
			-- Note: Not all terminals support saving of attribute information.
			--
			-- `a_attributes': True to also save the attributes; False otherwise.
		require
			is_writable: is_writable
		do
			if a_attributes then
				put_short_command (save_cursor_and_attributes_cmd)
			else
				put_command (save_cursor_cmd)
			end
		end

	restore_cursor (a_attributes: BOOLEAN)
			-- Restores the last cursor position.
			-- Note: Not all terminals support saving of attribute information.
			--
			-- `a_attributes': True to also restore the attributes; False otherwise.
		require
			is_writable: is_writable
		do
			if a_attributes then
				put_short_command (restore_cursor_and_attributes_cmd)
			else
				put_command (restore_cursor_cmd)
			end
		end

feature -- Basic operations: Erasing

	clear
			-- Erases the screen with the background colour and moves the cursor to home.
		require
			is_writable: is_writable
		do
			put_command (erase_screen_cmd)

				-- Not all terminals move the cursor, this is to ensure they do.
			move_cursor_to (1, 1)
		end

	clear_to_bottom
			-- Erases the screen from the current line down to the bottom of the screen.
		require
			is_writable: is_writable
		do
			put_command (erase_down_cmd)
		end

	clear_to_top
			-- Erases the screen from the current line up to the top of the screen.
		require
			is_writable: is_writable
		do
			put_command (erase_up_cmd)
		end

	clear_line
			-- Erases the entire current line.
		require
			is_writable: is_writable
		do
			put_command (erase_line_cmd)
		end

	clear_to_end_of_line
			-- Erases from the current cursor position to the end of the current line.
		require
			is_writable: is_writable
		do
			put_command (erase_end_of_line_cmd)
		end

	clear_to_start_of_line
			-- Erases from the current cursor position to the start of the current line.
		require
			is_writable: is_writable
		do
			put_command (erase_start_of_line_cmd)
		end

feature {NONE} -- Basic operations: Display

	put_command (a_command: STRING)
			-- Writes a command to the terminal.
			--
			-- `a_command': Command to write to the terminal.
		require
			is_writable: is_writable
			a_comamnd_attached: attached a_command
			not_a_command_is_empty: not a_command.is_empty
		local
			l_term: like terminal
		do
			if not {PLATFORM}.is_windows then
				l_term := terminal
				l_term.put_character (command_character)
				l_term.put_character (qualifer_character)
				l_term.put_string (a_command)
			end
		end

	put_short_command (a_command: STRING)
			-- Writes a command to the terminal, using the shorter command style.
			--
			-- `a_command': Command to write to the terminal.
		require
			is_writable: is_writable
			a_comamnd_attached: attached a_command
			not_a_command_is_empty: not a_command.is_empty
		local
			l_command: STRING
		do
			if not {PLATFORM}.is_windows then
				create l_command.make (3)
				l_command.append_character (command_character)
				l_command.append (a_command)
				terminal.put_string (l_command)
			end
		end

	put_attribute_command (a_code: NATURAL_8)
			-- Writes a display attribute command to the terminal.
			--
			-- `a_code': Display attribute code.
		require
			is_writable: is_writable
		local
			l_command: STRING
		do
			create l_command.make (3)
			l_command.append_natural_8 (a_code)
			l_command.append_character ('m')
			put_command (l_command)
		end

	update_color (a_color: TERMINAL_COLOR; a_background: BOOLEAN)
			-- Updates the terminals color.
			--
			-- `a_color': The color to set on the terminal.
			-- `a_background': True if the color should be set of the background; False otherwise.
		require
			is_writable: is_writable
			a_color_attached: attached a_color
		local
			l_command: STRING
			l_code: INTEGER
			l_offset: NATURAL_8
		do
			l_code := a_color.color
			if l_code /= {TERMINAL_COLOR}.none then
				check l_code_non_negative: l_code >= 0 end

				if a_background then
					l_offset := 40
				else
					l_offset := 30
				end

				if a_background or else a_color.is_basic then
						-- Background colors should use regular colors because they have little effect
						-- on display, when using dimmed and bright colors.
					put_attribute_command (l_code.as_natural_8 + l_offset)
				else
					create l_command.make (4)
					if a_color.is_bright then
						l_command.append_integer (1)
					elseif a_color.is_dim then
						l_command.append_integer (2)
					else
						check False end
					end
					l_command.append_character (attribute_separator)
					l_command.append_integer (l_code + l_offset)
					l_command.append_character ('m')
					put_command (l_command)
				end
			end
		end

	update_text_style (a_style: TERMINAL_TEXT_STYLE)
			-- Updates the terminals text style.
			--
			-- `a_style': Text style to set on the terminal.
		require
			is_writable: is_writable
			a_style_attached: attached a_style
		local
			l_style: NATURAL_8
		do
			l_style := a_style.item
			if (l_style & {TERMINAL_TEXT_STYLE}.bold) = {TERMINAL_TEXT_STYLE}.bold then
				put_attribute_command (1)
			end
			if (l_style & {TERMINAL_TEXT_STYLE}.italic) = {TERMINAL_TEXT_STYLE}.italic then
				put_attribute_command (3)
			end
			if (l_style & {TERMINAL_TEXT_STYLE}.underlined) = {TERMINAL_TEXT_STYLE}.underlined then
				put_attribute_command (4)
			end
			if (l_style & {TERMINAL_TEXT_STYLE}.reversed) = {TERMINAL_TEXT_STYLE}.reversed then
				put_attribute_command (7)
			end
			if (l_style & {TERMINAL_TEXT_STYLE}.hidden) = {TERMINAL_TEXT_STYLE}.hidden then
				put_attribute_command (8)
			end
		end

feature {NONE} -- Externals

	c_rows (a_fp: POINTER): NATURAL
			-- Number of rows visible in terminal window.
			--
			-- `a_fp': File pointer to the open terminal.
		require
			not_a_fp_is_null: a_fp /= default_pointer
		external
			"C inline use %"eif_terminal.h%""
		alias
			"[
				#ifndef EIF_WINDOWS
					struct winsize ws;
					ioctl(fileno($a_fp), TIOCGWINSZ, &ws);
					return ws.ws_row;
				#else
					return 0;
				#endif
			]"
		end

	c_columns (a_fp: POINTER): NATURAL
			-- Number of rows visible in terminal window.
			--
			-- `a_fp': File pointer to the open terminal.
		require
			not_a_fp_is_null: a_fp /= default_pointer
		external
			"C inline use %"eif_terminal.h%""
		alias
			"[
				#ifndef EIF_WINDOWS
					struct winsize ws;
					ioctl(fileno($a_fp), TIOCGWINSZ, &ws);
					return ws.ws_col;
				#else
					return 0;
				#endif
			]"
		end

feature {NONE} -- Constants

	command_character: CHARACTER = '%/027/'
	qualifer_character: CHARACTER = '['
	attribute_separator: CHARACTER = ';'

	display_reset_cmd: STRING = "0m"

	save_cursor_cmd: STRING = "s"
	restore_cursor_cmd: STRING = "u"
	save_cursor_and_attributes_cmd: STRING = "7"
	restore_cursor_and_attributes_cmd: STRING = "8"

	erase_end_of_line_cmd: STRING = "K"
	erase_start_of_line_cmd: STRING = "1K"
	erase_line_cmd: STRING = "2K"
	erase_down_cmd: STRING = "J"
	erase_up_cmd: STRING = "1J"
	erase_screen_cmd: STRING = "2J"

invariant
	terminal_attached: attached terminal
	terminal_exists: terminal.exists

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
