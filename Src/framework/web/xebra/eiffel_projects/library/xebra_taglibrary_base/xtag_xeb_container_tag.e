note
	description: "[
		{XTAG_XEB_CONTAINER_TAG}.
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

feature -- Access

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			generate_children (a_servlet_class, variable_table)
		end

	internal_put_attribute (id: STRING; a_attribute: STRING)
			-- <Precursor>
		do
		end

	generates_render: BOOLEAN = True
end
