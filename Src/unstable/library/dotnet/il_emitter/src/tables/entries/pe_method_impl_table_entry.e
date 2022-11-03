note
	description: "Summary description for {PE_METHOD_IMPL_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_IMPL_TABLE_ENTRY

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

	make_with_data (a_cls: NATURAL; a_method_body: PE_METHOD_DEF_OR_REF; a_method_dec: PE_METHOD_DEF_OR_REF)
		do
			create class_.make_with_index (a_cls)
			method_body := a_method_body
			method_declaration := a_method_dec
		end

feature -- Access

	class_: PE_TYPE_DEF

	method_body: PE_METHOD_DEF_OR_REF

	method_declaration: PE_METHOD_DEF_OR_REF

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tMethodimpl.value.to_integer_32
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

