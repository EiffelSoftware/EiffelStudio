indexing

	description: 
		"EiffelVision pixmap, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_PIXMAP_IMP
	
inherit
	EV_PIXMAP_I

	EV_DRAWABLE_IMP

	EV_PRIMITIVE_IMP
		rename
			make as widget_make
		end
	
creation

	make

feature {NONE} -- Initialization

	make (parent: EV_PIXMAP_CONTAINER) is
                        -- Create a gtk pixmap.
                local
			par_imp: EV_WIDGET_IMP
                do
			par_imp ?= parent.implementation
			check 
				parent_ok: par_imp /= Void
			end
			
			parent_widget := par_imp.widget
			
			widget := c_gtk_pixmap_create_empty (parent_widget)
                end

feature -- Element change

	read_from_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			-- If the file does not exist or it is in a 
			-- wrong format, an exception is raised.
		local
			 a: ANY
		do
			a ?= file_name.to_c
			
			if widget = Void then
				widget := c_gtk_pixmap_create_from_xpm (parent_widget, 
									$a)
			else
				c_gtk_pixmap_read_from_xpm (widget, parent_widget, $a)
			end
			
		end	
		
feature {NONE} -- Implementation

	parent_widget: POINTER

end -- EV_PIXMAP_IMP

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
