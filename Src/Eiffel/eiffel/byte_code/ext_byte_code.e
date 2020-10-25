note
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
			generate, generate_compound, analyze, generate_return_exp,
			is_external, pre_inlined_code, inlined_byte_code,
			make_body_code, generate_il
		end

create
	make

feature {NONE} -- Initialization

	make (a_name_id: INTEGER)
			-- Assign `s' to `a_name_id'.
		require
			a_name_id_positive: a_name_id > 0
		do
			external_name_id := a_name_id
		ensure
			external_name_id_set: external_name_id = a_name_id
		end

feature -- Access

	external_name_id: INTEGER
			-- Name ID of external.

	argument_types: like std_argument_types
			-- Type of arguments, not including Current.
		local
			arg: TYPE_A
			i, j, count: INTEGER
		do
			if arguments /= Void then
				from
					count := arguments.count
					create Result.make_filled ("", 1, count)
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
				create Result.make_empty
			end
		ensure
			argument_types_not_void: Result /= Void
		end

	argument_names: like std_argument_names
			-- Type of arguments, not including Current.
		local
			l_lower, l_upper: INTEGER
		do
			Result := std_argument_names
			if Result.count > 1 then
				l_lower := Result.lower
				l_upper := Result.upper
				create Result.make_filled ("", 1, l_upper - l_lower)
				Result.subcopy (std_argument_names, l_lower + 1, l_upper, 1)
			else
				create Result.make_empty
			end
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	external_name: STRING
			-- External name to call
		do
			Result := Names_heap.item (external_name_id)
		ensure
			external_name_not_void: Result /= Void
		end

feature -- Status report

	is_external: BOOLEAN = True
			-- Is the current byte code a byte code for external
			-- features ?

feature -- Analyzis

	analyze
			-- Analyze external code
		do
			if not system.il_generation then
				Precursor {STD_BYTE_CODE}
			end
		end

feature -- Byte code generation

	make_body_code (ba: BYTE_ARRAY; a_generator: MELTED_GENERATOR)
		local
			l_class: CLASS_C
		do
			if attached context.current_feature.extension as l_ext and then l_ext.is_built_in then
				ba.append (bc_builtin)
				l_class := context.current_feature.written_class
				if l_class = system.type_class.compiled_class then
					inspect
						context.current_feature.feature_name_id

					when {PREDEFINED_NAMES}.has_default_name_id then
						ba.append (bc_builtin_type__has_default)
					when {PREDEFINED_NAMES}.default_name_id then
						ba.append (bc_builtin_type__default)
					when {PREDEFINED_NAMES}.type_id_name_id then
						ba.append (bc_builtin_type__type_id)
					when {PREDEFINED_NAMES}.runtime_name_name_id then
						if
							attached context.current_feature.type.actual_type as t and then
							t.has_associated_class and then
							attached system.string_32_class as s and then
							s.is_compiled and then
							t.base_class.class_id = s.compiled_class.class_id
						then
								-- Result is of type STRING_32.
							ba.append (bc_builtin_type__runtime_name__s4)
						else
								-- Result is of type STRING_8.
							ba.append (bc_builtin_type__runtime_name__s1)
						end
					when {PREDEFINED_NAMES}.generic_parameter_type_name_id then
						ba.append (bc_builtin_type__generic_parameter_type)
					when {PREDEFINED_NAMES}.generic_parameter_count_name_id then
						ba.append (bc_builtin_type__generic_parameter_count)
					when {PREDEFINED_NAMES}.is_attached_name_id then
						ba.append (bc_builtin_type__is_attached)
					when {PREDEFINED_NAMES}.is_deferred_name_id then
						ba.append (bc_builtin_type__is_deferred)
					when {PREDEFINED_NAMES}.is_expanded_name_id then
						ba.append (bc_builtin_type__is_expanded)

					else
						ba.append (bc_builtin_unknown)
					end
				else
					ba.append (bc_builtin_unknown)
				end
			else
				Precursor (ba, a_generator)
			end
		end

feature -- Il code generation

	generate_il
			-- Generate the IL code for an external.
		do
			if attached context.current_feature.extension as l_ext and then l_ext.is_built_in then
				il_generator.generate_runtime_builtin_call (context.current_feature)
			else
				Precursor
			end
		end

feature -- C code generation

	generate
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

	generate_il_code
			-- Generate code for IL code generation.
		local
			l_ret_type: TYPE_A
			internal_name: STRING
			buf: GENERATION_BUFFER
		do
			buf := buffer
			l_ret_type := result_type

			internal_name := generated_c_feature_name
			buf.generate_function_signature (l_ret_type.c_type.c_string, internal_name,
				True, context.header_buffer, argument_names, argument_types)

			buf.generate_block_open
			if not l_ret_type.is_void then
				buf.put_new_line
				l_ret_type.c_type.generate (buf)
				buf.put_character (' ')
				buf.put_string ({C_CONST}.result_name)
				buf.put_character (';')
			end
			generate_compound
			if not result_type.is_void then
				buf.put_new_line
				buf.put_string ({C_CONST}.return)
				buf.put_character (' ')
				buf.put_string ({C_CONST}.result_name)
				buf.put_character (';')
			end
			buf.generate_block_close
			context.inherited_assertion.wipe_out
		end

	generate_compound
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
			if l_ext.is_built_in then
					-- We remove the hector variables that are not required in this case.
					-- since all `built_in' are supposed to work directly on objects.
				has_hector_variables := False
			end

			if not result_type.is_void then
					-- Only creates a result when needed.
				create l_result.make (result_type)
			end

			l_need_protection := has_hector_variables
			if l_need_protection then
				context.set_is_argument_protected (True)
				buf.generate_block_open
				generate_hector_variables
			end

				-- Now we want the body
			if l_ext.is_blocking_call then
				buf.put_new_line
				buf.put_string ("EIF_ENTER_C;")
			end

				-- Generate call to external.
			l_ext.generate_body (Current, l_result)

			if l_ext.is_blocking_call then
				buf.put_new_line
				buf.put_string ("EIF_EXIT_C;")
				buf.put_new_line
				buf.put_string ("RTGC;")
			end

			if l_need_protection then
				context.set_is_argument_protected (False)
				buf.generate_block_close
			end
		end

	generate_return_exp (type_c: TYPE_C)
			-- Generate the return expression for a function with return type `type_c`.
		local
			l_type: TYPE_A
			buf: GENERATION_BUFFER
			l_name: STRING
			l_class_type: CLASS_TYPE
		do
			l_type := real_type (result_type)
			if l_type.is_true_expanded then
				buf := buffer
					-- If the C externals failed into creating an expanded object, then we create a default one.
				buf.put_new_line
				buf.put_string ("if (!Result) {")
				buf.indent
				l_class_type := l_type.associated_class_type (Context.context_class_type.type)
				l_name := Context.Result_register.Register_name
				l_class_type.generate_expanded_creation (buf, l_name, result_type, Context.context_class_type)
				l_class_type.generate_expanded_initialization (buf, l_name, l_name, True)
				buf.generate_block_close

				buf.put_new_line
				if Context.workbench_mode then
					buf.put_string (once "{ EIF_TYPED_VALUE r; r.")
					type_c.generate_typed_tag (buf)
					buf.put_string (once "; r.")
					type_c.generate_typed_field (buf)
					buf.put_string (once " = Result; return r; }")
				else
					buf.put_string ("return Result;")
				end
			else
				Precursor (type_c)
			end
		end

feature -- Inlining

	pre_inlined_code: like Current
			-- An external does not have a body
			-- Inlining is done differently
		do
		end

	inlined_byte_code: like Current
		do
			Result := Current
		end

feature {NONE} -- Implementation

	has_hector_variables: BOOLEAN
			-- Does current external calls needs to protect some of its arguments?

	compute_hector_variables
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
					if real_type (arguments.item (i)).c_type.is_reference then
						has_hector_variables := True
						create l_arg
						l_arg.set_position (i)
						context.set_local_index (l_arg.register_name, l_arg)
					end
					i := i + 1
				end
			end
		end

	generate_hector_variables
			-- Generate protection of arguments that needs one.
		require
			has_hector_variables: has_hector_variables
			has_arguments: arguments /= Void
		local
			l_buf: GENERATION_BUFFER
			i, nb: INTEGER
		do
			l_buf := context.buffer
			from
				i := arguments.lower
				nb := arguments.upper
			until
				i > nb
			loop
				l_buf.put_new_line
				if real_type (arguments.item (i)).c_type.is_reference then
						-- Historically we were storing arguments in the hec_stack C structure,
						-- but this was useless and expensive since the arg is already stored in the loc_set
						-- structure. So here just providing the address of the `arg' is enough to give us
						-- the EIF_OBJECT the C external expects.
					l_buf.put_string ("EIF_OBJECT larg")
					l_buf.put_integer (i)
					l_buf.put_string (" = &arg")
				else
					l_buf.put_string (argument_types.item (i))
					l_buf.put_string (" larg")
					l_buf.put_integer (i)
					l_buf.put_string (" = arg")
				end
				l_buf.put_integer (i)
				l_buf.put_character (';')
				i := i + 1
			end

		end

invariant
	external_name_id_positive: external_name_id > 0

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
