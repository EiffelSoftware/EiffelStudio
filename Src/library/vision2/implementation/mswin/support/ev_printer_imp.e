indexing 
	description: "EiffelVision printer, implementation interface."
	status: "See notice at end of class"
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

feature -- Implementation
	
	interface: EV_PRINTER

end -- class EV_PRINTER_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

