indexing

	description: 
		"EiffelVision horizontal split."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_HORIZONTAL_SPLIT

inherit

	EV_SPLIT
		redefine
			make,			
			implementation
		end
	
creation
	
	make
	
feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a widget with, `par' as parent
		do
			!EV_HORIZONTAL_SPLIT_IMP!implementation.make (par)
			widget_make (par)
		end	
	
feature {NONE} -- Implementation
	
	implementation: EV_HORIZONTAL_SPLIT_I
			
end -- class EV_HORIZONTAL_SPLIT_AREA
