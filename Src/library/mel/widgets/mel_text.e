indexing

	description:
			"Text-editing widget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TEXT

inherit

	MEL_TEXT_RESOURCES
		export
			{NONE} all
		end;

	MEL_TEXT_FIELD
		redefine
			make
		end;

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif text widget
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_text (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		end;

feature -- Status report

	is_auto_show_cursor_position: BOOLEAN is
			-- Is the cursor always visible?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNautoShowCursorPosition)
		end;

	is_single_line_edit_mode: BOOLEAN is
			-- Is single line editing enabled?
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNeditMode) = XmSINGLE_LINE_EDIT
		end;

	is_multi_line_edit_mode: BOOLEAN is
			-- Is multi line editing enabled?
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNeditMode) = XmMULTI_LINE_EDIT
		end;

	source: MEL_TEXT_SOURCE is
			-- Text source
		require
			exists: not is_destroyed
		do
			!! Result.make_from_existing (xm_text_get_source (screen_object))
		ensure
			valid_text_source: Result /= Void and then not Result.is_destroyed
		end;

	top_character: INTEGER is
			-- Position of first displayed character
		require
			exists: not is_destroyed
		do
			Result := xm_text_get_top_character (screen_object)
		ensure
			top_character_large_enough: Result >=0
		end;

	is_height_resizable: BOOLEAN is
			-- Will all text always be shown (i.e. expand as the text grows
			-- instead of displaying a scroll bar)?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNresizeHeight)
		end;

	rows: INTEGER is
			-- Number of characters that should fit vertically
	   require
			exists: not is_destroyed
		do
			Result := get_xt_short (screen_object, XmNrows)
		ensure
			rows_large_enough: Result >= 0
		end;

	is_word_wrapped: BOOLEAN is
			-- Is word wrap enabled?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNwordWrap)
		end;

feature -- Status setting

	show_auto_cursor_position is
			-- Set `is_auto_show_cursor_position' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNautoShowCursorPosition, True)
		ensure
			auto_cursor_position_shown: is_auto_show_cursor_position
		end;

	hide_auto_show_cursor_position is
			-- Set `auto_show_cursor_position' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNautoShowCursorPosition, False)
		ensure
			auto_cursor_position_hidden: not is_auto_show_cursor_position
		end;

	set_single_line_edit_mode is
			-- Set `is_single_line_edit_mode' to True.
		require
			exists: not is_destroyed
		do
			set_xt_int (screen_object, XmNeditMode, XmSINGLE_LINE_EDIT)
		ensure
			is_single_line_edit_mode: is_single_line_edit_mode
		end;

	set_multi_line_edit_mode is
			-- Set `is_multi_line_edit_mode' to True.
		require
			exists: not is_destroyed
		do
			set_xt_int (screen_object, XmNeditMode, XmMULTI_LINE_EDIT)
		ensure
			is_multi_line_edit: is_multi_line_edit_mode
		end;

	set_top_character (a_position: INTEGER) is
			-- Set `top_character' to `a_position'.
		require
			exists: not is_destroyed;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= count
		do
			xm_text_set_top_character (screen_object, a_position)
		ensure
			top_character_set: top_character = a_position
		end;

	set_source (a_text_source: MEL_TEXT_SOURCE) is
			-- Set `source' to `a_text_source'.
		require
			exists: not is_destroyed;
			a_text_source_not_void: not a_text_source.is_destroyed
		do
		ensure
			text_source_set: source.is_equal (a_text_source)
		end;

	set_rows (a_height: INTEGER) is
			-- Set `rows' to `a_height'.
	   require
			exists: not is_destroyed;
			a_height_enough: a_height >= 0
		do
			set_xt_short (screen_object, XmNrows, a_height)
		ensure
			rows_set: rows = a_height
		end;

	enable_word_wrap is
			-- Set `word_wrap' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNwordWrap, True)
		ensure
			word_wrap_enabled: is_word_wrapped
		end;

	disable_work_wrap is
			-- Set `word_wrap' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNwordWrap, False)
		ensure
			word_wrap_disabled: is_word_wrapped
		end;

	enable_resize_height is
			-- Set `is_height_resizable' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNresizeHeight, True)
		ensure
			resize_height_enabled: is_height_resizable
		end;

	disable_resize_height is
			-- Set `is_height_resizable' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNresizeHeight, False)
		ensure
			resize_height_disabled: not is_height_resizable
		end;

	enable_redisplay is
			-- Allow visual update.
		require
			exists: not is_destroyed
		do
			xm_text_enable_redisplay (screen_object)
		end;

	disable_redisplay is
			-- Prevent visual update.
		require
			exists: not is_destroyed
		do
			xm_text_disable_redisplay (screen_object)
		end;

feature {NONE} -- Implementation

	xm_create_text (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/Text.h>"
		alias
			"XmCreateText"
		end;

	xm_text_enable_redisplay (w: POINTER) is
		external
			"C (Widget) | <Xm/Text.h>"
		alias
			"XmTextEnableRedisplay"
		end;

	xm_text_disable_redisplay (w: POINTER) is
		external
			"C (Widget) | <Xm/Text.h>"
		alias
			"XmTextDisableRedisplay"
		end;

	xm_text_get_top_character (w: POINTER): INTEGER is
		external
			"C (Widget): EIF_INTEGER | <Xm/Text.h>"
		alias
			"XmTextGetTopCharacter"
		end;

	xm_text_set_top_character (w: POINTER; char_pos: INTEGER) is
		external
			"C (Widget, XmTextPosition) | <Xm/Text.h>"
		alias
			"XmTextSetTopCharacter"
		end;

	xm_text_get_source (w: POINTER): POINTER is
		external
			"C (Widget): EIF_POINTER | <Xm/Text.h>"
		alias
			"XmTextGetSource"
		end;

	xm_text_set_source (w: POINTER; s: POINTER; top_c, cur_p: INTEGER) is
		external
			"C (Widget, XmTextSource, XmTextPosition, XmTextPosition) | <Xm/Text.h>"
		alias
			"XmTextSetSource"
		end;

end -- class MEL_TEXT

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
