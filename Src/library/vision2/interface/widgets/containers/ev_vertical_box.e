indexing

	description: 
		"EiffelVision vertical box."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 

	EV_VERTICAL_BOX

inherit

	EV_BOX
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
			!EV_VERTICAL_BOX_IMP!implementation.make (par)
			Precursor (par)
		end

feature {NONE} -- Implementation
	
	implementation: EV_VERTICAL_BOX_I
			
end -- class EV_VERTICAL_BOX
