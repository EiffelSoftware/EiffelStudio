note
	description: "Manifest type qualifier error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VWMQ

inherit

	FEATURE_ERROR
		redefine
			build_explain,
			print_single_line_error_message
		end

create
	make

feature {NONE} -- Creation

	make (t: TYPE_A; e: ARRAY [detachable TYPE_A]; c: AST_CONTEXT; l: LOCATION_AS)
			-- Create error that a type qualifier `t' is not expected for a manifest constant
			-- at location `l' in context `c' with a list `e' of expected type qualifiers.
		require
			t_attached: attached t
			e_attached: attached e
			c_attached: attached c
			l_attached: attached l
		do
			type := t
			expected_types := e
			c.init_error (Current)
			set_location (l)
		ensure
			type_set: type = t
			expected_types_set: expected_types = e
		end

feature -- Error properties

	code: STRING = "VWMQ"
			-- <Precursor>

feature {NONE} -- Context

	type: TYPE_A
			-- Actual type qualifier.

	expected_types: ARRAY [detachable TYPE_A]
			-- Expected type qualifiers.

feature -- Output

	build_explain (f: TEXT_FORMATTER)
			-- <Precursor>
		local
			comma: STRING
		do
			Precursor (f)
			f.add ("Type: ")
			type.append_to (f)
			f.add_new_line
			f.add ("Expected types: ")
				-- Comma before type name is not required for the first type.
			comma := ""
			across expected_types as c
				loop
					if attached c.item as t then
						f.add (comma)
						t.append_to (f)
							-- Subsequent type names should be delimited with comma.
						comma := once ", "
					end
				end
			f.add_new_line
		end

feature {NONE} -- Output

	print_single_line_error_message (f: TEXT_FORMATTER)
			-- <Precursor>
		do
			Precursor (f)
				-- Listing expected types is too much for a single line,
				-- so only the actual type is reported.
			f.add_space
			type.append_to (f)
		end

invariant

		type_attached: attached type
		expected_types_attached: attached expected_types

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
