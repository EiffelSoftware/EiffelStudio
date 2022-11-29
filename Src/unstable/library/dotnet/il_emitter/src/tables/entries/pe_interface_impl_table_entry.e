note
	description: "Summary description for {PE_INTERFACE_IMPL_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_INTERFACE_IMPL_TABLE_ENTRY

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

	make_with_data (a_cls: NATURAL; a_interface: PE_TYPEDEF_OR_REF)
		do
			create class_.make_with_index (a_cls)
			interface := a_interface
		end

feature -- Access

	class_: PE_TYPE_DEF

	interface: PE_TYPEDEF_OR_REF

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tinterfaceimpl.value.to_integer_32
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
