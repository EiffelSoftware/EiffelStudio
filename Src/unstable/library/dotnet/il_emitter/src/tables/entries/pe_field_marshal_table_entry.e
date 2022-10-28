note
	description: "Summary description for {PE_FIELD_MARSHAL_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_MARSHAL_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Intialization

	make_with_data (a_parent: PE_FIELD_MARSHAL; a_native_type: NATURAL)
		do
			parent := a_parent
			create native_type.make_with_index (a_native_type)
		end

feature -- Access

	parent: PE_FIELD_MARSHAL

	native_type: PE_BLOB

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tfieldmarshal.value.to_integer_32
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
