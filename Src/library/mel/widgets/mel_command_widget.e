indexing

	description:
			"Composite for command entry.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COMMAND

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
	make_no_auto_unmanage

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
			Mel_widgets.put (Current, screen_object);
			create_selection_children
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
			!! Result.make_from_existing (get_xm_string_table (screen_object, XmNhistoryItems),
						history_item_count)
		ensure
			history_items_not_void: Result /= Void
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
			a_list_exists: a_list /= Void and then not a_list.is_destroyed
		do
			set_xm_string_table (screen_object, XmNhistoryItems, a_list.handle)
		ensure
			history_items_set: history_items.is_equal (a_list)
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

	add_command_changed_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the value of command changes.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNcommandChangedCallback, a_callback, an_argument)
		end;

	add_command_entered_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when a command is entered in the widget.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNcommandEnteredCallback, a_callback, an_argument)
		end;

feature -- Removal

	remove_command_changed_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the value of command changes.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNcommandChangedCallback, a_callback, an_argument)
		end;

	remove_command_entered_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when a command is entered in the widget.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNcommandEnteredCallback, a_callback, an_argument)
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
			"C [macro <Xm/Command.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateCommand"
		end;

end -- class MEL_COMMAND

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
