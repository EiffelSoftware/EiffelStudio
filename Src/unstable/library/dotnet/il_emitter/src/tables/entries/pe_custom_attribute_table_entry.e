note
	description: "Summary description for {PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Intialization

	make_with_data (a_parent_index: PE_CUSTOM_ATTRIBUTE; a_type_index: PE_CUSTOM_ATTRIBUTE_TYPE; a_value_index: NATURAL_64)
		do
			parent_index := a_parent_index
			type_index := a_type_index
			create value_index.make_with_index (a_value_index)
		end

feature -- Access

	parent_index: PE_CUSTOM_ATTRIBUTE

	type_index: PE_CUSTOM_ATTRIBUTE_TYPE

	value_index: PE_BLOB

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tcustomattribute.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

end
