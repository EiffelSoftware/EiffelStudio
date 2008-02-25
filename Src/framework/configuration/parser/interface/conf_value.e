indexing
	description: "Value of a configuration option."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class CONF_VALUE

feature -- Status

	is_set: BOOLEAN
			-- Is option value set?

feature -- Modification

	unset
			-- Ensure no option value is set.
		do
			is_set := False
		ensure
			not_is_set: not is_set
		end

	set_safely (other: like Current)
			-- Set option value from `other' if it is not set yet.
		require
			other_attached: other /= Void
		do
			if not is_set and then other.is_set then
				copy (other)
			end
		ensure
			old_value: (old is_set or else not other.is_set) implies is_equal (old twin)
			new_value: (not old is_set and then other.is_set) implies is_equal (other)
		end

indexing
	copyright:	"Copyright (c) 2008, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
