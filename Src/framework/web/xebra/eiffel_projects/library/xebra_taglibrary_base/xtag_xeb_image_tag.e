
note
	description: "[
		Defines validator classes for an input field.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_IMAGE_TAG

inherit
	XTAG_TAG_SERIALIZER

create
	make

feature -- Initialization

	make
		do
			make_base		
		end

feature {NONE} -- Access

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
		
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do

		end

end
