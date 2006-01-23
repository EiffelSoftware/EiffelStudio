indexing
	description: "Font family (FF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT_FAMILY_CONSTANTS

feature -- Access

	Ff_dontcare: INTEGER is
			-- Don't care or don't know
		external
			"C [macro %"wel.h%"]"
		alias
			"FF_DONTCARE"
		end

	Ff_roman: INTEGER is
			-- Fonts with variable stroke width (proportional)
			-- and with serifs. MS Serif is an example.
		external
			"C [macro %"wel.h%"]"
		alias
			"FF_ROMAN"
		end

	Ff_swiss: INTEGER is
			-- Fonts with variable stroke width (proportional)
			-- and without serifs. MS Sans Serif is an example.
		external
			"C [macro %"wel.h%"]"
		alias
			"FF_SWISS"
		end

	Ff_modern: INTEGER is
			-- Fonts with constant stroke width (monospace),
			-- with or without serifs. Monospace fonts are usually
			-- modern. Pica, Elite, and CourierNew are examples.
		external
			"C [macro %"wel.h%"]"
		alias
			"FF_MODERN"
		end

	Ff_script: INTEGER is
			-- Fonts designed to look like handwriting.
			-- Script and Cursive are examples.
		external
			"C [macro %"wel.h%"]"
		alias
			"FF_SCRIPT"
		end

	Ff_decorative: INTEGER is
			-- Novelty fonts. Old English is an example.
		external
			"C [macro %"wel.h%"]"
		alias
			"FF_DECORATIVE"
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




end -- class WEL_FONT_FAMILY_CONSTANTS

