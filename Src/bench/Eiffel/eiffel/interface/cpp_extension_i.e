indexing

	description:
		"Encapsulation of a C++ extension.";
	date: "$Date$";
	revision: "$Revision$"

class CPP_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_equal, is_cpp,
			has_standard_prototype, generate_external_name,
			generate_parameter_list
		end

	SHARED_CPP_CONSTANTS
		undefine
			is_equal
		end

feature -- Properties

	class_name: STRING

	type: INTEGER

feature -- Convenience

	is_cpp: BOOLEAN is True

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
			Result := same_type (other) and then
				equal (return_type, other.return_type) and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files) and then
				class_name.is_equal (other.class_name) and then
				type = other.type
		end

feature -- Code generation

	generate_external_name (buffer: GENERATION_BUFFER; external_name: STRING;
				cl_type: CL_TYPE_I; ret_type: TYPE_C) is
			-- Generate the C name associated with the extension
		do
			check
				final_mode: Context.final_mode
			end
		end

	has_standard_prototype: BOOLEAN is False

	generate (external_name: STRING; parameters: BYTE_LIST [EXPR_B]) is
		local
			buffer: GENERATION_BUFFER
		do
			context.set_has_cpp_externals_calls (True);

			check
					-- VAPE on precondition so ...
				final_mode: Context.final_mode
			end

			buffer := Context.buffer

			buffer.putchar ('(')

			inspect
				type
			when standard, data_member then
				buffer.putchar ('(')
				generate_cpp_object_access (parameters)
				buffer.putstring (")->")
				buffer.putstring (external_name);
			when static, static_data_member then
				buffer.putstring (class_name)
				buffer.putstring ("::")
				buffer.putstring (external_name);
			when new then
				buffer.putstring ("new ")
				buffer.putstring (class_name)
			when delete then
				buffer.putstring ("delete (")
				generate_cpp_object_access (parameters)
				buffer.putchar (')')
			end

			inspect
				type
			when delete, data_member, static_data_member then
					-- Nothing to generate
			when standard, static, new then
				buffer.putchar ('(')
				generate_arguments_with_cast (parameters)
				buffer.putchar (')')
			end
 
			buffer.putchar (')')
		end
	
	generate_parameter_list (parameters: BYTE_LIST [EXPR_B]) is
			-- Generate parameters for C++ extension
		local
			buffer: GENERATION_BUFFER
		do
			if parameters /= Void then
				buffer := Context.buffer

					-- Cast will be done in encapsulation
				from
					parameters.start;
				until
					parameters.after
				loop
					parameters.item.print_register;
					if not parameters.islast then
						buffer.putstring (", ");
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
			buffer: GENERATION_BUFFER
		do
			buffer := Context.buffer

			buffer.putchar ('(')
			buffer.putstring (class_name)
			buffer.putstring ("*)")
			parameters.first.print_register
		end

	generate_arguments_with_cast (parameters: BYTE_LIST [EXPR_B]) is
			-- Generate the arguments to the C++ call
		local
			expr: EXPR_B
			i: INTEGER
			generate_cast: BOOLEAN
			arg_types: ARRAY [STRING]
			buffer: GENERATION_BUFFER
		do
			if parameters /= Void then
				from
					buffer := Context.buffer
					if generate_parameter_cast then
						generate_cast := True
						arg_types := argument_types
						i := arg_types.lower
					end
					parameters.start
					if type = standard then
							-- Skip C++ object
						parameters.forth
					end
				until
					parameters.after
				loop
					expr := parameters.item
					if generate_cast then
						buffer.putchar ('(')
						buffer.putstring (arg_types.item (i))
						buffer.putstring (") ")
						i := i + 1
					end
					expr.print_register;
					if not parameters.islast then
						buffer.putstring (", ")
					end
					parameters.forth
				end
			end
		end

end -- class CPP_EXTENSION_I

