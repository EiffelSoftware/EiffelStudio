indexing
	description: "Byte code for external features."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXT_BYTE_CODE 

inherit
	STD_BYTE_CODE
		rename
			argument_names as std_argument_names,
			argument_types as std_argument_types
		redefine
			generate, generate_compound,
			is_external, pre_inlined_code, inlined_byte_code
		end

create
	make

feature {NONE} -- Initialization

	make (a_name_id: INTEGER) is
			-- Assign `s' to `a_name_id'.
		require
			a_name_id_positive: a_name_id > 0
		do
			external_name_id := a_name_id
		ensure
			external_name_id_set: external_name_id = a_name_id
		end

feature -- Access

	external_name: STRING is
			-- External name to call
		do
			Result := Names_heap.item (external_name_id)
		ensure
			external_name_not_void: Result /= Void
		end
		
	external_name_id: INTEGER
			-- Name ID of external.

	argument_types: like std_argument_types is
			-- Type of arguments, not including Current.
		local
			arg: TYPE_I
			i, j, count: INTEGER
		do
			if arguments /= Void then
				from
					count := arguments.count
					create Result.make (1, count)
					j := 1
					i := 1
				until
					i > count
				loop
					arg := real_type (arguments.item (i))
					if arg.is_reference then
						Result.put ("EIF_OBJECT", j)
					else
						Result.put (arg.c_type.c_string, j)
					end
					i := i + 1
					j := j + 1
				end
			else
				create Result.make (1, 0)
			end
		ensure
			argument_types_not_void: Result /= Void
		end			

	argument_names: like std_argument_names is
			-- Type of arguments, not including Current.
		local
			l_lower, l_upper: INTEGER
		do
			Result := std_argument_names
			if Result.count > 1 then
				l_lower := Result.lower
				l_upper := Result.upper
				create Result.make (1, l_upper - l_lower)
				Result.subcopy (std_argument_names, l_lower + 1, l_upper, 1)
			else
				create Result.make (1, 0)
			end
		end

feature -- Status report

	is_external: BOOLEAN is True
			-- Is the current byte code a byte code for external
			-- features ?

feature -- C code generation

	generate is
			-- Generate body of routine.
		local
			l_ret_type: like result_type
		do
				-- Generate the header "int foo(Current, args)"
			l_ret_type := result_type
			result_type := real_type (result_type)

			if not result_type.is_void then
				Context.mark_result_used
			end
			
				-- Initialize protection if needed.
			compute_hector_variables

				-- Actual code generation.
			if system.il_generation then
				generate_il_code
			else
				Precursor {STD_BYTE_CODE}
			end

				-- Restore `result_type' as usually it is not kept evaluated.
			result_type := l_ret_type
		end

	generate_il_code is
			-- Generate code for IL code generation.
		local
			l_ret_type: TYPE_I
			internal_name: STRING
			buf: GENERATION_BUFFER
		do
			buf := buffer
			l_ret_type := result_type

			internal_name := encoder.feature_name (
				System.class_type_of_id (context.current_type.type_id).static_type_id, body_index)
			buf.generate_function_signature (l_ret_type.c_type.c_string, internal_name,
				True, context.header_buffer, argument_names, argument_types)

			buf.indent
			if not l_ret_type.is_void then
				l_ret_type.c_type.generate (buf)
				buf.put_string ("Result;")
				buf.put_new_line
			end
			generate_compound
			if not result_type.is_void then
				buf.put_string ("return Result;")
				buf.put_new_line
			end
			buf.exdent
			buf.put_character ('}')
			buf.put_new_line
			context.inherited_assertion.wipe_out
		end
		
	generate_compound is
			-- Byte code generation
		local
			buf: GENERATION_BUFFER
			l_result: RESULT_BL
			l_ext: EXTERNAL_EXT_I
			l_need_protection: BOOLEAN
		do
			buf := buffer
			l_ext := Context.current_feature.extension
			check
				is_external: Context.current_feature.is_external
					-- Current feature should be an external one and therefore
					-- should have an extension.
				l_ext_not_void: l_ext /= Void
			end

			if not result_type.is_void then
					-- Only creates a result when needed.
				create l_result.make (result_type)
			end

			l_need_protection := has_hector_variables
			if l_need_protection then
				context.set_is_argument_protected (True)
				generate_hector_variables
			end

				-- Now we want the body
			if l_ext.is_blocking_call then
				buf.put_string ("EIF_ENTER_C;")
				buf.put_new_line
			end
			
				-- Generate call to external.
			l_ext.generate_body (Current, l_result)
			
			if l_ext.is_blocking_call then
				buf.put_string ("EIF_EXIT_C;")
				buf.put_new_line
				buf.put_string ("RTGC;")
				buf.put_new_line
			end
			
			if l_need_protection then
				release_hector_variables
				context.set_is_argument_protected (False)
			end
		end
		
feature -- Inlining

	pre_inlined_code: like Current is
			-- An external does not have a body
			-- Inlining is done differently
		do
		end

	inlined_byte_code: like Current is
		do
			Result := Current
		end

feature {NONE} -- Implementation

	has_hector_variables: BOOLEAN
			-- Does current external calls needs to protect some of its arguments?
			
	compute_hector_variables is
			-- Set `has_hector_variables' to True if some arguments are references?
		local
			i, nb: INTEGER
			l_arg: ARGUMENT_BL
		do
			has_hector_variables := False
			if not System.il_generation and then arguments /= Void then
				from
					i := arguments.lower
					nb := arguments.upper
				until
					i > nb
				loop
					if real_type (arguments.item (i)).c_type.is_pointer then
						has_hector_variables := True
						create l_arg
						l_arg.set_position (i)
						context.set_local_index (l_arg.register_name, l_arg)
					end
					i := i + 1
				end
			end
		end
		
	generate_hector_variables is
			-- Generate protection of arguments that needs one.
		require
			has_hector_variables: has_hector_variables
			has_arguments: arguments /= Void
		local
			l_buf: GENERATION_BUFFER
			i, nb: INTEGER
		do
			l_buf := context.buffer
			l_buf.put_character ('{')
			l_buf.put_new_line
			l_buf.indent

			from
				i := arguments.lower
				nb := arguments.upper
			until
				i > nb
			loop
				if real_type (arguments.item (i)).c_type.is_pointer then
					l_buf.put_string ("EIF_OBJECT larg")
					l_buf.put_integer (i)
					l_buf.put_string (" = RTHP(")
					l_buf.put_string ("arg")
					l_buf.put_integer (i)
					l_buf.put_string (");")
				else
					l_buf.put_string (argument_types.item (i))
					l_buf.put_string (" larg")
					l_buf.put_integer (i)
					l_buf.put_string (" = arg")
					l_buf.put_integer (i)
					l_buf.put_character (';')
				end
				l_buf.put_new_line
				i := i + 1
			end
			
		end
		
	release_hector_variables is
			-- Release protection of arguments.
		local
			l_buf: GENERATION_BUFFER
		do
			l_buf := context.buffer
			l_buf.put_string ("RTHF(")
			l_buf.put_integer (number_of_hector_variables)
			l_buf.put_string (");")
			l_buf.put_new_line
			l_buf.exdent
			l_buf.put_character ('}')
			l_buf.put_new_line
		end
		
	number_of_hector_variables: INTEGER is
			-- Number of arguments to protect?
		local
			i, nb: INTEGER
		do
			from
				i := arguments.lower
				nb := arguments.upper
			until
				i > nb
			loop
				if real_type (arguments.item (i)).c_type.is_pointer then
					Result := Result + 1
				end
				i := i + 1
			end
		end

invariant
	external_name_id_positive: external_name_id > 0

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

end
