indexing
	description: "Encapsulation of a DLL extension."
	date: "$Date$"
	revision: "$Revision$"

class DLL_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_dll, is_equal, need_encapsulation
		end
		
	EXTERNAL_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal
		end
		
	SHARED_INCLUDE
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (t, i: INTEGER; n: like name) is
			-- Initialize DLL_EXTENSION_I
		require
			t_valid_type: t = dll32_type or t = dllwin32_type
			n_not_void: n /= Void
			n_not_empty: not n.is_empty
		do
			type := t
			index := i
			name := n
		ensure
			type_set: type = t
			index_set: index = i
			name_set: name = n
		end
		
feature -- Status report

	is_dll: BOOLEAN is True
			-- Current is a DLL external
			
	need_encapsulation: BOOLEAN is True
			-- We always need to call encapsulation.

feature -- Properties

	type: INTEGER
		-- Dll type

	index: INTEGER
		-- Dll index

	name: STRING
			-- Special file name (dll or macro)

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := same_type (other) and then
				return_type = other.return_type and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files) and then
				name.is_equal (other.name) and then
				type = other.type
		end

feature -- Code generation

	generate_body (dll_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
			-- Generate encapsulation to C/C++ dll external `macro_byte_code'.
		do
			inspect
				type
			when dll32_type then
				generate_dll_body (dll_byte_code, a_result, False)
			when dllwin32_type then
				generate_dll_body (dll_byte_code, a_result, True)
			end
		end

feature {NONE} -- Internal generation

	generate_dll_body (dll_byte_code: EXT_BYTE_CODE; a_result: RESULT_B; is_win_32: BOOLEAN) is
			-- Generate body for an external of type dllwin32
		require
			dll_byte_code_not_void: dll_byte_code /= Void
			a_result_valid: not dll_byte_code.result_type.is_void implies a_result /= Void
		local
			buf: GENERATION_BUFFER
			l_names_heap: like Names_heap
			l_ret_type: TYPE_I
		do
			buf := Context.buffer

			l_names_heap := Names_heap
			shared_include_queue.put (l_names_heap.eif_misc_header_name_id)

			buf.putchar ('{')
			buf.new_line
			buf.indent
			buf.putstring ("static char done = 0;")
			buf.new_line
			buf.putstring ("static EIF_POINTER fp = NULL;")
			buf.new_line
	
			buf.putstring ("if (!done) {")
			buf.indent
			buf.new_line
				-- Declare local variables required by the call
			buf.putstring ("HMODULE a_result;")
			buf.new_line

				-- Now comes the body
			buf.putstring ("a_result = eif_load_dll(")
			buf.putstring (name)
			buf.putstring (");")
			buf.new_line
			buf.putstring ("if (a_result == NULL) eraise(%"Cannot load library%",EN_PROG);")
			buf.new_line
			buf.putstring ("fp = (EIF_POINTER) GetProcAddress(a_result,")
			if index > -1 then 
				buf.putstring ("MAKEINTRESOURCE (")
				buf.putint (index)
				buf.putstring (")")
			else
				buf.putchar ('"')
				buf.putstring (dll_byte_code.external_name)
				buf.putchar ('"')
			end
			buf.putstring (");")
			buf.new_line
			buf.putstring ("if (fp == NULL) eraise(%"Cannot find entry point")
			if index > -1 then
				buf.putstring (" at index ")
				buf.putint (index)
			else
				buf.putstring (" of ")
				buf.putstring (dll_byte_code.external_name)
			end
			buf.putstring ("%",EN_PROG);")
			buf.new_line
			buf.putstring ("done = (char) 1;")
			buf.new_line
			buf.exdent
			buf.putchar ('}')
			buf.new_line

			l_ret_type := dll_byte_code.result_type
			if not l_ret_type.is_void then
				a_result.print_register
				buf.putstring (" = ")
				l_ret_type.c_type.generate_cast (buf)
				if l_ret_type.is_boolean then
					buf.putstring (" EIF_TEST")
				end
			end
			buf.putchar ('(')
				-- FIXME: Manu 07/21/2003: function cast is done using the Eiffel return type.
				-- This is not correct, it should use, if specified, the return type from
				-- signature. Some C compiler might optimize incorrectly otherwise.
			if is_win_32 then
				if has_arg_list then
					l_ret_type.c_type.generate_function_cast_type (buf, stdcall,
						l_names_heap.convert_to_string_array (argument_types))
				else
					l_ret_type.c_type.generate_function_cast_type (buf, stdcall, <<"void">>)
				end
			else
				if has_arg_list then
					l_ret_type.c_type.generate_function_cast (buf,
						l_names_heap.convert_to_string_array (argument_types))
				else
					l_ret_type.c_type.generate_function_cast (buf, <<"void">>)
				end
			end
			buf.putstring ("fp ) (")
			generate_parameter_list (Void, dll_byte_code.argument_count)
			buf.putchar (')');
			buf.putchar (';');

			buf.exdent
			buf.new_line
			buf.putchar ('}')
			buf.new_line
		end

	stdcall: STRING is "__stdcall"
			-- Special call type used to call certain function in DLLS.
			-- E.g. most of the Win32 API are using this kind of calling
			-- mechanism.

invariant
	name_not_void: name /= Void

end -- class DLL_EXTENSION_I
