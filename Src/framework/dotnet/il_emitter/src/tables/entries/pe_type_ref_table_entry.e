note
	description: "Object representing the TypeRef table"
	date: "$Date$"
	revision: "$Revision$"
	see: "II.22.38 TypeRef : 0x01"

class
	PE_TYPE_REF_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_resolution: PE_RESOLUTION_SCOPE; a_type_name_index: NATURAL_32; a_type_name_space_index: NATURAL_32)
		do
			resolution := a_resolution
			create type_name_index.make_with_index (a_type_name_index)
			create type_name_space_index.make_with_index (a_type_name_space_index)
		end

feature -- Access

	resolution: PE_RESOLUTION_SCOPE

	type_name_index: PE_STRING

	type_name_space_index: PE_STRING

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.type_name_index.is_equal (type_name_index) and then
					e.type_name_space_index.is_equal (type_name_space_index)
				)
		end

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.ttyperef.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- render the resolution and store the number of writen bytes.
			l_bytes := resolution.render (a_sizes, a_src, 0)

				-- render the type_name_index and add the number of writen bytes to l_bytes.
			l_bytes := l_bytes + type_name_index.render (a_sizes, a_src, l_bytes.to_integer_32)

				-- render the type_name_space_index and add the number of writen bytes to l_bytes.
			l_bytes := l_bytes + type_name_space_index.render (a_sizes, a_src, l_bytes.to_integer_32)

				--  Return the total number of bytes written to the destination `a_src`
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- read the number of bytes from resolution.
			l_bytes := resolution.get (a_sizes, a_src, 0)

				-- read the number of bytes from type_name_index and update the readed bytes.
			l_bytes := l_bytes + type_name_index.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- read the number of bytes from type_name_space_index and update the readed bytes.
			l_bytes := l_bytes + type_name_space_index.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readad.
			Result := l_bytes
		end

end
