indexing
	description: "Encapsulation of a C inline extension."
	date: "$Date$"
	revision: "$Revision$"

class INLINE_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_equal, is_cpp, is_inline
		end

create
	make

feature  -- Initialization

	make (is_cpp_inline: BOOLEAN) is
			-- Create Current object
			-- Set `is_cpp' to `is_cpp_inline'.
		do
			is_cpp := is_cpp_inline
		ensure
			is_cpp_set: is_cpp = is_cpp_inline
		end
		
feature -- Access

	argument_names: SPECIAL [INTEGER]
			-- Names of arguments.

feature -- Properties

	is_cpp: BOOLEAN
		-- Is Current inline a C++ one?
		
	is_inline: BOOLEAN is True
		-- Is Current external an inline one?

feature -- Settings

	set_argument_names (args: like argument_names) is
			-- Set `argument_names' with `args'.
		do
			argument_names := args
		ensure
			argument_names_set: argument_names = args
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do	
			Result := same_type (other) and then
				return_type = other.return_type and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files)
		end

feature -- Code generation

	generate_body (inline_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
			-- Generate code for inline C feature in a body, i.e. encpasulation of inline.
		local
			l_buffer: GENERATION_BUFFER
			l_is_func: BOOLEAN
			l_ret_type: TYPE_I
		do
			l_buffer := Context.buffer
			l_ret_type := inline_byte_code.result_type
			if not l_ret_type.is_void then
				l_is_func := True
				a_result.print_register
				l_buffer.putstring (" = ")
				l_ret_type.c_type.generate_cast (l_buffer)
			end
			internal_generate_inline (Void, l_ret_type)
			l_buffer.putchar (';')
		end

	generate_access (parameters: BYTE_LIST [EXPR_B]; a_ret_type: TYPE_I) is
			-- Generate code for access to inline C feature.
		require
			parameters_not_void: argument_names /= Void implies parameters /= Void
			parameters_count_valid: argument_names /= Void implies
				(argument_names.count = parameters.count)
		do
			internal_generate_inline (parameters, a_ret_type)
		end

feature {NONE} -- Implementation

	internal_generate_inline (parameters: BYTE_LIST [EXPR_B]; a_ret_type: TYPE_I) is
			-- Generate code for inline C feature.
		require
			parameters_not_void: parameters /= Void implies argument_names /= Void
			parameters_count_valid: parameters /= Void implies
				(argument_names.count = parameters.count)
		local
			l_code, l_arg: STRING
			l_buffer: GENERATION_BUFFER
			l_old, l_temp: GENERATION_BUFFER
			l_values: ARRAY [STRING]
			i, nb: INTEGER
		do
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end

			generate_header_files

			l_code := clone (Names_heap.item (alias_name_id))
			l_code.right_adjust
			l_code.left_adjust

			if argument_names /= Void then
					-- Generate all expressions corresponding to passed arguments.
					-- We use a trick to use an empty generation buffer by replacing
					-- shared one `context.buffer' by a temporary one.
				l_old := context.buffer
				create l_values.make (1, argument_names.count)
				if parameters /= Void then
					from
						parameters.start
						i := 1
					until
						parameters.after
					loop
						create l_temp.make (32)
						context.set_buffer (l_temp)
						parameters.item.print_register
						l_values.put (l_temp, i)
						parameters.forth
						i := i + 1
					end
				else
						-- If parameters was Void, it means that we are generating code
						-- in encapsulating routine.
					from
						i := 1
						nb := argument_names.count
					until
						i > nb
					loop
						l_values.put ("arg" + i.out, i)
						i := i + 1
					end
				end
				context.set_buffer (l_old)
			
				from
					i := 0
					nb := argument_names.count - 1
				until
					i > nb
				loop
					l_arg := "$" +  Names_heap.item (argument_names.item (i))
					l_code.replace_substring_all (l_arg, l_values.item (i + 1))
					i := i + 1
				end
			end

				-- Replace `$$_result_type' if used by return type of current inlined function
			l_code.replace_substring_all ("$$_result_type", a_ret_type.c_type.c_string)

				-- FIXME: Manu 03/26/2003:
				-- When verbatim strings are used, on Windows we get a %R%N which
				-- is annoying to see in generated code. We get rid of it here.
			l_code.replace_substring_all ("%R", "")

			l_buffer := Context.buffer
			if a_ret_type.is_void then
				l_buffer.putstring (l_code)
			else
				if a_ret_type.is_boolean then
					l_buffer.putstring ("EIF_TEST")
				end
				l_buffer.putchar ('(')
				l_buffer.putstring (l_code)
				l_buffer.putchar (')')
			end
		end

end -- class INLINE_EXTENSION_I
