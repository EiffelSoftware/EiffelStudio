indexing

	description: 
		"EiffelVision menu bar. Menu bar is a vertical the screen or in the window containing menu items."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EV_MENU_BAR

inherit

	EV_MENU_ITEM_CONTAINER 
		redefine
			implementation
		end

creation
	
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a menu widget with `par' as
                        -- parent
		do
			!EV_MENU_BAR_IMP!implementation.make (par)
			widget_make (par)
		end	
	
feature {NONE} -- Implementation
	
	implementation: EV_MENU_BAR_I	

end -- class EV_MENU BAR
