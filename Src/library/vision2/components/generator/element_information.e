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
