indexing
	description: "Toolbar for configuration actions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONFIGURATION_TOOLBAR

inherit
	EV_TOOL_BAR
		redefine
			initialize,
			is_in_default_state
		end

	EB_CONSTANTS
		undefine
			default_create,
			is_equal,
			copy
		end

	CONF_INTERFACE_CONSTANTS
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		do
			Precursor

			create edit_manually_button
			edit_manually_button.set_pixmap (pixmaps.icon_pixmaps.general_edit_icon)
			edit_manually_button.set_tooltip (conf_interface_names.target_edit_manually)
			extend (edit_manually_button)

			create add_target_button
			add_target_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			add_target_button.set_tooltip (conf_interface_names.add_target)
			extend (add_target_button)

			create add_cluster_button
			add_cluster_button.set_pixmap (pixmaps.icon_pixmaps.new_cluster_icon)
			add_cluster_button.set_tooltip (conf_interface_names.group_add_cluster)
			extend (add_cluster_button)

			create add_override_button
			add_override_button.set_pixmap (pixmaps.icon_pixmaps.new_override_cluster_icon)
			add_override_button.set_tooltip (conf_interface_names.group_add_override)
			extend (add_override_button)

			create add_assembly_button
			add_assembly_button.set_pixmap (pixmaps.icon_pixmaps.new_reference_icon)
			add_assembly_button.set_tooltip (conf_interface_names.group_add_assembly)
			extend (add_assembly_button)

			create add_library_button
			add_library_button.set_pixmap (pixmaps.icon_pixmaps.new_library_icon)
			add_library_button.set_tooltip (conf_interface_names.group_add_library)
			extend (add_library_button)

			create add_precompile_button
			add_precompile_button.set_pixmap (pixmaps.icon_pixmaps.new_precompiled_library_icon)
			add_precompile_button.set_tooltip (conf_interface_names.group_add_precompile)
			extend (add_precompile_button)

			create add_include_button
			add_include_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			add_include_button.set_tooltip (conf_interface_names.external_add_include)
			extend (add_include_button)

			create add_object_button
			add_object_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			add_object_button.set_tooltip (conf_interface_names.external_add_object)
			extend (add_object_button)

			create add_external_library_button
			add_external_library_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			add_external_library_button.set_tooltip (conf_interface_names.external_add_library)
			extend (add_external_library_button)

			create add_make_button
			add_make_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			add_make_button.set_tooltip (conf_interface_names.external_add_make)
			extend (add_make_button)

			create add_resource_button
			add_resource_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			add_resource_button.set_tooltip (conf_interface_names.external_add_resource)
			extend (add_resource_button)

			create add_pre_task_button
			add_pre_task_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			add_pre_task_button.set_tooltip (conf_interface_names.task_add_pre)
			extend (add_pre_task_button)

			create add_post_task_button
			add_post_task_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			add_post_task_button.set_tooltip (conf_interface_names.task_add_post)
			extend (add_post_task_button)

			create remove_button
			remove_button.set_pixmap (pixmaps.icon_pixmaps.general_remove_icon)
			remove_button.set_tooltip (conf_interface_names.general_remove)
			extend (remove_button)

			create edit_library
			edit_library.set_pixmap (pixmaps.icon_pixmaps.project_settings_edit_library_icon)
			edit_library.set_tooltip (conf_interface_names.library_edit_configuration)
			extend (edit_library)

				-- disable all buttons
			reset_sensitive
		end

feature -- Buttons

	edit_manually_button: EV_TOOL_BAR_BUTTON
			-- Button for manual editing of current configuration.

	add_target_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new target.

	add_cluster_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new cluster.

	add_override_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new override cluster.

	add_assembly_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new assembly.

	add_library_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new library.

	add_precompile_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new precompile.

	add_include_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new include external.

	add_object_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new object external.

	add_external_library_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new library external.

	add_make_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new make external.

	add_resource_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new resource external.

	add_pre_task_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new pre compilation task.

	add_post_task_button: EV_TOOL_BAR_BUTTON
			-- Button for adding a new post compilation task.

	remove_button: EV_TOOL_BAR_BUTTON
			-- Button for remove action.

	edit_library: EV_TOOL_BAR_BUTTON;
			-- Button to edit a library.

feature -- Update

	reset_sensitive is
			-- Reset sensitive status of items, disables all items that are not globally available.
		do
			do_all (agent (a_item: EV_TOOL_BAR_ITEM)
				local
					l_sens: EV_SENSITIVE
				do
					l_sens ?= a_item
					if l_sens /= Void then
						l_sens.disable_sensitive
					end
				end)
			edit_manually_button.enable_sensitive
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is True;

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
