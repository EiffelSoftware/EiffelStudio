note
	description: "Object representing The NestedClass table "
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=NestedClass",  "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=266&zoom=100,116,320", "protocol=uri"

class
	PE_NESTED_CLASS_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_nested: NATURAL_64; a_enclosing: NATURAL_64)
		do
			create nested_index.make_with_index (a_nested)
			create enclosing_index.make_with_index (a_enclosing)
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
					e.nested_index.is_equal (nested_index) and then
					e.enclosing_index.is_equal (enclosing_index)
				then
					Result := n
				end
			end
		end
feature -- Access

	nested_index: PE_TYPE_DEF
			-- an index into the TypeDef table.

	enclosing_index: PE_TYPE_DEF
			-- an index into the TypeDef table

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tNestedClass.to_integer_32
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
