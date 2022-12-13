note
	description: "Summary description for {PE_METHOD_IMPL_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_IMPL_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

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

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write class, method_body and method_declaration to the buffer and update the number of bytes.
			l_bytes := class_.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + method_body.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + method_declaration.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Read class, method_body and method_declaration from the buffer and update the number of bytes.
			l_bytes := class_.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + method_body.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + method_declaration.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end

end

