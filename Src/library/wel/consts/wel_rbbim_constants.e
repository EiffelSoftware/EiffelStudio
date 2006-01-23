indexing
	description: "Rebar Band Mask (RBBIM) messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RBBIM_CONSTANTS

feature -- Access

	Rbbim_style: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_STYLE"
		end

	Rbbim_colors: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_COLORS"
		end

	Rbbim_text: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_TEXT"
		end

	Rbbim_image: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_IMAGE"
		end

	Rbbim_child: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_CHILD"
		end

	Rbbim_childsize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_CHILDSIZE"
		end

	Rbbim_size: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_SIZE"
		end

	Rbbim_background: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_BACKGROUND"
		end

	Rbbim_id: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_ID"
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




end -- class WEL_RBBIM_CONSTANTS

