indexing
	description: "Encapsulation of a DLL extension."
	date: "$Date$"
	revision: "$Revision$"

class DLL_EXT_BYTE_CODE

inherit
	EXT_EXT_BYTE_CODE
		redefine
			is_special, generate_body
		end

feature -- Properties

	dll_type: INTEGER
		-- Dll type

	dll_index: INTEGER
		-- Dll index

	dll_name: STRING
			-- Special file name (dll or macro)

feature -- Initialization

	set_dll_type (t: INTEGER) is
			-- Assign `t' to `dll_type'
		do
			dll_type := t
		end

	set_dll_index (i: INTEGER) is
			-- Assign `i' to `dll_index'
		do
			dll_index := i
		end

	set_dll_name (f: STRING) is
			-- Assign `f' to `dll_name'.
		do
			dll_name := f
		end

feature -- Convenience

	is_special: BOOLEAN is
		do
			Result := dll_name /=  Void
		end

feature -- Code generation

	generate_body is
		do
			inspect
				dll_type
			when dll32_type then
				generate_dll_body (False)
			when dllwin32_type then
				generate_dll_body (True)
			end
		end

feature {NONE} -- Internal generation

	generate_dll_body (is_win_32: BOOLEAN) is
			-- Generate body for an external of type dllwin32
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer

			shared_include_queue.put (eif_misc_h)

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
			buf.putstring (dll_name)
			buf.putstring (");")
			buf.new_line
			buf.putstring ("if (a_result == NULL) eraise(%"Can not load library%",EN_PROG);")
			buf.new_line
			buf.putstring ("fp = (EIF_POINTER) GetProcAddress(a_result,")
			if dll_index > -1 then 
				buf.putstring ("MAKEINTRESOURCE (")
				buf.putint (dll_index)
				buf.putstring (")")
			else
				buf.putchar ('"')
				buf.putstring (external_name)
				buf.putchar ('"')
			end
			buf.putstring (");")
			buf.new_line
			buf.putstring ("if (fp == NULL) eraise(%"Can not find entry point")
			if dll_index > -1 then
				buf.putstring (" at index ")
				buf.putint (dll_index)
			else
				buf.putstring (" of ")
				buf.putstring (external_name)
			end
			buf.putstring ("%",EN_PROG);")
			buf.new_line
			buf.putstring ("done = (char) 1;")
			buf.new_line
			buf.exdent
			buf.putchar ('}')
			buf.new_line

			if not result_type.is_void then
				buf.putstring ("return ")
				result_type.c_type.generate_cast (buf)
			end
			buf.putchar ('(')
			if is_win_32 then
				if has_arg_list then
					result_type.c_type.generate_function_cast_type (buf, stdcall, argument_types)
				else
					result_type.c_type.generate_function_cast_type (buf, stdcall, <<"void">>)
				end
			else
				if has_arg_list then
					result_type.c_type.generate_function_cast (buf, argument_types)
				else
					result_type.c_type.generate_function_cast (buf, <<"void">>)
				end
			end
			buf.putstring ("fp )")
			if arguments /= Void then
				generate_arguments_with_cast
			else
				buf.putstring ("()")
			end
			buf.putchar (';');
			buf.new_line
		end

	stdcall: STRING is "__stdcall"
			-- Special call type used to call certain function in DLLS.
			-- E.g. most of the Win32 API are using this kind of calling
			-- mechanism.

	eif_misc_h: STRING is "%"eif_misc.h%""
			-- Where `eif_load_dll' is defined.

end -- class DLL_EXT_BYTE_CODE
