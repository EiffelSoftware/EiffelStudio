indexing

	description: 
		"EiffelVision horizontal box, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_HORIZONTAL_BOX_IMP
	
inherit
	
	EV_HORIZONTAL_BOX_I
		
	EV_BOX_IMP
	
create
		make

feature {NONE} -- Initialization
	
        make is
                        -- Create a fixed widget. 
		do
			widget := gtk_hbox_new (Default_homogeneous, Default_spacing)
			gtk_object_ref (widget)
		end

feature -- Status report

	is_child_expandable (child: EV_WIDGET): BOOLEAN is
			-- Is the child corresponding to `index' expandable. ie: does it
			-- accept the parent to resize or move it.
		local
			child_imp: EV_WIDGET_IMP
		do
			child_imp ?= child.implementation
			Result := c_gtk_box_is_child_expandable (widget, child_imp.vbox_widget)
		end
	
feature -- Status settings

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Make the child corresponding to `index' expandable if `flag',
			-- not expandable otherwise.
		local
			child_imp: EV_WIDGET_IMP
		do
			child_imp ?= child.implementation
			c_gtk_box_set_child_expandable (widget, child_imp.vbox_widget, flag)
		end	

end -- class EV_HORIZONTAL_BOX_IMP

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
