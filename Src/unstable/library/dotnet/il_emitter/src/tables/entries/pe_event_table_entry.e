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

	render (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

end

