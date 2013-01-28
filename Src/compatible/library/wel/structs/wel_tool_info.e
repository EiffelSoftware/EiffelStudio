note
	description: "Contains information about a tool in a tooltip control."
	legal: "See notice at end of class."
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
		undefine
			copy, is_equal
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Make a tool info structure.
		do
			structure_make
			cwel_toolinfo_set_cbsize (item, structure_size)
			set_instance (main_args.resource_instance)
		end

feature -- Access

	flags: INTEGER
			-- A set of bit flags. See class WEL_TTF_CONSTANTS
			-- for values.
		do
			Result := cwel_toolinfo_get_uflags (item)
		end

	window: detachable WEL_WINDOW
			-- Window that contains the tool
		do
			Result := window_of_item (cwel_toolinfo_get_hwnd (item))
		end

	id: POINTER
			-- Application-defined identifier of the tool
		do
			Result := cwel_toolinfo_get_uid (item)
		end

	rect: WEL_RECT
			-- Coordinates of the bounding rectangle of the tool
		do
			create Result.make_by_pointer (cwel_toolinfo_get_rect (item))
		ensure
			result_not_void: Result /= Void
		end

	instance: WEL_INSTANCE
			-- Instance that contains the string resource for the
			-- tool. If `text' specifies the identifier of a string
			-- resource, this information is used.
		do
			create Result.make (cwel_toolinfo_get_hinst (item))
		ensure
			result_not_void: Result /= Void
		end

	text: STRING_32
			-- Text for the tool
		require
			text_id_not_set: not text_id_set
		local
			l_text: like str_text
		do
			l_text := str_text
			if l_text /= Void then
				Result := l_text.string
			else
				create Result.make_empty
			end
		ensure
			result_not_void: Result /= Void
		end

	text_id: INTEGER
			-- String resource identifier for the text
		require
			text_id_set: text_id_set
		do
			Result := cwin_lo_word (cwel_toolinfo_get_lpsztext (item))
		end

feature -- Status report

	text_call_back_set: BOOLEAN
			-- Is `text' equal to `Lpstr_textcallback'?
		do
			Result := cwel_toolinfo_get_lpsztext (item) =
				Lpstr_textcallback
		end

	text_id_set: BOOLEAN
			-- Is `text' equal to a resource string identifier?
		do
			Result := cwin_hi_word (cwel_toolinfo_get_lpsztext (item)) = 0
		end

feature -- Element change

	set_flags (a_flags: INTEGER)
			-- Set `flags' with `a_flags'.
		do
			cwel_toolinfo_set_uflags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	set_window (a_window: WEL_WINDOW)
			-- Set `window' with `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			cwel_toolinfo_set_hwnd (item, a_window.item)
		ensure
			window_set: window = a_window
		end

	set_id_with_window (a_window: WEL_WINDOW)
			-- Set `id' with `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			cwel_toolinfo_set_uid (item, a_window.item)
		ensure
			id_set: id = a_window.item
		end

	set_id (an_id: POINTER)
			-- Set `id' with `an_id'.
		do
			cwel_toolinfo_set_uid (item, an_id)
		ensure
			id_set: id = an_id
		end

	set_rect (a_rect: WEL_RECT)
			-- Set `rect' with `a_rect'.
		require
			a_rect_not_void: a_rect /= Void
			a_rect_exists: a_rect.exists
		do
			cwel_toolinfo_set_rect (item, a_rect.item)
		ensure
			rect_set: rect.is_equal (a_rect)
		end

	set_instance (an_instance: WEL_INSTANCE)
			-- Set `instance' with `an_instance'.
		require
			an_instance_not_void: an_instance /= Void
			an_instance_exists: an_instance.exists
		do
			cwel_toolinfo_set_hinst (item, an_instance.item)
		ensure
			instance_set: instance.item = an_instance.item
		end

	set_text (a_text: STRING_GENERAL)
			-- Set `text' with `a_text'.
		require
			a_text_not_void: a_text /= Void
		local
			l_text: like str_text
		do
			create l_text.make (a_text)
				-- For GC reference
			str_text := l_text
			cwel_toolinfo_set_lpsztext (item, l_text.item)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_text_id (an_id: INTEGER)
			-- Set `text' with a string resource identifier `an_id'.
		do
			cwel_toolinfo_set_lpsztext (item,
				cwin_make_int_resource (an_id))
		ensure
			text_id_set: text_id = an_id
		end

	set_text_call_back
			-- Set `text' with `Lpstr_textcallback'.
		do
			cwel_toolinfo_set_lpsztext (item, Lpstr_textcallback)
		ensure
			text_call_back_set: text_call_back_set
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_toolinfo
		end

feature {NONE} -- Implementation

	str_text: detachable WEL_STRING
			-- C string to save `text'

	main_args: WEL_MAIN_ARGUMENTS
			-- Main arguments of the application used by `instance'
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	c_size_of_toolinfo: INTEGER
		external
			"C [macro <toolinfo.h>]"
		alias
			"sizeof (TOOLINFO)"
		end

	cwel_toolinfo_set_cbsize (ptr: POINTER; value: INTEGER)
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_uflags (ptr: POINTER; value: INTEGER)
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_hwnd (ptr: POINTER; value: POINTER)
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_uid (ptr: POINTER; value: POINTER)
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_rect (ptr: POINTER; value: POINTER)
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_hinst (ptr: POINTER; value: POINTER)
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_set_lpsztext (ptr: POINTER; value: POINTER)
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_get_uflags (ptr: POINTER): INTEGER
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_get_hwnd (ptr: POINTER): POINTER
		external
			"C [macro <toolinfo.h>] (TOOLINFO*): EIF_POINTER"
		end

	cwel_toolinfo_get_uid (ptr: POINTER): POINTER
		external
			"C [macro <toolinfo.h>]"
		end

	cwel_toolinfo_get_rect (ptr: POINTER): POINTER
		external
			"C [macro <toolinfo.h>] (TOOLINFO*): EIF_POINTER"
		end

	cwel_toolinfo_get_hinst (ptr: POINTER): POINTER
		external
			"C [macro <toolinfo.h>] (TOOLINFO*): EIF_POINTER"
		end

	cwel_toolinfo_get_lpsztext (ptr: POINTER): POINTER
		external
			"C [macro <toolinfo.h>] (TOOLINFO*): EIF_POINTER"
		end

	Lpstr_textcallback: POINTER
		external
			"C [macro <toolinfo.h>] : EIF_POINTER"
		alias
			"LPSTR_TEXTCALLBACK"
		end

	cwin_make_int_resource (an_id: INTEGER): POINTER
			-- SDK MAKEINTRESOURCE
		external
			"C [macro <wel.h>] (WORD): EIF_POINTER"
		alias
			"MAKEINTRESOURCE"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
