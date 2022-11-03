note
	description: "Summary description for {PE_MANIFEST_RESOURCE_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MANIFEST_RESOURCE_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_offset: NATURAL_16; a_flags: NATURAL_16; a_name: NATURAL; a_implementation: PE_IMPLEMENTATION)
		do
			offset := a_offset
			flags := a_flags
			create name.make_with_index (a_name)
			implementation := a_implementation
		end

feature -- Access

	offset: NATURAL_16

	flags: NATURAL_16

	name: PE_STRING

	implementation: PE_IMPLEMENTATION

feature -- Flags

	VisibilityMask: INTEGER = 7
	Public: INTEGER = 1
	Private: INTEGER = 2

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tManifestResource.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement ("Add implementation")
		end

end
