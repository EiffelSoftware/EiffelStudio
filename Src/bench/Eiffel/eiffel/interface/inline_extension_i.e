indexing
	description: "Encapsulation of a C inline extension."
	date: "$Date$"
	revision: "$Revision$"

class INLINE_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_equal, is_cpp, is_inline,
			has_standard_prototype, 
			generate_external_name
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

	generate_external_name (buffer: GENERATION_BUFFER; external_name: STRING; ret_type: TYPE_C) is
			-- Generate the C name associated with the extension
		do
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end
		end

	generate_inline_body (buffer: GENERATION_BUFFER) is
			-- Generate code for inline C feature in a body, i.e. encpasulation of inline.
		require
			buffer_not_void: buffer /= Void
		do
			internal_generate_inline (buffer, Void)
		end

	generate_inline_access (buffer: GENERATION_BUFFER; parameters: BYTE_LIST [EXPR_B]) is
			-- Generate code for access to inline C feature.
		require
			buffer_not_void: buffer /= Void
			parameters_not_void: argument_names /= Void implies parameters /= Void
			parameters_count_valid: argument_names /= Void implies
				(argument_names.count = parameters.count)
		do
			internal_generate_inline (buffer, parameters)
		end

feature {NONE} -- Implementation

	internal_generate_inline (buffer: GENERATION_BUFFER; parameters: BYTE_LIST [EXPR_B]) is
			-- Generate code for inline C feature.
		require
			buffer_not_void: buffer /= Void
			parameters_not_void: parameters /= Void implies argument_names /= Void
			parameters_count_valid: parameters /= Void implies
				(argument_names.count = parameters.count)
		local
			l_code, l_arg: STRING
			l_old, l_temp: like buffer
			l_values: ARRAY [STRING]
			i, nb: INTEGER
		do
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end

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

				-- FIXME: Manu 03/26/2003:
				-- When verbatim strings are used, on Windows we get a %R%N which
				-- is annoying to see in generated code. We get rid of it here.
			l_code.replace_substring_all ("%R", "")
			buffer.putstring (l_code)
		end
		
	has_standard_prototype: BOOLEAN is False

end -- class INLINE_EXTENSION_I
