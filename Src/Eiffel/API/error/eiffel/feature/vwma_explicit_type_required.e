note
	description: "[
		Manifest array has to be specified with an explicit type.
		
		Example:
			x: ARRAY [NATURAL_8]
			...
			x := <<2, 3>> -- Implicit type is ARRAY [INTEGER] that does not conform to ARRAY [NATURAL_8].
				-- The code has to be written as
			x := {ARRAY [NATURAL_8]} <<2, 3>>
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VWMA_EXPLICIT_TYPE_REQUIRED

inherit
	VWMA
		rename
			make as make_parent
		redefine
			build_explain,
			error_string,
			process_issue
		end

	COMPILER_WARNING
		undefine
			has_associated_file,
			trace,
			trace_primary_context
		redefine
			error_string,
			process_issue,
			trace_single_line
		end

	SHARED_WORKBENCH

create
	make

feature {NONE} -- Creation

	make (c: AST_CONTEXT; i, t: TYPE_A; a: ARRAY_AS; e: BOOLEAN)
			-- Initialize error object for implicit element type `i` and target element type `t`
			-- of a manifest array `a` in the context `c` with the error indicator `e`.
			--
			-- `e`: `True` - Error, `False` - Warning.
		require
			c_attached: attached c
			i_attached: attached i
			t_attached: attached t
			a_attached: attached a
		do
			implicit_element_type := i
			target_element_type := t
			is_error := e
			array := a
			make_parent (c, a.first_token (system.match_list_server.item (c.written_class.class_id)))
		ensure
			implicit_element_type_set: implicit_element_type = i
			target_element_type_set: target_element_type = t
			is_error_set: is_error = e
			array_set: array = a
		end

feature -- Access

	error_string: STRING
			-- <Precursor>
		do
			Result := if is_error then Precursor {VWMA} else Precursor {COMPILER_WARNING} end
		end

feature {COMPILER_ERROR_VISITOR} -- Visitor

	process_issue (v: COMPILER_ERROR_VISITOR)
			-- <Precursor>
		do
			v.process_array_explicit_type_required (Current)
		end

feature {FIX_FEATURE} -- Access

	target_array_type: GEN_TYPE_A
			-- Type of a target.
		do
			create Result.make (system.array_id, create {like {GEN_TYPE_A}.generics}.make_from_array (<<target_element_type>>))
		end

	array: ARRAY_AS
			-- Manifest array AST node.

feature {NONE} -- Access

	implicit_element_type: TYPE_A
			-- Implicit element type.

	target_element_type: TYPE_A
			-- Type of a target element.

	is_error: BOOLEAN
			-- Does current represent an error?

feature -- Output

	build_explain (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			trace_single_line (t)
			t.add_new_line
			format_elements (t, locale.translation_in_context ("Computed type of array elements {1} does not conform to the type {2} of target array elements.", "compiler.error"),
				<<agent implicit_element_type.append_to, agent target_element_type.append_to>>)
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context ("Explicit array type {1} has to be specified.", "compiler.error"), <<agent target_array_type.append_to>>)
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
