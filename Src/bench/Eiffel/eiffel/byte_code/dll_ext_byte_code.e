indexing

	description:
		"Encapsulation of a DLL extension.";
	date: "$Date$";
	revision: "$Revision$"

class DLL_EXT_BYTE_CODE

inherit
	C_EXT_BYTE_CODE
		redefine
			generate_body
		end

feature -- Properties

	dll_type: INTEGER
		-- Dll type

feature -- Initialization

	set_dll_type (t: INTEGER) is
			-- Assign `t' to `dll_type'
		do
			dll_type := t
		end

feature -- Code generation

	generate_body is
		do
			inspect
				dll_type
            when dll16_type then
                generate_dll16_body
            when dll32_type then
                generate_dll32_body
            when dllwin32_type then
                generate_dllwin32_body
			end
		end

    generate_dll16_body is
            -- Generate body for dll16 (Windows)
        do
                -- Declare local variables required by the call
            generated_file.putstring ("HANDLE a_result;");
            generated_file.new_line;
            generated_file.putstring ("FARPROC fp;");
            generated_file.new_line;
            generated_file.putstring ("HINDIR handle;");
            generated_file.new_line;
            if not result_type.is_void then
                result_type.c_type.generate (generated_file);
                generated_file.putstring (" Result;");
            generated_file.new_line;
            end;
            generated_file.new_line;
                -- Now comes the body
            generated_file.putstring ("a_result = eif_load_dll(");
            generated_file.putstring (special_file_name);
            generated_file.putstring (");");
            generated_file.new_line;
            generated_file.putstring ("if (a_result < 32) eraise(%"Can not load library%",EN_PROG);");
            generated_file.new_line;
            generated_file.putstring ("fp = GetProcAddress(a_result, ");
            if external_name.is_integer then
                generated_file.putstring ("MAKEINTRESOURCE (MAKELONG (");
                generated_file.putstring (external_name);
                generated_file.putstring (", 0))");
            else
                generated_file.putchar ('"');
                generated_file.putstring (external_name);
                generated_file.putchar ('"');
            end
            generated_file.putstring (");");
            generated_file.new_line;
            generated_file.putstring ("if (fp == NULL) eraise(%"Can not find function%",EN_PROG);");
            generated_file.new_line;
            generated_file.putstring ("handle = GetIndirectFunctionHandle(fp");
            if arguments /= Void then
                generated_file.putchar (',');
                generate_type_list;
            end;
            generated_file.putstring (", INDIR_ENDLIST);");
            generated_file.new_line;
            generated_file.putstring ("if (handle == NULL) eraise(%"Can not allocate function handle%",EN_PROG);");
            generated_file.new_line;
 
            if not result_type.is_void then
                generated_file.putstring ("Result = ");
            end;
            generated_file.putstring ("InvokeIndirectFunction(handle");
            if arguments /= Void then
                generated_file.putchar (',');
                generate_arguments;
            end;
            generated_file.putstring (");");
            generated_file.new_line;
            if not result_type.is_void then
                generated_file.putstring ("return ");
                if has_return_type then
                    generated_file.putchar ('(');
                    generated_file.putstring (return_type);
                    generated_file.putchar (')');
                    generated_file.putchar (' ');
                end;
                generated_file.putstring ("Result;");
                generated_file.new_line;
            end
        end;

    generate_dll32_body is
            -- Generate body for an external of type dll32
        do
                -- Declare local variables required by the call
            generated_file.putstring ("HANDLE a_result;");
            generated_file.new_line;
            generated_file.putstring ("FARPROC fp;");
            generated_file.new_line;
            generated_file.putstring ("HINDIR hindir1;");
            generated_file.new_line;
            if not result_type.is_void then
                result_type.c_type.generate (generated_file);
                generated_file.putstring (" Result;");
                generated_file.new_line;
            end;
            generated_file.new_line;
                -- Now comes the body
            generated_file.putstring ("a_result = eif_load_dll(");
            generated_file.putstring (special_file_name);
            generated_file.putstring (");");
            generated_file.new_line;
            generated_file.putstring ("if (a_result < 32) eraise(%"Can not load library%",EN_PROG);");
            generated_file.new_line;
            generated_file.putstring ("fp = GetProcAddress(a_result,%"Win386LibEntry%");");
            generated_file.new_line;
            generated_file.putstring ("if (fp == NULL) eraise(%"Can not find entry point%",EN_PROG);");
            generated_file.new_line;
            generated_file.putstring ("hindir1 = GetIndirectFunctionHandle (fp");
            if arguments /= Void then
                generated_file.putchar (',');
                generate_type_list;
            end;
            generated_file.putstring (", INDIR_WORD, INDIR_ENDLIST);");
            generated_file.new_line;
            generated_file.putstring ("if (hindir1 == NULL) eraise(%"Can not allocate function handle%",EN_PROG);");
            generated_file.new_line;
            if not result_type.is_void then
                generated_file.putstring ("Result = ");
            end;
            generated_file.putstring ("InvokeIndirectFunction(hindir1");
            if arguments /= Void then
                generated_file.putchar (',');
                generate_arguments;
            end;
            generated_file.putchar (',');
            generated_file.putstring (external_name);
            generated_file.putstring (");");
            generated_file.new_line;
            if not result_type.is_void then
                generated_file.putstring ("return ");
                if has_return_type then
                    generated_file.putchar ('(');
                    generated_file.putstring (return_type);
                    generated_file.putchar (')');
                    generated_file.putchar (' ');
                end;
                generated_file.putstring ("Result;");
                generated_file.new_line;
            end;
        end;

    generate_dllwin32_body is
            -- Generate body for an external of type dllwin32
        do
                -- FIXME: remove extern declaration
            generated_file.putstring ("extern HANDLE eif_load_dll(char*);");
            generated_file.new_line;
 
                -- Declare local variables required by the call
            generated_file.putstring ("HANDLE a_result;");
            generated_file.new_line;
 
            result_type.c_type.generate (generated_file);
            generated_file.putstring ("(*fp)();");
            generated_file.new_line;
 
            if not result_type.is_void then
                result_type.c_type.generate (generated_file);
                generated_file.putstring (" Result;");
                generated_file.new_line;
            end;
            generated_file.new_line;
                -- Now comes the body
            generated_file.putstring ("a_result = eif_load_dll(");
            generated_file.putstring (special_file_name);
            generated_file.putstring (");");
            generated_file.new_line;
            generated_file.putstring ("if (a_result == NULL) eraise(%"Can not load library%",EN_PROG);");
            generated_file.new_line;
            generated_file.putstring ("fp = ");
            result_type.c_type.generate_function_cast (generated_file);
            generated_file.putstring ("GetProcAddress(a_result,");
            if external_name.is_integer then
                generated_file.putstring ("MAKEINTRESOURCE (");
                generated_file.putstring (external_name);
                generated_file.putstring (")");
            else
                generated_file.putchar ('"');
                generated_file.putstring (external_name);
                generated_file.putchar ('"');
            end
            generated_file.putstring (");");
 
            generated_file.new_line;
            generated_file.putstring ("if (fp == NULL) eraise(%"Can not find entry point%",EN_PROG);");
            generated_file.new_line;
            if not result_type.is_void then
                generated_file.putstring ("Result = ");
            end;
            generated_file.putstring ("(fp)(");
            if arguments /= Void then
                generate_arguments_with_cast;
            end;
            generated_file.putstring (");");
            generated_file.new_line;
            if not result_type.is_void then
                generated_file.putstring ("return ");
                if has_return_type then
                    generated_file.putchar ('(');
                    generated_file.putstring (return_type);
                    generated_file.putchar (')');
                    generated_file.putchar (' ');
                end;
                generated_file.putstring ("Result;");
                generated_file.new_line;
            end;
        end;

    generate_type_list is
            -- Generate a list of the types held in the signature, for the dll
        local
            i, count: INTEGER;
        do
            if arguments /= Void then
                from
                    i := arguments.lower;
                    count := arguments.count;
                until
                    i > count
                loop
                    generated_file.putstring ("INDIR_");
                    generated_file.putstring (argument_types.item (i));
                    i := i + 1;
                    if i <= count then
                        generated_file.putstring (", ");
                    end;
                end;
            end;
        end;

end -- class DLL_EXT_BYTE_CODE
