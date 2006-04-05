indexing
	description : "Shared access to executing CLR version"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	SHARED_CLR_VERSION

feature -- Access

	clr_version: STRING is
			-- Executing version of CLR, for use with consumer folder.
		local
			l_ver: VERSION
		once	
			l_ver := {ENVIRONMENT}.version
			create Result.make (10)
			Result.append_character ('v')
			Result.append_integer (l_ver.major)
			Result.append_character ('.')
			Result.append_integer (l_ver.minor)
			Result.append_character ('.')
			Result.append_integer (l_ver.build)
		ensure
			result_not_void: Result /= Void
			not_reuslt_is_empty: not Result.is_empty
			result_has_initial_v: Result.item (1) = 'v' -- This holds true for al f/w to date
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


end -- class SHARED_CLR_VERSION
