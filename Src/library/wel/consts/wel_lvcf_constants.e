indexing
	description: "List view column flag (LVCF) constants"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
class
	WEL_LVCF_CONSTANTS

feature -- Access

	Lvcf_fmt: INTEGER is
			-- The fmt member is valid.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVCF_FMT"
		end

	Lvcf_subitem: INTEGER is
			-- The iSubItem member is valid.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVCF_SUBITEM"
		end

	Lvcf_text: INTEGER is
			-- The pszText member is valid.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVCF_TEXT"
		end

	Lvcf_width: INTEGER is
			-- The cx member is valid.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVCF_WIDTH"
		end

-- XX Not defined in Borland C++
--	Lvcf_image: INTEGER is
--			-- The ilmage member is valid
--		external
--			"C [macro <cctrl.h>]"
--		alias
--			"LVCF_IMAGE"
--		end

feature -- Format

	Lvcfmt_right: INTEGER is
			-- alignment of the column : right.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVCFMT_RIGHT"
		end

	Lvcfmt_center: INTEGER is
			-- alignment of the column : center.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVCFMT_CENTER"
		end

	Lvcfmt_left: INTEGER is
			-- alignment of the column : left.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVCFMT_LEFT"
		end

	Lvcfmt_justifymask: INTEGER is
			-- alignment of the column : justify.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVCFMT_JUSTIFYMASK"
		end

feature -- Status report

	valid_lvcfmt_constant (value: INTEGER): BOOLEAN is
			-- Is `value' a valid lvcfmt constant?
		do
			Result := value = Lvcfmt_left or else
				value = Lvcfmt_center or else
				value = Lvcfmt_right
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
