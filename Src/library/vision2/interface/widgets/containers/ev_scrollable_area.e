indexing

	description: 
		"EiffelVision scrollable area. Scrollable area is a container with scrollbars. Scrollable area offers automatic scrolling for its child."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EV_SCROLLABLE_AREA

inherit

	EV_CONTAINER 
		redefine
			make,
			implementation
		end
	
creation
	make
	

feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a fixed widget with, `par' as
                        -- parent
		do
			!EV_SCROLLABLE_AREA_IMP!implementation.make (par)
			widget_make (par)
		end	

feature {EV_MENU_ITEM} -- Implementation
	
	implementation: EV_SCROLLABLE_AREA_I	

end
