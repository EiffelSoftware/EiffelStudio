indexing
	description: "Contains information about a combo-box-ex%
			% notification message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_COMBO_BOX_EX

inherit
	WEL_STRUCTURE

creation
	make,
	make_by_nmhdr,
	make_by_pointer

feature -- Initialization

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
			create Result.make_by_pointer (cwel_nm_comboboxex_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	comboboxex_item: WEL_COMBO_BOX_EX_ITEM is
			-- Information about the notification-specific action flag.
			-- See class WEL_TVAF_CONSTANTS for the meaning of this parameter.
		local
			combo: WEL_COMBO_BOX_EX
		do
			create Result.make_by_pointer (cwel_nm_comboboxex_get_ceitem (item))
			combo ?= hdr.window_from
			if combo /= Void then
				Result := combo.get_item_info (Result.index)
			end
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_comboboxex
		end

feature {NONE} -- Externals

	c_size_of_nm_comboboxex: INTEGER is
		external
			"C [macro %"nmcomboboxex.h%"]"
		alias
			"sizeof (NMCOMBOBOXEX)"
		end

	cwel_nm_comboboxex_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro %"nmcomboboxex.h%"] (NMCOMBOBOXEX*): EIF_POINTER"
		end

	cwel_nm_comboboxex_get_ceitem (ptr: POINTER): POINTER is
		external
			"C [macro %"nmcomboboxex.h%"] (NMCOMBOBOXEX*): EIF_POINTER"
		end

end -- class WEL_NM_COMBO_BOX_EX

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
