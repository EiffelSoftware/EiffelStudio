indexing
	description: "Contains information about a toolbar notification %
		%message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_TOOL_BAR

inherit
	WEL_STRUCTURE

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
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_nmtoolbar_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	button_id: INTEGER is
			-- Information about the command identifier of the
			-- button associated with the notification.
		require
			exists: exists
		do
			Result := cwel_nmtoolbar_get_iitem (item)
		end

	button: WEL_TOOL_BAR_BUTTON is
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

	text: STRING is
			-- Text of the button associated with the notification.
		require
			exists: exists
		do
			create Result.make (0)
			Result.from_c (cwel_nmtoolbar_get_psztext (item))
		end

	text_count: INTEGER is
			-- Count of characters in the button text.
		require
			exists: exists
		do
			Result := cwel_nmtoolbar_get_cchtext (item)
		ensure
			positive_result: Result >= 0
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nmtoolbar
		end

feature {NONE} -- Externals

	c_size_of_nmtoolbar: INTEGER is
		external
			"C [macro %"nmtb.h%"]"
		alias
			"sizeof (NMTOOLBAR)"
		end

	cwel_nmtoolbar_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro %"nmtb.h%"] (NMTOOLBAR*): EIF_POINTER"
		end

	cwel_nmtoolbar_get_iitem (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmtb.h%"]"
		end

	cwel_nmtoolbar_get_tbbutton (ptr: POINTER): POINTER is
		external
			"C [macro %"nmtb.h%"] (NMTOOLBAR*): EIF_POINTER"
		end

	cwel_nmtoolbar_get_cchtext (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmtb.h%"]"
		end

	cwel_nmtoolbar_get_psztext (ptr: POINTER): POINTER is
		external
			"C [macro %"nmtb.h%"] (NMTOOLBAR*): EIF_POINTER"
		end

end -- class WEL_NM_TOOL_BAR


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

