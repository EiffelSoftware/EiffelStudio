indexing
	description: 
		"Eiffel Vision aggregate widget. WEL implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_AGGREGATE_WIDGET_IMP
	
inherit
	EV_AGGREGATE_WIDGET_I
		redefine
			interface
		select
			interface
		end

	EV_HORIZONTAL_BOX_IMP
		rename
			interface as ev_horizontal_box_imp_interface
		redefine
			make,
			initialize
		end
create
	make

feature -- initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			ev_wel_control_container_make
			!! ev_children.make (2)
			is_homogeneous := Default_homogeneous
			padding := Default_spacing
			border_width := Default_border_width
		end

	initialize is
			-- Initialize aggregate box.
		local
			b: EV_AGGREGATE_BOX_IMP
		do
			{EV_HORIZONTAL_BOX_IMP} Precursor
			create {EV_AGGREGATE_BOX} box
			extend (box)
			b ?= box.implementation
			b.set_real_parent (Current)
		end

feature -- Implementation

	interface: EV_WIDGET
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_AGGREGATE_IMP

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
--| Revision 1.8  2000/03/03 16:18:21  brendel
--| Fixed bug in order of initialization, where a widget cannot be added
--| before initialize is called.
--|
--| Revision 1.7  2000/02/22 18:39:45  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/22 17:32:26  rogers
--| Removed 'cell' which was no longer required.
--|
--| Revision 1.5  2000/02/21 20:04:47  rogers
--| Now inherits EV_HORIZONTAL_BOX_IMP. Removed features that had been defined within this class but are now inherited from EV_HORIZONTAL_BOX_IMP.
--|
--| Revision 1.4  2000/02/15 19:26:44  rogers
--| In make, now extend the internal box with the cell. Altered parent to return parent, instead of cell.parent.
--|
--| Revision 1.3  2000/02/14 22:26:33  oconnor
--| merged from HACK-O-RAMA
--|
--| Revision 1.1.2.4  2000/02/14 20:53:58  rogers
--| Removed the inheritance of EV_WIDGET_IMP and EV_CONTAINER_IMP. Added cell, and implemented deferred features inherited from EV_AGGREGATE_WIDGET_I, to use this cell. ev_aggregate_widget_imp.e
--|
--| Revision 1.1.2.3  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.1.2.2  2000/01/28 19:00:34  oconnor
--| changed to use EV_AGGREGATE_BOX
--|
--| Revision 1.1.2.1  2000/01/28 16:40:35  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
