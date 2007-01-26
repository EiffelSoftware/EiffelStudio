indexing
	description: "Names used in debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_NAMES

inherit
	SHARED_LOCALE

feature -- Names

	t_Application_launched: STRING_GENERAL is
			once Result := locale.translate ("Application launched") end
	t_Application_exited: STRING_GENERAL is
			once Result := locale.translate ("Application exited") end
	t_space_Application_ignoring_breakpoints: STRING_GENERAL is
			once Result := locale.translate (" (ignoring breakpoints)") end

	t_Not_running: STRING_GENERAL is
			once Result := locale.translate ("Application is not running") end
	t_Running: STRING_GENERAL is
			once Result := locale.translate ("Application is running") end
	t_Running_no_stop_points: STRING_GENERAL is
			once Result := locale.translate ("Application is running (ignoring breakpoints)") end
	t_Paused: STRING_GENERAL is
			once Result := locale.translate ("Application is paused") end

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
