indexing
	description: "Encapsulation of a C inline extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			name: STRING
			i: INTEGER
			put_eif_test: BOOLEAN
			arg_types: ARRAY [STRING]
		do
			name := inline_byte_code.generated_c_feature_name
			arg_types := inline_byte_code.argument_types
			force_inline_def (inline_byte_code.result_type, name, arg_types)
			name := inline_name (name)

			l_buffer := Context.buffer
			l_ret_type := inline_byte_code.result_type
			if not l_ret_type.is_void then
				put_eif_test := l_ret_type.is_boolean
				l_is_func := True
				l_buffer.put_new_line
				a_result.print_register
				l_buffer.put_string (" = ")
				if put_eif_test then
					l_buffer.put_string ("EIF_TEST(")
				end
			end

			l_buffer.put_string (name)
			l_buffer.put_string (" (")
			from
				i := 1
			until
				i > inline_byte_code.argument_count
			loop
				if i > 1 then
					l_buffer.put_string (", ")
				end
				l_buffer.put_character ('(')
				l_buffer.put_string (arg_types.item (i))
				l_buffer.put_string (") arg" + i.out)
				i := i + 1
			end
			if put_eif_test then
				l_buffer.put_character (')')
			end
			l_buffer.put_string (");")
			l_buffer.put_new_line
		end

	force_inline_def (a_ret_type: TYPE_I; name: STRING; arg_types: ARRAY [STRING]) is
			-- Add routine `name' in set of already generated inlines if not present already.
		require
			a_ret_type_not_void: a_ret_type /= Void
			name_not_void: name /= Void
			arg_types_not_void: arg_types /= Void
		do
			if not context.generated_inlines.has (name) then
				generate_inline_def (a_ret_type, name, arg_types)
				context.generated_inlines.put (name.twin)
			end
		end

	inline_name (a_name: STRING): STRING is
			-- Name of inline routine from original name `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			Result := "inline_" + a_name
		ensure
			inline_name_not_void: Result /= Void
		end

	generate_inline_def (a_ret_type: TYPE_I; name: STRING; arg_types: ARRAY [STRING]) is
			-- Generate content of inline routine `name' in a separate routine called `inline_name'.
		require
			a_ret_type_not_void: a_ret_type /= Void
			name_not_void: name /= Void
			arg_types_not_void: arg_types /= Void
		local
			buf, old_buf: GENERATION_BUFFER
			uc_name, type: STRING
		do
			old_buf := context.generation_buffer
			buf := context.generation_ext_inline_buffer
			context.set_buffer (buf)
			uc_name := name.as_upper

			buf.put_new_line_only
			buf.put_string ("#ifndef INLINE_")
			buf.put_string (uc_name)

			if a_ret_type.is_boolean then
				type := "int"
			else
				type := a_ret_type.c_type.c_string
			end

			buf.generate_function_signature (
				type,
				inline_name (name),
				False,
				Void,
				inline_arg_names (arg_types.count),
				arg_types)

			buf.generate_block_open

			internal_generate_inline (a_ret_type)
			buf.put_new_line
			buf.put_character (';')

			buf.generate_block_close

			buf.put_new_line_only
			buf.put_string ("#define INLINE_")
			buf.put_string (uc_name)
			buf.put_new_line_only
			buf.put_string ("#endif" )
			context.set_buffer (old_buf)
		end

feature {NONE} -- Implementation

	internal_generate_inline (a_ret_type: TYPE_I) is
			-- Generate code for inline C feature.
		local
			l_code, l_arg: STRING
			l_buffer: GENERATION_BUFFER
			l_old: GENERATION_BUFFER
			l_values: ARRAY [STRING]
			l_names: ARRAY [STRING]
			l_max, l_current_max: INTEGER
			i, nb: INTEGER
			done: BOOLEAN
		do
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end

			generate_header_files

			l_code := Names_heap.item (alias_name_id)
				-- If there was no alias clause then do nothing.
			if l_code /= Void then
				l_code := l_code.twin
				l_code.right_adjust
				l_code.left_adjust

				if argument_names /= Void then
						-- Generate all expressions corresponding to passed arguments.
						-- We use a trick to use an empty generation buffer by replacing
						-- shared one `context.buffer' by a temporary one.
					l_old := context.buffer
					create l_values.make (1, argument_names.count)
					create l_names.make (1, argument_names.count)

					from
						i := 1
						nb := argument_names.count
					until
						i > nb
					loop
						l_values.put ("arg" + i.out, i)
						i := i + 1
					end
					context.set_buffer (l_old)

					-- Extract names from arguments.
					from
						i := 0
						nb := argument_names.count - 1
					until
						i > nb
					loop
						l_arg := "$" + Names_heap.item (argument_names.item (i))
						l_names.put (l_arg, i + 1)
							-- Find out the length of the biggest one.
						l_max := l_max.max (l_arg.count)
						i := i + 1
					end

						-- Now replace arguments by their real name. Note that we always start
						-- with the bigger one to the small one. Not doing it was breaking
						-- eweasel tests ccomp046, ccomp047 and final026.
					from
					until
						done
					loop
						from
							done := True
							i := 1
							nb := argument_names.count
						until
							i > nb
						loop
							l_arg := l_names.item (i)
							if l_arg /= Void then
								if l_arg.count >= l_max then
									l_code.replace_substring_all (l_names.item (i), l_values.item (i))
									l_names.put (Void, i)
									done := False
								else
									l_current_max := l_current_max.max (l_arg.count)
								end
							end
							i := i + 1
						end
						l_max := l_current_max
						l_current_max := 0
					end
				end

					-- Replace `$$_result_type' if used by return type of current inlined function.
				l_code.replace_substring_all ("$$_result_type", a_ret_type.c_type.c_string)
				if not a_ret_type.is_void then
						-- Replace `$$_result_value' if used by return value field of current inlined function.
					l_code.replace_substring_all ("$$_result_value", a_ret_type.c_type.typed_field)
				end

					-- FIXME: Manu 03/26/2003:
					-- When verbatim strings are used, on Windows we get a %R%N which
					-- is annoying to see in generated code. We get rid of it here.
				l_code.replace_substring_all ("%R", "")

				l_buffer := Context.buffer
				l_buffer.put_new_line
				if a_ret_type.is_void then
					l_buffer.put_string (l_code)
				else
					if alias_contains_return (l_code) then
						l_buffer.put_string (l_code)
					else
						l_buffer.put_string ("return ")
						if a_ret_type.is_boolean then
							l_buffer.put_string ("(int) ")
						else
							a_ret_type.c_type.generate_cast (l_buffer)
						end
						l_buffer.put_character ('(')
						l_buffer.put_string (l_code)
						l_buffer.put_character (')')
					end
				end
			end
		end

	inline_arg_names (count: INTEGER): ARRAY [STRING] is
			-- Names of the arguments
		local
			i : INTEGER
			temp: STRING
		do
			from
				create Result.make(1, count)
				i := 1
			until
				i > count
			loop
				temp := "arg"
				temp.append_integer (i)
				Result.put (temp, i)
				i := i + 1
			end
		end

	alias_contains_return (c_code: STRING): BOOLEAN is
			-- checks, whether there is a return statement in c_code
		local
			in_string, in_char, in_single_comment,
			in_multi_comment, last_was_slash, last_was_star,
			last_was_backslash: BOOLEAN;
			i: INTEGER;
			c, tc: CHARACTER;
			changed_into: BOOLEAN
		do
			from
				i := 1
			until
				Result = True or i > c_code.count - 5
			loop
				c := c_code.item (i)
				if not in_string and not in_char and not in_single_comment and not in_multi_comment then
					if not last_was_backslash then
						changed_into := False
						inspect c
						when '%"' then
							in_string := True
							changed_into := True
						when '%'' then
							in_char := True
							changed_into := True
						when '/' then
							in_single_comment := last_was_slash
							changed_into := in_single_comment
						when '*' then
							in_multi_comment := last_was_slash
							changed_into := in_multi_comment
						else
						end

						if changed_into then
							last_was_slash := False
						else
							if c = 'r' then
								if equal (c_code.substring (i+1, i+5), "eturn") then
									tc := c_code.item (i+6)
									if not (tc.is_alpha_numeric or tc = '_') then
										Result := True
									end
								end
							end
						end
					end
					if not changed_into then
						last_was_slash := c = '/'
						last_was_backslash := c = '\' and not last_was_backslash
					end
				elseif in_string then
					if c = '"' and not last_was_backslash then
						in_string := False
					end
					last_was_backslash := c = '\' and not last_was_backslash
				elseif in_char then
					if c = '%'' and not last_was_backslash then
						in_char := False
					end
				else if in_single_comment then
					if c = '%N' then
						in_single_comment := False
					end
				elseif in_multi_comment then
					if last_was_star and c = '/' then
						in_multi_comment := False
					end
					last_was_star := c = '*'
				else
					check
						impossible_state: false
					end
				end
			end
			i := i + 1
		end
	end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class INLINE_EXTENSION_I
