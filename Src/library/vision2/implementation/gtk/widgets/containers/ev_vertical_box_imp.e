indexing
	description: 
		"EiffelVision vertical box. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "container, box, vertical"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_BOX_IMP
	
inherit
	EV_VERTICAL_BOX_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end
		
	EV_BOX_IMP
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create a GTK vertical box.
		do	
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			container_widget := C.gtk_vbox_new (Default_homogeneous, Default_spacing)
			C.gtk_container_add (c_object, container_widget)
			C.gtk_widget_show (container_widget)
		end

feature {EV_ANY_I} -- Implementation

    interface: EV_VERTICAL_BOX

end -- class EV_VERTICAL_BOX_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

