note
	description: "User specific options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	USER_OPTIONS

create
	make

feature {NONE} -- Initialization

	make (a_project_file_path: like project_file_path; a_target_name: like target_name)
			-- Create a user specific data file for project with location `a_project_file_path'.
		require
			a_uuid_not_void: a_project_file_path /= Void
			a_target_name_not_void: a_target_name /= Void
			a_target_name_not_empty: not a_target_name.is_empty
		do
			project_file_path := a_project_file_path
			target_name := a_target_name
			create targets.make (1)
		ensure
			project_file_path_set: project_file_path = a_project_file_path
			target_name_set: target_name = a_target_name
		end

feature -- Access

	project_file_path: STRING
			-- Path of configuration file associated with user configurations.

	target: TARGET_USER_OPTIONS
			-- Options for currently selected target `target_name'.
		do
			Result := targets.item (target_name)
			if Result = Void then
					-- No options yet, create them
				create Result.make (target_name)
				targets.put (Result, target_name)
			end
		ensure
			target_not_void: target /= Void
		end

	target_of_name (a_name: STRING): like target
			-- Options associated with target of name `a_name'.
			-- Void if no target of name `a_name' exists.
		require
			a_name_not_void: a_name /= Void
		do
			Result := targets.item (a_name)
		end

	target_name: STRING
			-- Name of last chosen target.

	target_names: LIST [STRING]
			-- List of available target names
		do
			create {ARRAYED_LIST [STRING]}Result.make_from_array (targets.current_keys)
		ensure
			result_attached: Result /= Void
		end

feature {USER_OPTIONS, USER_OPTIONS_FACTORY} -- Implementation: Access

	targets: HASH_TABLE [TARGET_USER_OPTIONS, STRING]
			-- Set of options indexed by target.

feature -- Update

	set_target_name (a_target: like target_name)
			-- Set `target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target_name := a_target
		ensure
			target_name_set: target_name = a_target
		end

invariant
	project_file_path_not_void: project_file_path /= Void
	targets_not_void: targets /= Void
	target_name_not_void: target_name /= Void
	target_name_not_empty: not target_name.is_empty

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
end
