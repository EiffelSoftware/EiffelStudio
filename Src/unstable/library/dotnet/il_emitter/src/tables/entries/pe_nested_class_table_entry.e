note
	description: "Summary description for {PE_NESTED_CLASS_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_NESTED_CLASS_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

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

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			l_bytes := nested_index.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + enclosing_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			l_bytes := nested_index.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + enclosing_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			Result := l_bytes
		end

end
