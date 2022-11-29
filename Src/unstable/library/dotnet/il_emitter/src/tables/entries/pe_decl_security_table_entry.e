note
	description: "Summary description for {PE_DECL_SECURITY_TABLE_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_DECL_SECURITY_TABLE_ENTRY

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

	make_with_data (a_action: NATURAL_16; a_parent: PE_DECL_SECURITY; a_permission_set: NATURAL)
		do
			action := a_action
			parent := a_parent
			create permission_set.make_with_index (a_permission_set)
		end

feature -- Access

	action: NATURAL_16
			-- Defined as a word two bytes.

	parent: PE_DECL_SECURITY

	permission_set: PE_BLOB


feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tDeclSecurity.value.to_integer_32
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
