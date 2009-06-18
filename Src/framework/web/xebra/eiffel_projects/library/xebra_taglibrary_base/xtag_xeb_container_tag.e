note
	description: "[
		A simple tag which does nothing apart from rendering its children
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_CONTAINER_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render
		end

create
	make

feature -- Initialization

	make
		do
			make_base
		end

feature -- Basic implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			generate_children (a_servlet_class, variable_table)
		end

	internal_put_attribute (id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
		end

	generates_render: BOOLEAN = True
	
end
