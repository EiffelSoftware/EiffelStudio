note
	description: "Objects that contains an debugging execution parameters"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_EXECUTION_PROFILE

inherit
	DEBUG_OUTPUT

create
	make,
	make_with_uuid

feature {NONE} -- Initialization

	make
			-- Create debugger parameters
		local
			uuidg: UUID_GENERATOR
		do
			create uuidg
			uuid := uuidg.generate_uuid
			make_with_uuid (uuid)
		end

	make_with_uuid (a_uuid: like uuid)
			-- Create debugger profile
		do
			uuid := a_uuid
			create arguments.make_empty
			create working_directory.make_empty
		end

feature -- Properties

	uuid: UUID
			-- unique identifier

	title: detachable STRING_32
			-- Associated title
			--| not required, just for information

	arguments: detachable STRING
			-- Command line arguments

	working_directory: detachable STRING
			-- Working directory for execution

	environment_variables: detachable HASH_TABLE [STRING_32, STRING_32]
			-- Modified environment variables

	parent: detachable like Current
			-- Parent profile
			--| if not Void, Current is based on `parent' parameters

feature {DEBUGGER_EXECUTION_PROFILE, DEBUGGER_EXECUTION_RESOLVED_PROFILE} -- Access

	version: NATURAL_32
			-- Version of the parameters
			-- used to track changes

feature -- Status report

	same_profile_parameters (p: like Current): BOOLEAN
			-- Has `p' same parameters as Current?
		require
			p_attached: p /= Void
		do
			Result := version = p.version
		end

feature -- Duplication

	duplication (is_deep: BOOLEAN): like Current
			-- Duplicated copy of Current
			-- if `is_deep' is False, keep the same UUID
		do
			if is_deep then
				create Result.make
			else
				create Result.make_with_uuid (uuid)
			end

			if attached title as l_title then
				Result.set_title (l_title.twin)
			end
			if attached arguments as args then
				Result.set_arguments (args.twin)
			end
			if attached working_directory as wcpy then
				Result.set_working_directory (wcpy.twin)
			end
			if attached environment_variables as envs and then not envs.is_empty then
				Result.set_environment_variables (envs.deep_twin)
			end
			if attached parent as p then
				Result.set_parent (p)
			end

			if is_deep then
				Result.set_version (0)
			else
				Result.set_version (version)
			end
		end

feature {DEBUGGER_EXECUTION_PROFILE} -- Element change: protected

	set_version (v: like version)
			-- Set `version'
		do
			version := v
		end

	set_uuid (v: like uuid)
			-- Set `uuid'
		require
			attached_v: v /= Void
		do
			uuid := v
		end

feature -- Element change

	incremente_version
			-- Incremente the value of `version'
		do
			if version < {NATURAL_32}.Max_value then
				version := version + 1
			else
				version := 1
			end
		end

	set_title (v: like title)
			-- Set `title'
		do
			title := v
		end

	set_arguments (v: like arguments)
			-- Set `arguments'
		do
			arguments := v
		end

	set_working_directory (v: like working_directory)
			-- Set `working_directory'
		do
			working_directory := v
		end

	set_environment_variables (v: like environment_variables)
			-- Set `environment_variables'
		do
			environment_variables := v
		end

	set_parent (v: like parent)
			-- Set `parent'
		do
			parent := v
		end

feature -- debug output

	debug_output: STRING
		do
			Result := "uuid=" + uuid.out + " version=" + version.out
		end

invariant
	uuid_set: uuid /= Void

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
