indexing

	description: 
		"EiffelVision box, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_BOX_IMP
	
inherit
	EV_BOX_I
		
	EV_INVISIBLE_CONTAINER_IMP
		undefine
			add_child,
			child_expand_changed,
			child_horiresize_changed,
			child_vertresize_changed
		end

feature {NONE} -- Initialization
	
        make (par: EV_CONTAINER) is
                        -- Create a fixed widget. 
		deferred
		end	

feature -- Element change (box specific)
	
	set_homogeneous (flag: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			gtk_box_set_homogeneous (widget, flag)
		end
	
	set_spacing (value: INTEGER) is
			-- Spacing between the objects in the box
		do
			gtk_box_set_spacing (widget, value)
		end	
	
feature {EV_WIDGET_IMP} -- Implementation

	set_child_options (resize_flag, position_flag: BOOLEAN; the_child:EV_WIDGET_IMP) is
			-- Set the new options of the child in the box
		do
			
		end

--feature {EV_BOX} -- Implementation
	
--	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. Several children
			-- possible.
--		do
--			child ?= child_imp
--			gtk_box_pack_start (widget, child_imp.widget, 
--					    child_imp.expand, , 0)
--		end

end -- class EV_BOX_IMP

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
