note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XRPC_API_TAG

inherit
	XTAG_TAG_SERIALIZER

create
	make

feature -- Initialization

	make
			-- <Precursor>
		do
			make_base
			create {XTAG_TAG_VALUE_ARGUMENT} i_class.make_default
			create {XTAG_TAG_VALUE_ARGUMENT} namespace.make_default
		ensure
			i_class_attached: attached i_class
			namespace_attached: attached namespace
		end

feature -- Access

	i_class: XTAG_TAG_ARGUMENT
			-- The name of the associated class (controller)

	namespace: XTAG_TAG_ARGUMENT
			-- Optional namespace of the xrpc api

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			-- TODO
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
			if a_id.is_equal ("i_class") then
				i_class := a_attribute
			end
			if a_id.is_equal ("namespace") then
				namespace := a_attribute
			end
		end

end
