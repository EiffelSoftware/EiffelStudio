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
			add_child,
			add_child_ok
		end
	

feature -- Status report
	
	add_child_ok: BOOLEAN is
			-- True, if it is ok to add a child to
			-- container. With menu item container, it is
			-- always ok.
		do
			Result := True
		end


feature {EV_WIDGET}
	
	add_child (c: EV_WIDGET) is
			-- If c is menu item, add it as a menu item, 
			-- otherwise use normal add_child of container

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
