note
	description: "Contains information about the initialization of the common controls dll.%
				 % Note: Require Windows98 or Windows95+IE4 or WindowsNT4+IE4 or Windows2000"
	legal: "See notice at end of class."
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
		undefine
			copy, is_equal
		end

create
	make,
	make_by_pointer,
	make_with_flags

feature {NONE} -- Initialization

	make
			-- Initialize the Win32 dlls only.
		local
			bool: BOOLEAN
		do
			structure_make
			set_dwsize (structure_size)
			set_dwicc (Icc_win95_classes)
			bool := cwin_init_common_controls_ex (item)
		end

	make_with_flags (flags: INTEGER)
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

	dwicc: INTEGER
		-- Set of bit flags that indicate which common control
		-- classes will be loaded from the DLL.
		-- This value can be a combination of WEL_ICC_CONSTANTS.
		do
			Result := cwel_initcommctrlex_get_dwicc (item)
		end

feature -- Element change

	set_dwicc (value: INTEGER)
			-- Set `dwicc' with `value'.
		do
			cwel_initcommctrlex_set_dwicc (item, value)
		ensure
			dwicc_set: dwicc = value
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_initcommctrlex
		end

feature {NONE} -- Implementation

	dwsize: INTEGER
			-- Size of the structure.
		do
			Result := cwel_initcommctrlex_get_dwsize (item)
		end

	set_dwsize (value: INTEGER)
			-- Set `dwsize' with `value'.
		do
			cwel_initcommctrlex_set_dwsize (item, value)
		ensure
			dwsize_set: dwsize = value
		end

feature {NONE} -- Externals

	c_size_of_initcommctrlex: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"sizeof (INITCOMMONCONTROLSEX)"
		end

	cwel_initcommctrlex_set_dwsize (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"initcommctrlex.h%"]"
		end

	cwel_initcommctrlex_set_dwicc (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"initcommctrlex.h%"]"
		end

	cwel_initcommctrlex_get_dwsize (ptr: POINTER): INTEGER
		external
			"C [macro %"initcommctrlex.h%"]"
		end

	cwel_initcommctrlex_get_dwicc (ptr: POINTER): INTEGER
		external
			"C [macro %"initcommctrlex.h%"]"
		end

	cwin_init_common_controls_ex (ptr: POINTER): BOOLEAN
			-- SDK InitCommonControlsEx
		external
			"C [macro %"cctrl.h%"] (LPINITCOMMONCONTROLSEX): BOOL"
		alias
			"InitCommonControlsEx"
		end

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




end -- class WEL_INIT_COMMCTRL_EX

