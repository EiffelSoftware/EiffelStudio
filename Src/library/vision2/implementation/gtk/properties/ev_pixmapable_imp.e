indexing

	description: 
		"EiffelVision pixmap container, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_PIXMAP_CONTAINER_IMP
	
inherit
	
	EV_PIXMAP_CONTAINER_I
		
	EV_CONTAINER_IMP
		redefine
			add_child
		end
	
	
creation	

	make_from_primitive

feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is
		do
			check
				do_not_call: False
			end
		end
	
	make_from_primitive (primitive: EV_BUTTON) is
			-- Create pixmap container inside of 'primitive'
		local
			primitive_imp: EV_BUTTON_IMP
		do
			primitive_imp ?= primitive.implementation
			check
				valid_primitive: primitive_imp /= Void
			end
			
			widget := primitive_imp.box
		end	
	
feature {EV_CONTAINER} -- Element change
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		do
			gtk_box_pack_start (GTK_BOX (widget), child_imp.widget, True, False, 0)
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
