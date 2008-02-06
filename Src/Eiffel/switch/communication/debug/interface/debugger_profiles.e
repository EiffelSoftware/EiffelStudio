indexing
	description: "Object keeping the execution profiles' data..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_PROFILES

inherit
	DS_HASH_TABLE [DEBUGGER_EXECUTION_PARAMETERS, STRING_32]

	SESSION_DATA_I
		undefine
			is_equal, copy
		end

create
	make_equal

feature -- Access

	last_profile_name: STRING_32
			-- Last profile's name

	last_profile: TUPLE [name: like last_profile_name; params: DEBUGGER_EXECUTION_PARAMETERS] is
			-- Last profile details
		do
			if
				last_profile_name /= Void and then
				has (last_profile_name)
			then
				Result := [last_profile_name, item (last_profile_name)]
			end
		end

feature -- Change

	set_last_profile (v: like last_profile) is
			-- Set `last_profile_name' to `v'
		do
			if v = Void then
				last_profile_name := Void
			else
				last_profile_name := v.name
				if has (last_profile_name) then
					replace (v.params, last_profile_name)
				else
					force_last (v.params, last_profile_name)
				end
			end
		end

;indexing
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
