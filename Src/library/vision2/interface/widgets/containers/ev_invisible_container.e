indexing

	description: 
		"EiffelVision invisible container. Invisible container is a container to be put inside another container to change the behavior of the child positioning and sizing inside of the container."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 

	EV_INVISIBLE_CONTAINER

inherit

	EV_CONTAINER
		redefine
			implementation,
			add_child
		end
	

feature {EV_WIDGET}
	
		add_child (c: EV_WIDGET) is
			-- Add child into composite. Several children
			-- possible.
		require else 
			-- Don't use the parent's precondition,
			-- because several children are allowed
			exists: not destroyed
			valid_child: c /= Void and then not c.destroyed
		do
			implementation.add_child (c.implementation)
			child := c
		end
	
	-- feature child in this class means the last child
feature {NONE} -- Implementation
	
	implementation: EV_INVISIBLE_CONTAINER_I
			
end -- class EV_FIXED
