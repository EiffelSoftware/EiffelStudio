indexing
	description	: "List view column flag (LVCF) constants"
	status		: "See notice at end of class"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVCF_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Column Flags (General)

	Lvcf_fmt: INTEGER is 1
			-- The fmt member is valid.
			--
			-- Declared in Windows as LVCF_FMT

	Lvcf_subitem: INTEGER is 8
			-- The iSubItem member is valid.
			--
			-- Declared in Windows as LVCF_SUBITEM

	Lvcf_text: INTEGER is 4
			-- The pszText member is valid.
			--
			-- Declared in Windows as LVCF_TEXT

	Lvcf_width: INTEGER is 2
			-- The cx member is valid.
			--
			-- Declared in Windows as LVCF_WIDTH

	Lvcf_image: INTEGER is 16
			-- The ilmage member is valid
			--
			-- Declared in Windows as LVCF_IMAGE

feature -- Column Flags (Format)

	Lvcfmt_right: INTEGER is 1
			-- alignment of the column : right.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_RIGHT

	Lvcfmt_center: INTEGER is 2
			-- alignment of the column : center.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_CENTER

	Lvcfmt_left: INTEGER is 0
			-- alignment of the column : left.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_LEFT

	Lvcfmt_justifymask: INTEGER is 3
			-- alignment of the column : justify.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_JUSTIFYMASK

feature -- Validation

	valid_lvcfmt_constant (value: INTEGER): BOOLEAN is
			-- Is `value' a valid lvcfmt constant?
		do
			Result := value = Lvcfmt_left or else
				value = Lvcfmt_center or else
				value = Lvcfmt_right or else
				value = Lvcfmt_justifymask
		end

end -- class WEL_LVCF_CONSTANTS

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
