note
	description: "Node for type intervals."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TYPE_INTERVAL_AS

inherit
	TYPE_AS
		redefine
			first_token, last_token
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (l, u: TYPE_AS)
			-- Create a new TYPE_INTERVAL_AS node.
		require
			l_not_void: l /= Void
			u_not_void: u /= Void
		do
			lower := l
			upper := u
		ensure
			lower_set: lower = l
			upper_set: upper = u
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_type_interval_as (Current)
		end

feature -- Properties

	lower: TYPE_AS
			-- Lower bound of type interval.

	upper: TYPE_AS
			-- Upper bound of type interval.

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := lower.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := upper.last_token (a_list)
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := lower.index
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (lower, other.lower) and equivalent (upper, other.upper)
		end

feature -- Output

	dump: STRING
		local
			l_lower_dump, l_upper_dump: STRING
		do
			l_lower_dump := lower.dump
			l_upper_dump := upper.dump
			create Result.make (l_lower_dump.count + 4 + l_upper_dump.count)
			Result.append (l_lower_dump)
			Result.append (" .. ")
			Result.append (l_upper_dump)
		end

note
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

