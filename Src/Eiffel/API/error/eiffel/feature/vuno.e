note
	description: "[
			Error for a non-object call.
		
			The specific reason of the error is detailed in descendants.
		]"

deferred class VUNO

inherit

	FEATURE_ERROR
		undefine
			print_short_help,
			trace_single_line
		end

feature {NONE} -- Creation

	make (f: FEATURE_I; c: CLASS_C; w: detachable CLASS_C; l: LOCATION_AS)
			-- Create an error for a non-object call in feature `f` of class `c` in the code from class `w` at location `l`.
		require
			f_attached: attached f
			c_attached: attached c
			l_attached: attached l
		do
			class_c := c
			written_class := if attached w then w else f.written_class end
			set_feature (f)
			set_location (l)
		ensure
			class_c_set: class_c = c
			written_class_set: attached written_class and (attached w implies written_class = w)
			e_feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

feature -- Properties

	code: STRING = "VUNO"
			-- <Precursor>

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
