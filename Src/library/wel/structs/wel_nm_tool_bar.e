note
	description: "Contains information about a toolbar notification %
		%message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_TOOL_BAR

inherit
	WEL_STRUCTURE

create
	make,
	make_by_nmhdr,
	make_by_pointer

feature {NONE} -- Initialization

	make_by_nmhdr (a_nmhdr: WEL_NMHDR)
			-- Make the structure with `a_nmhdr'.
		require
			a_nmhdr_not_void: a_nmhdr /= Void
		do
			make_by_pointer (a_nmhdr.item)
		end

feature -- Access

	hdr: WEL_NMHDR
			-- Information about the Wm_notify message.
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_nmtoolbar_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	button_id: INTEGER
			-- Information about the command identifier of the
			-- button associated with the notification.
		require
			exists: exists
		do
			Result := cwel_nmtoolbar_get_iitem (item)
		end

	button: WEL_TOOL_BAR_BUTTON
			-- Button associated with the notification. This
			-- member contains valid informations only with the
			-- Tbn_queryinsert and Tbn_querydelete notification
			-- messages.
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_nmtoolbar_get_tbbutton (item))
		ensure
			result_not_void: Result /= Void
		end

	text: STRING_32
			-- Text of the button associated with the notification.
		require
			exists: exists
		do
				-- Fixme: this routine is useless without a `set_text' counterpart.
			create Result.make_empty
		end

	text_count: INTEGER
			-- Count of characters in the button text.
		require
			exists: exists
		do
			Result := cwel_nmtoolbar_get_cchtext (item)
		ensure
			positive_result: Result >= 0
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nmtoolbar
		end

feature {NONE} -- Externals

	c_size_of_nmtoolbar: INTEGER
		external
			"C [macro %"nmtb.h%"]"
		alias
			"sizeof (NMTOOLBAR)"
		end

	cwel_nmtoolbar_get_hdr (ptr: POINTER): POINTER
		external
			"C [macro %"nmtb.h%"] (NMTOOLBAR*): EIF_POINTER"
		end

	cwel_nmtoolbar_get_iitem (ptr: POINTER): INTEGER
		external
			"C [macro %"nmtb.h%"]"
		end

	cwel_nmtoolbar_get_tbbutton (ptr: POINTER): POINTER
		external
			"C [macro %"nmtb.h%"] (NMTOOLBAR*): EIF_POINTER"
		end

	cwel_nmtoolbar_get_cchtext (ptr: POINTER): INTEGER
		external
			"C [macro %"nmtb.h%"]"
		end

	cwel_nmtoolbar_get_psztext (ptr: POINTER): POINTER
		external
			"C [macro %"nmtb.h%"] (NMTOOLBAR*): EIF_POINTER"
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
