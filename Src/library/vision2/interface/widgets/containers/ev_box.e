indexing

	description: 
		"EiffelVision box. Invisible container that allows unlimited number of other widgets to be packed inside it. Box controls the location the children's location and size automatically."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 

	EV_BOX

inherit

	EV_INVISIBLE_CONTAINER
		redefine
			implementation
		end
	
	
feature -- Element change (box specific)
	
	set_homogeneous (homogeneous: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size. If homogenous =
			-- True, expand argument for each child is
			-- automatically True
		require
			exist: not destroyed
		do
			implementation.set_homogeneous (homogeneous)
		end
	
	set_spacing (spacing: INTEGER) is
			-- Spacing between the objects in the box
		require
			exist: not destroyed
		do
			implementation.set_spacing (spacing)
		end
		
feature {NONE} -- Implementation
	
	implementation: EV_BOX_I
			
end -- class EV_BOX
