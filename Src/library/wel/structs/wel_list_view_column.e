indexing
	description: "Contains information about a list view control%
				% column."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LIST_VIEW_COLUMN

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_LVCF_CONSTANTS

creation
	make,
	make_by_pointer,
	make_with_attributes

feature -- Initialization

	make is
			-- Make a list view column structure
		do
			structure_make
			set_mask (Lvcf_fmt + Lvcf_width + Lvcf_text)
		end

	make_with_attributes (a_mask, a_cx, a_fmt: INTEGER; a_text: STRING) is
			-- Make a list view column structure with the given
			-- attributes.
		do
			structure_make
			set_mask (a_mask)
			set_cx (a_cx)
			set_fmt (a_fmt)
			set_text (a_text)
		end

feature -- Access

	mask: INTEGER is
			-- Array of flags that indicate which of the other
			-- structure members contain valid data or which are
			-- to be filled in. This member can be a combination
			-- of the Lvcf_* values.
			-- See class WEL_LVCF_CONSTANTS.
		do
			Result := cwel_lv_column_get_mask (item)
		end

	text: STRING is
			-- Title of the column
		do
			!! Result.make (0)
			Result.from_c (cwel_lv_column_get_psztext (item))
		ensure
			result_not_void: Result /= Void
		end

	cx: INTEGER is
			-- Specifies the width, in pixel, of the column
		do
			Result := cwel_lv_column_get_cx (item)
		ensure
			positive_result: Result >= 0
		end

	fmt: INTEGER is
			-- Specifies the alignment of the column
			-- See class WEL_LVCF_CONSTANTS.
		do
			Result := cwel_lv_column_get_fmt (item)
		ensure
			valid_result: valid_lvcfmt_constant (Result)
		end

feature -- Element change

	set_mask (a_mask: INTEGER) is
			-- Set `mask' with `a_mask'.
		do
			cwel_lv_column_set_mask (item, a_mask)
		ensure
			mask_set: mask = a_mask
		end

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			!! str_text.make (a_text)
			cwel_lv_column_set_psztext (item, str_text.item)
			cwel_lv_column_set_cchtextmax (item, a_text.count)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_cx (a_cx: INTEGER) is
			-- Set `cx' with `a_cx'.
		require
			positive_cx: a_cx >= 0
		do
			cwel_lv_column_set_cx (item, a_cx)
		ensure
			cx_set: cx = a_cx
		end

	set_fmt (a_fmt: INTEGER) is
			-- Set `fmt' with `a_fmt'.
		require
			valid_fmt: valid_lvcfmt_constant (a_fmt)
		do
			cwel_lv_column_set_fmt (item, a_fmt)
		ensure
			fmt_set: fmt = a_fmt
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_lv_column
		end

feature {NONE} -- Implementation

	str_text: WEL_STRING
			-- C string to save the text

feature {NONE} -- Externals

	c_size_of_lv_column: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"sizeof (LV_COLUMN)"
		end

	cwel_lv_column_set_mask (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_set_fmt (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_set_cx (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_set_psztext (ptr: POINTER; value: POINTER) is
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_set_cchtextmax (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvcolumn.h>]"
		end

-- XX Not define in Borland C++
--	cwel_lv_column_set_iimage (ptr: POINTER; value: INTEGER) is
--		external
--			"C [macro <lvcolumn.h>]"
--		end

	cwel_lv_column_get_mask (ptr: POINTER): INTEGER is
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_get_fmt (ptr: POINTER): INTEGER is
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_get_cx (ptr: POINTER): INTEGER is
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_get_psztext (ptr: POINTER): POINTER is
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_get_cchtextmax (ptr: POINTER): INTEGER is
		external
			"C [macro <lvcolumn.h>]"
		end

-- XX Not defined in Borland C++
--	cwel_lv_column_get_iimage (ptr: POINTER): INTEGER is
--		external
--			"C [macro <lvcolumn.h>]"
--		end

invariant
	invariant_clause: -- Your invariant here

end -- class WEL_LIST_VIEW_COLUMN

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
