note
	description: "Object representing the CustomAttribute table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=CustomAttribute", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=242&zoom=100,116,794", "protocol=uri"

class
	PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
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

feature -- Status

	token_from_tables (tables: MD_TABLES): NATURAL_64
			-- If Current was already defined in `tables` return the associated token.
		local
			lst: LIST [PE_TABLE_ENTRY_BASE]
			n: NATURAL_64
		do
			lst := tables.table
			n := 0
			across
				lst as i
			until
				Result /= {NATURAL_64} 0
			loop
				n := n + 1
				if
					attached {like Current} i as e and then
					e.parent_index.is_equal (parent_index) and then
					e.type_index.is_equal (type_index) and then
					e.value_index.is_equal (value_index)
				then
					Result := n
				end
			end
		end

feature -- Access

	parent_index: PE_CUSTOM_ATTRIBUTE
			-- an index into a metadata table that has an associated HasCustomAttribute index.

	type_index: PE_CUSTOM_ATTRIBUTE_TYPE
			-- an index into the MethodDef or MemberRef table; more precisely, a CustomAttributeType index.

	value_index: PE_BLOB
			-- an index into the Blob heap.

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tcustomattribute.to_integer_32
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
