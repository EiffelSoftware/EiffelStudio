indexing

	description:
			"Widget that allows a user to select form a list of choices.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_LIST

inherit

	MEL_LIST_RESOURCES
		export
			{NONE} all
		end;

	MEL_PRIMITIVE
		redefine
			create_callback_struct
		end;

	MEL_FONTABLE
		undefine
			clean_up
		redefine
			create_callback_struct
		end;

creation
	make, 
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif list widget.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_list (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Access

	index_of (an_item: MEL_STRING; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of `an_item'
			-- (Zero if not found.)
		require
			positive_occurrence: i > 0;
			valid_item: an_item /= Void and then an_item.is_valid
		do
			Result := xm_list_index_of (screen_object, an_item.handle, i)
		ensure 
			valid_result: Result >= 0
		end;

	item_pos_from (an_item: MEL_STRING; from_pos: INTEGER): INTEGER is
			-- Index of `an_item' beyond `from_pos' in `items'.
			-- (Zero if not found.)
		require
			valid_item: an_item /= Void and then an_item.is_valid;
			from_pos_large_enough: from_pos >= 0;
			from_pos_small_enough: from_pos <= item_count
		do
			Result := xm_list_item_pos_from (screen_object, an_item.handle, from_pos)
		ensure 
			valid_result: Result >= 0
		end;

	item_exists (an_item: MEL_STRING): BOOLEAN is
			-- Is `an_item' present?
		require
			exists: not is_destroyed;
			valid_item: an_item /= Void and then an_item.is_valid
		do
			Result := xm_list_item_exists (screen_object, an_item.handle)
		end;

	item_pos (an_item: MEL_STRING): INTEGER is
			-- Index of `an_item'
		require
			exists: not is_destroyed;
			valid_item: an_item /= Void and then an_item.is_valid
		do
			Result := xm_list_item_pos (screen_object, an_item.handle)
		ensure
			result_small_enough: Result <= item_count
		end;

	browse_selection_command: MEL_COMMAND_EXEC is
			-- Command set for the browse selection callback
		do
			Result := motif_command (XmNbrowseSelectionCallback)
		end;

	default_action_command: MEL_COMMAND_EXEC is
			-- Command set for the default action callback
		do
			Result := motif_command (XmNdefaultActionCallback)
		end;

	extended_selection_command: MEL_COMMAND_EXEC is
			-- Command set for the extended selection callback
		do
			Result := motif_command (XmNextendedSelectionCallback)
		end;

	multiple_selection_command: MEL_COMMAND_EXEC is
			-- Command set for the multiple selection callback
		do
			Result := motif_command (XmNmultipleSelectionCallback)
		end;

	single_selection_command: MEL_COMMAND_EXEC is
			-- Command set for the single selection callback
		do
			Result := motif_command (XmNsingleSelectionCallback)
		end

feature -- Status report

	double_click_interval: INTEGER is
			-- Time span (in milliseconds) within which two button clicks
			-- must occur to be considered a double clisck rather than two single
			-- clicks
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNdoubleclickInterval)
		ensure
			double_click_interval_large_enough: Result >= 0
		end;

	item_count: INTEGER is
			-- Number of items
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNitemCount)
		ensure
			item_count_large_enough: Result >= 0
		end;

	items: MEL_STRING_TABLE is
			-- All items in Current
		require
			exists: not is_destroyed
		do
			!! Result.make_from_existing (get_xm_string_table 
						(screen_object, XmNitems), item_count);
			Result.set_shared
		ensure
			items_exist: Result /= Void and then Result.is_valid;
			items_is_shared: Result.is_shared
		end;

	margin_height: INTEGER is
			-- Amount of space between the top or bottom and the displayed items
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNlistMarginHeight)
		ensure
			margin_height_large_enough: Result >= 0
		end;

	margin_width: INTEGER is
			-- Amount of space between the left and right and the displayed items.
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNlistMarginWidth)
		ensure
			margin_width_large_enough: Result >= 0
		end;

	spacing: INTEGER is
			-- Space between items
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNlistSpacing)
		ensure
			spacing_large_enough: Result >= 0
		end;

	selected_item_count: INTEGER is
			-- Number of selected items
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNselectedItemCount)
		ensure
			selected_item_count_large_enough: Result >= 0
		end;

	selected_positions: LINKED_LIST [INTEGER] is
			-- Positions of the selected items
		local
			int_table: POINTER;
			i, c: INTEGER
		do
			!! Result.make;
			c := selected_item_count;
			if c > 0 then
				from
					i := 1;
					int_table := xm_list_get_selected_pos (screen_object)
				until
					i > c
				loop
					Result.extend (xm_list_get_i_int_table (int_table, i));
					i := i + 1
				end;
				xt_free (int_table)
			end
		ensure
			valid_result: selected_item_count = Result.count
		end;

	selected_items: MEL_STRING_TABLE is
			-- Table of selected items
		require
			exists: not is_destroyed
		do
			!! Result.make_from_existing (get_xm_string_table 
				(screen_object, XmNselectedItems), selected_item_count);
			Result.set_shared
		ensure
			selected_items_exists: Result /= Void and then Result.is_valid;
			items_is_shared: Result.is_shared
		end;

	is_single_select: BOOLEAN is
			-- Can the user select only one item at a time? 
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNselectionPolicy) = XmSINGLE_SELECT
		end;

	is_browse_select: BOOLEAN is
			-- Is there always an item selected, while selecting one item at a time?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNselectionPolicy) = XmBROWSE_SELECT
		end;

	is_multiple_select: BOOLEAN is
			-- Can the user select, in one range, more than one item?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNselectionPolicy) = XmMULTIPLE_SELECT
		end;

	is_extended_select: BOOLEAN is
			-- Can the user select, in many ranges, more than one item?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNselectionPolicy) = XmEXTENDED_SELECT
		end;

	is_string_direction_l_to_r: BOOLEAN is
			-- Are the strings displayed from left to right?
		require
			exists: not is_destroyed
		do
			Result := get_xm_string_direction (screen_object, XmNstringDirection) = XmSTRING_DIRECTION_L_TO_R
		end;

	is_string_direction_r_to_l: BOOLEAN is
			-- Are the strings displayed from right to left?
		require
			exists: not is_destroyed
		do
			Result := get_xm_string_direction 
				(screen_object, XmNstringDirection) = XmSTRING_DIRECTION_R_TO_L
		end;

	top_item_position: INTEGER is
			-- Position in `items' of the first visible item
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNtopItemPosition)
		ensure
			top_item_position_large_enough: Result > 0
		end;

	visible_item_count: INTEGER is
			-- Number of visible items
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNvisibleItemCount)
		ensure
			visible_item_count_large_enough: Result >= 0
		end;

	is_pos_selected (a_position: INTEGER): BOOLEAN is
			-- Is item at `a_position' selected?
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position > 0;
			a_position_small_enough: a_position <= item_count
		do
			Result := xm_list_pos_selected (screen_object, a_position)
		end;

feature -- Status setting

	set_double_click_interval (a_time: INTEGER) is
			-- Set `double_click_interval' to `a_time'.
		require
			exists: not is_destroyed;
			a_time_large_enough: a_time >= 0
		do
			set_xt_int (screen_object, XmNdoubleclickInterval, a_time)
		ensure
			time_set: double_click_interval = a_time
		end;

	set_items (a_list: MEL_STRING_TABLE) is
			-- Set `items' to `a_list'.
		require
			exists: not is_destroyed;
			valid_list: a_list /= Void and then a_list.is_valid
		do
			set_xm_string_table (screen_object, XmNitems, a_list.handle)
		end;

	set_margin_height (a_height: INTEGER) is
			-- Set `margin_height' to `a_height'.
		require
			exists: not is_destroyed
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNlistMarginHeight, a_height)
		ensure
			margin_height_set: margin_height = a_height
		end;

	set_margin_width (a_width: INTEGER) is
			-- Set `margin_width' to `a_width'.
		require
			exists: not is_destroyed
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNlistMarginWidth, a_width)
		ensure
			margin_width_set: margin_width = a_width
		end;

	set_spacing (a_spacing: INTEGER) is
			-- Set `spacing' to `a_spacing'.
		require
			exists: not is_destroyed
			a_spacing_large_enough: a_spacing >= 0
		do
			set_xt_dimension (screen_object, XmNlistSpacing, a_spacing)
		ensure
			spacing_set: spacing = a_spacing
		end;

	set_selected_items (a_list: MEL_STRING_TABLE) is
			-- Set `selected_items' to `a_list'.
		require
			exists: not is_destroyed;
			valid_list: a_list /= Void and then a_list.is_valid
		do
			set_xm_string_table (screen_object, XmNselectedItems, a_list.handle)
		end;

	set_single_select is
			-- Set `is_single_select'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNselectionPolicy, XmSINGLE_SELECT)
		ensure
			single_select_set: is_single_select
		end;

	set_browse_select is
			-- Set `is_browse_select'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNselectionPolicy, XmBROWSE_SELECT)
		ensure
			browse_select_set: is_browse_select
		end;

	set_multiple_select is
			-- Set `is_multiple_select'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNselectionPolicy, XmMULTIPLE_SELECT)
		ensure
			multiple_select_set: is_multiple_select
		end;

	set_extended_select is
			-- Set `is_extended_select'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNselectionPolicy, XmEXTENDED_SELECT)
		ensure
			extended_select_set: is_extended_select
		end;

	set_string_direction_l_to_r is
			-- Set the direction in which to draw the string to left to right.
		require
			exists: not is_destroyed
		do
			set_xm_string_direction (screen_object, 
						XmNstringDirection, XmSTRING_DIRECTION_L_TO_R)
		ensure
			is_string_direction_l_to_r: is_string_direction_l_to_r
		end;

	set_string_direction_r_to_l is
			-- Set the direction in which to draw the string to right to left.
		require
			exists: not is_destroyed
		do
			set_xm_string_direction (screen_object, 
						XmNstringDirection, XmSTRING_DIRECTION_R_TO_L)
		ensure
			is_string_direction_r_to_l: is_string_direction_r_to_l
		end;

	set_top_item_position (a_position: INTEGER) is
			-- Set `top_item_position' to `a_position'.
		require
			exists: not is_destroyed;
			a_position_large_enough: 1 <= a_position;
			a_position_small_enough: a_position <= item_count
		do
			set_xt_int (screen_object, XmNtopItemPosition, a_position)
		ensure
			top_item_position_set: top_item_position = a_position
		end;

	set_visible_item_count (a_value: INTEGER) is
			-- Set `visible_item_count' to `a_value'.
		require
			exists: not is_destroyed;
			a_positive_value: a_value > 0
		do
			set_xt_int (screen_object, XmNvisibleItemCount, a_value)
		end;

	set_pos (a_value: INTEGER) is
			-- Set the first visible item to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value > 0;
			a_value_small_enough: a_value <= item_count
		do
			xm_list_set_pos (screen_object, a_value)
		end;

	set_bottom_pos (a_value: INTEGER) is
			-- Set index of last visible item to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value > 0;
			a_value_small_enough: a_value <= item_count
		do
			xm_list_set_bottom_pos (screen_object, a_value)
		end;

feature -- Element Change

	add_item (an_item: MEL_STRING; a_position: INTEGER) is
			-- Put `an_item' at `a_position' and select it.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position > 0;
			a_position_small_enough: a_position <= item_count + 1;
			valid_item: an_item /= Void and then an_item.is_valid
		do
			xm_list_add_item (screen_object, an_item.handle, a_position)
		ensure
			item_added: item_count = old item_count + 1;
			item_selected: is_pos_selected (a_position)
		end;

	add_item_unselected (an_item: MEL_STRING; a_position: INTEGER) is
			-- Put `an_item' at `a_position'.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= item_count + 1;
			valid_item: an_item /= Void and then an_item.is_valid
		do
			xm_list_add_item_unselected (screen_object, an_item.handle, a_position)
		ensure
			item_added: item_count = old item_count + 1
		end;

	add_items (an_item_list: MEL_STRING_TABLE; a_position: INTEGER) is
			-- Put `an_item_list' at `a_position' and select them.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= item_count + 1;
			valid_list: an_item_list /= Void and then an_item_list.is_valid
		do
			xm_list_add_items (screen_object, an_item_list.handle, an_item_list.count, a_position)
		ensure
			items_added: item_count = old item_count + an_item_list.count
		end;

	add_items_unselected (an_item_list: MEL_STRING_TABLE; a_position: INTEGER) is
			-- Put `an_item_list' at `a_position'.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position > 0;
			a_position_small_enough: a_position <= item_count + 1;
			valid_list: an_item_list /= Void and then an_item_list.is_valid
		do
			xm_list_add_items_unselected (screen_object, an_item_list.handle, an_item_list.count, a_position)
		ensure
			items_added: item_count = old item_count + an_item_list.count
		end;

	replace_items_pos (new_items: MEL_STRING_TABLE; a_position: INTEGER) is
			-- Replace the items from `position' by `new_items' and select them.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position > 0;
			a_position_small_enough: a_position <= item_count;
			valid_list: new_items /= Void and then new_items.is_valid
		do
			xm_list_replace_items_pos (screen_object, new_items.handle, new_items.count, a_position)
		ensure
			no_items_added: item_count = old item_count
		end;

	replace_item_pos (new_item: MEL_STRING; a_position: INTEGER) is
			-- Replace the item at `position' by `new_item' and select it.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position > 0;
			a_position_small_enough: a_position <= item_count;
			new_items_not_void: new_item /= Void and then new_item.is_valid
		local
			ptr: POINTER
		do
			ptr := new_item.handle;
			xm_list_replace_items_pos (screen_object, $ptr, 1, a_position)
		ensure
			item_not_added: item_count = old item_count
		end;

	replace_items_pos_unselected (new_items: MEL_STRING_TABLE; a_position: INTEGER) is
			-- Replace the items from `position' by `new_items'.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position > 0;
			a_position_small_enough: a_position <= item_count;
			valid_items: new_items /= Void and then new_items.is_valid
		do
			xm_list_replace_items_pos_unselected (screen_object, new_items.handle, new_items.count, a_position)
		ensure
			no_items_added: item_count = old item_count
		end;

	replace_items (old_items, new_items: MEL_STRING_TABLE) is
			-- Replace `old_items' by `new_items' and select `new_items'.
		require
			exists: not is_destroyed;
			valid_old_items: old_items /= Void and then old_items.is_valid;
			valid_new_items: new_items /= Void and then new_items.is_valid;
			old_items_as_big_as_new_items: old_items.count = new_items.count
		do
			xm_list_replace_items (screen_object, old_items.handle, old_items.count, new_items.handle)
		ensure
			no_items_added: item_count = old item_count
		end;

	replace_items_unselected (old_items, new_items: MEL_STRING_TABLE) is
			-- Replace `old_items' by `new_items'.
		require
			exists: not is_destroyed;
			valid_old_items: old_items /= Void and then old_items.is_valid;
			valid_new_items: new_items /= Void and then new_items.is_valid;
			old_items_as_big_as_new_items: old_items.count = new_items.count
		do
			xm_list_replace_items_unselected (screen_object, old_items.handle, old_items.count, new_items.handle)
		ensure
			no_items_added: item_count = old item_count
		end;

	select_item (an_item: MEL_STRING; notify: BOOLEAN) is
			-- Select `an_item' and call the callback routines aaccording to `notify'.
		require
			exists: not is_destroyed;
			valid_item: an_item /= Void and then an_item.is_valid;
			an_item_already_present: item_exists (an_item)
		do
			xm_list_select_item (screen_object, an_item.handle, notify)
		end;

	select_pos (a_position: INTEGER; notify: BOOLEAN) is
			-- Select item at `a_position' and call
			-- the callback routines according to `notify'.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position > 0;
			a_position_small_enough: a_position <= item_count
		do
			xm_list_select_pos (screen_object, a_position, notify)
		ensure
			pos_selected: is_pos_selected (a_position)
		end;

	deselect_item (an_item: MEL_STRING) is
			-- Deselect `an_item'.
		require
			exists: not is_destroyed;
			valid_item: an_item /= Void and then an_item.is_valid;
			an_item_already_present: item_exists (an_item)
		do
			xm_list_deselect_item (screen_object, an_item.handle)
		end;

	deselect_pos (a_position: INTEGER) is
			-- Deselect item at `a_position'.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position > 0;
			a_position_small_enough: a_position <= item_count
		do
			xm_list_deselect_pos (screen_object, a_position)
		ensure
			position_not_selected: not is_pos_selected (a_position)
		end;

	deselect_all_items is
			-- Deselect all items.
		require
			exists: not is_destroyed
		do
			xm_list_deselect_all_items (screen_object)
		ensure
			no_item_selected: selected_item_count = 0
		end;

	set_browse_selection_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when an item is selected in
			-- browse mode.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNbrowseSelectionCallback, a_command, an_argument)
		ensure
			command_set: command_set (browse_selection_command, a_command, an_argument)
		end;

	set_default_action_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when an item is selected 
			-- by pressing `RETURN' or double clicking it.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNdefaultActionCallback, a_command, an_argument)
		ensure
			command_set: command_set (default_action_command, a_command, an_argument)
		end;

	set_extended_selection_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when items are selected in
			-- extended mode.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNextendedSelectionCallback, a_command, an_argument)
		ensure
			command_set: command_set (extended_selection_command, a_command, an_argument)
		end;

	set_multiple_selection_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when items are selected in
			-- multiple mode.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNmultipleSelectionCallback, a_command, an_argument)
		ensure
			command_set: command_set (multiple_selection_command, a_command, an_argument)
		end;

	set_single_selection_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when items are selected in
			-- single selected mode.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNsingleSelectionCallback, a_command, an_argument)
		ensure
			command_set: command_set (single_selection_command, a_command, an_argument)
		end;

feature -- Removal

	delete_item (an_item: MEL_STRING) is
			-- Delete `an_item'.
		require
			exists: not is_destroyed;
			valid_item: an_item /= Void and then an_item.is_valid;
			an_item_already_present: item_exists (an_item)
		do
			xm_list_delete_item (screen_object, an_item.handle)
		end;

	delete_pos (a_position: INTEGER) is
			-- Delete item at `a_position'.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position > 0;
			a_position_small_enough: a_position <= item_count
		do
			xm_list_delete_pos (screen_object, a_position)
		end;

	delete_items (an_item_list: MEL_STRING_TABLE) is
			-- Delete all items of `an_item_list'.
		require
			exists: not is_destroyed;
			valid_list: an_item_list /= Void and then an_item_list.is_valid
		do
			xm_list_delete_items (screen_object, an_item_list.handle, an_item_list.count)
		end;

	delete_items_pos (an_item_count, a_position: INTEGER) is
			-- Delete `an_item_count' items starting at `a_position'.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position > 0;
			a_position_small_enough: a_position <= item_count;
			an_item_cont_large_enough: an_item_count > 0;
			an_item_cont_small_enough: an_item_count <= item_count - a_position
		do
			xm_list_delete_items_pos (screen_object, an_item_count, a_position)
		end;

	delete_all_items is
			-- Delete all items.
		require
			exists: not is_destroyed
		do
			xm_list_delete_all_items (screen_object)
		end;

	remove_browse_selection_callback is
			-- Remove the command for the selection callback.
		do
			remove_callback (XmNbrowseSelectionCallback)
		ensure
			removed: browse_selection_command = Void
		end;

	remove_default_action_callback is
			-- Remove the command for the default action callback.
		do
			remove_callback (XmNdefaultActionCallback)
		ensure
			removed: default_action_command = Void
		end;

	remove_extended_selection_callback is
			-- Remove the command for the extended selection callback.
		do
			remove_callback (XmNextendedSelectionCallback)
		ensure
			removed: extended_selection_command = Void
		end;

	remove_multiple_selection_callback is
			-- Remove the command for the multiple selection callback.
		do
			remove_callback (XmNmultipleSelectionCallback)
		ensure
			removed: multiple_selection_command = Void
		end;

	remove_single_selection_callback is
			-- Remove the command for the single selection callback.
		do
			remove_callback (XmNsingleSelectionCallback)
		ensure
			removed: single_selection_command = Void
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER; 
				resource_name: POINTER): MEL_LIST_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end

feature {NONE} -- Implementation

	xm_create_list (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/List.h>"
		alias
			"XmCreateList"
		end;

	xm_list_add_item (a_target: POINTER; an_item: POINTER; a_position: INTEGER) is
		external
			"C (Widget, XmString, int) | <Xm/List.h>"
		alias
			"XmListAddItem"
		end;

	xm_list_add_item_unselected (a_target: POINTER; an_item: POINTER; a_position: INTEGER) is
		external
			"C (Widget, XmString, int) | <Xm/List.h>"
		alias
			"XmListAddItemUnselected"
		end;

	xm_list_add_items (a_target: POINTER; an_item_list: POINTER; an_item_count: INTEGER; a_position: INTEGER) is
		external
			"C (Widget, XmStringTable, int, int) | <Xm/List.h>"
		alias
			"XmListAddItems"
		end;

	xm_list_add_items_unselected (a_target: POINTER; an_item_list: POINTER; an_item_count: INTEGER; a_position: INTEGER) is
		external
			"C (Widget, XmStringTable, int, int) | <Xm/List.h>"
		alias
			"XmListAddItemsUnselected"
		end;

	xm_list_item_exists (a_target: POINTER; an_item: POINTER): BOOLEAN is
		external
			"C (Widget, XmString): EIF_BOOLEAN | <Xm/List.h>"
		alias
			"XmListItemExists"
		end;

	xm_list_item_pos (a_target: POINTER; an_item: POINTER): INTEGER is
		external
			"C (Widget, XmString): EIF_INTEGER | <Xm/List.h>"
		alias
			"XmListItemPos"
		end;

	xm_list_replace_items_pos (a_target: POINTER; an_item_list: POINTER; an_item_count: INTEGER; a_position: INTEGER) is
		external
			"C (Widget, XmStringTable, int, int) | <Xm/List.h>"
		alias
			"XmListReplaceItemsPos"
		end;

	xm_list_replace_items_pos_unselected (a_target: POINTER; an_item_list: POINTER; an_item_count: INTEGER; a_position: INTEGER) is
		external
			"C (Widget, XmStringTable, int, int) | <Xm/List.h>"
		alias
			"XmListReplaceItemsPosUnselected"
		end;

	 xm_list_replace_items (a_target: POINTER; old_item_list: POINTER; an_item_count: INTEGER; new_item_list: POINTER) is
		external
			"C (Widget, XmStringTable, int, XmStringTable) | <Xm/List.h>"
		alias
			"XmListReplaceItems"
		end;

	 xm_list_replace_items_unselected (a_target: POINTER; old_item_list: POINTER; an_item_count: INTEGER; new_item_list: POINTER) is
		external
			"C (Widget, XmStringTable, int, XmStringTable) | <Xm/List.h>"
		alias
			"XmListReplaceItemsUnselected"
		end;

	xm_list_delete_item (a_target: POINTER; an_item: POINTER) is
		external
			"C (Widget, XmString) | <Xm/List.h>"
		alias
			"XmListDeleteItem"
		end;

	xm_list_delete_pos (a_target: POINTER; a_position: INTEGER) is
		external
			"C (Widget, int) | <Xm/List.h>"
		alias
			"XmListDeletePos"
		end;

	xm_list_delete_items (a_target: POINTER; an_item_list: POINTER; an_item_count: INTEGER) is
		external
			"C (Widget, XmStringTable, int) | <Xm/List.h>"
		alias
			"XmListDeleteItems"
		end;

	xm_list_delete_items_pos (a_target: POINTER; an_item_count: INTEGER; a_position: INTEGER) is
		external
			"C (Widget, int, int) | <Xm/List.h>"
		alias
			"XmListDeleteItemsPos"
		end;

	xm_list_delete_all_items (a_target: POINTER) is
		external
			"C (Widget) | <Xm/List.h>"
		alias
			"XmListDeleteAllItems"
		end;

	xm_list_select_item (a_target: POINTER; an_item: POINTER; notify: BOOLEAN) is
		external
			"C (Widget, XmString, Boolean) | <Xm/List.h>"
		alias
			"XmListSelectItem"
		end;

	xm_list_select_pos (a_target: POINTER; a_position: INTEGER; notify: BOOLEAN) is
		external
			"C (Widget, int, Boolean) | <Xm/List.h>"
		alias
			"XmListSelectPos"
		end;

	xm_list_deselect_item (a_target: POINTER; an_item: POINTER) is
		external
			"C (Widget, XmString) | <Xm/List.h>"
		alias
			"XmListDeselectItem"
		end;

	xm_list_deselect_pos (a_target: POINTER; a_position: INTEGER) is
		external
			"C (Widget, int) | <Xm/List.h>"
		alias
			"XmListDeselectPos"
		end;

	xm_list_deselect_all_items (a_target: POINTER) is
		external
			"C (Widget) | <Xm/List.h>"
		alias
			"XmListDeselectAllItems"
		end;

	xm_list_pos_selected (a_target: POINTER; a_position: INTEGER): BOOLEAN is
		external
			"C  (Widget, int): EIF_BOOLEAN | <Xm/List.h>"
		alias
			"XmListPosSelected"
		end;

	xm_list_set_pos (a_target: POINTER; a_position: INTEGER) is
		external
			"C (Widget, int) | <Xm/List.h>"
		alias
			"XmListSetPos"
		end;

	xm_list_set_bottom_pos (a_target: POINTER; a_position: INTEGER) is
		external
			"C (Widget, int) | <Xm/List.h>"
		alias
			"XmListSetBottomPos"
		end;

	xm_list_index_of (a_target, a_str: POINTER; a_position: INTEGER): INTEGER is
		external
			"C"
		end;

	xm_list_get_i_int_table (a_target: POINTER; a_position: INTEGER): INTEGER is
		external
			"C"
		end;

	xm_list_item_pos_from (a_target, a_string: POINTER; a_position: INTEGER): INTEGER is
		external
			"C"
		end;

	xm_list_get_selected_pos (a_target: POINTER): POINTER is
		external
			"C"
		end;

end -- class MEL_LIST


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

