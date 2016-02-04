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
			p: PATH
		do
			compile_project := True
			freeze_required := False
			create ace_location.make_empty
			p := eiffel_layout.user_projects_path

			from
				l_count := 1
				project_name := Default_project_name + "_" + l_count.out
				create l_dir.make_with_path (p.extended (project_name))
			until
				not l_dir.exists or else
				l_count = 100
			loop
				create l_dir.make_with_path (p.extended (project_name))
				if l_dir.exists then
					project_name := default_project_name + "_" + l_count.out
				end
				l_count := l_count + 1
			end
			project_location := p.extended (project_name)
			is_scoop_supported := project_generator.is_scoop_supported
			is_scoop := is_scoop_supported
		end

feature -- Setting

	set_project_location (a_location: like project_location)
			-- Set the project location to `a_location'.
		do
			project_location := a_location
		end

	set_project_name (a_project_name: like project_name)
			-- Set the project name to `a_project_name'.
		do
			project_name := a_project_name
		end

	set_is_scoop (value: BOOLEAN)
			-- Set `is_scoop' to `value'.
		do
			is_scoop := value
		ensure
			is_scoop_set: is_scoop = value
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

	set_ace_location (an_ace_location: like ace_location)
			-- Set the location of the ace file to `an_ace_location'.
		do
			ace_location := an_ace_location
		end

feature -- Access

	project_location: PATH
			-- Location of the generated code.

	ace_location: PATH
			-- Location of the ace file.

	project_name: STRING_32
			-- Name of the project.

	is_scoop_supported: BOOLEAN
			-- Can project be compiled in SCOOP mode?
			--| This attribute can be replaced with a function,
			--| but then a check whether there is a SCOOP-specific file
			--| will be performed whenever this function is accessed.

	is_scoop: BOOLEAN
			-- Is project compiled in SCOOP mode?

	compile_project: BOOLEAN
			-- Should the project be compiled upon generation?

	freeze_required: BOOLEAN
			-- Should we freeze the project if compiled?

feature {NONE} -- Implementation

	Default_project_name: STRING
			-- Default project name
		deferred
		ensure
			valid_result: Result /= Void and then not Result.is_empty
		end

	project_generator: BENCH_WIZARD_PROJECT_GENERATOR
			-- A project generator used to set initial values of the information.
		deferred
		ensure
			attached_result: attached Result
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
