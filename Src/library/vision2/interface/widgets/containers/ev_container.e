indexing

	description: 
		"EiffelVision composite. Composite is a widget that can hold children inside it"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
--XX deferred class 
class 
	
	EV_CONTAINER

inherit

	EV_WIDGET
		redefine
			implementation
		end
	
	
feature {EV_WIDGET}
	
	add_child (c: EV_WIDGET) is
			-- Add child into composite
		require
			valid_child: c /= Void and then not c.destroyed
			no_other_children: child = Void
		do
			implementation.add_child (c.implementation)
			child := c
		ensure
			child = c
		end
	
feature -- Access
	
	child: EV_WIDGET
			-- The child managed by the composite
	
feature {NONE} -- Implementation

        implementation: EV_WINDOW_I
	
end -- class CONTAINER
