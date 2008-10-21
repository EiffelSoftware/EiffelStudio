indexing
	description: "Representation of a built_in external."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BUILT_IN_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_built_in, is_static
		end

	PREFIX_INFIX_NAMES
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (v: like is_static) is
			-- Initialize `Current'.
		do
			is_static := v
		end

feature -- Status report

	is_static: BOOLEAN
			-- Is current builtin statically callable?

	is_built_in: BOOLEAN is True
			-- Current is a builtin.

feature -- Code generation

	generate_body (inline_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
		local
			l_ret_type: TYPE_A
			l_buffer: GENERATION_BUFFER
		do
			l_buffer := context.buffer

			l_ret_type := inline_byte_code.result_type
			l_buffer.put_new_line
			if not l_ret_type.is_void then
				a_result.print_register
				l_buffer.put_string (" = ")
				l_ret_type.c_type.generate_cast (l_buffer)
			end
				-- Make sure that the class id passed in is where the built-in feature is written, not melted.
				-- This makes sure the replicated built-in's get generated correctly.
			internal_generate_access (inline_byte_code.feature_name, Context.current_feature.written_in,
				Void, Void, inline_byte_code.argument_count, l_ret_type)

			l_buffer.put_character (';')
		end

	generate_access (external_name: STRING; written_class_id: INTEGER; reg: REGISTRABLE; parameters: BYTE_LIST [EXPR_B]; a_ret_type: TYPE_A) is
			-- Generate inline call to C++ external.
		require
			external_name_not_void: external_name /= Void
			a_ret_type_not_void: a_ret_type /= Void
		do
			check
				final_mode: Context.final_mode
			end
			if parameters /= Void then
				internal_generate_access (external_name, written_class_id, reg, parameters, parameters.count, a_ret_type)
			else
				internal_generate_access (external_name, written_class_id, reg, Void, 0, a_ret_type)
			end
		end

feature {NONE} -- Implementation

	internal_generate_access (
			external_name: STRING; written_class_id: INTEGER; reg: REGISTRABLE; parameters: BYTE_LIST [EXPR_B];
			nb: INTEGER; a_ret_type: TYPE_A)
		is
			-- Generate inline C external call.
		require
			external_name_not_void: external_name /= Void
			written_class_id_positive: written_class_id > 0
			parameters_valid: parameters /= Void implies parameters.count = nb
		local
			l_buffer: GENERATION_BUFFER
			l_class: CLASS_C
			l_name: STRING
		do
			l_buffer := context.buffer

			l_class := system.class_of_id (written_class_id)

			check l_class_not_void: l_class /= Void end
				-- Special processing of operators that have a name not suitable
				-- for C code generation.
			l_name := external_name.twin
			if is_mangled_name (l_name) then
				if is_mangled_alias_name (l_name) then
					l_name := extract_alias_name (l_name)
				elseif is_mangled_infix (l_name) then
					l_name := extract_symbol_from_infix (l_name)
				else
					check is_prefix: is_mangled_prefix (l_name) end
					l_name := extract_symbol_from_prefix (l_name)
				end
				operator_table.search (l_name)
				if operator_table.found then
					l_name := operator_table.found_item.twin
				else
					l_name.replace_substring_all (" ", "_")
				end
			end
			l_name.prepend_character ('_')
			l_name.prepend (l_class.name)
			l_name.prepend ("eif_builtin_")

			l_buffer.put_string (l_name)
			if not is_static or else nb > 0 then
				l_buffer.put_string (" (")
			end

			if not is_static then
				if reg /= Void then
					reg.print_register
				else
					l_buffer.put_string ("Current")
				end
				if nb > 0 then
					l_buffer.put_string (", ")
				end
			end
			generate_parameter_list (parameters, nb, False)

			if not is_static or else nb > 0 then
				l_buffer.put_character (')')
			end

			shared_include_queue.put ({PREDEFINED_NAMES}.eif_built_in_header_name_id)
		end

feature {NONE} -- Implementation

	operator_table: HASH_TABLE [STRING, STRING]
			-- Mapping between standard operator and their C generated names
		once
			create Result.make (20)
			Result.put ("or_else", "or else")
			Result.put ("and_then", "and then")
			Result.put ("slash", "/")
			Result.put ("div", "//")
			Result.put ("backslash", "\")
			Result.put ("mod", "\\")
			Result.put ("bitwise_and", "&")
			Result.put ("binary_and", "&&")
			Result.put ("minus", "-")
			Result.put ("plus", "+")
			Result.put ("star", "*")
			Result.put ("power", "^")
			Result.put ("le", "<")
		ensure
			operator_table_not_void: Result /= Void
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

end
