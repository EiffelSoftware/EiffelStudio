indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OVERRIDE_SECTION

inherit
	CLUSTER_SECTION
		redefine
			group,
			remove_group,
			add_dialog_type,
			update_toolbar_sensitivity
		end

create
	make

feature -- Access

	group: CONF_OVERRIDE
		-- Group for which information are displayed.

feature -- Element update

	remove_group is
			-- Remove `Current' from the configuration and from the tree where it is displayed.
			-- Also remove the parent node if it is empty.
		do
			target.remove_override (group.name)
			Precursor
		end

feature {NONE} -- Implementation

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.reset_sensitive

			toolbar.add_override_button.select_actions.wipe_out
			toolbar.add_override_button.select_actions.extend (agent add_subcluster)
			toolbar.add_override_button.enable_sensitive

			toolbar.remove_button.select_actions.wipe_out
			toolbar.remove_button.select_actions.extend (agent ask_remove_group)
			toolbar.remove_button.enable_sensitive
		end

feature {NONE} -- Type anchors

	add_dialog_type: CREATE_OVERRIDE_DIALOG;
			-- Type of the add dialog

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
