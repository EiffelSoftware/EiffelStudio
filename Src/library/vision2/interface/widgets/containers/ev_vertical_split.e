indexing

	description: 
		"EiffelVision vertical split."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EV_VERTICAL_SPLIT

inherit

	EV_SPLIT 
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
			!EV_VERTICAL_SPLIT_IMP!implementation.make (par)
			widget_make (par)
		end
			
feature {EV_MENU_ITEM} -- Implementation
	
	implementation: EV_SPLIT_I	

end 
