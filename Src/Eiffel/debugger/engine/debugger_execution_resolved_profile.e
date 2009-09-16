note
	description: "Objects that contains an debugging execution parameters"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_EXECUTION_RESOLVED_PROFILE

create
	make_from_profile

feature {NONE} -- Initialization

	make_from_profile (a_profile: DEBUGGER_EXECUTION_PROFILE)
			-- Create debugger parameters
		require
			a_profile_attached: a_profile /= Void
		local
			p: detachable DEBUGGER_EXECUTION_PROFILE
		do
			uuid := a_profile.uuid
			version := a_profile.version
			title := a_profile.title

			p := a_profile.parent
			if p /= Void then
				parent_uuid := p.uuid
				parent_version := p.version
			end

				--| Arguments
			if attached a_profile.arguments as args then
				arguments := args
			else
				if p /= Void and then attached p.arguments as p_args then
					arguments := p_args
				else
					create arguments.make_empty
				end
			end

				--| Working copy
			if attached a_profile.working_directory as cwd then
				working_directory := cwd
			else
				if p /= Void and then attached p.working_directory as p_cwd then
					working_directory := p_cwd
				else
					create working_directory.make_empty
				end
			end

				--| Environment_variables
			if attached environment_variables as envs and then not envs.is_empty then
				environment_variables := envs.deep_twin
			end

			resolve
		end

	resolve
			-- Resolve parameters
		local
			envi: ENV_INTERP
			shared_eiffel: SHARED_EIFFEL_PROJECT
			wd: like working_directory
			l_dir: DIRECTORY
			l_dir_sep: CHARACTER
		do
				--| Resolution
			create envi
			create shared_eiffel

				--| Argument
			if not arguments.is_empty then
				arguments := envi.interpreted_string (arguments)
			end

				--| Working_directory
			if
				working_directory.is_empty
			then
				wd := shared_eiffel.Eiffel_project.lace.directory_name
			else
				wd := envi.interpreted_string (working_directory)
			end
			wd := wd.twin; wd.left_adjust; wd.right_adjust
			if wd.count > 1 then
					-- Check if directory exists? If it does not, it might be because of
					-- an extra directory separator at the end of the name which could cause
					-- some problem. Therefore we remove it.
					-- We only do it if there is at least one character in the directory name,
					-- otherwise it does not make sense.
				create l_dir.make (wd)
				l_dir_sep := (create {OPERATING_ENVIRONMENT}).directory_separator
				if not l_dir.exists and then wd.item (wd.count) = l_dir_sep then
					wd.remove_tail (1)
					create l_dir.make (wd)
					if not l_dir.exists then
							-- Revert back to the original string.
						wd.extend (l_dir_sep)
					end
				end
			end
			working_directory := wd
		end

feature -- Properties

	uuid: UUID
			-- Unique identifier

	title: detachable STRING
			-- Optional title

	arguments: STRING
			-- Command line arguments (not Void)

	working_directory: STRING
			-- Working directory for execution (not Void)

	environment_variables: detachable HASH_TABLE [STRING_32, STRING_32]
			-- Modified environment variables

	parent_uuid: like uuid
			-- Unique identifier of parent

	parent_version: like version

	version: NATURAL_32
			-- Version of the parameters
			-- used to track changes

feature -- Status report

	same_profile_parameters (p: DEBUGGER_EXECUTION_PROFILE): BOOLEAN
			-- Has `p' same parameters as Current?
		require
			p_attached: p /= Void
		do
			Result := uuid ~ p.uuid and then version = p.version
			if Result and parent_uuid /= Void then
				Result := attached p.parent as par and then parent_uuid ~ par.uuid and then parent_version = par.version
			end
		end

feature -- Element change

	set_arguments (v: like arguments)
			-- Set `arguments'
		require
			v_attached: v /= Void
		do
			arguments := v
		end

	set_working_directory (v: like working_directory)
			-- Set `working_directory'
		require
			v_attached: v /= Void
		do
			working_directory := v
		end

	set_environment_variables (v: like environment_variables)
			-- Set `environment_variables'
		require
			v_attached: v /= Void
		do
			environment_variables := v
		end

invariant
	uuid_set: uuid /= Void
	arguments_attached: arguments /= Void
	working_directory_attached: working_directory /= Void
	parent_set_if_not_void: parent_uuid /= Void implies parent_version > 0

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
