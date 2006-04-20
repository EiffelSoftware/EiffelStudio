indexing
	description	: "Shared instance of Application execution."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date		: "$Date$";
	revision	: "$Revision $"

class SHARED_APPLICATION_EXECUTION

feature -- Access

	Application_initialized: BOOLEAN is
		do
			Result := cell_Application_initialized.item
		end

	Application: APPLICATION_EXECUTION is
		once
			create Result.make
		end

feature {DEBUGGER_MANAGER} -- Build

	build_shared_application_execution (dbg_manager: DEBUGGER_MANAGER) is
		require
			not Application_initialized
		do
			check application.debugger_manager = Void end
			Application.set_debugger_manager (dbg_manager)
			cell_Application_initialized.put (True)
		ensure
			Application_initialized
		end

feature {NONE} -- Impl

	cell_Application_initialized: CELL [BOOLEAN] is
		once
			create Result.put (False)
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

end -- class SHARED_APPLICATION_EXECUTION
