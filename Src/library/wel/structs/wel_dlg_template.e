indexing
	description: "Objects that contain information about a %
		%dialog template."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DLG_TEMPLATE

inherit
	WEL_STRUCTURE

creation
	make,
	make_by_pointer

feature -- Access

	style: INTEGER is
			-- Style of dialog.
		do
			Result := cwel_dlgtemplate_get_style (item)
		end

	dwextendedstyle: INTEGER is
			-- Extended style of dialog.
		do
			Result := cwel_dlgtemplate_get_extended_style (item)
		end

	cdit: INTEGER is
			-- Number of items in dialog.
		do
			Result := cwel_dlgtemplate_get_cdit (item)
		end

	x: INTEGER is
			-- X coordinate of dialog.
		do
			Result := cwel_dlgtemplate_get_x (item)
		end

	y: INTEGER is
			-- Y coordinate of dialog.
		do
			Result := cwel_dlgtemplate_get_y (item)
		end

	cx: INTEGER is
			-- Width of dialog.
		do
			Result := cwel_dlgtemplate_get_cx (item)
		end

	cy: INTEGER is
			-- Height of dialog.
		do
			Result := cwel_dlgtemplate_get_cy (item)
		end

feature -- Status setting.

	set_style (a_style: INTEGER) is
			-- Assign `a_style' to `style'.
		do
			cwel_dlgtemplate_set_style (item, a_style)
		end

	set_dwextendedstyle (a_style: INTEGER) is
			-- Assign `a_style' to `dwextendedstyle'.
		do
			cwel_dlgtemplate_set_dwextendedstyle (item, a_style)
		end

	set_cdit (a_value: INTEGER) is
			-- Assign `a_value' to `cdit'.
		do
			cwel_dlgtemplate_set_cdit (item, a_value)
		end

	set_x (an_x: INTEGER) is
			-- Assign `an_x' to `x'.
		do
			cwel_dlgtemplate_set_x (item, an_x)
		end

	set_y (a_y: INTEGER) is
			-- Assign `a_y' to `y'.
		do
			cwel_dlgtemplate_set_x (item, a_y)
		end

	set_cx (a_cx: INTEGER) is
			-- Assign `a_cx' to `x'.
		do
			cwel_dlgtemplate_set_cx (item, a_cx)
		end

	set_cy (a_cy: INTEGER) is
			-- Assign `a_cy' to `cy'.
		do
			cwel_dlgtemplate_set_cy (item, a_cy)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_dlgtemplate
		end

feature {NONE} -- Externals

	c_size_of_dlgtemplate: INTEGER is
		external
			"C [macro <windows.h>]"
		alias
			"sizeof (DLGTEMPLATE)"
		end

	cwel_dlgtemplate_get_style (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"style"
		end

	cwel_dlgtemplate_get_extended_style (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"dwExtendedStyle"
		end

	cwel_dlgtemplate_get_cdit (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"cdit"
		end

	cwel_dlgtemplate_get_x (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"x"
		end

	cwel_dlgtemplate_get_y (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"y"
		end

	cwel_dlgtemplate_get_cx (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"cx"
		end

	cwel_dlgtemplate_get_cy (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"cy"
		end

	cwel_dlgtemplate_set_style (ptr: POINTER; a_style: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, DWORD)"
		alias
			"style"
		end

	cwel_dlgtemplate_set_dwextendedstyle (ptr: POINTER; a_style: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, DWORD)"
		alias
			"dwExtendedStyle"
		end

	cwel_dlgtemplate_set_cdit (ptr: POINTER; a_cdir: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, WORD)"
		alias
			"dwExtendedStyle"
		end

	cwel_dlgtemplate_set_x (ptr: POINTER; an_x: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, short)"
		alias
			"x"
		end

	cwel_dlgtemplate_set_y (ptr: POINTER; a_y: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, short)"
		alias
			"y"
		end

	cwel_dlgtemplate_set_cy (ptr: POINTER; a_cy: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, short)"
		alias
			"cy"
		end

	cwel_dlgtemplate_set_cx (ptr: POINTER; a_cx: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, short)"
		alias
			"cx"
		end

end -- class WEL_DLGTEMPLATE
