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
			-- Tooltip that has been set.

feature -- Element change

	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
		local
			app_imp: EV_APPLICATION_IMP
			old_ref_count: INTEGER
	        do
			tooltip := clone (a_text)
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			old_ref_count := C.gtk_object_struct_ref_count (c_object)
			C.gtk_tooltips_set_tip (
				app_imp.tooltips,
				c_object,
				eiffel_to_c (a_text),
				NULL
			)
		end

	remove_tooltip is
			-- Set `tooltip' to `Void'.
		local
			app_imp: EV_APPLICATION_IMP
	        do
			tooltip := Void
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			C.gtk_tooltips_set_tip (
				app_imp.tooltips,
				c_object,
				NULL,
				NULL
			)
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
--| Revision 1.5  2001/06/07 23:08:04  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.7  2001/03/15 00:25:11  gauthier
--| Does not try any more to remove the reference added by the tooltip, as
--| it was prematurely destroying the object when removing a tooltip or
--| setting a new one.
--|
--| Revision 1.1.2.6  2000/10/09 19:20:25  oconnor
--| cosmetics
--|
--| Revision 1.1.2.5  2000/09/18 18:10:27  oconnor
--| If adding a tooltip refs the widget, remove the new ref.
--| The tooltip has no buisness holding a strong reference to the widget.
--| This is a GTK bug/feature depending to who you listen to on the list.
--|
--| Revision 1.1.2.4  2000/06/27 23:42:08  king
--| Now using visual_widget instead of c_object
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
