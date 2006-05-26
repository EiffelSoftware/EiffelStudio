indexing
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

	make (a_uuid: like uuid; a_target_name: like target_name) is
			-- Create a user specific data file for project with UUID `a_uuid'.
		require
			a_uuid_not_void: a_uuid /= Void
			a_target_name_not_void: a_target_name /= Void
		do
			uuid := a_uuid
			target_name := a_target_name
			create targets.make (1)
		ensure
			uuid_set: uuid = a_uuid
			target_name_set: target_name = a_target_name
		end

feature -- Access

	uuid: UUID
			-- UUID of configuration file associated with user configurations.

	target: TARGET_USER_OPTIONS is
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

	target_of_name (a_name: STRING): like target is
			-- Options associated with target of name `a_name'.
			-- Void if no target of name `a_name' exists.
		require
			a_name_not_void: a_name /= Void
		do
			Result := targets.item (a_name)
		end

	target_name: STRING
			-- Name of last chosen target.

feature {USER_OPTIONS, USER_OPTIONS_FACTORY} -- Implementation: Access

	targets: HASH_TABLE [TARGET_USER_OPTIONS, STRING]
			-- Set of options indexed by target.

feature -- Update

	set_target_name (a_target: like target_name) is
			-- Set `target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target_name := a_target
		ensure
			target_name_set: target_name = a_target
		end

invariant
	uuid_not_void: uuid /= Void
	targets_not_void: targets /= Void
	target_name_not_void: target_name /= Void

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
end
