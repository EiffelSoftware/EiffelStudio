indexing
	description: "Objects that represent a tab for the project settings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_SYSTEM_TAB

inherit

	EV_VERTICAL_BOX
		undefine
			is_in_default_state,
			initialize
		end
		
	GB_DEFAULT_STATE
	
	GB_SHARED_SYSTEM_STATUS
		undefine
			default_create, copy, is_equal
		end
		
	GB_WIDGET_UTILITIES
		undefine
			default_create, copy, is_equal
		end
		
feature -- Basic operation.

	update_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Update all attributes of `Current' to reflect information
			-- in `project_settings'.
		require
			project_settings_not_void: project_settings /= Void
		deferred
		end
		
	save_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Save all attributes of `Current' into `project_settings'.
		require
			project_settings_not_void: project_settings /= Void
		deferred
		end
		
	validate is
			-- Check all fields for valid input.
		require
			parented: parent /= Void
		deferred
		end
		
	validate_successful: BOOLEAN
		-- Was the last call to `validate' succesful?
		
feature {NONE} -- Implementation

	select_in_parent is
			-- Ensure `Current' is the visible
			-- tab in `parent'.
		local
			notebook_parent: EV_NOTEBOOK
		do
			notebook_parent ?= parent
			check
				parent_is_a_notebook: notebook_parent /= Void
			end
			notebook_parent.select_item (Current)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_SYSTEM_TAB
