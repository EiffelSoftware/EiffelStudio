indexing

	description:
		"Composite for command entry.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COMMAND_WIDGET

inherit

	MEL_COMMAND_RESOURCES
		export
			{NONE} all
		end;

	MEL_SELECTION_BOX
		redefine
			create_callback_struct, create_widget
		end

creation
	make,
	make_no_auto_unmanage,
	make_from_existing

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create Current with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object :=
					xm_create_command (p_so,
						$w_name, default_pointer, 0);
			else
				screen_object :=
					xm_create_command (p_so,
						$w_name, auto_unmanage_arg, 1);
			end;
		end

feature -- Status report

	command: MEL_STRING is
			-- The text currently displayed on the command line
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNcommand)
		ensure
			command_not_void: Result /= Void
		end;

	history_items: MEL_STRING_TABLE is
			-- The items in the history list
		require
			exists: not is_destroyed
		do
			!! Result.make_from_existing 
				(get_xm_string_table (screen_object, XmNhistoryItems),
						history_item_count);
			Result.set_shared
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
		end;

	history_item_count: INTEGER is
			-- The number of strings in the history_items list
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNhistoryItemCount)
		ensure
			history_item_count_large_enough: Result >= 0
		end;

	history_max_items: INTEGER is
			-- Maximum number of items `history_items'
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNhistoryMaxItems)
		ensure
			history_max_items_large_enough: Result >= 0
		end;

	history_visible_item_count: INTEGER is
			-- Number of history list commands that will
			-- be displayed at one time
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNhistoryVisibleItemCount)
		ensure
			history_visible_item_count_large_enough: Result >= 0
		end;

	prompt_string: MEL_STRING is
			-- The command line prompt
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNpromptString)
		ensure
			prompt_string_not_void: Result /= Void
		end;

feature -- Access

	command_changed_command: MEL_COMMAND_EXEC is
			-- Command set for the disarm callback
		do
			Result := motif_command (XmNcommandChangedCallback)
		end;

	command_entered_command: MEL_COMMAND_EXEC is
			-- Command set for the disarm callback
		do
			Result := motif_command (XmNcommandEnteredCallback)
		end;

feature -- Status setting

	set_command (a_compound_string: MEL_STRING) is
			-- Set the text currently displayed in the command line to `a_compound_string'.
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNcommand, a_compound_string)
		ensure
			command_set: command.is_equal (a_compound_string)
		end;

	set_history_items (a_list: MEL_STRING_TABLE) is
			-- Set `history_items' to `a_list'.
		require
			exists: not is_destroyed;
			valid_list: a_list /= Void and then a_list.is_valid
		do
			set_xm_string_table (screen_object, XmNhistoryItems, a_list.handle)
		end;

	set_history_item_count (a_count: INTEGER) is
			-- Set `history_item_count' to `a_count'.
		require
			exists: not is_destroyed;
			a_count_large_enough: a_count >= 0
		do
			set_xt_int (screen_object, XmNhistoryItemCount, a_count)
		ensure
			history_item_count_set: history_item_count = a_count
		end;

	set_history_max_items (a_count: INTEGER) is
			-- Set `history_max_items' to `a_count'.
		require
			exists: not is_destroyed;
			a_count_large_enough: a_count >= 0
		do
			set_xt_int (screen_object, XmNhistoryMaxItems, a_count)
		ensure
			history_max_items_set: history_max_items = a_count
		end;

	set_history_visible_item_count (a_count: INTEGER) is
			-- Set `history_visible_item_count' to `a_count'.
		require
			exists: not is_destroyed;
			a_count_large_enough: a_count >= 0
		do
			set_xt_int (screen_object, XmNhistoryVisibleItemCount, a_count)
		ensure
			history_visible_item_count_set: history_visible_item_count = a_count
		end;

	set_prompt_string (a_compound_string: MEL_STRING) is
			-- Set `prompt_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNpromptString, a_compound_string)
		ensure
			prompt_string_set: prompt_string.is_equal (a_compound_string)
		end;

feature -- Element change

	set_command_changed_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the value of command changes.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNcommandChangedCallback, a_command, an_argument)
		ensure
			command_set: command_set 
				(command_changed_command, a_command, an_argument)
		end;

	set_command_entered_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when a command is entered in the widget.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNcommandEnteredCallback, a_command, an_argument)
		ensure
			command_set: command_set 
				(command_entered_command, a_command, an_argument)
		end;

feature -- Removal

	remove_command_changed_callback is
			-- Remove the command for the command changed callback.
		do
			remove_callback (XmNcommandChangedCallback)
		ensure
			removed: command_changed_command = Void
		end;

	remove_command_entered_callback is
			-- Remove the command for the command entered callback.
		do
			remove_callback (XmNcommandEnteredCallback)
		ensure
			removed: command_entered_command = Void
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr, 
				resource_name: POINTER): MEL_ANY_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			if resource_name = XmNcommandEnteredCallback or else
				resource_name = XmNcommandChangedCallback then
				!MEL_COMMAND_CALLBACK_STRUCT! Result.make (Current, a_callback_struct_ptr)
			elseif resource_name = XmNokCallback or else
				resource_name = XmNcancelCallback or else
				resource_name = XmNnoMatchCallback or else
				resource_name = XmNapplyCallback
			then
				!MEL_SELECTION_BOX_CALLBACK_STRUCT! Result.make 
						(Current, a_callback_struct_ptr)
			else
				!MEL_ANY_CALLBACK_STRUCT! Result.make 
						(Current, a_callback_struct_ptr)
			end
		end

feature {NONE} -- Implementation

	xm_create_command (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/Command.h>"
		alias
			"XmCreateCommand"
		end;

end -- class MEL_COMMAND_WIDGET


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

