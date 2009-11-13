note

	description: "All_body or Some_body expression is not of type BOOLEAN."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VWBE5

inherit

	VWBE
		redefine
			code,
			subcode
		end

create

	make

feature {NONE} -- Creation

	make (t: like type; a: BOOLEAN; l: LOCATION_AS; c: AST_CONTEXT)
			-- Create error object for the type `t' at location `l' in context `c'
			-- used in All_body (`a = True') or Some_body (`a = False').
		require
			t_attached: t /= Void
			l_attached: l /= Void
			c_attached: c /= Void
		do
			set_type (t)
			is_all := a
			set_location (l)
			c.init_error (Current)
		ensure
			type_set: type = t
			is_all_set: is_all = a
		end

feature {NONE} -- Access

	is_all: BOOLEAN
			-- Is error being reported for All_body rather than Some_body?

feature -- Error description

	code: STRING = "ECMA-VWBE"
			-- <Precursor>

	subcode: INTEGER = 2
			-- <Precursor>

feature -- Properties

	where: STRING
			-- <Precursor>
		do
			if is_all then
				Result := "In All_body of a loop expression"
			else
				Result := "In Some_body of a loop expression"
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
