indexing 
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
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current', a printer object.
		do
			base_make (an_interface)
		end

	set_default_colors is
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end

feature -- Status setting

	set_printer_dc (a_dc: WEL_PRINTER_DC) is
			-- Set `dc' to `a_dc'.
		do
			dc := a_dc
		end

feature -- Access

	dc: WEL_PRINTER_DC
			-- DC for drawing.

feature -- Measurement

	width: INTEGER is
			-- Width of `Current'.
		do
			Result := dc.width
		end

	height: INTEGER is
			-- Height of `Current'.
		do
			Result := dc.height
		end

feature -- Status setting

	start_document is
		do
			dc.start_document ("Eiffel Vision Print Job")
			dc.start_page
		end

	end_document is
		do
			dc.end_page
			dc.end_document
		end

	redraw is 
			-- Force `Current' to redraw itself. 
		do 
		end 

feature -- Implementation
	
	interface: EV_PRINTER;

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




end -- class EV_PRINTER_IMP

