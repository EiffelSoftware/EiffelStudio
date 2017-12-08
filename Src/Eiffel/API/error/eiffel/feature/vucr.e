note
	description: "[
			Error for a declaration of an instance-free feature.
		
			The specific reason of the error is detailed in descendants.
		]"

deferred class VUCR

inherit

	FEATURE_ERROR
		undefine
			print_short_help,
			trace_single_line
		end

	INTERNAL_COMPILER_STRING_EXPORTER
	SHARED_NAMES_HEAP

feature {NONE} -- Creation

	make (f: FEATURE_I; c: CLASS_C; l: LOCATION_AS)
			-- Create an error for a feature `f` in class `c`.
		require
			f_attached: attached f
			c_attached: attached c
			l_attached: attached l
		do
			class_c := c
			set_feature (f)
			set_location (l)
		ensure
			class_c_set: class_c = c
			e_feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

feature -- Properties

	code: STRING = "VUCR"
			-- <Precursor>

note
	date: "$Date$";
	revision: "$Revision $"
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
