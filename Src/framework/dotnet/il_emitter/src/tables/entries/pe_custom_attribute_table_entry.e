note
	description: "Object representing the CustomAttribute table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=CustomAttribute", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=242&zoom=100,116,794", "protocol=uri"

class
	PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

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

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write parent_index, type_index and value_index to the buffer and update
				-- the number of bytes
			l_bytes := parent_index.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + type_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + value_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Read parent_index, type_index and value_index from the buffer and update
				-- the number of bytes
			l_bytes := parent_index.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + type_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + value_index.render (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed
			Result := l_bytes
		end

end
