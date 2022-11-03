note
	description: "Summary description for {PE_METHOD_SEMANTIC_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_SEMANTIC_TABLE_ENTRY

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

	make_with_data (a_semantics: NATURAL_16; a_method: NATURAL; a_association: PE_SEMANTICS)
		do
			semantics := a_semantics
			create method.make_with_index (a_method)
			association := a_association
		end

feature -- Access

	semantics: NATURAL_16
			-- Defined as a word two bytes.

	method: PE_METHOD_LIST

	association: PE_SEMANTICS

feature -- Flags

	Setter: INTEGER = 1
	Getter: INTEGER = 2
	Other: INTEGER = 4
	AddOn: INTEGER = 8
	RemoveOn: INTEGER = 16
	Fire: INTEGER = 32

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tMethodSemantics.value.to_integer_32
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

