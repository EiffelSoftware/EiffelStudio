note
	description: "Summary description for {PE_METHOD_SPEC_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_SPEC_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_method: PE_METHOD_DEF_OR_REF; a_instantiation: NATURAL_64)
		do
			method := a_method
			create instantiation.make_with_index (a_instantiation)
		end

feature -- Access

	method: PE_METHOD_DEF_OR_REF

	instantiation: PE_BLOB

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tMethodSpec.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			l_bytes := method.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + instantiation.render (a_sizes, a_dest, l_bytes.to_integer_32)

			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			l_bytes := method.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + instantiation.get (a_sizes, a_src, l_bytes.to_integer_32)

			Result := l_bytes
		end

end

