indexing

	description: 
		"EiffelVision composite, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_CONTAINER_IMP
	
inherit
	EV_CONTAINER_I

	EV_WIDGET_IMP

	EV_GTK_CONTAINERS_EXTERNALS
	
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
	
feature {EV_RADIO_BUTTON_IMP} -- Access
	
	radio_button_group: POINTER is
			-- Gtk radio button group for this container. 
			-- If no radio buttons are added inside this 
			-- container, return Default_pointer
		do
			if rbg_pointer = Void then
				Result := Default_pointer
			else
				Result := rbg_pointer
			end
		end
	
	set_rbg_pointer (new_rbg_pointer: POINTER) is
		do
			rbg_pointer := new_rbg_pointer
		end
	
feature {EV_CONTAINER, EV_WIDGET_IMP} -- Element change
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		do
			child := child_imp
			gtk_container_add (widget, child_imp.widget)
		end
	

feature {NONE} -- Implementation
	
	rbg_pointer: POINTER
						

feature {EV_WIDGET_IMP} -- Implementation

	child_packing_changed (the_child: EV_WIDGET_IMP) is
		do
		end

--	child_expand_changed (the_child: EV_WIDGET_IMP) is
--		deferred	
 --		end

--	child_vertresize_changed (the_child: EV_WIDGET_IMP) is
--		deferred	
--		end

--	child_horiresize_changed (the_child: EV_WIDGET_IMP) is
--		deferred	
--		end

end -- class EV_CONTAINER_IMP

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
