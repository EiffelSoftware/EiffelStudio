indexing

	description: 
		"EiffelVision container. Container is a widget that can hold children inside it"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	
	EV_CONTAINER

inherit

	EV_WIDGET
		redefine
			implementation
		end
	
	
feature -- Access
	
	child: EV_WIDGET
			-- The child managed by the composite
	
	client_width: INTEGER is
			-- Width of the client area (area of the
			-- widget excluding the borders etc) of
			-- container
		require
			exists: not destroyed	
		do
			Result := implementation.client_width
		ensure
			positive_result: Result >= 0
		end
	
	client_height: INTEGER is
			-- Height of the client area (area of the
			-- widget excluding the borders etc) of
			-- container
		require
			exists: not destroyed	
		do
			Result := implementation.client_height
		ensure
			positive_result: Result >= 0	
		end
	
	manager: BOOLEAN is
			-- Manager container manages the geometry of its 
			-- child(ren). Default True.
		once
			Result := True
		end
	
feature -- Status report
	
	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container. Normal container have
			-- only one child, but this feature can be
			-- redefined in decendants.
		do
			Result := child = Void
		end
	
	child_add_successful (new_child: EV_WIDGET): BOOLEAN is
			-- Used in the postcondition of 'add_child'
		do
			Result := child = new_child
		end
	
			
feature {EV_WIDGET}
	
	add_child (c: EV_WIDGET) is
			-- Add child into composite. There can be only
			-- one child inside.
		require
			exists: not destroyed
			valid_child: c /= Void and then not c.destroyed
			add_child_ok: add_child_ok
		do
			implementation.add_child (c.implementation)
			child := c
		ensure
			child_add_successful: child_add_successful (c)
		end
	
		
feature {EV_WIDGET_IMP} -- Implementation

        implementation: EV_CONTAINER_I
	
end -- class CONTAINER
