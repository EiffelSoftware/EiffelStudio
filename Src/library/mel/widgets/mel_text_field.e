indexing

	description:
			"Single line text-editing widget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MEL_TEXT_FIELD

inherit

	MEL_TEXT_FIELD_RESOURCES
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
			-- Create a motif text field.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_text_field (a_parent.screen_object, $widget_name, default_pointer, 0);
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

	count, last_position: INTEGER is
			-- Number of characters
		do
			Result :=  xm_text_get_last_position (screen_object)
		ensure 
			valid_result: Result >= 0
		end;

	is_selection_active: BOOLEAN is
			-- Is some portion selected?
		require 
			realized: realized
		do
			Result := xm_text_is_selection_active (screen_object)
		end;

	pos_to_x (char_pos: INTEGER): INTEGER is
			-- X coordinate relative to the upper left corner of position `char_pos'
		do
			Result := xm_text_x_coord (screen_object, char_pos)
		end;

	pos_to_y (char_pos: INTEGER): INTEGER is
			-- Y coordinate relative to the upper left corner of position `char_pos'
		do
			Result := xm_text_y_coord (screen_object, char_pos)
		end;

	xy_to_pos (x_coord, y_coord: INTEGER): INTEGER is
			-- Character position at position `x_coord', `y_coord'
		do
			Result := xm_text_xy_to_pos (screen_object, x_coord, y_coord)
		end;

feature -- Status report

	begin_of_selection: INTEGER is
			-- Start position of selection
		require
			selection_active: is_selection_active;
			realized: realized
		do
			Result := xm_text_get_begin_of_selection (screen_object)
		ensure 
			valid_result: Result >= 0 and then Result < count
		end;

	end_of_selection: INTEGER is
			-- End position of selection
		require
			selection_active: is_selection_active;
			realized: realized
		do
			Result := xm_text_get_end_of_selection (screen_object)
		ensure 
			valid_result: Result >= 0 and then Result < count
		end;

	blink_rate: INTEGER is
			-- Time in milliseconds that the cursor spends either being
			-- visible or invisible
			-- (A value of zero prevents the cursor from blinking.)
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNblinkRate)
		ensure
			blink_rate_large_enough: Result >=0
		end;

	columns: INTEGER is
			-- Number of characters that fit horizontally
	   require
			exists: not is_destroyed
		do
			Result := get_xt_short (screen_object, XmNcolumns)
		ensure
			columns_large_enough: Result >=0
		end;

	is_cursor_position_visible: BOOLEAN is
			-- Is the cursor visible?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNcursorPositionVisible)
		end;

	is_width_resizable: BOOLEAN is
			-- Will all text always be shown (i.e. expand as the text grows
			-- instead of displaying a scroll bar)?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNresizeWidth)
		end;

	string, value: STRING is
			-- Displayed string
		require
			exists: not is_destroyed
		local
			c_string: POINTER
		do
			c_string := xm_text_get_string (screen_object);
			!! Result.make (0);
			Result.from_c (c_string);
			Xt_Free (c_string)
		ensure
			string_not_void: Result /= Void
		end;

	cursor_position: INTEGER is
			-- Current position of the cursor
		require
			exists: not is_destroyed
		do
			Result := xm_text_get_insertion_position (screen_object)
		ensure
			cursor_position_large_enough: Result  >= 0;
			cursor_position_small_enough: Result <= count
		end;

	is_editable: BOOLEAN is
			-- Is Current editable?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNeditable)
		end;

	margin_height: INTEGER is
			-- Spacing between the top and bottom edges and the text
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginHeight)
		ensure
			margin_height_large_enough: Result >= 0
		end;

	margin_width: INTEGER is
			-- Spacing between the left and right edges of and the text
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginWidth)
		ensure
			margin_width_large_enough: Result >= 0
		end;

	max_length: INTEGER is
			-- Maximum length of the text string that the user can enter
			-- from the keyboard.
		require
			exists: not is_destroyed
		do
			Result := xm_text_get_max_length (screen_object)
		ensure
			max_length_large_enough: Result >= 0
		end;

	is_pending_delete: BOOLEAN is
			-- Is pending delete mode on?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNpendingDelete)
		end;

	selection_array_count: INTEGER is
			-- Number of items in the selection array
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNselectionArrayCount)
		ensure
			selection_array_count_large_enough: Result >=0
		end;

	select_threshold: INTEGER is
			-- Number of pixels the insertion cursor must be dragged
			-- during selection in order to select the next character
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNselectThreshold)
		ensure
			select_threshold_large_enough: Result >=0
		end;

	is_verify_bell_enabled: BOOLEAN is
			-- Will a bell sound when a verification produces no action?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNverifyBell)
		end;

feature -- Status setting

	set_blink_rate (a_rate: INTEGER) is
			-- Set `blink_rate' to `a_rate'.
		require
			exists: not is_destroyed;
			a_rate_large_enough: a_rate >= 0
		do
			set_xt_int (screen_object, XmNblinkRate, a_rate)
		ensure
			blink_rate_set: blink_rate = a_rate
		end;

	set_columns (a_width: INTEGER) is
			-- Set `columns' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_short (screen_object, XmNcolumns, a_width)
		ensure
			columns_set: columns = a_width
		end;

	set_cursor_position_visible is
			-- Set `is_cursor_position_visible' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNcursorPositionVisible, True)
		ensure
			cursor_is_visible: is_cursor_position_visible 
		end;

	set_cursor_position_invisible is
			-- Set `is_cursor_position_visible' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNcursorPositionVisible, False)
		ensure
			cursor_is_invisible: not is_cursor_position_visible 
		end;

	enable_resize_width is
			-- Set `is_width_resizable' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNresizeWidth, True)
		ensure
			resize_width_enabled: is_width_resizable
		end;

	disable_resize_width is
			-- Set `is_width_resizable' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNresizeWidth, False)
		ensure
			resize_width_disabled: not is_width_resizable
		end;

	set_string, set_value (a_string: STRING) is
			-- Set `string' and `value' to `a_string'.
		require
			exists: not is_destroyed;
			string_not_void: a_string /= Void
		local
			ext_name: ANY
		do
			ext_name := a_string.to_c;
			xm_text_set_string (screen_object, $ext_name)
		ensure
			string_set: string.is_equal (a_string);
			value_set: value.is_equal (a_string)
		end;

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position'.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= count
		do
			xm_text_set_insertion_position (screen_object, a_position)
		ensure
			a_position_set: cursor_position = a_position
		end;

	set_editable is
			-- Set `is_editable' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNeditable, True)
		ensure
			edition_allowed: is_editable 
		end;

	set_read_only is
			-- Set `is_editable' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNeditable, False)
		ensure
			read_only_text: not is_editable 
		end;

	set_margin_height (a_height: INTEGER) is
			-- Set `margin_height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNmarginHeight, a_height)
		ensure
			margin_height_set: margin_height = a_height
		end;

	set_margin_width (a_width: INTEGER) is
			-- Set `margin_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNmarginWidth, a_width)
		ensure
			margin_width_set: margin_width = a_width
		end;

	set_max_length (a_length: INTEGER) is
			-- Set `max_length' to `a_length'.
		require
			exists: not is_destroyed;
			a_length_large_enough: a_length >= 0
		do
			xm_text_set_max_length (screen_object, a_length)
		ensure
			max_length_set: max_length = a_length
		end;

	set_pending_delete_on is
			-- Set `is_pending_delete' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNpendingDelete, True)
		ensure
			pending_delete_switched_on: is_pending_delete 
		end;

	set_pending_delete_off is
			-- Set `is_pending_delete' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNpendingDelete, False)
		ensure
			pending_delete_switched_off: not is_pending_delete 
		end;

	set_selection (first, last: INTEGER; time: INTEGER) is
			-- Select the text between `first' and `last' with time `time'
			-- of the event that caused the event.
		require
			exists: not is_destroyed;
			first_positive_not_null: first >= 0;
			last_fewer_than_count: last <= count;
			first_fewer_than_last: first <= last;
			realized: realized
		do
			xm_text_set_selection (screen_object, first, last, time)
		ensure
			is_selection_active: is_selection_active;
			correctly_set: begin_of_selection = first and then
					end_of_selection = last
		end;

	set_selection_with_current_time (first, last: INTEGER) is
			-- Select the text between `first' and `last' at `Current_time'.
		require
			exists: not is_destroyed;
			first_positive_not_null: first >= 0;
			last_fewer_than_count: last <= count;
			first_fewer_than_last: first <= last;
			realized: realized
		do
			xm_text_set_selection (screen_object, first, last, current_time)
		ensure
			is_selection_active: is_selection_active;
			correctly_set: begin_of_selection = first and then
					end_of_selection = last
		end;

	set_selection_array_count (a_count: INTEGER) is
			-- Set `selection_array_count' to `a_count'.
		require
			exists: not is_destroyed;
			a_count_large_enough: a_count >= 0
		do
			set_xt_int (screen_object, XmNselectionArrayCount, a_count)
		ensure
			selection_array_count_set: selection_array_count = a_count
		end;

	set_select_threshold (a_threshold: INTEGER) is
			-- Set `select_threshold' to `a_threshold'.
		require
			exists: not is_destroyed;
			a_threshold_large_enough: a_threshold >= 0
		do
			set_xt_int (screen_object, XmNselectThreshold, a_threshold)
		ensure
			select_threshold_set: select_threshold = a_threshold
		end;

	enable_verify_bell is
			-- Set `is_verify_bell_enabled' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNverifyBell, True)
		ensure
			verify_bell_enabled: is_verify_bell_enabled 
		end;

	disable_verify_bell is
			-- Set `is_verify_bell_enabled' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNverifyBell, False)
		ensure
			verify_bell_disabled: not is_verify_bell_enabled 
		end;

feature -- Element change

	add_activate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the user causes the text field
			-- widget to be activated.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNactivateCallback, a_callback, an_argument)
		end;

	add_focus_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the text widget receives
			-- the focus.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNfocusCallback, a_callback, an_argument)
		end;

	add_gain_primary_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the text widget gains
			-- ownership of the primary selection.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNgainPrimaryCallback, a_callback, an_argument)
		end;

	add_lose_primary_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the text widget loses
			-- ownership of the primary selection.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNlosePrimaryCallback, a_callback, an_argument)
		end;

	add_losing_focus_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the text widget loses
			-- the focus.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNlosingFocusCallback, a_callback, an_argument)
		end;

	add_modify_verify_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called before the value of the text field
			-- widget is changed.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNmodifyVerifyCallback, a_callback, an_argument)
		end;

	add_modify_verify_callback_wcs (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called before the value of the text field
			-- widget is changed.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNmodifyVerifyCallbackWcs, a_callback, an_argument)
		end;

	add_motion_verify_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called before the insertion cursor is moved
			-- in the text widget.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNmotionVerifyCallback, a_callback, an_argument)
		end;

	add_value_changed_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called after the value of the text field
			-- widget is changed.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNvalueChangedCallback, a_callback, an_argument)
		end;

	append (a_text: STRING) is
			-- Append `a_text' at the end of `string'.
		require 
			non_void_text: a_text /= Void
		do
			insert (count, a_text);
		ensure
			count_incremented: count = old count + a_text.count;
		end;

	cut_text (a_time: INTEGER) is
			-- Copy the primary selected text to the clipboard
			-- and then remove the selection.
		require
			exists: not is_destroyed
		do
			xm_text_cut (screen_object, a_time)
		end;

	copy_text (a_time: INTEGER) is
			-- Copy the primary selected text into the clipboard.
		require
			exists: not is_destroyed
		do
			xm_text_copy (screen_object, a_time)
		end;

	paste_text  is
			-- Insert the clipboard selection text at the current cursor position.
		require
			exists: not is_destroyed
		do
			xm_text_paste (screen_object)
		end;

	insert (a_position: INTEGER; a_text: STRING) is
			-- Insert `a_text' at `a_position'.
		require 
			exists: not is_destroyed;
			non_void_text: a_text /= Void
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= count
		local
			ext_name: ANY
		do
			ext_name := a_text.to_c;
			xm_text_insert (screen_object, a_position, $ext_name)
		ensure 
			count_incremented: count = (old count) + a_text.count;
			valid_count: a_text.count > 0 implies 
				a_text.is_equal (value.substring (a_position+1, a_position + a_text.count))
		end;

	replace (from_position, to_position: INTEGER; a_text: STRING) is
			-- Replace text from `from_position' to `to_position' by `a_text'.
			-- `from_position' indicates the character position in the
			-- string starting from 0. `to_position' indicates the
			-- last character position to replace.
		require
			exists: not is_destroyed;
			not_text_void: a_text /= Void;
			from_position_smaller_than_to_position: from_position <= to_position;
			from_position_large_enough: from_position >= 0;
			to_position_small_enough: to_position <= count
		local
			ext_name: ANY
		do
			ext_name := a_text.to_c;
			xm_text_replace (screen_object, from_position, to_position, $ext_name)
		ensure
			count_incremented: count = ((old count) + 
					a_text.count + from_position - to_position);
			valid_count: a_text.count > 0 implies a_text.is_equal
				(value.substring (from_position+1, from_position + a_text.count))
		end;

feature -- Removal

	remove_activate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the user causes the text field
			-- widget to be activated.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNactivateCallback, a_callback, an_argument)
		end;

	remove_focus_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the text widget receives
			-- the focus.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNfocusCallback, a_callback, an_argument)
		end;

	remove_gain_primary_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the text widget gains
			-- ownership of the primary selection.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNgainPrimaryCallback, a_callback, an_argument)
		end;

	remove_lose_primary_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the text widget loses
			-- ownership of the primary selection.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNlosePrimaryCallback, a_callback, an_argument)
		end;

	remove_losing_focus_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the text widget loses
			-- the focus.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNlosingFocusCallback, a_callback, an_argument)
		end;

	remove_modify_verify_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called before the value of the text field
			-- widget is changed.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNmodifyVerifyCallback, a_callback, an_argument)
		end;

	remove_modify_verify_callback_wcs (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called before the value of the text field
			-- widget is changed.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNmodifyVerifyCallbackWcs, a_callback, an_argument)
		end;

	remove_motion_verify_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called before the insertion cursor is moved
			-- in the text widget.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNmotionVerifyCallback, a_callback, an_argument)
		end;

	remove_value_changed_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called after the value of the text field
			-- widget is changed.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNvalueChangedCallback, a_callback, an_argument)
		end;

	clear is
			-- Clear text.
		do
			set_string ("")
		ensure
			cleared: string.empty
		end;

	clear_selection (time: INTEGER) is
			-- Clear text with time of the event `time' that caused the request.
		require
			realized: realized
			selection_active: is_selection_active
		do
			xm_text_clear_selection (screen_object, time)
		ensure
			not_selection_active: not is_selection_active
		end;

	clear_selection_with_current_time is
			-- Clear text using `Current_time'.
		require
			realized: realized
			selection_active: is_selection_active;
		do
			xm_text_clear_selection (screen_object, current_time)
		ensure
			not_selection_active: not is_selection_active
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER
				resource_name: POINTER): MEL_ANY_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			if resource_name = XmNlosingFocusCallback or
				resource_name = XmNmodifyVerifyCallback or
				resource_name = XmNmotionVerifyCallback
			then
				!MEL_TEXT_VERIFY_CALLBACK_STRUCT! Result.make (Current, a_callback_struct_ptr)
			else
				if resource_name = XmNmodifyVerifycallbackWcs then
					!MEL_TEXT_VERIFY_CALLBACK_STRUCT_WCS! Result.make (Current, a_callback_struct_ptr)
				else
					!! Result.make (Current, a_callback_struct_ptr)
				end
			end
		end;

feature {NONE} -- Implementation

	xm_create_text_field (w, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/TextF.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateTextField"
		end;

	xm_text_set_string (w: POINTER; a_string: POINTER) is
		external
			"C [macro <Xm/Text.h>] (Widget, char *)"
		alias
			"XmTextSetString"
		end;

	xm_text_get_string (w: POINTER): POINTER is
			-- Returns pointer to C string (need to free it)
		external
			"C [macro <Xm/Text.h>] (Widget): EIF_POINTER"
		alias
			"XmTextGetString"
		end;

	xm_text_cut (w: POINTER; a_time: INTEGER) is
			-- Copy the primary selection to the clipboard
			-- and remove the selected text.
		external
			"C [macro <Xm/Text.h>] (Widget, Time)"
		alias
			"XmTextCut"
		end;

	xm_text_copy (w: POINTER; a_time: INTEGER) is
			-- Copy the primary selection to the clipboard.
		external
			"C [macro <Xm/Text.h>] (Widget, Time)"
		alias
			"XmTextCopy"
		end;

	xm_text_paste (w: POINTER) is
			-- Insert the clipboard selection.
		external
			"C [macro <Xm/Text.h>] (Widget)"
		alias
			"XmTextPaste"
		end;

	xm_text_insert (w: POINTER; a_pos: INTEGER; a_text: POINTER) is
		external
			"C [macro <Xm/Text.h>] (Widget, XmTextPosition, char *)"
		alias
			"XmTextInsert"
		end;

	xm_text_replace (w: POINTER; spos, epos: INTEGER; a_text: POINTER) is
		external
			"C [macro <Xm/Text.h>] (Widget, XmTextPosition, XmTextPosition, char *)"
		alias
			"XmTextReplace"
		end;

	xm_text_get_insertion_position (w: POINTER): INTEGER is
		external
			"C [macro <Xm/Text.h>] (Widget): EIF_INTEGER"
		alias
			"XmTextGetInsertionPosition"
		end;

	xm_text_set_insertion_position (w: POINTER; pos: INTEGER) is
		external
			"C [macro <Xm/Text.h>] (Widget, XmTextPosition)"
		alias
			"XmTextSetInsertionPosition"
		end;

	xm_text_get_begin_of_selection (w: POINTER): INTEGER is
		external
			"C"
		alias
			"xm_text_get_begin_of_selection"
		end;

	xm_text_get_end_of_selection (w: POINTER): INTEGER is
		external
			"C"
		alias
			"xm_text_get_end_of_selection"
		end;

	xm_text_is_selection_active (w: POINTER): BOOLEAN is
		external
			"C"
		end;

	xm_text_set_selection (w: POINTER; spos, epos, time: INTEGER) is
		external
			"C [macro <Xm/Text.h>] (Widget, XmTextPosition, XmTextPosition, Time)"
		alias
			"XmTextSetSelection"
		end;

	xm_text_clear_selection (w: POINTER; time: INTEGER) is
		external
			"C [macro <Xm/Text.h>] (Widget, Time)"
		alias
			"XmTextClearSelection"
		end;

	xm_text_get_max_length (w: POINTER): INTEGER is
		external
			"C [macro <Xm/Text.h>] (Widget): EIF_INTEGER"
		alias
			"XmTextGetMaxLength"
		end;

	xm_text_set_max_length (w: POINTER; a_len: INTEGER) is
		external
			"C [macro <Xm/Text.h>] (Widget, int)"
		alias
			"XmTextSetMaxLength"
		end;

	xm_text_xy_to_pos (w: POINTER; x0, y0: INTEGER): INTEGER is
		external
			"C [macro <Xm/Text.h>] (Widget, Position, Position): EIF_INTEGER"
		alias
			"XmTextXYToPos"
		end;

	xm_text_get_last_position (w: POINTER): INTEGER is
		external
			"C [macro <Xm/Text.h>] (Widget): EIF_INTEGER"
		alias
			"XmTextGetLastPosition"
		end;

	xm_text_x_coord (w: POINTER; char_p: INTEGER): INTEGER is
		external
			"C"
		end;

	xm_text_y_coord (w: POINTER; char_p: INTEGER): INTEGER is
		external
			"C"
		end;

end -- class MEL_TEXT_FIELD

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
