indexing

	description: 
		"EiffelVision label"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LABEL

inherit

	EV_BAR_ITEM
		redefine
			make
		end
	
	EV_TEXT_CONTAINER
	
creation
	
	make

feature {NONE} -- Initialization

        make (parent: CONTAINER) is
                        -- Create a label with, `parent' as
                        -- parent
		do
			!EV_LABEL_IMP!implementation.make (parent)
			Precursor (parent)
		end
		

		
end -- class EV_LABEL
