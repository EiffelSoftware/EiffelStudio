note

	description: "[
			Error for invalid parent type: different generic derivations
			of the same class are used in Parent parts.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VHPR5_ECMA

inherit

	EIFFEL_ERROR
		redefine
			print_error_message,
			print_single_line_error_message,
			subcode
		end

create

	make

feature {NONE} -- Creation

	make (c: CLASS_C; t1: CL_TYPE_A; w1: CLASS_C; t2: CL_TYPE_A; w2: CLASS_C; l: detachable LOCATION_AS)
			-- Initialize an error for class `c` at location `l' with offending
			-- parent types `t1` and `t2` derived in `w1` and `w2` respectively.
		require
			c_attached: attached c
			t1_attached: attached t1
			w1_attached: attached w1
			t2_attached: attached t2
			w2_attached: attached w2
		do
			set_class (c)
			parent_type_1 := t1
			derived_in_1 := w1
			parent_type_2 := t2
			derived_in_2 := w2
			if attached l then
				set_location (l)
			end
		ensure
			class_c_set: class_c = c
			parent_type_1_set: parent_type_1 = t1
			parent_type_2_set: parent_type_2 = t2
			derived_in_1_set: derived_in_1 = w1
			derived_in_2_set: derived_in_2 = w2
			line_set: attached l implies line = l.line
			column_set: attached l implies column = l.column
		end

feature -- Error code

	code: STRING = "ECMA-VHPR"
			-- Error code

	subcode: INTEGER = 5
			-- Error subcode

feature {NONE} -- Output

	print_error_message (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			print_error_code (t)
			t.add_new_line
			format (t, locale.translation_in_context
					("[
						The class inherits two different generic derivations of the same class:
							{1} (derived in class {2})
							{3} (derived in class {4})
						 
						What to do: ensure the derivations are identical or remove offending inheritance links.
					]",
					"eiffel.error"),
				<<element (agent parent_type_1.append_to),
				element (agent derived_in_1.append_name),
				element (agent parent_type_2.append_to),
				element (agent derived_in_2.append_name)>>
			)
				-- Make sure any other information about the error comes at a new line.
			t.add_new_line
			t.add_new_line
		end

	print_single_line_error_message (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format (t,
				locale.translation_in_context ("Different generic derivations of {1} are ancestors of the same class.", "eiffel.error"),
				<<element (agent (parent_type_1.base_class).append_name)>>)
		end

feature {NONE} -- Data

	parent_type_1: CL_TYPE_A
			-- Parent type involved in the error

	parent_type_2: CL_TYPE_A
			-- Parent type involved in the error

	derived_in_1: CLASS_C
			-- A class where `parent_type_1` is derived.

	derived_in_2: CLASS_C
			-- A class where `parent_type_2` is derived.

;note
	ca_ignore: "CA011", "CA011 — too many arguments"
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
