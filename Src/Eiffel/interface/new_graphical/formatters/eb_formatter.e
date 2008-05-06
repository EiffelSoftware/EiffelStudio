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
		redefine
			update
		end

	EB_SHARED_WINDOW_MANAGER

	EB_CONSTANTS

	EV_STOCK_PIXMAPS

	EB_STONABLE

	EB_RECYCLABLE

feature -- Initialization

	make (a_manager: like manager) is
			-- Create a formatter associated with `a_manager'.
		do
			manager := a_manager
			command_name := capital_command_name.twin
			command_name := interface_names.string_general_as_left_adjusted (command_name)
			command_name := interface_names.string_general_as_lower (command_name)
			create post_execution_action
		ensure
			valid_capital_command_name: valid_string (capital_command_name)
		end

feature -- Properties

	manager: EB_STONABLE
			-- What sends and receives stones.

	output_line: EV_LABEL
			-- Where status information should be printed.

	widget: EV_WIDGET is
			-- Widget representing the associated system information.
		deferred
		end

	stone: STONE
			-- Stone representing Current

	viewpoints: CLASS_VIEWPOINTS
			-- Class view points

	post_execution_action: EV_NOTIFY_ACTION_SEQUENCE
			-- Called after execution

	empty_widget: EV_WIDGET is
			-- Widget displayed when no information can be displayed.
		do
			if internal_empty_widget = Void then
				new_empty_widget
			end
			Result := internal_empty_widget
		end

	command_name: STRING_GENERAL
			-- Command name

	element_name: STRING is
			-- name of associated element in current formatter.
			-- For exmaple, if a class stone is associated to current, `element_name' would be the class name.
			-- Void if element is not retrievable.
		deferred
		end

	name: STRING_GENERAL is
			-- Name of Current formatter
		do
			Result := command_name.twin
		ensure
			result_attached: Result /= Void
		end

	displayer_generator: TUPLE [any_generator: FUNCTION [ANY, TUPLE, like displayer]; name: STRING] is
			-- Generator to generate proper `displayer' for Current formatter
		deferred
		ensure
			result_attached: Result /= Void
			result_valid: Result.any_generator /= Void and then (Result.name /= Void and then not Result.name.is_empty)
		end

	control_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- Possible area to display a tool bar
		deferred
		end

	displayer: EB_FORMATTER_DISPLAYER is
			-- Displayer used to display Result of Current formatter
		deferred
		end

	veto_format_function: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Function to veto format.
			-- If not Void, it's invoked before `format'. And if returned value is True,
			-- format will go on, if returned value is False, format is vetoed.
			-- If Void, format will go on.

feature -- Displayer factory

	displayer_generators: EB_FORMATTER_DISPLAYERS is
			-- Displayer generators
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET class texts?
		deferred
		end

	is_valid: BOOLEAN is
			-- Is Current formatter valid?
		do
			Result := True
		end

	is_customized_fomatter: BOOLEAN is
			-- Is Current a customized formatter?
		do
		end

	is_editor_formatter: BOOLEAN is
			-- Is Current formatter based on an editor?
		do
		end

	is_browser_formatter: BOOLEAN is
			-- Is Current formatter based on a browser?
		do
		end

	should_displayer_be_recycled: BOOLEAN
			-- Should `displayer' be recycled in `internal_recycle'?

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

	set_viewpoints (a_viewpoints: like viewpoints) is
			-- Viewpoints of current formatting
		do
			viewpoints := a_viewpoints
		ensure
			viewpoints_is_set: viewpoints = a_viewpoints
		end

	set_veto_format_function (a_function: like veto_format_function) is
			-- Set `veto_format_function' with `a_function'.
		do
			veto_format_function := a_function
		ensure
			veto_format_function_set: veto_format_function = a_function
		end

	set_focus is
			-- Set focus to current formatter.
		deferred
		end

	reset_display is
			-- Clear all graphical output.
		deferred
		end

	synchronize is
			-- Check validity of Current formatter.
			-- Update UI according to validity of Current formatter if displayed.
		do
			if is_valid then
				enable_sensitive
				widget.enable_sensitive
			else
				disable_sensitive
				widget.disable_sensitive
			end
		end

	update (a_window: EV_WINDOW) is
			-- Update `accelerator' and interfaces according to `referred_shortcut'.
		local
			mname: STRING_GENERAL
			tt: STRING_GENERAL
		do
			Precursor {EB_RADIO_COMMAND_FEEDBACK} (a_window)
			if menu_item /= Void then
				mname := menu_name.twin
				if shortcut_available then
					mname.append (tabulation)
					mname.append (shortcut_string)
				end
				menu_item.set_text (mname)
			end
			tt := capital_command_name.twin
			if shortcut_available then
				tt.append (opening_parenthesis)
				tt.append (shortcut_string)
				tt.append (closing_parenthesis)
			end
			if button /= Void then
				button.set_tooltip (tt)
			end
			if sd_button /= Void then
				sd_button.set_tooltip (tt)
				sd_button.set_description (capital_command_name)
			end
		end

	ensure_display_in_widget_owner is
			-- If Current is selected, ensure Current is displayed in `widget_owner' if `widget_owner' is attached.
		do
			if selected and then widget_owner /= Void then
				widget_owner.ensure_formatter_display (Current)
				display_header
			end
		end

	set_should_displayer_be_recycled (b: BOOLEAN) is
			-- Set `should_displayer_be_recycled' with `b'.
		do
			should_displayer_be_recycled := b
		ensure
			should_displayer_be_recycled_set: should_displayer_be_recycled = b
		end

feature -- Formatting

	format is
			-- Refresh `widget' if `must_format' and `selected'.
		deferred
		end

	last_was_error: BOOLEAN
			-- Did an error occur during the last attempt to format?

	set_must_format (b: BOOLEAN) is
			-- Set `must_format' with `b'.
		do
			must_format := b
		ensure
			must_format_set: must_format = b
		end

feature -- Interface

	symbol: ARRAY [EV_PIXMAP] is
			-- Pixmaps for the default button (1 is color, 2 is grey, if any).
		deferred
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representation.
		deferred
		end

	new_standalone_menu_item: EV_RADIO_MENU_ITEM is
			-- Create a new menu item.
		local
			mname: STRING_GENERAL
		do
			mname := menu_name.twin
			if shortcut_available then
				mname.append (Tabulation)
				mname.append (shortcut_string)
			end
			create Result.make_with_text (mname)
			Result.set_pixmap (symbol @ 1)
		ensure
			new_standalone_menu_item_not_void: Result /= Void
		end

	new_menu_item: EV_RADIO_MENU_ITEM
			-- Create a new menu item for `Current'.
		do
			Result := new_standalone_menu_item
			set_menu_item (Result)
		ensure
			new_menu_item_not_void: Result /= Void
		end

	new_button: EV_TOOL_BAR_RADIO_BUTTON is
			-- Create a new tool bar button representing `Current'.
		local
			tt: STRING_GENERAL
		do
			create Result
			Result.set_pixmap (symbol @ 1)
			tt := capital_command_name.twin
			if shortcut_available then
				tt.append (Opening_parenthesis)
				tt.append (shortcut_string)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
			set_button (Result)
			Result.drop_actions.extend (agent execute_with_stone)
			Result.drop_actions.set_veto_pebble_function (agent veto_pebble_function)
		end

	new_sd_button: SD_TOOL_BAR_RADIO_BUTTON is
			-- Create a new tool bar button representing `Current'
		local
			tt: STRING_GENERAL
		do
			create Result.make
			Result.set_pixmap (symbol @ 1)
			Result.set_pixel_buffer (pixel_buffer)
			tt := capital_command_name.twin
			if shortcut_available then
				tt.append (Opening_parenthesis)
				tt.append (shortcut_string)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
			Result.set_name (generating_type)
			Result.set_description (capital_command_name)
			set_sd_button (Result)
			Result.drop_actions.extend (agent execute_with_stone)
			Result.drop_actions.set_veto_pebble_function (agent veto_pebble_function)
		end

feature -- Pop up

	popup is
			-- Make `widget' visible.
		do
			if widget_owner /= Void then
				widget_owner.ensure_formatter_display (Current)
				widget_owner.force_display
			end
			display_header
			if not popup_actions.is_empty then
				popup_actions.call (Void)
			end
		end

	widget_owner: ES_FORMATTER_TOOL_PANEL_BASE
			-- Container of `widget'.

	set_widget_owner (new_owner: like widget_owner) is
			-- Set `widget_owner' to `new_owner'.
		do
			widget_owner := new_owner
		end

feature -- Actions

	on_shown is
			-- `Widget's parent is displayed.
		do
			internal_displayed := True
			ensure_display_in_widget_owner
			synchronize
			if is_valid then
				format
			else
				reset_display
			end
		end

	on_hidden is
			-- `Widget's parent is hidden.
		do
			internal_displayed := False
		end

	execute_with_stone (a_stone: STONE) is
			-- Notify `manager' of the dropping of `stone'.
		do
			if not selected then
				set_stone (a_stone)
				execute
			end
			manager.set_stone (a_stone)
		end

feature -- Commands

	execute is
			-- Execute as a command.
		do
			enable_select
			popup
			fresh_old_formatter
			format
			post_execution_action.call (Void)
		end

	save_in_file is
			-- Save output format into a file.
		do
--|FIXME XR: To be implemented.		
		end

	display_header is
			-- Show header for current formatter.
		do
			if output_line /= Void then
				output_line.set_text (header)
				output_line.refresh_now
			end
			if cur_wid = Void or old_cur = Void then
				--| Do nothing.
			else
				cur_wid.set_pointer_style (old_cur)
				old_cur := Void
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
			if manager /= Void then
				manager.set_pos_container (Current)
			end
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

feature -- Agents

	popup_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed when current format `popup's.
		do
			if popup_actions_internal = Void then
				create popup_actions_internal
			end
			Result := popup_actions_internal
		ensure
			result_attached: Result /= Void
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

	setup_viewpoint is
			-- Setup viewpoint for formatting.
		deferred
		end

feature {NONE} -- Recyclable

	internal_recycle is
			-- Recycle
		do
			manager := Void
			if should_displayer_be_recycled then
				if displayer /= Void then
					displayer.recycle
				end
			end
			if sd_button /= Void then
				sd_button.drop_actions.set_veto_pebble_function (Void)
				sd_button.drop_actions.wipe_out
				sd_button := Void
			end
			if button /= Void then
				button.drop_actions.set_veto_pebble_function (Void)
				button.drop_actions.wipe_out
				button.destroy
				button := Void
			end
		end

feature {NONE} -- Implementation

	old_cur: EV_POINTER_STYLE
			-- Cursor saved while displaying the hourglass cursor.

	cur_wid: EV_WIDGET
			-- Widget on which the hourglass cursor was set.

	displayed: BOOLEAN is
			-- Is `widget' displayed?
		do
			Result := selected and then internal_displayed
		end

	internal_displayed: BOOLEAN
			-- Is `widget's parent visible?

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
				cur_wid.set_pointer_style (wait_cursor)
			end
			if output_line /= Void then
				output_line.set_text (temp_header)
				output_line.refresh_now
			end
		end

	header: STRING_GENERAL is
			-- Text displayed in the ouput_line when current formatter is displayed.
		deferred
		end

	temp_header: STRING_GENERAL is
			-- Text displayed in the ouput_line when current formatter is working.
		deferred
		end

	file_name: FILE_NAME is
			-- Name of the file in which displayed information may be stored
		require
			element_name_attached: element_name /= Void
		do
			create Result.make_from_string (element_name)
			Result.add_extension (post_fix)
		ensure
			result_attached: Result /= Void
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

	popup_actions_internal: like popup_actions
			-- Implementation of `popup_actions'

	internal_empty_widget: EV_WIDGET
			-- Widget displayed when no information can be displayed.	

	new_empty_widget is
			-- Initialize a default empty_widget.
		local
			l_frame: EV_FRAME
		do
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			l_frame.set_background_color ((create {EV_STOCK_COLORS}).white)
			internal_empty_widget := l_frame
			if widget_owner /= Void then
				internal_empty_widget.drop_actions.extend (agent widget_owner.drop_stone)
			else
				internal_empty_widget.drop_actions.extend (agent execute_with_stone)
			end
		end

	retrieve_sorting_order is
			-- Retrieve last recored sorting order.
		do
		end

	actual_veto_format_result: BOOLEAN is
			-- Actual veto format result.
			-- i.e., if `veto_format_function' is Void, always allow format to go on.
		do
			if veto_format_function /= Void then
				Result := veto_format_function.item (Void)
			else
				Result := True
			end
		end

	veto_pebble_function (a_any: ANY): BOOLEAN is
			-- Veto pebble function
		do
			Result := actual_veto_format_result
		end

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
