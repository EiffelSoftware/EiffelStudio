note
	description: "Summary description for {PE_TYPEDEF_TABLE_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPEDEF_TABLE_ENTRY

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

	make_with_data (a_flags: INTEGER; a_type_name_index: NATURAL_64; a_type_name_space_index: NATURAL_64;
					a_extends: PE_TYPEDEF_OR_REF; a_field_index: NATURAL_64; a_method_index: NATURAL_64)
		do
			flags := a_flags
			create type_name_index.make_with_index (a_type_name_index)
			create type_name_space_index.make_with_index (a_type_name_space_index)
			extends := a_extends
			create fields.make_with_index (a_field_index)
			create methods.make_with_index (a_method_index)
		end


feature -- Access

	flags: INTEGER

	type_name_index: PE_STRING

	type_name_space_index: PE_STRING

	extends: PE_TYPEDEF_OR_REF

	fields: PE_FIELD_LIST

	methods: PE_METHOD_LIST


feature -- Operations


	table_index: INTEGER
		do
			Result := {PE_TABLES}.ttypedef.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement  ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

end
