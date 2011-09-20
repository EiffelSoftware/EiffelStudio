note
	description: "Error for assignment to a stable attribute."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class VBAR2

inherit
	VBAR
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Creation

	make (s: TYPE_A; t: FEATURE_I; l: LOCATION_AS; c: AST_CONTEXT)
			-- Create an error object for source type `s', associated target `t' at location `l' in the context `c'.
		require
			s_attached: attached s
			t_attached: attached t
			l_attached: attached l
			c_attached: attached c
		do
			source_type := s
			target := t.e_feature
			set_location (l)
			c.init_error (Current)
		ensure
			class_c_set: class_c = c.current_class
			source_type_set: source_type = s
			target_set: attached target
			location_set: line = l.line and then column = l.column
			is_defined: is_defined
		end

feature -- Properties

	source_type: TYPE_A
			-- Source type of the assignment.

	target: E_FEATURE
			-- Target of the assignment.

	subcode: INTEGER = 2
			-- Error subcode.

feature -- Output

	build_explain (f: TEXT_FORMATTER)
			-- <Precursor>
		do
			f.add ("Stable attribute: ")
			target.append_name (f)
			f.add_new_line
			f.add ("Source type: ")
			source_type.append_to (f)
			f.add_new_line
		end

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
