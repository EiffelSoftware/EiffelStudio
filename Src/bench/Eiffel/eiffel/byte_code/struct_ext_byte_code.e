indexing
	description:
		"Encapsulation of a macro extension in C or C++ mode.";
	date: "$Date$";
	revision: "$Revision$"

class STRUCT_EXT_BYTE_CODE

inherit
	EXT_BYTE_CODE
		redefine
			is_special, generate_body
		end

feature -- Properties

	is_cpp_code: BOOLEAN
			-- Is current macro to be generated in a CPP context?

	field_name_id: INTEGER
			-- Name of struct.
			--| Can be empty if parsed through the old syntax

feature -- Initialization

	set_is_cpp_code (v: BOOLEAN) is
			-- Assign `v' to `is_cpp_code'.
		do
			is_cpp_code := v
		ensure
			is_cpp_code_set: is_cpp_code = v
		end

	set_field_name_id (id: INTEGER) is
			-- Assign `s' to `field_name_id'.
		do
			field_name_id := id
		ensure
			field_name_id_set: field_name_id = id
		end

feature -- Code generation

	generate_body is
			-- Generate the body for an external of type macro
		local
			buf: GENERATION_BUFFER
			special_access: BOOLEAN
			name: STRING
			setter: BOOLEAN
			new_syntax: BOOLEAN
			l_names_heap: like Names_heap
		do
			buf := buffer
			if is_cpp_code then
				context.set_has_cpp_externals_calls (True)
			end
			
			l_names_heap := Names_heap

			name := l_names_heap.item (field_name_id)
			if name = Void then
				name := external_name
			else
				new_syntax := True
			end

			setter := (new_syntax and then argument_types.count = 2)
					or else (not new_syntax and then not has_return_type)

			if not setter then
				buf.putstring ("return ");
				result_type.c_type.generate_cast (buf)

				if name.item (1) = '&' and then name.count > 1 then
					buf.putchar ('&')
					special_access := True
				end

					--| External structure access will be generated as:
					--| (type_2) (((type_1 *) arg1)->alias_name);
				buf.putstring ("(((")
				buf.putstring (l_names_heap.item (argument_types.item(1)))
				buf.putstring (" *) arg1");
				buf.putstring (")->")
				if not special_access then
					buf.putstring (name)
				else
					buf.putstring (name.substring (2, name.count))
				end
				buf.putstring (");")
				buf.new_line;
			else
					--| External structure setting will be generated as:
					--| ((type_1 *) arg1)->alias_name = (type_2) (arg2);
				buf.putstring ("((")
				buf.putstring (l_names_heap.item (argument_types.item(1)))
				buf.putstring (" *) arg1");
				buf.putstring (")->")
				buf.putstring (name)
				buf.putstring (" = (")
				buf.putstring (l_names_heap.item (argument_types.item(2)))
				buf.putstring (")(arg2);");
				buf.new_line;
			end
		end

feature -- Convenience

	is_special: BOOLEAN is True

end -- class STRUCT_EXT_BYTE_CODE
