indexing

	description: 
		"EiffelVision composite, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
--XX deferred class
class
	
	EV_CONTAINER_IMP
	
inherit
	
	EV_WIDGET_IMP
	
feature {EV_CONTAINER}
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		do
			gtk_container_add (widget, child_imp.widget)
		end
	

feature -- Access
	
	client_width: INTEGER is
			-- Width of the client area of container
		do
                        check
                                not_yet_implemented: False
                        end		
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
		do
                        check
                                not_yet_implemented: False
                        end		
		end




end

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
