note
	description: "Summary description for {PE_EVENT_TABLE_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_EVENT_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: NATURAL_16; a_name: NATURAL; a_event_type: PE_TYPEDEF_OR_REF)
		do
			flags := a_flags
			create name.make_with_index (a_name)
			event_type := a_event_type
		end

feature -- Access

	flags: NATURAL_16
		-- defined as word two bytes.

	name: PE_STRING

	event_type: PE_TYPEDEF_OR_REF

feature -- Enum: Flags

	SpecialName: INTEGER = 0x200
	ReservedMask: INTEGER = 0x400
	RTSpecialName: INTEGER = 0x400

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tEvent.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write falgs to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, flags, 0)

				-- Intialize the number of bytes written
			l_bytes := 2

				-- Write name and event_type to the buffer and update the number of bytes.
			l_bytes := l_bytes + name.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + event_type.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end


	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the flags (from a_src)  to action
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, 0)

				-- Intialize the number of bytes.
			l_bytes := 2

				-- Read name and event_type from the buffer and update the number of bytes.
			l_bytes := l_bytes + name.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + event_type.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed
			Result := l_bytes
		end
end

