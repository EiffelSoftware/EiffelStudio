indexing
	description:	
		"Objects that display class information in a widget."
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

	EB_FORMATTER_DATA

feature -- Properties

	manager: EB_STONABLE
			-- What sends and receives stones.

	output_line: EV_TEXTABLE
			-- Where status information should be printed.

	widget: EV_WIDGET is
			-- Widget representing the associated system information.
		deferred
		end

feature -- Initialization

	make (a_manager: like manager) is
			-- Create a formatter associated with `a_manager'.
		do
			manager := a_manager
			capital_command_name := clone (command_name)
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
			mname := clone (menu_name)
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
			tt := clone (capital_command_name)
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
				cur_wid.set_pointer_style (old_cur)
				cur_wid.disable_capture
				cur_wid := Void
			end
		end

feature {NONE} -- Implementation

	old_cur: EV_CURSOR
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
--			cur_wid := create {EV_HORIZONTAL_BOX}
			if cur_wid = Void then
				--| Do nothing.
			else
				old_cur := cur_wid.pointer_style
				cur_wid.enable_capture
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

end -- class EB_FORMATTER
