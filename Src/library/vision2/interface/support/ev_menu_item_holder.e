indexing

	description: 
		"EiffelVision menu item container. Abstract class and a common ancestor classes that can contain menu items."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 

	EV_MENU_ITEM_CONTAINER

inherit

	EV_CONTAINER
		redefine
			implementation,
			add_child
		end
	

feature {EV_WIDGET}
	
	add_child (c: EV_WIDGET) is
			-- If c is menu item, add it as a menu item, 
			-- otherwise use normal add_child of container
		require else 
			-- Don't use the parent's precondition,
			-- because several children are allowed
			exists: not destroyed
			valid_child: c /= Void and then not c.destroyed
		local
			i: EV_MENU_ITEM
		do
			i ?= c
			if i = Void then
				implementation.add_child (c.implementation)
			else
				implementation.add_menu_item (i.implementation)
			end
			child := c
		end
	
	-- feature child in this class means the last child
feature {NONE} -- Implementation
	
	implementation: EV_MENU_ITEM_CONTAINER_I
			
end 
