indexing

	description: 
		"EiffelVision split. Split consists of two parts divided by a groove, which can be moved by the user to change the visible portion of the parts. Split is an abstract class with effective decendants horizontal and vertical split."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class EV_SPLIT_AREA

inherit

	EV_CONTAINER 
		redefine
			implementation,
			add_child,
			add_child_ok,
			child_add_successful
		end
	
feature -- Access
	
	-- The first child of the split area
	child1: EV_WIDGET
	-- The second child of the split area
	child2: EV_WIDGET 
	
	-- 'child' defined in EV_CONTAINER is the last child added to
	-- the split
	
feature -- Status report
	
	add_child_ok: BOOLEAN is
			-- True, if it is ok to add a child to
			-- container. Two children
			-- are allowed
		do
			Result := child2 = Void or child = Void
		end
	
	child_add_successful (new_child: EV_WIDGET): BOOLEAN is
			-- Used in the postcondition of 'add_child'
		do
			Result := child = new_child and (child1 = new_child or child2 = new_child)
		end	
	
feature {EV_WIDGET}
	
	add_child (c: EV_WIDGET) is
			-- Add child into split area. Split area can 
			-- have two children.
		do
			child := c
			if child1 = Void then
				child1 := c
				implementation.add_child1 (c.implementation)
			else
				child2 := c
				implementation.add_child2 (c.implementation)
			end
		end
	

feature {EV_MENU_ITEM} -- Implementation
	
	implementation: EV_SPLIT_AREA_I	

end -- class EV_MENU
