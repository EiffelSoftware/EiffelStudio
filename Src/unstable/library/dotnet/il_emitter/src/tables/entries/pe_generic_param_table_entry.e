note
	description: "Summary description for {PE_GENERIC_PARAM_TABLE}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GENERIC_PARAM_TABLE_ENTRY

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

	make_with_data (a_number: NATURAL_16; a_flags: NATURAL_16; a_owner: PE_TYPE_OR_METHOD_DEF; a_name: NATURAL)
		do
			number := a_number
			flags := a_flags
			owner := a_owner
			create name.make_with_index (a_name)
		end

feature -- Access

	number: NATURAL_16
			-- Defined as word two bytes.

	flags: NATURAL_16
			-- Defined as word two bytes.

	owner: PE_TYPE_OR_METHOD_DEF

	name: PE_STRING

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tGenericParam.value.to_integer_32
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


