indexing

	description:
		"Encapsulation of a C++ extension.";
	date: "$Date$";
	revision: "$Revision$"

class CPP_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		rename
			is_equal as ext_is_equal,
			generate_header_files as old_generate_header_files
		redefine
			is_cpp, has_standard_prototype, generate_external_name,
			generate_parameter_list
		end
	EXTERNAL_EXT_I
		redefine
			is_equal, is_cpp, generate_header_files,
			has_standard_prototype, generate_external_name,
			generate_parameter_list
		select
			is_equal, generate_header_files
		end
	SHARED_CPP_CONSTANTS
		redefine
			is_equal
		end

feature -- Properties

	class_name: STRING

	class_header_file: STRING

	type: INTEGER

feature -- Convenience

	is_cpp: BOOLEAN is True

	set_class_header_file (h: STRING) is
			-- Assign `h' to `class_header_file'.
		do
			class_header_file := h
		end

	set_class_name (n: STRING) is
			-- Assign `n' to `class_name'.
		do
			class_name := n
		end

	set_type (t: INTEGER) is
			-- Assing `t' to `type'.
		do
			type := t
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := ext_is_equal (other) and then
				class_name.is_equal (other.class_name) and then
				class_header_file.is_equal (other.class_header_file) and then
				type = other.type
		end

feature -- Code generation

	generate_external_name (gen_file: INDENT_FILE; external_name: STRING;
				entry: POLY_TABLE [ENTRY]; cl_type: CL_TYPE_I; ret_type: TYPE_C) is
			-- Generate the C name associated with the extension
		do
			check
				final_mode: Context.final_mode
			end
		end

	generate_header_files is
			-- Generate header files for the extension.
		do
			old_generate_header_files
			if not shared_include_queue.has (class_header_file) then
				shared_include_queue.extend (class_header_file)
			end
		end

	has_standard_prototype: BOOLEAN is False

	generate (external_name: STRING; parameters: BYTE_LIST [EXPR_B]) is
		local
			generated_file: INDENT_FILE
		do
			check
					-- VAPE on precondition so ...
				final_mode: Context.final_mode
			end

			generated_file := Context.generated_file

			generated_file.putchar ('(')

			inspect
				type
			when standard, data_member then
				generated_file.putchar ('(')
				generate_cpp_object_access (parameters)
				generated_file.putstring (")->")
				generated_file.putstring (external_name);
			when static, static_data_member then
				generated_file.putstring (class_name)
				generated_file.putstring ("::")
				generated_file.putstring (external_name);
			when new then
				generated_file.putstring ("new ")
				generated_file.putstring (class_name)
			when delete then
				generated_file.putstring ("delete (")
				generate_cpp_object_access (parameters)
				generated_file.putchar (')')
			end

			inspect
				type
			when delete, data_member, static_data_member then
					-- Nothing to generate
			when standard, static, new then
				generated_file.putchar ('(')
				generate_arguments_with_cast (parameters)
				generated_file.putchar (')')
			end
 
			generated_file.putchar (')')
		end

	generate_parameter_list (parameters: BYTE_LIST [EXPR_B]) is
			-- Generate parameters for C++ extension
		local
			generated_file: INDENT_FILE
		do
			if parameters /= Void then
				generated_file := Context.generated_file

					-- Cast will be done in encapsulation
				from
					parameters.start;
				until
					parameters.after
				loop
					parameters.item.print_register;
					if not parameters.islast then
						generated_file.putstring (", ");
					end;
					parameters.forth;
				end;
			end;
		end

feature {NONE} -- Code generation

	generate_cpp_object_access (parameters: BYTE_LIST [EXPR_B]) is
			-- Generate the C++ access code (first expression)
		require
			non_void_arg: parameters /= Void
			valid_arg: parameters.count >= 1
		local
			generated_file: INDENT_FILE
		do
			generated_file := Context.generated_file

			generated_file.putchar ('(')
			generated_file.putstring (class_name)
			generated_file.putstring ("*)")
			parameters.first.print_register
		end

	generate_arguments_with_cast (parameters: BYTE_LIST [EXPR_B]) is
			-- Generate the arguments to the C++ call
		require
			non_void_arg: parameters /= Void
		local
			expr: EXPR_B
			i: INTEGER
			generate_cast: BOOLEAN
			arg_types: ARRAY [STRING]
			generated_file: INDENT_FILE
		do
			generated_file := Context.generated_file
			if generate_parameter_cast then
				generate_cast := True
				arg_types := argument_types
			end
			from
				parameters.start
				if type = standard then
						-- Skip C++ object
					parameters.forth
				end
				i := 1
			until
				parameters.after
			loop
				expr := parameters.item
				if generate_cast then
					generated_file.putchar ('(')
					generated_file.putstring (arg_types.item (i))
					generated_file.putstring (") ")
				end
				expr.print_register;
				if not parameters.islast then
					generated_file.putstring (", ")
				end
				parameters.forth
				i := i + 1
			end
		end

end -- class CPP_EXTENSION_I
