indexing

	description: 
		"EiffelVision vertical box, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_VERTICAL_BOX_IMP
	
inherit
	
	EV_VERTICAL_BOX_I
		
	EV_BOX_IMP
	
creation
	
	make

feature {NONE} -- Initialization
	
        make (par: EV_CONTAINER) is
                        -- Create a fixed widget. 
		do
			widget := gtk_vbox_new (Default_homogeneous, Default_spacing)
		end	
	
feature {EV_BOX} -- Implementation
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. Several children
			-- possible.
		do
			child ?= child_imp
			gtk_box_pack_start (widget, child_imp.widget, 
			    child_imp.expandable,
			    child_imp.vertical_resizable, 0)
		end

feature {EV_WIDGET_IMP} -- Implementation

	child_expand_changed (the_child: EV_WIDGET_IMP) is
		do
			c_gtk_box_set_child_options (widget, the_child.widget,
				  the_child.expandable, the_child.vertical_resizable)
 		end	

	child_vertresize_changed (the_child: EV_WIDGET_IMP) is
		do
			c_gtk_box_set_child_options (widget, the_child.widget,
				  the_child.expandable, the_child.vertical_resizable)
		end

	child_horiresize_changed (the_child: EV_WIDGET_IMP) is
		do
			
		end

end -- class EV_VERTICAL_BOX_IMP

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
