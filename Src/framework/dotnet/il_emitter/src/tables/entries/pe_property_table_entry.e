note
	description: "Object representing the Property table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Property Table", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=267&zoom=100,116,494", "protocol=uri"
class
	PE_PROPERTY_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: NATURAL_16; a_name: NATURAL_32; a_property_type: NATURAL_32)
		do
			flags := a_flags
			create name.make_with_index (a_name)
			create property_type.make_with_index (a_property_type)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.flags = flags and then
					e.name.is_equal (name) and then
					e.property_type.is_equal (property_type)
				)
		end

feature -- Access

	flags: NATURAL_16
			-- defined as a word two bytes.

	name: PE_STRING
			-- an index into the String heap

	property_type: PE_BLOB
			-- Yes this is a signature in the blob.

feature -- Status report	

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{Property} "
			Result := Result + " name[" + name.debug_output + "]"
			Result := Result + " type[" + property_type.debug_output + "]"
		end

feature -- Flags

	SpecialName: INTEGER = 0x200
	ReservedMask: INTEGER = 0xf400
	RTSpecialName: INTEGER = 0x400
	HasDefault: INTEGER = 0x1000

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tProperty
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write flags to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_natural_16 (a_dest, flags, 0)

				-- Intialize the number of bytes written
			l_bytes := 2

				-- Write name and property_type to the buffer and update the number of bytes.
			l_bytes := l_bytes + name.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + property_type.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Set the offset (from a_src)  to action
			flags := {BYTE_ARRAY_HELPER}.natural_16_at (a_src, 0)

				-- Intialize the number of bytes.
			l_bytes := 2

				-- Read name and property_type from the buffer and update the number of bytes.
			l_bytes := l_bytes + name.get (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + property_type.get (a_sizes, a_src, l_bytes)
				-- Return the number of bytes readed
			Result := l_bytes
		end

end

