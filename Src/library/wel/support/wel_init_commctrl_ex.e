indexing
	description: "Contains information about the initialization of the common controls dll.%
				 % Note: Require Windows98 or Windows95+IE4 or WindowsNT4+IE4 or Windows2000"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INIT_COMMCTRL_EX

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_ICC_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_pointer,
	make_with_flags

feature {NONE} -- Initialization

	make is
			-- Initialize the Win32 dlls only.
		local
			bool: BOOLEAN
		do
			structure_make
			set_dwsize (structure_size)
			set_dwicc (Icc_win95_classes)
			bool := cwin_init_common_controls_ex (item)
		end

	make_with_flags (flags: INTEGER) is
			-- initialize the given dll.
		local
			bool: BOOLEAN
		do
			structure_make
			set_dwsize (structure_size)
			set_dwicc (flags)
			bool := cwin_init_common_controls_ex (item)
		end

feature -- Access

	dwicc: INTEGER is
		-- Set of bit flags that indicate which common control
		-- classes will be loaded from the DLL.
		-- This value can be a combination of WEL_ICC_CONSTANTS.
		do
			Result := cwel_initcommctrlex_get_dwicc (item)
		end

feature -- Element change

	set_dwicc (value: INTEGER) is
			-- Set `dwicc' with `value'.
		do
			cwel_initcommctrlex_set_dwicc (item, value)
		ensure
			dwicc_set: dwicc = value
		end

feature {NONE} -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_initcommctrlex
		end

feature {NONE} -- Implementation

	dwsize: INTEGER is
			-- Size of the structure.
		do
			Result := cwel_initcommctrlex_get_dwsize (item)
		end

	set_dwsize (value: INTEGER) is
			-- Set `dwsize' with `value'.
		do
			cwel_initcommctrlex_set_dwsize (item, value)
		ensure
			dwsize_set: dwsize = value
		end

feature {NONE} -- Externals

	c_size_of_initcommctrlex: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"sizeof (INITCOMMONCONTROLSEX)"
		end

	cwel_initcommctrlex_set_dwsize (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"initcommctrlex.h%"]"
		end

	cwel_initcommctrlex_set_dwicc (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"initcommctrlex.h%"]"
		end

	cwel_initcommctrlex_get_dwsize (ptr: POINTER): INTEGER is
		external
			"C [macro %"initcommctrlex.h%"]"
		end

	cwel_initcommctrlex_get_dwicc (ptr: POINTER): INTEGER is
		external
			"C [macro %"initcommctrlex.h%"]"
		end

	cwin_init_common_controls_ex (ptr: POINTER): BOOLEAN is
			-- SDK InitCommonControlsEx
		external
			"C [macro %"cctrl.h%"] (LPINITCOMMONCONTROLSEX): BOOL"
		alias
			"InitCommonControlsEx"
		end

end -- class WEL_INIT_COMMCTRL_EX


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

