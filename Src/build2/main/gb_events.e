indexing
	description: "[
		Objects that represent events fired by EiffelBuild. If you are using EiffelBuild in
		client mode, you will need to respond to these events in order to update
		your interface accordingly.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EVENTS

create
	make_with_components

feature -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Initialize all action sequences and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			create open_project_start_actions
			create open_project_finish_actions
			create close_project_start_actions
			create close_project_finish_actions
			create new_project_actions
			create project_dirtied_actions
			create project_cleaned_actions
			create import_project_start_actions
			create import_project_finish_actions
		ensure
			components_set: components = a_components
		end

feature -- Access

	open_project_start_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed when the opening of a project is started.

	open_project_finish_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed after an existing project has been successfully opened.

	close_project_start_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed when the closing of a project is started.

	close_project_finish_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed when the closing of a project is finished.

	new_project_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed after a new project has been created.

	project_dirtied_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed after a change has "dirtied" the project.
		-- which means there is now a change to be saved.

	project_cleaned_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed after the project has been "cleaned", that
		-- is updated so that there are no changes to be saved.

	import_project_start_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed when an import of a project is started.

	import_project_finish_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed when an import of a project is finished.

invariant
	invariant_clause: True -- Your invariant here

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


end
