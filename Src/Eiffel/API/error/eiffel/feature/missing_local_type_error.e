note
	description: "A syntax error for missing local type declaration."

class
	MISSING_LOCAL_TYPE_ERROR

inherit
	FEATURE_ERROR
		redefine
			print_error_message,
			print_single_line_error_message,
			process_issue
		end

	TYPE_A_VISITOR
		redefine
			process_multi_formal_a
		end

	SHARED_LOCALE export {NONE} all end
	SHARED_NAMES_HEAP export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (i: ITERABLE [INTEGER_32]; c: AST_CONTEXT; l: LOCATION_AS)
			-- Initialize an error for local variable names `i' in context `c' at location `l'.
		do
			identifiers := i
			c.init_error (Current)
			set_location (l)
		end

feature -- Access

	identifiers: ITERABLE [INTEGER_32]
			-- Identifiers of local variables without type declaration.

feature -- Properties

	code: STRING = "Syntax Error"
			-- <Precursor>

feature -- Modification

	set_suggested_type (t: TYPE_A)
			-- Associate suggested type `t' used for fix suggestions of the error.
		do
			suggested_type := t
				-- Update the suggested type by removing unnecessary attachment marks.
			t.process (Current)
		end

feature -- Automated correction

	suggested_type: TYPE_A
			-- A type that may be used to fix the error.

feature {COMPILER_ERROR_VISITOR} -- Visitor

	process_issue (v: COMPILER_ERROR_VISITOR)
			-- <Precursor>
		do
			v.process_missing_local_type (Current)
		end

feature {NONE} -- Output

	print_error_message (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			print_error_code (t)
			t.add_new_line
			message.format (t, locale.translation_in_context
					("[
						No type is specified for the local declaration list:
						  {1}
					]",
					"eiffel.error"),
				<<message.list (locals)>>
			)
				-- Make sure any other information about the error comes at a new line.
			t.add_new_line
			t.add_new_line
		end

	print_single_line_error_message (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			message.format (t, locale.translation_in_context ("Missing type in local declaration list: {1}", "eiffel.error"), <<message.list (locals)>>)
		end

feature {NONE} -- Formatting

	locals: like message.listable
			-- Collection of formatters to add local variable names.
		do
			create {ITERABLE_FUNCTION [PROCEDURE[TEXT_FORMATTER], INTEGER_32]} Result.make
				(agent (local_name: INTEGER_32): PROCEDURE[TEXT_FORMATTER]
					do
						Result := agent {TEXT_FORMATTER}.add_local (names_heap.item_32 (local_name))
					end,
				identifiers)
		end

	message: FORMATTED_MESSAGE
			-- A message formatter.
		once
			create Result
		end

feature {TYPE_A} -- Type visitor

	process_boolean_a (a_type: BOOLEAN_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_character_a (a_type: CHARACTER_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_cl_type_a (a_type: CL_TYPE_A)
			-- <Precursor>
		do
			if written_class.lace_class.is_void_unsafe then
					-- Void-unsafe class: leave type as is.
				suggested_type := a_type
			else
					-- Void-safe class: remove attachment marks that are assumed by default.
				if written_class.lace_class.is_attached_by_default then
					if a_type.has_attached_mark then
						suggested_type := a_type.as_attachment_mark_free
					else
						suggested_type := a_type
					end
				else
					if a_type.has_detachable_mark then
						suggested_type := a_type.as_attachment_mark_free
					else
						suggested_type := a_type
					end
				end
			end
		end

	process_formal_a (a_type: FORMAL_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_gen_type_a (a_type: GEN_TYPE_A)
			-- <Precursor>
		local
			new_generics: detachable ARRAYED_LIST [TYPE_A]
			old_generics: ARRAYED_LIST [TYPE_A]
			t: TYPE_A
			i: INTEGER
		do
			process_cl_type_a (a_type)
			t := suggested_type
			from
				old_generics := a_type.generics
				i := old_generics.count
			until
				i <= 0
			loop
				old_generics [i].process (Current)
				if old_generics [i] /= suggested_type then
						-- Update actual generic parameter.
					if not attached new_generics then
							-- Use new class type with new generics.
						if t = a_type then
							t := a_type.duplicate
						end
						new_generics := t.generics
					end
					new_generics [i] := suggested_type
				end
				i := i - 1
			end
			suggested_type := t
		end

	process_integer_a (a_type: INTEGER_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_like_argument (a_type: LIKE_ARGUMENT)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_like_current (a_type: LIKE_CURRENT)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_like_feature (a_type: LIKE_FEATURE)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_local (a_type: LOCAL_TYPE_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_manifest_integer_a (a_type: MANIFEST_INTEGER_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_manifest_natural_64_a (a_type: MANIFEST_NATURAL_64_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_manifest_real_a (a_type: MANIFEST_REAL_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_multi_formal_a (a_type: MULTI_FORMAL_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_named_tuple_type_a (a_type: NAMED_TUPLE_TYPE_A)
			-- <Precursor>
		do
			process_gen_type_a (a_type)
		end

	process_native_array_type_a (a_type: NATIVE_ARRAY_TYPE_A)
			-- <Precursor>
		do
			process_gen_type_a (a_type)
		end

	process_natural_a (a_type: NATURAL_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_none_a (a_type: NONE_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_pointer_a (a_type: POINTER_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_qualified_anchored_type_a (a_type: QUALIFIED_ANCHORED_TYPE_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_real_a (a_type: REAL_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_tuple_type_a (a_type: TUPLE_TYPE_A)
			-- <Precursor>
		do
			process_gen_type_a (a_type)
		end

	process_typed_pointer_a (a_type: TYPED_POINTER_A)
			-- <Precursor>
		do
			process_gen_type_a (a_type)
		end

	process_unevaluated_like_type (a_type: UNEVALUATED_LIKE_TYPE)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_unevaluated_qualified_anchored_type (a_type: UNEVALUATED_QUALIFIED_ANCHORED_TYPE)
			-- <Precursor>
		do
			suggested_type := a_type
		end

	process_void_a (a_type: VOID_A)
			-- <Precursor>
		do
			suggested_type := a_type
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
