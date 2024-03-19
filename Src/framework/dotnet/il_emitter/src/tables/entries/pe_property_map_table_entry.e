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
			same_as
		end

	DEBUG_OUTPUT


create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_parent: NATURAL_32; a_property_list: NATURAL_32)
		do
			create parent.make_with_index (a_parent)
			create property_list.make_with_index (a_property_list)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| There shall be no duplicate rows, based upon Parent (a given class has only one
			--| ‘pointer’ to the start of its property list)
			--| There shall be no duplicate rows, based upon PropertyList (different classes cannot
			--|	share rows in the Property table)
		do
			Result := Precursor (e)
				or else (
					e.parent.is_equal (parent) or else
					e.property_list.is_equal (property_list)
				)
		end

feature -- Access

	parent: PE_TYPE_DEF
			-- an index into the TypeDef table.

	property_list: PE_PROPERTY_LIST
			-- an index into the Property table.

feature -- Status report	

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{Field} "
			Result := Result + " parent[" + parent.debug_output + "]"
			Result := Result + " properties[" + property_list.debug_output + "]"
		end

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tPropertyMap
		end

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write parent and propety_list to the buffer and update the bytes.
			l_bytes := parent.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + property_list.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes.
			Result := l_bytes
		end

	rendering_size (a_sizes: SPECIAL [NATURAL_32]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Read parent and propety_list from the buffer and update the bytes.
			l_bytes := parent.rendering_size (a_sizes)
			l_bytes := l_bytes + property_list.rendering_size (a_sizes)

				-- Return the number of bytes.
			Result := l_bytes
		end

end

