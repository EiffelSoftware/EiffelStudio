indexing
	description: "Some constants needed for the%
				% WEL_DRAWING_ROUTINES."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DRAWING_ROUTINES_CONSTANTS

feature -- Constants fo `draw_edge' feature

	Edge_bump: INTEGER is
			-- Raised outer and sunken inner edges.
		external
			"C [macro %"wel.h%"]"
		alias
			"EDGE_BUMP"
		end

	Edge_etched: INTEGER is
			-- Sunken outer and raised inner edges.
		external
			"C [macro %"wel.h%"]"
		alias
			"EDGE_ETCHED"
		end

	Edge_raised: INTEGER is
			-- Raised inner and outer edges.
		external
			"C [macro %"wel.h%"]"
		alias
			"EDGE_RAISED"
		end

	Edge_sunken: INTEGER is
			-- Sunken inner and outer edges.
		external
			"C [macro %"wel.h%"]"
		alias
			"EDGE_SUNKEN"
		end

	Bdr_raisedouter: INTEGER is 1
			-- Raised outer edge.

	Bdr_sunkenouter: INTEGER is 2
			-- Sunken outer edge.

	Bdr_raisedinner: INTEGER is 4
			-- Raised inner edge.

	Bdr_sunkeninner: INTEGER is 8
			-- Sunken inner edge.

	Bf_rect: INTEGER is
			-- Entire border rectangle
		external
			"C [macro %"wel.h%"]"
		alias
			"BF_RECT"
		end

	Bf_adjust: INTEGER is
			-- Rectangle to be adjusted to leave space for 
			-- client area.
		external
			"C [macro %"wel.h%"]"
		alias
			"BF_ADJUST"
		end

	Bf_flat: INTEGER is
			-- Flat border.
		external
			"C [macro %"wel.h%"]"
		alias
			"BF_FLAT"
		end

	Bf_soft: INTEGER is
			-- Soft buttons instead of tiles.
		external
			"C [macro %"wel.h%"]"
		alias
			"BF_SOFT"
		end

feature -- Constants fo `draw_state' feature

	Dst_bitmap: INTEGER is
			-- The image is a bitmap. The low-order word of the lData
			-- parameter is the bitmap handle. 
		external
			"C [macro %"wel.h%"]"
		alias
			"DST_BITMAP"
		end

	Dst_complex: INTEGER is
			-- The image is application defined. To render the image,
			-- DrawState calls the callback function specified by the
			-- lpOutputFunc parameter.
		external
			"C [macro %"wel.h%"]"
		alias
			"DST_COMPLEX"
		end

	Dst_icon: INTEGER is
			-- The image is an icon. The low-order word of lData is 
			-- the icon handle.
		external
			"C [macro %"wel.h%"]"
		alias
			"DST_ICON"
		end

	Dst_prefixtext: INTEGER is
			-- The image is text that may contain an accelerator
			-- mnemonic. DrawState interprets the ampersand (&)
			-- prefix character as a directive to underscore the
			-- character that follows. The lData parameter specifies
			-- the address of the string, and the wData parameter
			-- specifies the length. If wData is zero, the string 
			-- must be null-terminated.
		external
			"C [macro %"wel.h%"]"
		alias
			"DST_PREFIXTEXT"
		end

	Dst_text: INTEGER is
			-- The image is text. The lData parameter specifies the
			-- address of the string, and the wData parameter
			-- specifies the length. If wData is zero, the string
			-- must be null-terminated.
		external
			"C [macro %"wel.h%"]"
		alias
			"DST_TEXT"
		end

	Dss_normal: INTEGER is
			-- Draws the image without any modification.
		external
			"C [macro %"wel.h%"]"
		alias
			"DSS_NORMAL"
		end

	Dss_union: INTEGER is
			-- Dithers the image.
		external
			"C [macro %"wel.h%"]"
		alias
			"DSS_UNION"
		end

	Dss_disabled: INTEGER is
			-- Embosses the image.
		external
			"C [macro %"wel.h%"]"
		alias
			"DSS_DISABLED"
		end

	Dss_mono: INTEGER is
			-- Draws the image using the brush specified by the
			-- hbr parameter.
		external
			"C [macro %"wel.h%"]"
		alias
			"DSS_MONO"
		end
	
end -- class WEL_DRAWING_ROUTINES_CONSTANTS


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

