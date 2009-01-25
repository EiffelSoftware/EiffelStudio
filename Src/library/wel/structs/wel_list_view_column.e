note
	description: "Contains information about a list view control%
				% column."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LIST_VIEW_COLUMN

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_LIST_VIEW_CONSTANTS
		export
			{NONE} all
			{ANY} valid_lvcfmt_constant,
					lvscw_autosize,
					Lvscw_autosize_useheader
		undefine
			copy, is_equal
		end

create
	make,
	make_by_pointer,
	make_with_attributes

feature -- Initialization

	make
			-- Make a list view column structure
		do
			structure_make
			set_mask (0)
		end

	make_with_attributes (a_mask, a_width, an_alignment: INTEGER; a_text: STRING_GENERAL)
			-- Make a list view column structure with the given
			-- attributes:
			-- `a_mask' set the valid member (`Lvcf_text', ...)
			-- `a_width' is the width of the column in pixels
			-- `an_alignment' is the alignment of the column header and
			--                items in the column.
			-- `a_text' is the text of of the header.
		require
			valid_fmt: valid_lvcfmt_constant (an_alignment)
			a_text_not_void: a_text /= Void
		do
			structure_make
			cwel_lv_column_set_mask (item, a_mask)
			cwel_lv_column_set_cx (item, a_width)
			cwel_lv_column_set_fmt (item, an_alignment)
			set_text (a_text)
		end

feature -- Access

	mask: INTEGER
			-- Array of flags that indicate which of the other
			-- structure members contain valid data or which are
			-- to be filled in. This member can be a combination
			-- of the Lvcf_* values.
			-- See class WEL_LVCF_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_lv_column_get_mask (item)
		end

	text: STRING_32
			-- Title of the column
		require
			text_meaningfull: is_text_valid
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

	width: INTEGER
			-- Get the width, in pixel, of the column
		require
			exists: exists
			width_meaningfull: is_width_valid
		do
			Result := cwel_lv_column_get_cx (item)
		ensure
			positive_result: Result >= 0
		end

	alignment: INTEGER
			-- Specifies the alignment of the column
			-- See class WEL_LVCF_CONSTANTS for possible values.
		require
			exists: exists
		do
			Result := cwel_lv_column_get_fmt (item)
		ensure
			valid_result: valid_lvcfmt_constant (Result)
		end

feature -- Status Report

	is_width_valid: BOOLEAN
			-- Is there any specified width in pixel for this column?
		require
			exists: exists
		do
			Result := is_in_mask (Lvcf_width)
		end

	is_text_valid: BOOLEAN
			-- Is there any specified text for this column?
		require
			exists: exists
		do
			Result := is_in_mask (Lvcf_text)
		end

	is_alignment_valid: BOOLEAN
			-- Is there any specified alignment for this column?
		require
			exists: exists
		do
			Result := is_in_mask (Lvcf_fmt)
		end

	is_in_mask (a_mask: INTEGER): BOOLEAN
			-- Is `a_mask' contained in the current mask?
		require
			exists: exists
		local
			backup_mask: INTEGER
			new_mask: INTEGER
		do
				-- Backup the current mask
			backup_mask := cwel_lv_column_get_mask (item)

				-- Remove and add `a_mask' to current mask
				-- to test if `a_mask' is contained in
				-- the current mask
			cwel_lv_column_remove_mask (item, a_mask)
			cwel_lv_column_add_mask (item, a_mask)
			new_mask :=  cwel_lv_column_get_mask (item)
			Result := (new_mask = backup_mask)

				-- Restore the mask.
			cwel_lv_column_set_mask (item, backup_mask)
		end

feature -- Element change

	set_mask (a_mask: INTEGER)
			-- Set `mask' with `a_mask'.
		require
			exists: exists
		do
			cwel_lv_column_set_mask (item, a_mask)
		ensure
			mask_set: mask = a_mask
		end

	remove_mask
			-- Reset the mask to zero.
		require
			exists: exists
		do
			cwel_lv_column_set_mask (item, 0)
		ensure
			mask_reseted: mask = 0
		end

	set_text (a_text: STRING_GENERAL)
			-- Set `text' with `a_text'.
		require
			exists: exists
			a_text_not_void: a_text /= Void
		local
			l_text: like str_text
		do
			cwel_lv_column_add_mask (item, Lvcf_text)
			create l_text.make (a_text)
			str_text := l_text
			cwel_lv_column_set_psztext (item, l_text.item)
			cwel_lv_column_set_cchtextmax (item, a_text.count)
		ensure
			text_set: text.is_equal (a_text)
		end

	remove_text
			-- Remove any specified text on the column.
		require
			exists: exists
		do
			cwel_lv_column_remove_mask (item, Lvcf_text)
		ensure
			text_not_valid: not is_text_valid
		end

	set_width (a_width: INTEGER)
			-- Set the width of the column to `a_width'.
		require
			exists: exists
			valid_width: a_width >= 0 or
			a_width = Lvscw_autosize or
			a_width = Lvscw_autosize_useheader
		do
			cwel_lv_column_add_mask (item, Lvcf_width)
			cwel_lv_column_set_cx (item, a_width)
		ensure
			width_set: width = a_width
		end

	remove_width
			-- Remove any specified width on the column.
		require
			exists: exists
		do
			cwel_lv_column_remove_mask (item, Lvcf_width)
		ensure
			width_not_valid: not is_width_valid
		end

	set_alignment (an_alignment: INTEGER)
			-- Set the alignment of the column to `an_alignment'.
			-- See class WEL_LVCF_CONSTANTS for possible values.
		require
			exists: exists
			valid_alignment: valid_lvcfmt_constant (an_alignment)
		do
			cwel_lv_column_add_mask (item, Lvcf_fmt)
			cwel_lv_column_set_fmt (item, an_alignment)
		ensure
			fmt_set: alignment = an_alignment
		end

	remove_alignment
			-- Remove any specified alignment on the column.
		require
			exists: exists
		do
			cwel_lv_column_remove_mask (item, Lvcf_fmt)
		ensure
			alignment_not_valid: not is_alignment_valid
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_lv_column
		end

feature -- Obsolete

	cx: INTEGER
			-- Specifies the width, in pixel, of the column
		obsolete
			"use `width' instead, `cx' will be removed after January 2001"
		require
			exists: exists
		do
			Result := width
		end

	set_cx (a_width: INTEGER)
			-- Set `cx' with `a_cx'.
		obsolete
			"use `set_width' instead, `set_cx' will be removed after January 2001"
		require
			exists: exists
		do
			set_width (a_width)
		end

	set_fmt (a_fmt: INTEGER)
			-- Set `fmt' with `a_fmt'.
		obsolete
			"use `set_alignment' instead, `set_fmt' will be removed after January 2001"
		require
			exists: exists
		do
			set_alignment (a_fmt)
		end

	fmt: INTEGER
			-- Specifies the alignment of the column
			-- See class WEL_LVCF_CONSTANTS for possible values.
		obsolete
			"use `alignment' instead, `fmt' will be removed after January 2001"
		require
			exists: exists
		do
			Result := alignment
		end

feature {NONE} -- Externals

	str_text: ?WEL_STRING
			-- Backend buffer for `text'.

	c_size_of_lv_column: INTEGER
		external
			"C [macro <cctrl.h>]"
		alias
			"sizeof (LV_COLUMN)"
		end

	cwel_lv_column_set_mask (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_add_mask (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_remove_mask (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_set_fmt (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_set_cx (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_set_psztext (ptr: POINTER; value: POINTER)
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_set_cchtextmax (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_get_mask (ptr: POINTER): INTEGER
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_get_fmt (ptr: POINTER): INTEGER
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_get_cx (ptr: POINTER): INTEGER
		external
			"C [macro <lvcolumn.h>]"
		end

	cwel_lv_column_get_psztext (ptr: POINTER): POINTER
		external
			"C [macro <lvcolumn.h>] (LV_COLUMN*): EIF_POINTER"
		end

	cwel_lv_column_get_cchtextmax (ptr: POINTER): INTEGER
		external
			"C [macro <lvcolumn.h>]"
		end

-----------------------------------------------------------------
-- Not defined in Borland C++ 4.5
-----------------------------------------------------------------
--	cwel_lv_column_set_iimage (ptr: POINTER; value: INTEGER) is
--		external
--			"C [macro <lvcolumn.h>]"
--		end
--
--	cwel_lv_column_get_iimage (ptr: POINTER): INTEGER is
--		external
--			"C [macro <lvcolumn.h>]"
--		end
-----------------------------------------------------------------

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
