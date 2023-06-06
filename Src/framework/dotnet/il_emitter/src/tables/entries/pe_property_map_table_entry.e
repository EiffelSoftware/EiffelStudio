note
	description: "Object representing the PropertyMap table."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Property Map", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=268&zoom=100,116,710", "protocol=uri"

class
	PE_PROPERTY_MAP_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
		end


create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_parent: NATURAL_64; a_property_list: NATURAL_64)
		do
			create parent.make_with_index (a_parent)
			create property_list.make_with_index (a_property_list)
		end

feature -- Status

	token_from_tables (tables: MD_TABLES): NATURAL_64
			-- If Current was already defined in `tables` return the associated token.
		local
			n: NATURAL_64
		do
			n := 0
			across
				tables as i
			until
				Result /= {NATURAL_64} 0
			loop
				n := n + 1
				if
					attached {like Current} i as e and then
					e.parent.is_equal (parent) and then
					e.property_list.is_equal (property_list)
				then
					Result := n
				end
			end
		end

feature -- Access

	parent: PE_TYPE_DEF
			-- an index into the TypeDef table.

	property_list: PE_PROPERTY_LIST
			-- an index into the Property table.

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tPropertyMap.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write parent and propety_list to the buffer and update the bytes.
			l_bytes := parent.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + property_list.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Read parent and propety_list from the buffer and update the bytes.
			l_bytes := parent.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + property_list.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes.
			Result := l_bytes
		end

end

