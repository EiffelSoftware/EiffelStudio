indexing
	description: "Utilities for metrics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_UTILITY

inherit
	QL_SHARED_UNIT

feature -- Access

	internal_name (a_name: STRING): STRING is
			-- Internal name for `a_name'.
		do
			if a_name /= Void then
				Result := a_name.twin
				Result.left_adjust
				Result.right_adjust
				if Result.is_empty then
					Result := Void
				else
					Result.to_lower
				end
			end
		end

feature -- Status report

	is_name_valid (a_name: STRING): BOOLEAN is
			-- Is `a_name' valid?
		require
			a_name_attached: a_name /= Void
		do
			Result := not internal_name (a_name).is_empty
		end

	is_unit_valid (a_unit: STRING): BOOLEAN is
			-- Is `a_unit' valid?
			-- `a_unit' should be left and right trimmed and should be in lowercase.
		require
			a_unit_attached: a_unit /= Void
			not_a_unit_is_empty: not a_unit.is_empty
		do
			Result := unit_table.has (a_unit)
		end

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
