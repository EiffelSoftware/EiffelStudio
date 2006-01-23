indexing
	description: "The XFORM structure specifies a world-space to page-space transformation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_XFORM

inherit
	WEL_STRUCTURE
		redefine
			structure_size
		end

create
	make,
	make_by_pointer

feature -- Access

	em11: REAL is
			-- Specifies the following:
			-- Scaling: Horizontal scaling component
			-- Rotation: Cosine of rotation angle
			-- Reflection: Horizontal component
		do
			Result := cwel_paraformat_get_em11 (item)
		end

	em12: REAL is
			-- Specifies the following:
			-- Shear: Horizontal proportionality constant
			-- Rotation: Sine of the rotation angle
		do
			Result := cwel_paraformat_get_em12 (item)
		end

	em21: REAL is
			-- Specifies the following:
			-- Shear: Vertical proportionality constant
			-- Rotation: Negative sine of the rotation angle
		do
			Result := cwel_paraformat_get_em21 (item)
		end

	em22: REAL is
			-- Specifies the following:
			-- Scaling: Vertical scaling component
			-- Rotation: Cosine of rotation angle
			-- Reflection: Vertical reflection component
		do
			Result := cwel_paraformat_get_em22 (item)
		end

	edx: REAL is
			-- Specifies the horizontal translation component, in logical units. 	
		do
			Result := cwel_paraformat_get_edx (item)
		end

	edy: REAL is
			-- Specifies the vertical translation component, in logical units.
		do
			Result := cwel_paraformat_get_edy (item)
		end

feature -- Element change

	set_em11 (an_effect: REAL) is
		do
			cwel_paraformat_set_em11 (item, an_effect)
		ensure
			em11_set: em11 = an_effect
		end

	set_em12 (an_effect: REAL) is
		do
			cwel_paraformat_set_em12 (item, an_effect)
		ensure
			em12_set: em12 = an_effect
		end

	set_em21 (an_effect: REAL) is
		do
			cwel_paraformat_set_em21 (item, an_effect)
		ensure
			em21_set: em21 = an_effect
		end

	set_em22 (an_effect: REAL) is
		do
			cwel_paraformat_set_em22 (item, an_effect)
		ensure
			em22_set: em22 = an_effect
		end

	set_edx (an_effect: REAL) is
		do
			cwel_paraformat_set_edx (item, an_effect)
		ensure
			edx_set: edx = an_effect
		end

	set_edy (an_effect: REAL) is
		do
			cwel_paraformat_set_edy (item, an_effect)
		ensure
			edy_set: edy = an_effect
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_xform
		end

feature {NONE} -- Externals

	c_size_of_xform: INTEGER is
		external
			"C [macro <windows.h>]"
		alias
			"sizeof (XFORM)"
		end

	cwel_paraformat_set_em11 (ptr: POINTER; value: REAL) is
			--
		external
			"C [struct <windows.h>] (XFORM, FLOAT)"
		alias
			"eM11"
		end

	cwel_paraformat_get_em11 (ptr: POINTER): REAL is
		external
			"C [struct <windows.h>] (XFORM): EIF_REAL"
		alias
			"eM11"
		end

	cwel_paraformat_set_em12 (ptr: POINTER; value: REAL) is
			--
		external
			"C [struct <windows.h>] (XFORM, FLOAT)"
		alias
			"eM12"
		end

	cwel_paraformat_get_em12 (ptr: POINTER): REAL is
		external
			"C [struct <windows.h>] (XFORM): EIF_REAL"
		alias
			"eM12"
		end

	cwel_paraformat_set_em21 (ptr: POINTER; value: REAL) is
			--
		external
			"C [struct <windows.h>] (XFORM, FLOAT)"
		alias
			"eM21"
		end

	cwel_paraformat_get_em21 (ptr: POINTER): REAL is
		external
			"C [struct <windows.h>] (XFORM): EIF_REAL"
		alias
			"eM21"
		end

	cwel_paraformat_set_em22 (ptr: POINTER; value: REAL) is
			--
		external
			"C [struct <windows.h>] (XFORM, FLOAT)"
		alias
			"eM22"
		end

	cwel_paraformat_get_em22 (ptr: POINTER): REAL is
		external
			"C [struct <windows.h>] (XFORM): EIF_REAL"
		alias
			"eM22"
		end

	cwel_paraformat_set_edx (ptr: POINTER; value: REAL) is
			--
		external
			"C [struct <windows.h>] (XFORM, FLOAT)"
		alias
			"eDx"
		end

	cwel_paraformat_get_edx (ptr: POINTER): REAL is
		external
			"C [struct <windows.h>] (XFORM): EIF_REAL"
		alias
			"eDx"
		end

	cwel_paraformat_set_edy (ptr: POINTER; value: REAL) is
			--
		external
			"C [struct <windows.h>] (XFORM, FLOAT)"
		alias
			"eDy"
		end

	cwel_paraformat_get_edy (ptr: POINTER): REAL is
		external
			"C [struct <windows.h>] (XFORM): EIF_REAL"
		alias
			"eDy"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_XFORM

