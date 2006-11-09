indexing
	description: "[
		Factory used to create projects.
		
		Note: Because of the internals of the Eiffel compiler and the use of onces once a project
		      has been loaded no other load should be attempted.
		      The contracts to enforce this can be removed once this limitation has been fixed
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	PROJECT_FACTORY

inherit
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create {COMPILER}
	make

feature {NONE} -- Initialization

	make (a_loader: like project_loader) is
			-- Initialize a new project factory with an implementation loader `a_loader'
		require
			a_loader_attached: a_loader /= Void
		do
			project_loader := a_loader
		ensure
			project_loader_set: project_loader = a_loader
		end

feature -- Factory

	open_project (a_file_name, a_target, a_path: STRING; a_clean: BOOLEAN): E_PROJECT is
			-- Opens a project
		require
			not_a_file_name_is_empty: a_file_name /= Void implies not a_file_name.is_empty
			not_a_target_is_empty: a_target /= Void implies not a_target.is_empty
			not_a_path_is_empty: a_path /= Void implies not a_path.is_empty
			can_create_project: can_create_project
		local
			l_loader: like project_loader
		do
			l_loader := project_loader
			l_loader.open_project_file (a_file_name, a_target, a_path, a_clean)
			if not l_loader.has_error then
				Result := l_loader.eiffel_project
			end
		ensure
			result_attached: not project_loader.has_error implies Result /= Void
			result_initialized: Result /= Void implies Result.initialized
		end

	convert_project (a_file_name: STRING): E_PROJECT is
			-- Converts an loads project ace, used in 5.6 or before.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			can_create_project: can_create_project
		local
			l_loader: like project_loader
		do
			l_loader := project_loader
			project_loader.convert_project (a_file_name)
			if not l_loader.has_error then
				Result := l_loader.eiffel_project
			end
		ensure
			result_attached: not project_loader.has_error implies Result /= Void
			result_initialized: Result /= Void implies Result.initialized
		end

feature -- Status Report

	can_create_project: BOOLEAN is
			-- Inidicates if a project can be loaded
		do
			Result := not is_single_project_system or else not eiffel_project.initialized
		end

	is_single_project_system: BOOLEAN = True
			-- Indicates if Eiffel only supports loading of a single project in same process
			-- Note: This can be set to False once all onces have been removed.

feature {NONE} -- Implementation

	project_loader: PROJECT_LOADER
			-- Loader used to load projects

invariant
	project_loader_attached: project_loader /= Void

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

end -- class {PROJECT_FACTORY}
