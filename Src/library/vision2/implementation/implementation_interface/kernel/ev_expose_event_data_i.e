--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision expose event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_EXPOSE_EVENT_DATA_I

inherit
	EV_EVENT_DATA_I	

feature -- Access

	widget: EV_WIDGET
			-- The mouse pointer was over this widget 
			-- when event happened

	clip_region: EV_RECTANGLE
			-- Exposed region

	exposes_to_come: INTEGER
			-- Number of expose events to come

feature -- Element change	
	
	set_clip_region (clip: EV_RECTANGLE) is
		do
			clip_region := clip
		end 

end -- class EV_EXPOSE_EVENT_DATA_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.3  2000/01/27 19:29:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.2  2000/01/24 23:54:20  oconnor
--| renamed EV_CLIP -> EV_RECTANGLE
--|
--| Revision 1.7.6.1  1999/11/24 17:30:05  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
