indexing
	description: "Contains information about a combo-box-ex%
			% Cben_endedit notification message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_COMBO_BOX_EX_ENDEDIT

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
			create Result.make_by_pointer (cwel_nm_cbeendedit_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	has_changed: BOOLEAN is
			-- Value indicating whether the contents of the control's
			-- edit box have changed.
		do
			Result := cwel_nm_cbeendedit_get_fchanged (item) /= 0
		end

	selected_item: INTEGER is
			-- Zero-based index of the item that will be selected
			-- after completing the edit operation.
		do
			Result := cwel_nm_cbeendedit_get_inewselection (item)
		end

	text: STRING is
			-- Text from within the control's edit box.
		do
			create Result.make (0)
			Result.from_c (cwel_nm_cbeendedit_get_tchar (item))
		end

	why: INTEGER is
			-- Value that specifies the action that generated then
			-- Cben_endedit notification message.
			-- Can be any of the Cbenf_* constants.
			-- See class WEL_CBEN_CONSTANTS for values.
		do
			Result := cwel_nm_cbeendedit_get_iwhy (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_cbeendedit
		end

feature {NONE} -- Externals

	c_size_of_nm_cbeendedit: INTEGER is
		external
			"C [macro %"nmcbeendedit.h%"]"
		alias
			"sizeof (NMCBEENDEDIT)"
		end

	cwel_nm_cbeendedit_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro %"nmcbeendedit.h%"] (NMCBEENDEDIT*): EIF_POINTER"
		end

	cwel_nm_cbeendedit_get_fchanged (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmcbeendedit.h%"]"
		end

	cwel_nm_cbeendedit_get_inewselection (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmcbeendedit.h%"]"
		end

	cwel_nm_cbeendedit_get_tchar (ptr: POINTER): POINTER is
		external
			"C [macro %"nmcbeendedit.h%"] (NMCBEENDEDIT*): EIF_POINTER"
		end

	cwel_nm_cbeendedit_get_iwhy (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmcbeendedit.h%"]"
		end

end -- class WEL_NM_COMBO_BOX_EX_ENDEDIT


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

