note
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

	make (v: like is_static)
			-- Initialize `Current'.
		do
			is_static := v
		end

feature -- Status report

	is_static: BOOLEAN
			-- Is current builtin statically callable?

	is_built_in: BOOLEAN = True
			-- Current is a builtin.

feature -- Code generation

	generate_body (inline_byte_code: EXT_BYTE_CODE; a_result: RESULT_B)
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
			internal_generate_access (inline_byte_code.external_name, Context.current_feature.written_in,
				Void, Void, inline_byte_code.argument_count, l_ret_type,
				context.current_feature.written_class.feature_of_body_index (context.current_feature.body_index), context.class_type)

			l_buffer.put_character (';')
		end

	generate_access (external_name: STRING; written_class_id: INTEGER; reg: REGISTRABLE; parameters: BYTE_LIST [EXPR_B]; a_ret_type: TYPE_A;
		declared_feature: detachable FEATURE_I; target_type: CLASS_TYPE)
			-- Generate inline call to a built-in feature declared as `declared_feature` and called on target type `target_type`.
		require
			external_name_not_void: external_name /= Void
			a_ret_type_not_void: a_ret_type /= Void
		do
			check
				final_mode: Context.final_mode
			end
			internal_generate_access (external_name, written_class_id, reg, parameters,
				if attached parameters then parameters.count else 0 end, a_ret_type, declared_feature, target_type)
		end

feature {NONE} -- Implementation

	internal_generate_access (
			external_name: STRING; written_class_id: INTEGER; reg: REGISTRABLE; parameters: BYTE_LIST [EXPR_B];
			nb: INTEGER; a_ret_type: TYPE_A; declared_feature: detachable FEATURE_I; target_type: CLASS_TYPE)

			-- Generate inline C external call.
		require
			external_name_not_void: external_name /= Void
			written_class_id_positive: written_class_id > 0
			parameters_valid: parameters /= Void implies parameters.count = nb
		local
			l_buffer: GENERATION_BUFFER
			l_class: CLASS_C
			l_name: STRING_8
			mutable_name: STRING_8
		do
			l_buffer := context.buffer

			l_class := system.class_of_id (written_class_id)

			check l_class_not_void: l_class /= Void end
				-- Special processing of operators that have a name not suitable
				-- for C code generation.
			l_name := external_name
			if is_mangled_alias_name (l_name) then
				l_name := extract_alias_name (l_name)
				if attached operator_table [l_name] as n then
					l_name := n
				else
					create mutable_name.make_from_string (l_name)
					mutable_name.replace_substring_all (" ", "_")
					l_name := mutable_name
				end
			end
			l_buffer.put_string ("eif_builtin_")
				-- Append class name.
			l_buffer.put_string (l_class.name)
			l_buffer.put_character ('_')
			l_buffer.put_string (l_name)

				-- Append original signature.
			if attached declared_feature then
					-- The signature is delimited with 2 consequent underscores.
					-- One is generated here and another one is added when generating target/arguments/result.
				l_buffer.put_character ('_')
				if not is_static and then target_type.is_expanded and then attached target_type.type.generics then
						-- Append target type name.
					l_buffer.put_character ('_')
					append_type_name (target_type.type, target_type, l_buffer)
				end
					-- Append argument type names.
				if attached declared_feature.arguments as ts then
					across
						ts as t
					loop
						l_buffer.put_character ('_')
						append_type_name (t.item, target_type, l_buffer)
					end
				end
					-- Append result type name.
					-- If there is no result type, there is still a trailing underscore.
				l_buffer.put_character ('_')
				if attached declared_feature.type as t and then not t.is_void then
					append_type_name (t, target_type, l_buffer)
				end
			end

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

			shared_include_queue_put ({PREDEFINED_NAMES}.eif_built_in_header_name_id)
		end

feature {SPECIAL_FEATURES} -- Generation: signature

	append_type_name (t: TYPE_A; target_type: CLASS_TYPE; buffer: GENERATION_BUFFER)
			-- Append type name of type `t` declared in class `c` to buffer `buffer`.
			-- The appended name uses only valid identifier characters.
		require
			t.is_valid_context_type (target_type.type)
		local
			conformance_type: TYPE_A
			class_type: CL_TYPE_A
			name: READABLE_STRING_8
		do
			conformance_type := t.conformance_type
				-- Ignore formal generic types.
			if conformance_type.has_associated_class_type (target_type.type) then
				class_type := conformance_type.associated_class_type (target_type.type).type
				name := class_type.base_class.name
				buffer.put_string (if attached class_name_abbreviation [name] as n then n else name end)
				if class_type.is_basic and then attached class_type.generics as gs and then not gs.is_empty and then not class_type.is_tuple then
					across
						gs as g
					loop
						buffer.put_character ('_')
						append_type_name (g.item, target_type, buffer)
					end
				end
			end
		ensure
			class
		end

feature {NONE} -- Name translation

	operator_table: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- Mapping between standard operator and their C generated names
		once
			create Result.make_equal (20)
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

	class_name_abbreviation: STRING_TABLE [READABLE_STRING_8]
			-- Abbreviations to be used for know class names.
		once
			create Result.make_equal (10)
			Result.compare_objects
			Result ["ANY"] := "o"
			Result ["ARRAY"] := "a"
			Result ["BOOLEAN"] := "b"
			Result ["CHARACTER_8"] := "c1"
			Result ["CHARACTER_32"] := "c4"
			Result ["EXCEPTION"] := "e"
			Result ["IMMUTABLE_STRING_8"] := "m1"
			Result ["IMMUTABLE_STRING_32"] := "m4"
			Result ["INTEGER_8"] := "i1"
			Result ["INTEGER_16"] := "i2"
			Result ["INTEGER_32"] := "i4"
			Result ["INTEGER_64"] := "i8"
			Result ["NATURAL_8"] := "u1"
			Result ["NATURAL_16"] := "u2"
			Result ["NATURAL_32"] := "u4"
			Result ["NATURAL_64"] := "u8"
			Result ["POINTER"] := "p"
			Result ["REAL_32"] := "r4"
			Result ["REAL_64"] := "r8"
			Result ["SPECIAL"] := "s"
			Result ["STRING_8"] := "s1"
			Result ["STRING_32"] := "s4"
			Result ["TUPLE"] := "u"
			Result ["TYPE"] := "t"
		ensure
			class
			unique_mapping: across Result as t1 all across Result as t2 all t1.item.same_string (t2.item) implies t1.key = t2.key end end
		end

note
	ca_ignore: "CA011", "CA011: too many arguments"
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
