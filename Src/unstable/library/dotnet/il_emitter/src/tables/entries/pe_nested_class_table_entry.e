note
	description: "Summary description for {PE_NESTED_CLASS_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_NESTED_CLASS_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_nested: NATURAL_64; a_enclosing: NATURAL_64)
		do
			create nested_index.make_with_index (a_nested)
			create enclosing_index.make_with_index (a_enclosing)
		end

feature -- Access

	nested_index: PE_TYPE_DEF

	enclosing_index: PE_TYPE_DEF

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tNestedClass.value.to_integer_32
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
