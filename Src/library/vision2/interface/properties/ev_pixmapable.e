indexing

	description: 
		"EiffelVision pixmap container. Pixmap container is used internally in EiffelVision (by EV_BUTTON and EV_MENU_ITEM to allow a EV_PIXMAP to be put inside it)."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 

	EV_PIXMAP_CONTAINER

inherit

	EV_CONTAINER
		redefine
			implementation
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
		do
			!EV_PIXMAP_CONTAINER_IMP!implementation.make_from_primitive (primitive)
		end
	
	
	
feature {NONE} -- Implementation
	
	implementation: EV_PIXMAP_CONTAINER_I
			
end
