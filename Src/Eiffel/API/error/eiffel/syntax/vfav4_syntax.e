note
	description: "VFAV(4) error detected at parse time."

class VFAV4_SYNTAX

inherit
	VFAV_SYNTAX
		rename
			make as make_general
		end

create
	make

feature -- Access

	subcode: INTEGER = 4
			-- Error subcode

feature {NONE} -- Creation

	make (f: ID_AS; a1, a2: STRING_AS)
			-- Create error object for feature of name `f` with conflicting alias names `a1` and `a2`.
		require
			f_attached: attached f
			a1_attached: attached a1
			a2_attached: attached a2
		do
			set_class (system.current_class)
			set_feature_name (f.name_32)
			set_location (a2)
		ensure
			class_c_set: class_c /= Void
			feature_name_set: feature_name.same_string (f.name_32)
			location_set: line = a2.line and column = a2.column
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
