indexing
	description: 
	"EiffelVision text area. To query multiple lines of text from the user"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT

inherit
	EV_TEXT_COMPONENT
		redefine
			make,
			implementation
		end
	
creation
	make,
	make_with_text
	
feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty text area with `par' as
			-- parent.
		do
			!EV_TEXT_IMP!implementation.make
			widget_make (par)
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a text area with `par' as
			-- parent and `txt' as text.
		require
			valid_parent: parent_needed implies par /= Void
		do
			!EV_TEXT_IMP!implementation.make_with_text (txt)
			widget_make (par)
		end

feature -- Basic operation

	search (str: STRING): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `Void'
		require
			exists: not destroyed
			valid_string: str /= Void
		do
			Result := implementation.search (str)
		end

feature {NONE} -- Implementation

	implementation: EV_TEXT_I
			-- Implementation 
			
end -- class EV_TEXT

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

