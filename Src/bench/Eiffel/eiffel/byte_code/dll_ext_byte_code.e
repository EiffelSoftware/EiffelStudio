indexing
	description: "Encapsulation of a DLL extension."
	date: "$Date$"
	revision: "$Revision$"

class DLL_EXT_BYTE_CODE

inherit
	C_EXT_BYTE_CODE
		redefine
			is_special, generate_body, generate_signature
		end

feature -- Properties

	dll_type: INTEGER
		-- Dll type

	dll_index: INTEGER
		-- Dll index

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

feature -- Convenience

	is_special: BOOLEAN is
		do
			Result := special_file_name /=  Void
		end

feature -- Code generation

	generate_body is
		do
			inspect
				dll_type
			when dll16_type then
				generate_dll16_body
			when dll32_type then
				generate_dllwin32_body --JOCE--
			when dllwin32_type then
				generate_dllwin32_body
			end
		end

	generate_signature is
		do
			if is_special then
				generate_basic_signature
			elseif encapsulated then
				old_generate
			end
		end

feature {NONE} -- Internal generation

	generate_dll16_body is
			-- Generate body for dll16 (Windows)
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- Declare local variables required by the call
			buf.putstring ("HANDLE a_result;")
			buf.new_line
			buf.putstring ("FARPROC fp;")
			buf.new_line
			buf.putstring ("HINDIR handle;")
			buf.new_line
			if not result_type.is_void then
				result_type.c_type.generate (buf)
				buf.putstring (" Result;")
				buf.new_line
			end
			buf.new_line

				-- Now comes the body
			buf.putstring ("a_result = eif_load_dll(")
			buf.putstring (special_file_name)
			buf.putstring (");")
			buf.new_line
			buf.putstring ("if (a_result < 32) eraise(%"Can not load library%",EN_PROG);")
			buf.new_line
			buf.putstring ("fp = GetProcAddress(a_result, ")
			if external_name.is_integer then
				buf.putstring ("MAKEINTRESOURCE (MAKELONG (")
				buf.putstring (external_name)
				buf.putstring (", 0))")
			else
				buf.putchar ('"')
				buf.putstring (external_name)
				buf.putchar ('"')
			end
			buf.putstring (");")
			buf.new_line
			buf.putstring ("if (fp == NULL) eraise(%"Can not find function%",EN_PROG);")
			buf.new_line
			buf.putstring ("handle = GetIndirectFunctionHandle(fp")
			if arguments /= Void then
				buf.putchar (',')
				generate_type_list
			end
			buf.putstring (", INDIR_ENDLIST);")
			buf.new_line
			buf.putstring ("if (handle == NULL) eraise(%"Can not allocate function handle%",EN_PROG);")
			buf.new_line

			if not result_type.is_void then
				buf.putstring ("Result = ")
			end
			buf.putstring ("InvokeIndirectFunction(handle")
			if arguments /= Void then
				buf.putchar (',')
				generate_arguments
			end
			buf.putstring (");")
			buf.new_line
			if not result_type.is_void then
				buf.putstring ("return ")
				if has_return_type then
					buf.putchar ('(')
					buf.putstring (return_type)
					buf.putchar (')')
					buf.putchar (' ')
				end
				buf.putstring ("Result;")
				buf.new_line
			end
		end

	generate_dll32_body is
			-- Generate body for an external of type dll32
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- Declare local variables required by the call
			buf.putstring ("HANDLE a_result;")
			buf.new_line
			buf.putstring ("FARPROC fp;")
			buf.new_line
			buf.putstring ("HINDIR hindir1;")
			buf.new_line
			if not result_type.is_void then
				result_type.c_type.generate (buf)
				buf.putstring (" Result;")
				buf.new_line
			end
			buf.new_line

				-- Now comes the body
			buf.putstring ("a_result = eif_load_dll(")
			buf.putstring (special_file_name)
			buf.putstring (");")
			buf.new_line
			buf.putstring ("if (a_result < 32) eraise(%"Can not load library%",EN_PROG);")
			buf.new_line
			buf.putstring ("fp = GetProcAddress(a_result,%"Win386LibEntry%");")
			buf.new_line
			buf.putstring ("if (fp == NULL) eraise(%"Can not find entry point%",EN_PROG);")
			buf.new_line
			buf.putstring ("hindir1 = GetIndirectFunctionHandle (fp")
			if arguments /= Void then
				buf.putchar (',')
				generate_type_list
			end
			buf.putstring (", INDIR_WORD, INDIR_ENDLIST);")
			buf.new_line
			buf.putstring ("if (hindir1 == NULL) eraise(%"Can not allocate function handle%",EN_PROG);")
			buf.new_line
			if not result_type.is_void then
				buf.putstring ("Result = ")
			end
			buf.putstring ("InvokeIndirectFunction(hindir1")
			if arguments /= Void then
				buf.putchar (',')
				generate_arguments
			end
			buf.putchar (',')
			buf.putstring (external_name)
			buf.putstring (");")
			buf.new_line
			if not result_type.is_void then
				buf.putstring ("return ")
				if has_return_type then
					buf.putchar ('(')
					buf.putstring (return_type)
					buf.putchar (')')
					buf.putchar (' ')
				end
				buf.putstring ("Result;")
				buf.new_line
			end
		end

	generate_dllwin32_body is
			-- Generate body for an external of type dllwin32
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- FIXME: remove extern declaration
			buf.putstring ("extern HANDLE eif_load_dll(char*);")
			buf.new_line

				-- Declare local variables required by the call
			buf.putstring ("HANDLE a_result;")
			buf.new_line

			result_type.c_type.generate (buf)
			buf.putstring ("(*fp)();")
			buf.new_line

			if not result_type.is_void then
				result_type.c_type.generate (buf)
				buf.putstring (" Result;")
				buf.new_line
			end
			
			buf.new_line

				-- Now comes the body
			buf.putstring ("a_result = eif_load_dll(")
			buf.putstring (special_file_name)
			buf.putstring (");")
			buf.new_line
			buf.putstring ("if (a_result == NULL) eraise(%"Can not load library%",EN_PROG);")
			buf.new_line
			buf.putstring ("fp = ")
			result_type.c_type.generate_function_cast (buf, argument_types)
			buf.putstring ("GetProcAddress(a_result,")
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
			buf.putstring ("if (fp == NULL) eraise(%"Can not find entry point%",EN_PROG);")
			buf.new_line
			if not result_type.is_void then
				buf.putstring ("Result = ")
			end
			buf.putstring ("fp")
			if arguments /= Void then
				generate_arguments_with_cast
			end
			buf.putchar (';');
			buf.new_line
			if not result_type.is_void then
				buf.putstring ("return ")
				if has_return_type then
					buf.putchar ('(')
					buf.putstring (return_type)
					buf.putchar (')')
					buf.putchar (' ')
				end
				buf.putstring ("Result;")
				buf.new_line
			end
		end

	generate_type_list is
			-- Generate a list of the types held in the signature, for the dll
		local
			i, count: INTEGER
			buf: GENERATION_BUFFER
		do
			if arguments /= Void then
				from
					buf := buffer
					i := arguments.lower
					count := arguments.count
				until
					i > count
				loop
					buf.putstring ("INDIR_")
					buf.putstring (argument_types.item (i))
					i := i + 1

					if i <= count then
						buf.putstring (", ")
					end
				end
			end
		end

end -- class DLL_EXT_BYTE_CODE
