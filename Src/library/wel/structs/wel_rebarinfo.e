indexing
	description: "Contains information about a rebar control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_REBARINFO

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make is
			-- Make a REBARINFO structure.
			-- We have to set `cbSize' to the structure
			-- size before to use this object.
			-- As the imagelist are not implemented, we initialize
			-- the list to the default_pointer, otherwise,
			-- the bar has the wrong size.
		do
			structure_make
			set_cbsize (structure_size)
		end

feature -- Access

	mask: INTEGER is
			-- Array of flags that indicate which of the other
			-- structure members contain valid data or which are
			-- to be filled in. This member can be a combination
			-- of the Rbim_* values (only one for now).
			-- See class WEL_RBIM_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_rebarinfo_get_fmask (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_rebarinfo
		end

feature {WEL_REBAR} -- Implementation

	set_cbsize (value: INTEGER) is
			-- Set `cbSize' (size of the structure) as `value'.
		do
			cwel_rebarinfo_set_cbsize (item, value)
		end

	set_mask (value: INTEGER) is
			-- Set `mask' with `value.
		do
			cwel_rebarinfo_set_fmask (item, value)
		ensure
			mask_set: mask = value
		end

feature {NONE} -- Externals

	c_size_of_rebarinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"sizeof (REBARINFO)"
		end

	cwel_rebarinfo_set_fmask (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarinfo.h%"]"
		end

	cwel_rebarinfo_set_cbsize (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarinfo.h%"]"
		end

	cwel_rebarinfo_set_himl (ptr, value: POINTER) is
		external
			"C [macro %"rebarinfo.h%"]"
		end

	cwel_rebarinfo_get_fmask (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarinfo.h%"]"
		end

	cwel_rebarinfo_get_cbsize (ptr: POINTER) is
		external
			"C [macro %"rebarinfo.h%"]"
		end

	cwel_rebarinfo_get_himl (ptr: POINTER) is
		external
			"C [macro %"rebarinfo.h%"]"
		end

end -- class WEL_REBARINFO


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

