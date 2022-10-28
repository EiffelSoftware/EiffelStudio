note
	description: "Summary description for {PE_TYPE_REF_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPE_REF_TABLE_ENTRY

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

	make_with_data (a_resolution: PE_RESOLUTION_SCOPE; a_type_name_index: NATURAL; a_type_name_space_index: NATURAL)
		do
			resolution := a_resolution
			create type_name_index.make_with_index (a_type_name_index)
			create type_name_space_index.make_with_index (a_type_name_space_index)
		end

feature -- Access

	resolution: PE_RESOLUTION_SCOPE

	type_name_index: PE_STRING

	type_name_space_index: PE_STRING


feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.ttyperef.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement  ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement ("Add implementation")
		end

end
