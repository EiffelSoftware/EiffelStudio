note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_XRPC_METHOD_TAG

inherit
	XTAG_TAG_SERIALIZER

create
	make

feature -- Initialization

	make
			-- <Precursor>
		do
			make_base
			create {XTAG_TAG_VALUE_ARGUMENT} name.make_default
		end

feature -- Access

	name: XTAG_TAG_ARGUMENT
			-- The name of the method


feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			-- TODO
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if a_id.is_equal ("name") then
				name := a_attribute
			end
		end

end
