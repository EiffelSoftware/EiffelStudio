indexing
	description: "[
		This structure identifies a change of selection in a WEL_RICH_EDIT control and is
		used with the En_selchange notification message. See also
		WEL_EN_SELCHANGE_CONSTANTS.
			]"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_SELCHANGE

inherit
	WEL_STRUCTURE

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

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

	selection_type: INTEGER is
			-- Type of selection, see WEL_EN_SELCHANGE_CONSTANTS for values.
		do
			Result := cwel_selchange_get_seltyp (item)
		end
		
	character_range: WEL_CHARACTER_RANGE is
			-- Lower and upper indexes of selection, equal when caret is displayed
			-- and no selection.
		do
			create Result.make_by_pointer (cwel_selchange_get_chrg (item))
		ensure
			Result_not_void: Result /= Void
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_edit_selchange
		end
		
feature {NONE} -- Implementation

	c_size_of_edit_selchange: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"sizeof (SELCHANGE)"
		end

	cwel_selchange_get_seltyp (ptr: POINTER): INTEGER is
		external
			"C struct SELCHANGE access seltyp use %"redit.h%""
		end
		
	cwel_selchange_get_chrg (ptr: POINTER): POINTER is
		external
			"C struct SELCHANGE access &chrg use %"redit.h%""
		end

end -- class WEL_RICH_EDIT_SELCHANGE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

