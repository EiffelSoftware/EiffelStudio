note
	description: "[
		Manifest array may need an explicit type because the implicit type does not match the type of a reattachment target.
		
		Example:
			x: ARRAY [READABLE_STRING_GENERAL]
			...
			x := <<"abc", "def">> -- Implicit type is ARRAY [STRING] that does not match to ARRAY [READABLE_STRING_GENERAL].
				-- The code has to be written as
			x := {ARRAY [READABLE_STRING_GENERAL]} <<"abc", "def">>
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VWMA_EXPLICIT_TYPE_REQUIRED_FOR_MATCH

inherit
	VWMA_EXPLICIT_TYPE_REQUIRED
		redefine
			print_short_help,
			subcode
		end

create
	make

feature -- Access

	subcode: INTEGER = 1
			-- <Precursor>

feature {COMPILER_ERROR_VISITOR} -- Visitor

	process_issue (v: COMPILER_ERROR_VISITOR)
			-- <Precursor>
		do
			v.process_array_explicit_type_required_for_match (Current)
		end

feature -- Output

	build_explain (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			trace_single_line (t)
			t.add_new_line
			format_elements (t,
				locale.translation_in_context ("Computed type of array elements {1} differs from the type {2} of target array elements.", "compiler.error"),
				<<agent implicit_element_type.append_to, agent target_element_type.append_to>>)
			t.add_new_line
		end

	print_short_help (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add_new_line
			format_elements (t, locale.translation_in_context ("[
					Error: An implicit type of the manifest array used as a source of a reattachment differs from the type of the reattachment target.
					What to do:
						- add an explicit manifest array type;
						- change target type to make sure the types are the same;
						- (recommended) change options to always compute a manifest array type without checking it against a target type (In project settings, set "Advanced | Language | Manifest array type" to "Standard").
				]", "compiler.error"),
				<<agent target_array_type.append_to>>)
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context ("Explicit array type {1} may need to be specified.", "compiler.error"), <<agent target_array_type.append_to>>)
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
