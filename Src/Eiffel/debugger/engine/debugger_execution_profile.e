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
			make_with_uuid (uuidg.generate_uuid)
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

	group: detachable STRING_32
			-- Associated group

	title: detachable STRING_32
			-- Associated title
			--| not required, just for information

	arguments: STRING_32
			-- Command line arguments

	working_directory: detachable PATH
			-- Working directory for execution

	environment_variables: detachable HASH_TABLE [STRING_32, STRING_32]
			-- Modified environment variables

	parent: detachable like Current
			-- Parent profile
			--| if not Void, Current is based on `parent' parameters

feature -- Query

	title_suggestion: detachable STRING_32
			-- Title suggestion based on Current parameters.
		local
			args: like arguments
		do
			args := arguments
			if not args.is_whitespace then
				create Result.make_from_string (args)
			end
		end

feature {DEBUGGER_EXECUTION_PROFILE, DEBUGGER_EXECUTION_RESOLVED_PROFILE} -- Access

	version: NATURAL_32
			-- Version of the parameters
			-- used to track changes

feature -- Status report

	same_uuid_as (p: like Current): BOOLEAN
			-- Has `p' same parameters as Current?
		require
			p_attached: p /= Void
		do
			Result := uuid.out.same_string (p.uuid.out)
		end

	same_as (p: like Current): BOOLEAN
			-- Has `p' same parameters as Current?
		require
			p_attached: p /= Void
		do
			Result := same_uuid_as (p) and then version = p.version
		end

	is_in_group (grp: READABLE_STRING_GENERAL): BOOLEAN
			-- Is Current profile inside group `grp`?
		do
			Result := attached group as g and then grp.same_string (g)
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
			if attached group as grp then
				Result.set_group (grp.twin)
			end
			if attached title as l_title then
				Result.set_title (l_title.twin)
			end
			Result.set_arguments (arguments.twin)
			Result.set_working_directory (working_directory)
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

	increment_version
			-- Increment the value of `version'
		do
			if version < {NATURAL_32}.Max_value then
				version := version + 1
			else
				version := 1
			end
		end

	set_group (v: detachable READABLE_STRING_GENERAL)
			-- Set `group'
		do
			if v = Void then
				group := Void
			else
				group := v.to_string_32
			end
		end

	set_title (v: detachable READABLE_STRING_GENERAL)
			-- Set `title'
		do
			if v = Void then
				title := Void
			else
				title := v.to_string_32
			end
		end

	set_arguments (v: READABLE_STRING_GENERAL)
			-- Set `arguments'
		require
			v_attached: v /= Void
		do
			arguments := v.to_string_32
		end

	set_working_directory (a_path: like working_directory)
			-- Set `working_directory'
		do
			working_directory := a_path
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

	set_environment_variable (a_value: READABLE_STRING_GENERAL; a_name: READABLE_STRING_GENERAL)
			-- Add an environment variable "a_name=a_value".
		local
			tb: like environment_variables
		do
			tb := environment_variables
			if tb = Void then
				create tb.make (1)
				environment_variables := tb
			end
			tb.force (a_value.as_string_32, a_name.as_string_32)
		end

	unset_environment_variable (a_name: READABLE_STRING_GENERAL)
			-- Unset the environment variable "a_name".	
		local
			tb: like environment_variables
		do
			tb := environment_variables
			if tb = Void then
				create tb.make (1)
				environment_variables := tb
			end
			tb.force ("", {DEBUGGER_CONTROLLER}.environment_variable_unset_prefix + a_name.as_string_32)
		end

feature -- debug output

	debug_output: STRING_32
		do
			create Result.make (32)
			if attached group as g then
				Result.append_character ('[')
				Result.append (g)
				Result.append_character (']')
				Result.append_character (' ')
			end
			Result.append_string_general ("uuid=")
			Result.append_string_general (uuid.out)
			Result.append_string_general (" version=")
			Result.append_string_general (version.out)
		end

invariant
	uuid_set: uuid /= Void
	working_directory_attached: working_directory /= Void
	arguments_attached: arguments /= Void

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
