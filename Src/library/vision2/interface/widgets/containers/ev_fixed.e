indexing

	description: 
		"EiffelVision fixed. Invisible container that allows unlimited number of other widgets to be put inside it. The location of each widget inside is specified by the coordinates of the widget."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class EV_FIXED

inherit

	EV_INVISIBLE_CONTAINER
		redefine
			make,
			implementation,
			manager
		end
	
creation
	
	make
	
feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a fixed widget with, `par' as
                        -- parent
		do
			!EV_FIXED_IMP!implementation.make (par)
			Precursor (par)
		end

feature -- Access
	
	manager: BOOLEAN is 
		once
			Result := False
		end
	
feature {NONE} -- Implementation
	
	implementation: EV_FIXED_I
			
end -- class EV_FIXED
