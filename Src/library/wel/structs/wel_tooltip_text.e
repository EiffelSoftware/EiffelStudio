indexing
	description: "This structure identifies a tool for which text is to be %
		%displayed and receives the text for the tool. This structure %
		%is used with the Ttn_needtext notification message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TOOLTIP_TEXT

inherit
	WEL_STRUCTURE

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

creation
	make,
	make_by_nmhdr,
	make_by_pointer

feature {NONE} -- Initialization

	make_by_nmhdr (a_nmhdr: WEL_NMHDR) is
			-- Make the structure with `a_nmhdr'.
		require
			a_nmhdr_not_void: a_nmhdr /= Void
		do
			make_by_pointer (a_nmhdr.item)
		end

feature -- Access

	hdr: WEL_NMHDR is
			-- Information about the Wm_notify message.
		do
			create Result.make_by_pointer (cwel_tooltiptext_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	text: STRING is
			-- Text of the tooltip
		require
			text_id_not_set: not text_id_set
		do
			create Result.make (0)
			Result.from_c (cwel_tooltiptext_get_lpsztext (item))
		ensure
			result_not_void: Result /= Void
		end

	text_id: INTEGER is
			-- String resource identifier for the text
		require
			text_id_set: text_id_set
		do
			Result := cwin_lo_word (cwel_pointer_to_integer (
				cwel_tooltiptext_get_lpsztext (item)))
		end

	instance: WEL_INSTANCE is
			-- Instance that contains a string resource to be
			-- used as the text.
		do
			create Result.make (cwel_tooltiptext_get_hinst (item))
		end

	flags: INTEGER is
			-- Flag that indicates how to interpret `id_from'
			-- member of `hdr'.
			-- See class WEL_TTF_CONSTANTS for the different values.
		do
			Result := cwel_tooltiptext_get_uflags (item)
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		require
			text_not_void: a_text /= Void
		do
			create str_text.make (a_text)
			cwel_tooltiptext_set_lpsztext (item, str_text.item)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_text_id (an_id: INTEGER) is
			-- Set `text' with a string resource identifier `an_id'.
		do
			set_instance (main_args.current_instance)
			cwel_tooltiptext_set_lpsztext (item,
				cwin_make_int_resource (an_id))
		ensure
			text_id_set: text_id = an_id
		end

	set_instance (an_instance: WEL_INSTANCE) is
			-- Set `instance' with `an_instance'.
		require
			an_instance_not_void: an_instance /= Void
		do
			cwel_tooltiptext_set_hinst (item, an_instance.item)
		ensure
			instance_set: instance.item = an_instance.item
		end

	set_flags (a_flags: INTEGER) is
			-- Set `flags' with `a_flags'.
		require
			positive_flags: a_flags >= 0
		do
			cwel_tooltiptext_set_uflags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

feature -- Status report

	text_id_set: BOOLEAN is
			-- Is `text' equal to a resource string identifer?
		do
			Result := cwin_hi_word (cwel_pointer_to_integer (
				cwel_tooltiptext_get_lpsztext (item))) = 0
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tooltiptext
		end

feature {NONE} -- Implementation

	str_text: WEL_STRING
			-- C string to save `text'

	main_args: WEL_MAIN_ARGUMENTS is
			-- Main arguments of the application
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	c_size_of_tooltiptext: INTEGER is
		external
			"C [macro <tooltipt.h>]"
		alias
			"sizeof (TOOLTIPTEXT)"
		end

	cwin_make_int_resource (an_id: INTEGER): POINTER is
			-- SDK MAKEINTRESOURCE
		external
			"C [macro <wel.h>] (WORD): EIF_POINTER"
		alias
			"MAKEINTRESOURCE"
		end

	cwel_tooltiptext_set_lpsztext (ptr: POINTER; value: POINTER) is
		external
			"C [macro <tooltipt.h>]"
		end

	cwel_tooltiptext_set_hinst (ptr: POINTER; value: POINTER) is
		external
			"C [macro <tooltipt.h>]"
		end

	cwel_tooltiptext_set_uflags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tooltipt.h>]"
		end

	cwel_tooltiptext_get_lpsztext (ptr: POINTER): POINTER is
		external
			"C [macro <tooltipt.h>]"
		end

	cwel_tooltiptext_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro <tooltipt.h>] (TOOLTIPTEXT*): EIF_POINTER"
		end

	cwel_tooltiptext_get_hinst (ptr: POINTER): POINTER is
		external
			"C [macro <tooltipt.h>] (TOOLTIPTEXT*): EIF_POINTER"
		end

	cwel_tooltiptext_get_uflags (ptr: POINTER): INTEGER is
		external
			"C [macro <tooltipt.h>] (TOOLTIPTEXT*): EIF_POINTER"
		end

end -- class WEL_TOOLTIP_TEXT


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

