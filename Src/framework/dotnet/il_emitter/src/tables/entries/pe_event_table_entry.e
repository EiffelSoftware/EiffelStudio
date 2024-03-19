note
	description: "Summary description for {PE_EVENT_TABLE_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_EVENT_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

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

feature -- Status report

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tEvent
		end

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write falgs to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_natural_16 (a_dest, flags, 0)

				-- Intialize the number of bytes written
			l_bytes := 2

				-- Write name and event_type to the buffer and update the number of bytes.
			l_bytes := l_bytes + name.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + event_type.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end


	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Set the flags (from a_src)  to action
			flags := {BYTE_ARRAY_HELPER}.natural_16_at (a_src, 0)

				-- Intialize the number of bytes.
			l_bytes := 2

				-- Read name and event_type from the buffer and update the number of bytes.
			l_bytes := l_bytes + name.get (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + event_type.get (a_sizes, a_src, l_bytes)

				-- Return the number of bytes readed
			Result := l_bytes
		end
end

