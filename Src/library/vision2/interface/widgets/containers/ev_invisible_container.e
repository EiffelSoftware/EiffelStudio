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
			add_child_ok
		end
	

feature -- Status report
	
	add_child_ok: BOOLEAN is
			-- True, if it is ok to add a child to
			-- container. With invisible container, it is 
			-- always ok.
		do
			Result := True
		end

	
	-- feature 'child' in this class means the last child added

feature {NONE} -- Implementation
	
	implementation: EV_INVISIBLE_CONTAINER_I
			
end -- class EV_FIXED
