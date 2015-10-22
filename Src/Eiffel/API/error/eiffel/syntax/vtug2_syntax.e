note
	description: "VTUG(2) error reported at parse time."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class VTUG2_SYNTAX

inherit
	EIFFEL_ERROR
		redefine
			subcode,
			trace
		end

create
	make

feature {NONE} -- Creation

	make (t: like type; c: CLASS_C; l: LOCATION_AS)
			-- Create error object for invalid type `t' in a class `c' at location `l'.
		require
			t_attached: attached t
			c_attached: attached c
			l_attached: attached l
		do
			set_class (c)
			type := t
			set_location (l)
		ensure
			class_c_set: class_c = c
			type_set: type = t
			location_set: line = l.line and column = l.column
		end

feature -- Access

	code: STRING = "VTUG"
			-- <Precursor>

	subcode: INTEGER = 2
			-- <Precursor>

	type: CL_TYPE_A
			-- Erroneous type.

feature -- Output

	trace (a_text_formatter: TEXT_FORMATTER)
			-- Display full error message in `a_text_formatter'.
		do
			print_error_message (a_text_formatter)
			a_text_formatter.add ("Class: ")
			class_c.append_signature (a_text_formatter, False)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Type: ")
			type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
			build_explain (a_text_formatter)
			if line > 0 then
				print_context_of_error (class_c, a_text_formatter)
			end
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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

