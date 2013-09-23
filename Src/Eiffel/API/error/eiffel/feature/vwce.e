note
	description: "Error for conditional expression."

class VWCE

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Creation

	make (t, e: TYPE_A; l: LOCATION_AS; c: AST_CONTEXT)
			-- Create an error object for conditional expression with type `t' in Then_part and type `e' in Else(if)_part at location `l' in the context `c'.
		require
			s_attached: attached t
			t_attached: attached e
			l_attached: attached l
			c_attached: attached c
		do
			then_type := t
			else_type := e
			set_location (l)
			c.init_error (Current)
		ensure
			class_c_set: class_c = c.current_class
			written_class_set: written_class = c.written_class
			feature_set: attached c.current_feature implies attached e_feature
			then_type_set: then_type = t
			else_type_set: else_type = e
			location_set: line = l.line and then column = l.column
			is_defined: is_defined
		end

feature -- Properties

	code: STRING = "VWCE"
			-- Error code

feature -- Properties

	then_type: TYPE_A
			-- Type in Then_part.

	else_type: TYPE_A
			-- Type in Else_part or Elseif_part.

feature -- Output

	build_explain (f: TEXT_FORMATTER)
			-- <Precursor>
		do
			f.add ("Type in Then_part: ")
			then_type.append_to (f)
			f.add_new_line
			f.add ("Type in Else(if)_part: ")
			else_type.append_to (f)
			f.add_new_line
		end

note
	date: "$Date$";
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
