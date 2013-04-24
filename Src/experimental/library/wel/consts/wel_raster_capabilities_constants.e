note
	description: "Raster capabilities (RC) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RASTER_CAPABILITIES_CONSTANTS

feature -- Access

	Rc_bitblt: INTEGER
			-- Transfers bitmaps
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_BITBLT"
		end

	Rc_banding: INTEGER
			-- Supports banding
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_BANDING"
		end

	Rc_scaling: INTEGER
			-- Supports scaling
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_SCALING"
		end

	Rc_bitmap64: INTEGER
			-- Supports bitmaps larger than 64K
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_BITMAP64"
		end

	Rc_gdi20_output: INTEGER
			-- Supports Windows version 2.0 features
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_GDI20_OUTPUT"
		end

	Rc_gdi20_state: INTEGER
			-- Includes a state block in the device context
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_GDI20_STATE"
		end

	Rc_savebitmap: INTEGER
			-- Saves bitmaps locally
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_SAVEBITMAP"
		end

	Rc_di_bitmap: INTEGER
			-- Supports the set_di_bits feature
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_DI_BITMAP"
		end

	Rc_palette: INTEGER
			-- Specifies a palette-based device
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_PALETTE"
		end

	Rc_dibtodev: INTEGER
			-- Supports the set_di_bits_to_device feature
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_DIBTODEV"
		end

	Rc_bigfont: INTEGER
			-- Supports fonts larger then 64K
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_BIGFONT"
		end

	Rc_stretchblt: INTEGER
			-- Supports the stretch_blt feature
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_STRETCHBLT"
		end

	Rc_floodfill: INTEGER
			-- Performs flood fills
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_FLOODFILL"
		end

	Rc_stretchdib: INTEGER
			-- Supports the stretch_di_bits feature
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_STRETCHDIB"
		end

	Rc_op_dx_output: INTEGER
			-- Supports dev opaque and DX array
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_OP_DX_OUTPUT"
		end

	Rc_devbits: INTEGER
			-- Supports device bitmaps
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_DEVBITS"
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




end -- class WEL_RASTER_CAPABILITIES_CONSTANTS

