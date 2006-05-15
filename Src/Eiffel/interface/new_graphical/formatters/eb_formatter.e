indexing
	description:
		"Objects that display class information in a widget."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FORMATTER

inherit
	SHARED_CONFIGURE_RESOURCES

	EB_RADIO_COMMAND_FEEDBACK

	EB_SHARED_WINDOW_MANAGER

	EB_CONSTANTS

	EV_STOCK_PIXMAPS

	EB_STONABLE

feature -- Properties

	manager: EB_STONABLE
			-- What sends and receives stones.

	output_line: EV_TEXTABLE
			-- Where status information should be printed.

	widget: EV_WIDGET is
			-- Widget representing the associated system information.
		deferred
		end

	stone: STONE
			-- Stone representing Current

	is_editor_formatter: BOOLEAN is
			-- Is current formatter use an editor to display information?
		do
		end

feature -- Initialization

	make (a_manager: like manager) is
			-- Create a formatter associated with `a_manager'.
		do
			manager := a_manager
			capital_command_name := command_name.twin
			capital_command_name.left_adjust
				-- Set the first character to upper case.
			capital_command_name.put ((capital_command_name @ 1) - 32, 1)
		ensure
			valid_capital_command_name: valid_string (capital_command_name)
		end

feature -- Setting

	invalidate is
			-- Force `Current' to refresh itself next time `format' is called.
		do
			must_format := True
		end

	set_output_line (a_line: like output_line) is
			-- Set `output_line' to `a_line'.
		do
			output_line := a_line
		end

	set_accelerator (accel: EV_ACCELERATOR) is
			-- Set `accelerator' to `accel'.
		do
			accelerator := accel
		end

	set_manager (a_manager: like manager) is
			-- Change `Current's stone manager.
		require
			a_manager_not_void: a_manager /= Void
		do
			manager := a_manager
		end

	set_editor (an_editor: EB_CLICKABLE_EDITOR) is
			-- Set `editor' to `an_editor'.
			-- Used to share an editor between several formatters.
		require
			an_editor_non_void: an_editor /= Void
		do
			editor := an_editor
			internal_widget := an_editor.widget
		end

feature -- Formatting

	format is
			-- Refresh `widget' if `must_format' and `selected'.
		deferred
		end

	last_was_error: BOOLEAN
			-- Did an error occur during the last attempt to format?

feature -- Interface

	on_shown is
			-- `Widget's parent is displayed.
		do
			internal_displayed := True
			if
				widget_owner /= Void and then
				selected
			then
				widget_owner.set_widget (widget)
				display_header
			end
			format
		end

	on_hidden is
			-- `Widget's parent is hidden.
		do
			internal_displayed := False
		end

	symbol: ARRAY [EV_PIXMAP] is
			-- Pixmaps for the default button (1 is color, 2 is grey, if any).
		deferred
		end

	new_menu_item: EV_RADIO_MENU_ITEM is
			-- Create a new menu item for `Current'.
		local
			mname: STRING
		do
			mname := menu_name.twin
			if accelerator /= Void then
				mname.append (Tabulation)
				mname.append (accelerator.out)
			end
			create Result.make_with_text (mname)
			set_menu_item (Result)
		end

	new_button: EV_TOOL_BAR_RADIO_BUTTON is
			-- Create a new tool bar button representing `Current'.
		local
			tt: STRING
		do
			create Result
			Result.set_pixmap (symbol @ 1)
			tt := capital_command_name.twin
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
			set_button (Result)
		end

feature -- Pop up

	popup is
			-- Make `widget' visible.
		do
			if widget_owner /= Void then
				if widget_owner.last_widget /= widget then
					widget_owner.set_widget (widget)
				end
				widget_owner.force_display
			end
			display_header
		end

	widget_owner: WIDGET_OWNER
			-- Container of `widget'.

	set_widget_owner (new_owner: WIDGET_OWNER) is
			-- Set `widget_owner' to `new_owner'.
		do
			widget_owner := new_owner
		end

feature -- Commands

	execute is
			-- Execute as a command.
		do
			enable_select
			popup
			fresh_old_formatter
			format
		end

	save_in_file is
			-- Save output format into a file.
		deferred
		end

	display_header is
			-- Show header for current formatter.
		do
			if output_line /= Void then
				output_line.set_text (header)
			end
			if cur_wid = Void then
				--| Do nothing.
			else
				if old_cur /= Void then
					cur_wid.set_pointer_style (old_cur)
				end
				cur_wid := Void
			end
		end

feature -- Stonable

	refresh is
			-- Do nothing.
		do
		end

	force_stone (a_stone: STONE) is
			-- Directly set `stone' with `a_stone'
		do
			stone := a_stone
			manager.set_pos_container (Current)
			if stone /= Void and selected then
				stone.set_pos_container (Current)
			end
		end

feature -- Loacation

	fresh_position is
			-- Fresh stone position
		do
			if manager.stone /= Void then
				stone := manager.stone.twin
			end
			if stone /= Void then
				check
					manager.position >= 0
				end
				stone.set_pos_container (Current)
				stone.set_position (manager.position)
			end
		end

	go_to_position is
			-- Save manager position and go to position in `editor' if possible.
		do
			save_manager_position
			if
				selected and then
				stone /= Void and then
				stone.pos_container = current and then
				stone.position > 0
			then
				editor.display_line_at_top_when_ready (stone.position)
			end
		end

feature {NONE} -- Location

	fresh_old_formatter is
			-- Fresh old formatter position
		local
			l_formatter: EB_FORMATTER
		do
			l_formatter ?= manager.previous_pos_container
			if l_formatter /= Void then
				l_formatter.fresh_position
			end
		end

	save_manager_position is
			-- Save container and position in manager
		do
			if stone /= Void then
				manager.set_previous_position (stone.position)
			else
				manager.set_previous_position (manager.position)
			end
			manager.set_previous_pos_container (Current)
		end

feature {NONE} -- Implementation

	old_cur: EV_CURSOR
			-- Cursor saved while displaying the hourglass cursor.

	cur_wid: EV_WIDGET
			-- Widget on which the hourglass cursor was set.

	editor: EB_CLICKABLE_EDITOR
			-- Output editor.

	displayed: BOOLEAN is
			-- Is `widget' displayed?
		do
			Result := selected and then internal_displayed
		end

	internal_displayed: BOOLEAN
			-- Is `widget's parent visible?

	internal_widget: EV_WIDGET
			-- Widget corresponding to `editor's text area.

	must_format: BOOLEAN
			-- Is a call to `format' really necessary?
			-- (i.e. has the stone changed since last call?)

	display_info (str: STRING) is
			-- Print `str' in `output_line'.
		do
			output_line.set_text (str)
		end

	display_temp_header is
			-- Display a temporary header during the format processing.
			-- Display a hourglass-shaped cursor.
		do
			if window_manager.last_focused_development_window /= Void then
					-- Check is needed for session handling.
				cur_wid := Window_manager.last_focused_development_window.window
			end
			if cur_wid = Void then
				--| Do nothing.
			else
				old_cur := cur_wid.pointer_style
				cur_wid.set_pointer_style (Wait_cursor)
			end

			if output_line /= Void then
				output_line.set_text (temp_header)
			end
		end

	header: STRING is
			-- Text displayed in the ouput_line when current formatter is displayed.
		deferred
		end

	temp_header: STRING is
			-- Text displayed in the ouput_line when current formatter is working.
		deferred
		end

	file_name: FILE_NAME is
			-- Name of the file where formatted output may be saved.
		deferred
		end

	post_fix: STRING is
			-- Postfix name of current format.
			-- Used as an extension while saving.
		deferred
		ensure
			Result_not_void: Result /= Void
			valid_extension: Result.count <= 3
		end

	Tabulation: STRING is "%T"
	Opening_parenthesis: STRING is " ("
	Closing_parenthesis: STRING is ")"

	has_breakpoints: BOOLEAN is deferred end
		-- Should `Current' display breakpoints?

	line_numbers_allowed: BOOLEAN is deferred end
		-- Does it make sense to show line numbers in Current?

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FORMATTER
