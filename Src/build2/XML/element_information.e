indexing
	description: "Objects that hold both a name, a piece of data%
		% and an XML_ELEMENT. For use by application generator."
	date: "$Date$"
	revision: "$Revision$"

class
	ELEMENT_INFORMATION

create
	default_create

feature -- Initialization

feature -- Access

	name: STRING
		-- Name contained.

	data: STRING
		-- Data associated with `Name'.

	element: XML_ELEMENT
		-- Element associated with `Name'.

feature -- Status setting

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		do
			name := a_name
		end

	set_data (a_data: STRING) is
			-- Assign `a_data' to `data'.
		do
			data := a_data
		end

	set_element (an_element: XML_ELEMENT) is
			-- Assign `an_element' to `element'.
		do
			element := an_element
		end

end -- class ELEMENT_INFORMATION


--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

