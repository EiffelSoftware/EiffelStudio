note
	description: "EiffelVision printer, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINTER_IMP

inherit
	EV_PRINTER_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			interface
		end

create
	make_with_dc

feature -- Initialization

	make_with_dc (a_dc: WEL_PRINTER_DC)
			-- Create and initialize `Current' using `a_dc'.
		do
			set_printer_dc (a_dc)
			make
		end

	old_make (an_interface: like interface)
			-- Create `Current', a printer object.
		do
			assign_interface (an_interface)
		end

	set_default_colors
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end

feature -- Status setting

	set_printer_dc (a_dc: WEL_PRINTER_DC)
			-- Set `dc' to `a_dc'.
		do
			dc := a_dc
		end

feature -- Access

	dc: WEL_PRINTER_DC
			-- DC for drawing.

feature -- Measurement

	width: INTEGER
			-- Width of `Current'.
		do
			Result := dc.width
		end

	height: INTEGER
			-- Height of `Current'.
		do
			Result := dc.height
		end

feature -- Status setting

	start_document
		do
			dc.start_document ("Eiffel Vision Print Job")
			dc.start_page
		end

	end_document
		do
			dc.end_page
			dc.end_document
		end

	redraw
			-- Force `Current' to redraw itself.
		do
		end

feature -- Implementation

	interface: detachable EV_PRINTER note option: stable attribute end;

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




end -- class EV_PRINTER_IMP





