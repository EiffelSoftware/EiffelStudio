note
	description: "C Pattern of a feature: it is constitued of the meta types of the %
		%arguments and result."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class C_PATTERN

inherit

	SHARED_WORKBENCH
		redefine
			is_equal
		end

	HASHABLE
		redefine
			is_equal
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		redefine
			is_equal
		end

	SHARED_TYPE_I
		export
			{NONE} all
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (t: TYPE_C; a_args: like argument_types)
			-- Creation of a pattern with a result meta type
		require
			valid_type: t /= Void;
		do
			result_type := t
			argument_types := a_args
		ensure
			result_type_set: result_type = t
			argument_types_set: argument_types = a_args
		end

feature {PATTERN} -- Update

	update (t: TYPE_C; a_args: like argument_types)
			-- Creation of a pattern with a result meta type
		require
			valid_type: t /= Void;
		do
			result_type := t
			argument_types := a_args
		ensure
			result_type_set: result_type = t
			argument_types_set: argument_types = a_args
		end

feature

	duplicate: C_PATTERN
			-- Duplicate of `Current'.
		local
			l_arg_types: like argument_types
		do
			l_arg_types := argument_types
			if l_arg_types /= Void and then l_arg_types.count > 0 then
				create Result.make (result_type, argument_types.resized_area (l_arg_types.count))
			else
				create Result.make (result_type, Void)
			end
		end

	result_type: TYPE_C;
			-- Meta type of the result

	argument_types: SPECIAL [TYPE_C];
			-- Meta types of the arguments

	argument_count: INTEGER
			-- Number of arguments
		do
			if argument_types /= Void then
				Result := argument_types.count;
			end;
		end;

	is_equal (other: C_PATTERN): BOOLEAN
			-- Is `other' equal to Current ?
		local
			n, i: INTEGER;
		do
			Result := other = Current
			if not Result then
				n := argument_count;
				Result :=  n = other.argument_count and then
						result_type.same_as (other.result_type)
				from
					i := 0;
				until
					i = n or else not Result
				loop
					Result := argument_types [i].same_as (other.argument_types [i]);
					i := i + 1;
				end
			end
		end;

	hash_code: INTEGER
			-- Hash code for pattern
		local
			i, n: INTEGER
			l_rotate: INTEGER
			l_bytes: INTEGER
		do
			Result := result_type.hash_code
			n := argument_count
			if n > 0 then
				from
					i := 0
				until
					i = n
				loop
						-- Perform a rotation of the hash_code value every 4 bytes.
					l_rotate := argument_types.item (i).hash_code
					l_bytes := 4 * ((i + 1) \\ 8)
					l_rotate := (l_rotate |<< l_bytes) | (l_rotate |>> (32 - l_bytes))
					Result := Result.bit_xor (l_rotate)
					i := i + 1
				end
					-- To prevent negative values.
				Result := Result.hash_code
			end
		end

feature -- Pattern generation

	nb_hooks: INTEGER
			-- Number of garbage collector hooks needed
		local
			i, nb: INTEGER;
		do
			from
				Result := 1;
				i := 0;
				nb := argument_count;
			until
				i = nb
			loop
				if argument_types.item (i).is_reference then
					Result := Result + 1;
				end;
				i := i + 1;
			end;
			if result_type.is_reference then
				Result := Result + 1;
			end;
		end;

	argument_hook_index (j: INTEGER): INTEGER
			-- Hook index for i-th argument
		require
			index_small_enough: j <= argument_count;
			index_large_enough: j >= 1;
			consistency: argument_types.item (j).is_reference;
		local
			i: INTEGER;
		do
			from
				i := 0;
			until
				i = j
			loop
				if argument_types.item (i).is_reference then
					Result := Result + 1;
				end;
				i := i + 1
			end;
		ensure
			Result > 0
		end;

	argument_name_array: ARRAY [STRING]
			-- Argument names for code generation
		local
			i, nb: INTEGER;
			temp: STRING
		do
			create Result.make (1, argument_count + 1)
			Result.put ("Current", 1)
			from
				i := 1;
				nb := argument_count
			until
				i > nb
			loop
				temp := "arg"
				temp.append_integer (i)
				Result.put (temp, i+1)
				i := i + 1;
			end;
		end;

	workbench_argument_type_array: ARRAY [STRING]
			-- Argument types for code generation
		local
			i, j, nb: INTEGER
		do
			nb := argument_count
			create Result.make (1, nb + 1)
			Result.put ("EIF_REFERENCE", 1)
			j := 2
			from
				i := 1;
			until
				i > nb
			loop
				Result.put ("EIF_TYPED_VALUE", j)
				i := i + 1;
				j := j + 1;
			end
		ensure
			workench_argument_type_array_not_void: Result /= Void
		end

	argument_type_array: ARRAY [STRING]
			-- Argument types for code generation
		local
			i, j, nb: INTEGER
		do
			nb := argument_count
			create Result.make (1, nb + 1)
			Result.put ("EIF_REFERENCE", 1)
			j := 2
			from
				i := 0;
			until
				i = nb
			loop
				Result.put (argument_types.item (i).c_string, j)
				i := i + 1;
				j := j + 1;
			end;
		end

	generate_argument_declaration (buffer: GENERATION_BUFFER)
			-- Generate argument declarations
		local
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := argument_count
			until
				i > nb
			loop
				buffer.put_new_line
				buffer.put_string ("EIF_TYPED_VALUE *arg")
				buffer.put_integer (i)
				buffer.put_character (';')
				i := i + 1
			end
		end

	generate_pattern (id: INTEGER; buffer: GENERATION_BUFFER)
			-- Generate pattern
		do
				-- Generate pattern from C code to interpreter
			generate_toi_compound (id, buffer)

				-- Compound pattern from interpreter to C code
			generate_toc_compound (id, buffer)
		end

	generate_toc_compound (id: INTEGER; buffer: GENERATION_BUFFER)
			-- Generate compound pattern from interpreter to C code
		local
			f_name: STRING
		do
			create f_name.make (8)
			f_name.append (once "toc")
			f_name.append_integer (id)

			buffer.generate_function_signature (once "void", f_name, False, buffer,
					<<once "ptr">>, <<once "fnptr">>)
			buffer.generate_block_open
			buffer.put_new_line
			buffer.put_string (once "EIF_REFERENCE Current;")
			if not result_type.is_void then
				buffer.put_new_line
				buffer.put_string (once "EIF_TYPED_VALUE result;")
				buffer.put_new_line
				buffer.put_string (once "EIF_TYPED_VALUE *it;")
			end
			generate_argument_declaration (buffer)
			generate_toc_pop (buffer)
			generate_routine_call (buffer)
			if not result_type.is_void then
				buffer.put_new_line
				buffer.put_string (once "it = iget();")
				buffer.put_new_line
				if result_type.is_reference then
						-- Result might need to be boxed.
					buffer.put_string (
						once "[
							if ((result.type & SK_HEAD) == SK_REF) {
									*it = result;
								} else {
									it->type = SK_REF;
									it->it_ref = RTBU(result);
								}
						]"
					)
				else
						-- Result of a basic type can be used as it is.
					buffer.put_string (once "*it = result;")
				end
			end
			buffer.generate_block_close
				-- Separation for formatting
			buffer.put_new_line
		end

	generate_toi_compound (id: INTEGER; buffer: GENERATION_BUFFER)
			-- Generate compound pattern from C code to the interpreter
		local
			f_name: STRING
			result_string: STRING
			arg_types: ARRAY [STRING]
		do
			f_name := "toi";
			f_name.append_integer (id);

			if result_type.is_void then
				result_string := result_type.c_string
			else
				result_string := "EIF_TYPED_VALUE"
			end

			arg_types := workbench_argument_type_array

			buffer.generate_function_signature
				(result_string, f_name, False, buffer,
				 argument_name_array, arg_types)
			buffer.generate_block_open
			buffer.put_gtcx
			buffer.put_new_line
			buffer.put_string ("EIF_TYPED_VALUE *it;")
			generate_toi_push (buffer)
			buffer.put_new_line
			buffer.put_string ("xinterp(IC, ")
			buffer.put_integer (argument_count + 1)
			buffer.put_two_character (')', ';')
			if result_type.is_reference then
					-- Mask type-specific bits of the type tag
					-- because they are not expected on the C side.
				buffer.put_new_line
				buffer.put_string ("it = opop();")
				buffer.put_new_line
				buffer.put_string ("it->")
				result_type.generate_typed_tag (buffer)
				buffer.put_character (';')
				buffer.put_new_line
				buffer.put_string ("return *it;")
			elseif not result_type.is_void then
					-- Use basic type tag as is.
				buffer.put_new_line
				buffer.put_string ("return * opop();")
			end
			buffer.generate_block_close
				-- Separation for formatting
			buffer.put_new_line
		end

	generate_toi_push (buffer: GENERATION_BUFFER)
			-- Generates stack pushing instruction for the patterns
			-- going from C to the interpreter
		local
			i, nb: INTEGER;
			arg: TYPE_C;
		do
			from
				i := 1;
				nb := argument_count;
			until
				i > nb
			loop
				arg := argument_types [i - 1]
				buffer.put_new_line
				if arg.is_reference then
						-- Reference value can be used as it is.
					buffer.put_string ("*iget() = arg")
					buffer.put_integer (i)
				else
						-- Basic value might need to be unboxed.
					buffer.put_string ("it = iget();");
					buffer.put_new_line
					buffer.put_string ("it->type = ");
					arg.generate_sk_value (buffer);
					buffer.put_character (';')
					buffer.put_string ("it->");
					arg.generate_typed_field (buffer);
					buffer.put_string (" = ((arg");
					buffer.put_integer (i);
					buffer.put_string (".type & SK_HEAD) == SK_REF)? * ")
					arg.generate_access_cast (buffer)
					buffer.put_string ("arg")
					buffer.put_integer (i)
					buffer.put_character ('.')
					reference_c_type.generate_typed_field (buffer)
					buffer.put_string (": arg")
					buffer.put_integer (i)
					buffer.put_character ('.')
					arg.generate_typed_field (buffer)
				end
				buffer.put_character (';')
				i := i + 1;
			end;
			buffer.put_string ("%N%
				%%Tit = iget();%N%
				%%Tit->type = SK_REF;%N%
				%%Tit->it_ref = Current;%N");
		end;

	generate_toc_pop (buffer: GENERATION_BUFFER)
			-- Generate poping instructions for pattern from interpreter
			-- to C code
		local
			i: INTEGER
		do
			buffer.put_new_line
			buffer.put_string ("Current = opop()->it_ref;")
			buffer.put_new_line
			from
				i := argument_count
			until
				i < 1
			loop
				buffer.put_new_line
				buffer.put_string ("arg")
				buffer.put_integer (i)
				buffer.put_string (" = opop();")
				i := i - 1
			end
		end

	generate_routine_call (buffer: GENERATION_BUFFER)
			-- Generate C routine call
		local
			i, nb: INTEGER
		do
			buffer.put_new_line
			if not result_type.is_void then
				buffer.put_string ("result = ")
			end
			buffer.put_character ('(')
				-- Patterns are only in workbench mode generation
			result_type.generate_function_cast (buffer, workbench_argument_type_array, True)
			buffer.put_string ("ptr)(")
			nb := argument_count
			buffer.put_string ("Current")
			if nb > 0 then
				buffer.put_character (',')
			end
			from
				i := 1
			until
				i > nb
			loop
				buffer.put_string ("*arg")
				buffer.put_integer (i)
				if i < nb then
					buffer.put_character (',')
				end;
				i := i + 1
			end
			buffer.put_string (");")
		end

invariant

	result_type_exists: result_type /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
