indexing
	description: "Dialog to create a new group."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CREATE_GROUP_DIALOG

inherit
	EV_DIALOG

	EIFFEL_SYNTAX_CHECKER
		undefine
			default_create,
			copy
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	make (a_target: CONF_TARGET; a_factory: like factory) is
			-- Create.
		require
			a_target_not_void: a_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			target := a_target
			factory := a_factory
			default_create
		ensure
			target_set: target = a_target
			factory_set: factory = a_factory
		end

feature -- Status

	is_ok: BOOLEAN
			-- Was the dialog closed with ok?

feature -- Access

	last_group: CONF_GROUP;
			-- Last added group.

feature {NONE} -- Implementation

	target: CONF_TARGET
			-- Target where we add the group.

	factory: CONF_PARSE_FACTORY
			-- Factory to create a group.

	group_exists (a_group: STRING; a_target: CONF_TARGET): BOOLEAN is
			-- Check if `a_target' or any child of `a_target' already has `a_group'.
		require
			a_group_ok: a_group /= Void and then not a_group.is_empty
		local
			l_groups: HASH_TABLE [CONF_GROUP, STRING_8]
		do
			l_groups := a_target.groups
			Result := l_groups.has_key (a_group.as_lower) and then l_groups.found_item.name.is_equal (a_group.as_lower)
			if not Result then
				Result := a_target.child_targets.there_exists (agent group_exists(a_group.as_lower, ?))
			end
		end

invariant
	target_not_void: target /= Void
	factory_not_void: factory /= Void

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
