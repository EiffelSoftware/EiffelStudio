note
	description: "Summary description for {PE_EXPORTED_TYPE_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_EXPORTED_TYPE_TABLE_ENTRY
inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

	PE_TYPE_DEF_FLAGS

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: NATURAL; a_type_def_id: NATURAL; a_type_name: NATURAL; a_type_name_space: NATURAL; a_implementation: PE_IMPLEMENTATION)
		do
			flags := a_flags
			create type_def_id.make_with_index (a_type_def_id)
			create type_name.make_with_index (a_type_name)
			create type_name_space.make_with_index (a_type_name_space)
			implementation := a_implementation
		end

feature -- Access

	flags: NATURAL
			-- Defined as a DWord four bytes.

	type_def_id: PE_TYPE_DEF

	type_name: PE_STRING

	type_name_space: PE_STRING

	implementation: PE_IMPLEMENTATION

feature -- Operations

	table_index: INTEGER
		do
			fixme ("Double check if tManifestResource its ok or tExportedType is the correct one. ")
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
