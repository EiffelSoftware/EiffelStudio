indexing
	description: "Contains information about a tool in a tooltip control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TOOL_INFO

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make a tool info structure.
		do
			structure_make
			cwel_toolinfo_set_cbsize (item, structure_size)
			set_instance (main_args.current_instance)
		end

feature -- Access

	flags: INTEGER is
			-- A set of bit flags. See class WEL_TTF_CONSTANTS
			-- for values.
		do
			Result := cwel_toolinfo_get_uflags (item)
		end

	window: WEL_WINDOW is
			-- Window that contains the tool
		do
			Result := window_manager.window_of_item (cwel_toolinfo_get_hwnd (item))
		end

	id: INTEGER is
			-- Application-defined identifier of the tool
		do
			Result := cwel_toolinfo_get_uid (item)
		end

	rect: WEL_RECT is
			-- Coordinates of the bounding rectangle of the tool
		do
			create Result.make_by_pointer (cwel_toolinfo_get_rect (item))
		ensure
			result_not_void: Result /= Void
		end

	instance: WEL_INSTANCE is
			-- Instance that contains the string resource for the
			-- tool. If `text' specifies the identifier of a string
			-- resource, this information is used.
		do
			create Result.make (cwel_toolinfo_get_hinst (item))
		ensure
			result_not_void: Result /= Void
		end

	text: STRING is
			-- Text for the tool
		require
			text_id_not_set: not text_id_set
		do
			create Result.make_from_c (cwel_toolinfo_get_lpsztext (item))
		ensure
			result_not_void: Result /= Void
		end

	text_id: INTEGER is
			-- String resource identifier for the text
		require
			text_id_set: text_id_set
		do
			Result := cwin_lo_word (cwel_pointer_to_integer (
				cwel_toolinfo_get_lpsztext (item)))
		end

feature -- Status report

	text_call_back_set: BOOLEAN is
			-- Is `text' equal to `Lpstr_textcallback'?
		do
			Result := cwel_toolinfo_get_lpsztext (item) =
				Lpstr_textcallback
		end

	text_id_set: BOOLEAN is
			-- Is `text' equal to a resource string identifer?
		do
			Result := cwin_hi_word (cwel_pointer_to_integer (
				cwel_toolinfo_get_lpsztext (item))) = 0
		end

feature -- Element change

	set_flags (a_flags: INTEGER) is
			-- Set `flags' with `a_flags'.
		do
			cwel_toolinfo_set_uflags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	set_window (a_window: WEL_WINDOW) is
			-- Set `window' with `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			cwel_toolinfo_set_hwnd (item, a_window.item)
		ensure
			window_set: window = a_window
		end

	set_id_with_window (a_window: WEL_WINDOW) is
			-- Set `id' with `a_window'.
		do
			cwel_toolinfo_set_uid (item, cwel_pointer_to_integer (a_window.item))
		ensure
			id_set: id = cwel_pointer_to_integer (a_window.item)
		end

	set_id (an_id: INTEGER) is
			-- Set `id' with `an_id'.
		do
			cwel_toolinfo_set_uid (item, an_id)
		ensure
			id_set: id = an_id
		end

	set_rect (a_rect: WEL_RECT) is
			-- Set `rect' with `a_rect'.
		require
			a_rect_not_void: a_rect /= Void
		do
			cwel_toolinfo_set_rect (item, a_rect.item)
		ensure
			rect_set: rect.is_equal (a_rect)
		end

	set_instance (an_instance: WEL_INSTANCE) is
			-- Set `instance' with `an_instance'.
		require
			an_instance_not_void: an_instance /= Void
		do
			cwel_toolinfo_set_hinst (item, an_instance.item)
		ensure
			instance_set: instance.item = an_instance.item
		end

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			create str_text.make (a_text)
			cwel_toolinfo_set_lpsztext (item, str_text.item)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_text_id (an_id: INTEGER) is
			-- Set `text' with a string resource identifier `an_id'.
		do
			cwel_toolinfo_set_lpsztext (item,
				cwin_make_int_resource (an_id))
		ensure
			text_id_set: text_id = an_id
		end

	set_text_call_back is
			-- Set `text' with `Lpstr_textcallback'.
		do
			cwel_toolinfo_set_lpsztext (item, Lpstr_textcallback)
		ensure
			text_call_back_set: text_call_back_set
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_toolinfo
		end

feature {NONE} -- Implementation

	str_text: WEL_STRING
			-- C string to save `text'

	window_manager: WEL_WINDOW_MANAGER is
			-- Window manager used by `window'
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	main_args: WEL_MAIN_ARGUMENTS is
			-- Main arguments of the application used by `instance'
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	c_size_of_toolinfo: INTEGER is
		external
			"C [macro <toolinfo.h>]"
		alias
			"sizeof (TOOLINFO)"
		end

	cwel_toolinfo_set_cbsize (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_uflags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_hwnd (ptr: POINTER; value: POINTER) is
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_uid (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_rect (ptr: POINTER; value: POINTER) is
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_hinst (ptr: POINTER; value: POINTER) is
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_lpsztext (ptr: POINTER; value: POINTER) is
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_get_uflags (ptr: POINTER): INTEGER is
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_get_hwnd (ptr: POINTER): POINTER is
		external
			"C [macro <toolinfo.h>] (TOOLINFO*): EIF_POINTER"
		end

	cwel_toolinfo_get_uid (ptr: POINTER): INTEGER is
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_get_rect (ptr: POINTER): POINTER is
		external
			"C [macro <toolinfo.h>] (TOOLINFO*): EIF_POINTER"
		end

	cwel_toolinfo_get_hinst (ptr: POINTER): POINTER is
		external
			"C [macro <toolinfo.h>] (TOOLINFO*): EIF_POINTER"
		end

	cwel_toolinfo_get_lpsztext (ptr: POINTER): POINTER is
		external
			"C [macro <toolinfo.h>] (TOOLINFO*): EIF_POINTER"
		end

	Lpstr_textcallback: POINTER is
		external
			"C [macro <toolinfo.h>] : EIF_POINTER"
		alias
			"LPSTR_TEXTCALLBACK"
		end

	cwin_make_int_resource (an_id: INTEGER): POINTER is
			-- SDK MAKEINTRESOURCE
		external
			"C [macro <wel.h>] (WORD): EIF_POINTER"
		alias
			"MAKEINTRESOURCE"
		end

end -- class WEL_TOOL_INFO

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

