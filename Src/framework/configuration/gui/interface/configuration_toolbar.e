note
	description: "Toolbar for configuration actions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONFIGURATION_TOOLBAR

inherit
	SD_TOOL_BAR
		redefine
			initialize,
			is_in_default_state
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize.
		local
			l_ac: EV_ACCELERATOR
		do
			Precursor {SD_TOOL_BAR}

			create accelerators

			create add_target_button.make
			add_target_button.set_pixmap (conf_pixmaps.new_target_icon)
			add_target_button.set_pixel_buffer (conf_pixmaps.new_target_icon_buffer)
			extend (add_target_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_t), True, False, False)
			l_ac.actions.extend (agent press_button (add_target_button))
			accelerators.extend (l_ac)
			add_target_button.set_tooltip (name_with_key (conf_interface_names.add_target, l_ac))

			extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create add_cluster_button.make
			add_cluster_button.set_pixmap (conf_pixmaps.new_cluster_icon)
			add_cluster_button.set_pixel_buffer (conf_pixmaps.new_cluster_icon_buffer)
			extend (add_cluster_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_u), True, False, False)
			l_ac.actions.extend (agent press_button (add_cluster_button))
			accelerators.extend (l_ac)
			add_cluster_button.set_tooltip (name_with_key (conf_interface_names.group_add_cluster, l_ac))

			create add_override_button.make
			add_override_button.set_pixmap (conf_pixmaps.new_override_cluster_icon)
			add_override_button.set_pixel_buffer (conf_pixmaps.new_override_cluster_icon_buffer)
			extend (add_override_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_o), True, False, False)
			l_ac.actions.extend (agent press_button (add_override_button))
			accelerators.extend (l_ac)
			add_override_button.set_tooltip (name_with_key (conf_interface_names.group_add_override, l_ac))

			create add_assembly_button.make
			add_assembly_button.set_pixmap (conf_pixmaps.new_reference_icon)
			add_assembly_button.set_pixel_buffer (conf_pixmaps.new_reference_icon_buffer)
			extend (add_assembly_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_a), True, False, False)
			l_ac.actions.extend (agent press_button (add_assembly_button))
			accelerators.extend (l_ac)
			add_assembly_button.set_tooltip (name_with_key (conf_interface_names.group_add_assembly, l_ac))

			create add_library_button.make
			add_library_button.set_pixmap (conf_pixmaps.new_library_icon)
			add_library_button.set_pixel_buffer (conf_pixmaps.new_library_icon_buffer)
			extend (add_library_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_l), True, False, False)
			l_ac.actions.extend (agent press_button (add_library_button))
			accelerators.extend (l_ac)
			add_library_button.set_tooltip (name_with_key (conf_interface_names.group_add_library, l_ac))

			create add_precompile_button.make
			add_precompile_button.set_pixmap (conf_pixmaps.new_precompiled_library_icon)
			add_precompile_button.set_pixel_buffer (conf_pixmaps.new_precompiled_library_icon_buffer)
			extend (add_precompile_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_p), True, False, False)
			l_ac.actions.extend (agent press_button (add_precompile_button))
			accelerators.extend (l_ac)
			add_precompile_button.set_tooltip (name_with_key (conf_interface_names.group_add_precompile, l_ac))

			extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create add_include_button.make
			add_include_button.set_pixmap (conf_pixmaps.new_include_icon)
			add_include_button.set_pixel_buffer (conf_pixmaps.new_include_icon_buffer)
			extend (add_include_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_i), True, False, False)
			l_ac.actions.extend (agent press_button (add_include_button))
			accelerators.extend (l_ac)
			add_include_button.set_tooltip (name_with_key (conf_interface_names.external_add_include, l_ac))

			create add_object_button.make
			add_object_button.set_pixmap (conf_pixmaps.new_object_icon)
			add_object_button.set_pixel_buffer (conf_pixmaps.new_object_icon_buffer)
			extend (add_object_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_b), True, False, False)
			l_ac.actions.extend (agent press_button (add_object_button))
			accelerators.extend (l_ac)
			add_object_button.set_tooltip (name_with_key (conf_interface_names.external_add_object, l_ac))

			create add_external_library_button.make
			add_external_library_button.set_pixmap (conf_pixmaps.new_object_icon)
			add_external_library_button.set_pixel_buffer (conf_pixmaps.new_object_icon_buffer)
			extend (add_external_library_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_e), True, False, False)
			l_ac.actions.extend (agent press_button (add_external_library_button))
			accelerators.extend (l_ac)
			add_external_library_button.set_tooltip (name_with_key (conf_interface_names.external_add_library, l_ac))

			create add_make_button.make
			add_make_button.set_pixmap (conf_pixmaps.new_makefile_icon)
			add_make_button.set_pixel_buffer (conf_pixmaps.new_makefile_icon_buffer)
			extend (add_make_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_k), True, False, False)
			l_ac.actions.extend (agent press_button (add_make_button))
			accelerators.extend (l_ac)
			add_make_button.set_tooltip (name_with_key (conf_interface_names.external_add_make, l_ac))

			create add_resource_button.make
			add_resource_button.set_pixmap (conf_pixmaps.new_resource_icon)
			add_resource_button.set_pixel_buffer (conf_pixmaps.new_resource_icon_buffer)
			extend (add_resource_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_r), True, False, False)
			l_ac.actions.extend (agent press_button (add_resource_button))
			accelerators.extend (l_ac)
			add_resource_button.set_tooltip (name_with_key (conf_interface_names.external_add_resource, l_ac))

			extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create add_pre_task_button.make
			add_pre_task_button.set_pixmap (conf_pixmaps.new_pre_compilation_task_icon)
			add_pre_task_button.set_pixel_buffer (conf_pixmaps.new_pre_compilation_task_icon_buffer)
			extend (add_pre_task_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_s), True, False, False)
			l_ac.actions.extend (agent press_button (add_pre_task_button))
			accelerators.extend (l_ac)
			add_pre_task_button.set_tooltip (name_with_key (conf_interface_names.task_add_pre, l_ac))

			create add_post_task_button.make
			add_post_task_button.set_pixmap (conf_pixmaps.new_post_compilation_task_icon)
			add_post_task_button.set_pixel_buffer (conf_pixmaps.new_post_compilation_task_icon_buffer)
			extend (add_post_task_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_h), True, False, False)
			l_ac.actions.extend (agent press_button (add_post_task_button))
			accelerators.extend (l_ac)
			add_post_task_button.set_tooltip (name_with_key (conf_interface_names.task_add_post, l_ac))

			extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create remove_button.make
			remove_button.set_pixmap (conf_pixmaps.general_delete_icon)
			remove_button.set_pixel_buffer (conf_pixmaps.general_delete_icon_buffer)
			extend (remove_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_delete), False, False, False)
			l_ac.actions.extend (agent press_button (remove_button))
			accelerators.extend (l_ac)
			remove_button.set_tooltip (name_with_key (conf_interface_names.general_remove, l_ac))

			extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create edit_library.make
			edit_library.set_pixmap (conf_pixmaps.project_settings_edit_library_icon)
			edit_library.set_pixel_buffer (conf_pixmaps.project_settings_edit_library_icon_buffer)
			extend (edit_library)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_y), True, False, False)
			l_ac.actions.extend (agent press_button (edit_library))
			accelerators.extend (l_ac)
			edit_library.set_tooltip (name_with_key (conf_interface_names.library_edit_configuration, l_ac))

			extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create edit_manually_button.make
			edit_manually_button.set_pixmap (conf_pixmaps.general_edit_icon)
			edit_manually_button.set_pixel_buffer (conf_pixmaps.general_edit_icon_buffer)
			extend (edit_manually_button)
			create l_ac.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_m), True, False, False)
			l_ac.actions.extend (agent press_button (edit_manually_button))
			accelerators.extend (l_ac)
			edit_manually_button.set_tooltip (name_with_key (conf_interface_names.target_edit_manually, l_ac))

			compute_minimum_size
				-- disable all buttons
			reset_sensitive
		end

feature -- Buttons

	edit_manually_button: SD_TOOL_BAR_BUTTON
			-- Button for manual editing of current configuration.

	add_target_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new target.

	add_cluster_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new cluster.

	add_override_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new override cluster.

	add_assembly_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new assembly.

	add_library_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new library.

	add_precompile_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new precompile.

	add_include_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new include external.

	add_object_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new object external.

	add_external_library_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new library external.

	add_make_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new make external.

	add_resource_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new resource external.

	add_pre_task_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new pre compilation task.

	add_post_task_button: SD_TOOL_BAR_BUTTON
			-- Button for adding a new post compilation task.

	remove_button: SD_TOOL_BAR_BUTTON
			-- Button for remove action.

	edit_library: SD_TOOL_BAR_BUTTON;
			-- Button to edit a library.

	accelerators: EV_ACCELERATOR_LIST
			-- Accelerators for this toolbar.

feature -- Update

	reset_sensitive
			-- Reset sensitive status of items, disables all items that are not globally available.
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			l_items := items
			l_items.do_all (agent (a_item: SD_TOOL_BAR_ITEM)
				local
					l_sens: SD_TOOL_BAR_BUTTON
				do
					l_sens ?= a_item
					if l_sens /= Void then
						l_sens.disable_sensitive
					end
				end)
			edit_manually_button.enable_sensitive
		end

feature {NONE} -- Implementation

	press_button (a_button: SD_TOOL_BAR_BUTTON)
			-- Press `a_button'.
		do
			if a_button.is_sensitive then
				a_button.select_actions.call (Void)
			end
		end

	name_with_key (a_name: STRING_GENERAL; a_key: EV_ACCELERATOR): STRING_GENERAL
			-- Format text with `a_name' and `a_key'.
		require
			a_name_not_void: a_name /= Void
		do
			Result := a_name.twin
			if a_key /= Void then
				Result.append (" (")
				Result.append (a_key.out)
				Result.append (")")
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN = True;

invariant
	accelerators_not_void: accelerators /= Void
	edit_manually_button: edit_manually_button /= Void
	add_target_button: add_target_button /= Void
	add_cluster_button: add_cluster_button /= Void
	add_override_button: add_override_button /= Void
	add_assembly_button: add_assembly_button /= Void
	add_library_button: add_library_button /= Void
	add_precompile_button: add_precompile_button /= Void
	add_include_button: add_include_button /= Void
	add_object_button: add_object_button /= Void
	add_external_library_button: add_external_library_button /= Void
	add_make_button: add_make_button /= Void
	add_resource_button: add_resource_button /= Void
	add_pre_task_button: add_pre_task_button /= Void
	add_post_task_button: add_post_task_button /= Void
	remove_button: remove_button /= Void
	edit_library: edit_library /= Void

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
