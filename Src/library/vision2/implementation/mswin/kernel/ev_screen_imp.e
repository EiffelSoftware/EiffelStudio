indexing 
	description: "EiffelVision screen, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCREEN_IMP

inherit
	EV_SCREEN_I

	EV_DRAWABLE_IMP

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a screen object.
		local
			color: EV_COLOR
		do
			!! dc
			dc.get
			!! color.make_rgb (0, 0, 0)
			set_background_color (color)
			!! color.make_rgb (255, 255, 255)
			set_foreground_color (color)
		end

feature -- Access

	dc: WEL_SCREEN_DC
			-- DC for drawing

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := not dc.exists
		end

feature -- Measurement

	width: INTEGER is
			-- Width of the widget
		do
			Result := dc.width
		end

	height: INTEGER is
			-- Height of the widget
		do
			Result := dc.height
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			dc.delete
		end

end -- class EV_SCREEN_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
