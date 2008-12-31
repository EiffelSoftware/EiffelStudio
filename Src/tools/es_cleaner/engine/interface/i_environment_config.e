note
	description: "[
		Interface for the EiffelStudio related user configuration settings, used to extract information from a UI or data store about a project to clean, backup or restore.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	I_ENVIRONMENT_CONFIG

inherit
	ANY
		undefine
			default_create,
			copy,
			is_equal
		end

feature -- Status report

	can_any_processing_occur: BOOLEAN
			-- Indiciates if any processing can occur
		do
			Result := process_environement_preferences or
				process_environement_editing_layout or
				process_environement_debug_layout
		end

	process_environement_preferences: BOOLEAN
			-- Indiciates if the environment preferences should be processed
		deferred
		end

	process_environement_editing_layout: BOOLEAN
			-- Indiciates if the environment editing layout should be processed
		deferred
		end

	process_environement_debug_layout: BOOLEAN
			-- Indiciates if the environment debug layout should be processed
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
