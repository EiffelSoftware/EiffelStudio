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
		redefine
			implementation
		end
	
	EV_TEXTABLE
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

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
