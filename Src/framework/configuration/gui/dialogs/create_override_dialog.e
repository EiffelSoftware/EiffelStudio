note
	description: "Add an override cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_OVERRIDE_DIALOG

inherit
	CREATE_CLUSTER_DIALOG
		redefine
			last_group,
			make,
			on_ok
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: CONF_TARGET; a_factory: like factory)
		-- Create.
	do
		Precursor {CREATE_CLUSTER_DIALOG} (a_target, a_factory)
		set_title (conf_interface_names.dialog_create_override_title)
		set_icon_pixmap (conf_pixmaps.new_override_cluster_icon)
	end

feature -- Access

	last_group: CONF_OVERRIDE
			-- Last added override cluster.

feature {NONE} -- Actions

	on_ok
			-- Add group and close the dialog.
		local
			l_loc: CONF_DIRECTORY_LOCATION
		do
			if not name.text.is_empty and not location.text.is_empty then
				if not is_valid_group_name (name.text) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.invalid_override_name, Current, Void)
				elseif group_exists (name.text, target) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.group_already_exists (name.text), Current, Void)
				else
					l_loc := factory.new_location_from_path (location.text, target)
					last_group := factory.new_override (name.text, l_loc, target)
					if parent_cluster /= Void then
						last_group.set_parent (parent_cluster)
						last_group.set_classes (create {HASH_TABLE [CONF_CLASS, STRING]}.make (0))
						parent_cluster.add_child (last_group)
					end
					last_group.set_recursive (True)
					target.add_override (last_group)
					is_ok := True
					destroy
				end
			end
		end

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
