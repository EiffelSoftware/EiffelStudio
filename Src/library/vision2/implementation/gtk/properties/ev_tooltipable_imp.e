--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"Eiffel Vision tooltipable. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_TOOLTIPABLE_IMP
	
inherit
	
	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

feature -- Initialization

	tooltip: STRING
			-- Pixmap that has been set.

feature -- Element change

	set_tooltip (a_text: STRING) is
			-- Assign `a_text' to `tooltip'.
		local
			app_imp: EV_APPLICATION_IMP
	        do
			tooltip := clone (a_text)
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			C.gtk_tooltips_set_tip (app_imp.tooltips, c_object,
				eiffel_to_c (a_text), NULL)
		end

	remove_tooltip is
			-- Set `tooltip' to `Void'.
		local
			app_imp: EV_APPLICATION_IMP
	        do
			tooltip := Void
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			C.gtk_tooltips_set_tip (app_imp.tooltips, c_object,
				NULL, NULL)
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE

end -- EV_TOOLTIPABLE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/06/07 17:27:33  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.3  2000/05/05 16:39:32  king
--| Added not for release
--|
--| Revision 1.2  2000/05/05 16:36:17  king
--| Corrected set_tooltip
--|
--| Revision 1.1.2.3  2000/05/10 23:02:56  king
--| Integrated inital tooltipable changes
--|
--| Revision 1.1.2.2  2000/05/04 18:50:31  king
--| Corrected set_tooltip
--|
--| Revision 1.1.2.1  2000/05/03 19:08:41  oconnor
--| mergred from HEAD
--|
--| Revision 1.1  2000/05/02 22:15:40  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
