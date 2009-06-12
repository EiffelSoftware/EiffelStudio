note
	description	: "All information about the wizard ... This class is inherited in each state "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	BENCH_WIZARD_INFORMATION

inherit
	WIZARD_STATE_DATA

	WIZARD_SHARED

	BENCH_WIZARD_SHARED

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make
			-- Assign default values
		local
			l_dir: DIRECTORY
			l_count: INTEGER
			l_layout: WIZARD_EIFFEL_LAYOUT
		do
			compile_project := True
			freeze_required := False
			ace_location := ""

			project_location := eiffel_layout.user_projects_path
			from
				l_count := 1
				project_name := Default_project_name + "_" + l_count.out
				create l_dir.make (project_path)
			until
				not l_dir.exists or else
				l_count = 100
			loop
				create l_dir.make (project_path)
				if l_dir.exists then
					project_name := default_project_name + "_" + l_count.out
				end
				l_count := l_count + 1
			end
			if project_location @ project_location.count /= Operating_environment.Directory_separator then
				project_location.append_character (Operating_environment.Directory_separator)
			end
			project_location.append (project_name)
		end

feature -- Setting

	set_project_location (a_location: STRING)
			-- Set the project location to `a_location'.
		do
			project_location := a_location
		end

	set_project_name (a_project_name: STRING)
			-- Set the project name to `a_project_name'.
		do
			project_name := a_project_name
		end

	set_compile_project (enable_compilation: BOOLEAN)
			-- Enable or disable the compilation of the project depending on
			-- `enable_compilation'.
		do
			compile_project := enable_compilation
		end

	set_freeze_required (v: BOOLEAN)
			-- Enable or disable the freeze of the project depending on `v'.
		do
			freeze_required := v
		ensure
			freeze_required_set: freeze_required = v
		end

	set_ace_location (an_ace_location: STRING)
			-- Set the location of the ace file to `an_ace_location'.
		do
			ace_location := an_ace_location
		end

feature -- Access

	project_location: STRING
			-- Location of the generated code.

	ace_location: STRING
			-- Location of the ace file.

	project_name: STRING
			-- Name of the project.

	compile_project: BOOLEAN
			-- Should the project be compiled upon generation?

	freeze_required: BOOLEAN
			-- Should we freeze the project if compiled?

feature {NONE} -- Implementation

	project_path: STRING
			-- project path
		do
			create Result.make (project_location.count + project_name.count + 2)
			Result.append (project_location)
			Result.append_character ((create {OPERATING_ENVIRONMENT}.default_create).Directory_separator)
			Result.append (project_name)
		ensure
			non_void_project_path: Result /= Void
		end

	Default_project_name: STRING
			-- Default project name
		deferred
		ensure
			valid_result: Result /= Void and then not Result.is_empty
		end

note
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
end -- class BENCH_WIZARD_INFORMATION
