note
	description: "Summary description for {PE_GENERIC_PARAM_TABLE}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GENERIC_PARAM_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
	
create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_number: NATURAL_16; a_flags: NATURAL_16; a_owner: PE_TYPE_OR_METHOD_DEF; a_name: NATURAL_64)
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

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, number, 0)
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, flags, 2)
			l_bytes := 4

			l_bytes := l_bytes + owner.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + name.render (a_sizes, a_dest, l_bytes.to_integer_32)

			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			number := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, 0)
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, 2)
			l_bytes := 4

			l_bytes := l_bytes + owner.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + name.get (a_sizes, a_src, l_bytes.to_integer_32)

			Result := l_bytes
		end

end


