note
	description: "Summary description for {PE_MEMBER_REF_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MEMBER_REF_TABLE_ENTRY

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

	make_with_data (a_parent_index: PE_MEMBER_REF_PARENT; a_name_index: NATURAL; a_signature_index: NATURAL)
		do
			parent_index := a_parent_index
			create name_index.make_with_index (a_name_index)
			create signature_index.make_with_index (a_signature_index)
		end

feature -- Access

	parent_index: PE_MEMBER_REF_PARENT

	name_index: PE_STRING

	signature_index: PE_BLOB

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tmemberref.value.to_integer_32
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
