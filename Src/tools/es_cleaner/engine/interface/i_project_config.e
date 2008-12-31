note
	description: "[
		Interface for project related user configuration settings, used to extract information from a UI or data store about a project to clean, backup or restore.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	I_PROJECT_CONFIG

inherit
	ANY
		undefine
			default_create,
			copy,
			is_equal
		end

feature -- Access

	project_location: STRING
			-- Location of the Eiffel project to clean.
		require
			process_project: process_project
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_location_exists: (create {RAW_FILE}.make (Result)).exists
		end

feature -- Status report

	can_any_processing_occur: BOOLEAN
			-- Indiciates if any processing can occur
		do
			Result := process_project and then
				(process_project_preferences or
				process_project_layout or
				process_project_session)
		end

	process_project: BOOLEAN
			-- Indiciates if an Eiffel project should be processed
		deferred
		end

	process_project_preferences: BOOLEAN
			-- Indiciates if the project preferences should be processed
		require
			process_project: process_project
		deferred
		end

	process_project_layout: BOOLEAN
			-- Indiciates if the project layout should be processed
		require
			process_project: process_project
		deferred
		end

	process_project_session: BOOLEAN
			-- Indiciates if the project session should be processed
		require
			process_project: process_project
		deferred
		end

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
