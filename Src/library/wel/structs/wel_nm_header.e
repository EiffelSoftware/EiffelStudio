indexing
	description: "Contains information about a header control notification%
		%message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_HEADER

inherit
	WEL_STRUCTURE

create
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
			create Result.make_by_pointer (cwel_nmheader_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	iitem: INTEGER is
			-- Zero-based index of the header item generating message.
		do
			Result := cwel_nmheader_get_iitem (item)
		end

	ibutton: INTEGER is
			-- Value of mouse button used to generate message.
		do
			Result := cwel_nmheader_get_ibutton (item)
		end

	hditem: WEL_HD_ITEM is
			-- `Result' is information about `iitem'.
		do
			create Result.make_by_pointer (cwel_nmheader_get_hditem (item))
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_header
		end

feature {NONE} -- Externals

	c_size_of_nm_header: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"sizeof (NMHEADER)"
		end

	cwel_nmheader_get_hdr (ptr: POINTER): POINTER is
		external
			"C [struct <commctrl.h>] (NMHEADER): EIF_POINTER"
		alias
			"&hdr"
		end

	cwel_nmheader_get_iitem (ptr: POINTER): INTEGER is
		external
			"C [struct <commctrl.h>] (NMHEADER): EIF_INTEGER"
		alias
			"iItem"
		end

	cwel_nmheader_get_ibutton (ptr: POINTER): INTEGER is
		external
			"C [struct <commctrl.h>] (NMHEADER): EIF_INTEGER"
		alias
			"iButton"
		end

	cwel_nmheader_get_hditem (ptr: POINTER): POINTER is
		external
			"C [struct <commctrl.h>] (NMHEADER): EIF_POINTER"
		alias
			"pitem"
		end

end -- class WEL_NM_HEADER

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
