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

	EV_PRIMITIVE
		redefine
			make, implementation
		end
	
	EV_BAR_ITEM
	
	EV_TEXT_CONTAINER
		redefine
			implementation
		end

	EV_FONTABLE
		redefine
			implementation
		end
		
creation
	
	make, make_with_text

feature {NONE} -- Initialization

		
	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Label with 'par' as parent and 'txt' as 
			-- text label
		do
			!EV_LABEL_IMP!implementation.make_with_text (par, txt)
			widget_make (par)
		end
	
feature {NONE} -- Implementation

	implementation: EV_LABEL_I
			-- Implementation of label
	
end -- class EV_LABEL
