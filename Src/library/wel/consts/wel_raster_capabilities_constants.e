indexing
	description: "Raster capabilities (RC) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RASTER_CAPABILITIES_CONSTANTS

feature -- Access

	Rc_bitblt: INTEGER is
			-- Transfers bitmaps
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_BITBLT"
		end

	Rc_banding: INTEGER is
			-- Supports banding
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_BANDING"
		end

	Rc_scaling: INTEGER is
			-- Supports scaling
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_SCALING"
		end

	Rc_bitmap64: INTEGER is
			-- Supports bitmaps larger than 64K
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_BITMAP64"
		end

	Rc_gdi20_output: INTEGER is
			-- Supports Windows version 2.0 features
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_GDI20_OUTPUT"
		end

	Rc_gdi20_state: INTEGER is
			-- Includes a state block in the device context
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_GDI20_STATE"
		end

	Rc_savebitmap: INTEGER is
			-- Saves bitmaps locally
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_SAVEBITMAP"
		end

	Rc_di_bitmap: INTEGER is
			-- Supports the set_di_bits feature
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_DI_BITMAP"
		end

	Rc_palette: INTEGER is
			-- Specifies a palette-based device
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_PALETTE"
		end

	Rc_dibtodev: INTEGER is
			-- Supports the set_di_bits_to_device feature
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_DIBTODEV"
		end

	Rc_bigfont: INTEGER is
			-- Supports fonts larger then 64K
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_BIGFONT"
		end

	Rc_stretchblt: INTEGER is
			-- Supports the stretch_blt feature
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_STRETCHBLT"
		end

	Rc_floodfill: INTEGER is
			-- Performs flood fills
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_FLOODFILL"
		end

	Rc_stretchdib: INTEGER is
			-- Supports the stretch_di_bits feature
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_STRETCHDIB"
		end

	Rc_op_dx_output: INTEGER is
			-- Supports dev opaque and DX array
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_OP_DX_OUTPUT"
		end

	Rc_devbits: INTEGER is
			-- Supports device bitmaps
		external
			"C [macro %"wel.h%"]"
		alias
			"RC_DEVBITS"
		end

end -- class WEL_RASTER_CAPABILITIES_CONSTANTS


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

