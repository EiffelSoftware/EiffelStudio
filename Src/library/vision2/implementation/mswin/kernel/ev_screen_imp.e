--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision screen, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCREEN_IMP

inherit
	EV_SCREEN_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			interface
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a screen object.
		local
			color: EV_COLOR
		do
			base_make (an_interface)
			!! dc
			dc.get
		end

feature -- FIXME These have been added to enable
		-- compilation. 

	wel_set_font (w: WEL_FONT) is
		do
		end

	wel_font: WEL_FONT

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
			is_destroyed := True
			destroy_just_called := True
		end

feature -- Implementation
	
	interface: EV_SCREEN

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 22:26:34  oconnor
--| merged from HACK-O-RAMA
--|
--| Revision 1.3.10.5  2000/02/14 20:48:59  rogers
--| Added 'is_destroyed := True' and 'destroy_just_called := True' to destroy.
--|
--| Revision 1.3.10.4  2000/01/27 19:30:32  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.3  2000/01/21 23:20:44  brendel
--| Rearranged initialization.
--|
--| Revision 1.3.10.2  1999/12/17 00:18:51  rogers
--| Altered to fit in with the review branch. Make now takes an interface.
--|
--| Revision 1.3.10.1  1999/11/24 17:30:36  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
