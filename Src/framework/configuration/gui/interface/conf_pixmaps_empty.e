note
	description: "A collection of empty pixmaps for {CONF_PIXMAPS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_PIXMAPS_EMPTY

inherit
	CONF_PIXMAPS

feature -- Pixel buffers

	general_delete_icon_buffer,
	general_edit_icon_buffer,
	general_tick_icon_buffer,
	general_warning_icon_buffer,
	new_cflag_icon_buffer,
	new_cluster_icon_buffer,
	new_include_icon_buffer,
	new_library_icon_buffer,
	new_linker_flag_icon_buffer,
	new_makefile_icon_buffer,
	new_object_icon_buffer,
	new_override_cluster_icon_buffer,
	new_post_compilation_task_icon_buffer,
	new_pre_compilation_task_icon_buffer,
	new_precompiled_library_icon_buffer,
	new_reference_icon_buffer,
	new_resource_icon_buffer,
	new_target_icon_buffer,
	new_remote_target_icon_buffer,
	project_settings_edit_library_icon_buffer: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			create Result
		end

feature -- Pixmaps

	folder_assembly_icon,
	folder_blank_icon,
	folder_blank_readonly_icon,
	folder_cluster_icon,
	folder_cluster_readonly_icon,
	folder_hidden_blank_icon,
	folder_hidden_blank_readonly_icon,
	folder_hidden_cluster_icon,
	folder_hidden_cluster_readonly_icon,
	folder_library_icon,
	folder_library_readonly_icon,
	folder_namespace_icon,
	folder_override_blank_icon,
	folder_override_blank_readonly_icon,
	folder_override_cluster_icon,
	folder_override_cluster_readonly_icon,
	folder_precompiled_library_icon,
	folder_precompiled_library_readonly_icon,
	general_add_icon,
	general_delete_icon,
	general_edit_icon,
	general_open_icon,
	general_remove_icon,
	general_tick_icon,
	general_warning_icon,
	library_iron_library_icon,
	library_iron_package_icon,
	new_cflag_icon,
	new_cluster_icon,
	new_include_icon,
	new_library_icon,
	new_linker_flag_icon,
	new_makefile_icon,
	new_object_icon,
	new_override_cluster_icon,
	new_post_compilation_task_icon,
	new_pre_compilation_task_icon,
	new_precompiled_library_icon,
	new_reference_icon,
	new_resource_icon,
	new_target_icon,
	new_remote_target_icon,
	project_settings_advanced_icon,
	project_settings_assertions_icon,
	project_settings_cflag_icon,
	project_settings_debug_icon,
	project_settings_default_highlighted_icon,
	project_settings_default_icon,
	project_settings_edit_library_icon,
	project_settings_externals_icon,
	project_settings_groups_icon,
	project_settings_include_file_icon,
	project_settings_linker_flag_icon,
	project_settings_make_file_icon,
	project_settings_object_file_icon,
	project_settings_resource_file_icon,
	project_settings_system_icon,
	project_settings_task_icon,
	project_settings_tasks_icon,
	project_settings_type_mappings_icon,
	project_settings_variables_icon,
	project_settings_warnings_icon,
	tool_config_icon,
	tool_properties_icon,
	top_level_folder_clusters_icon,
	top_level_folder_library_icon,
	top_level_folder_overrides_icon,
	top_level_folder_precompiles_icon,
	top_level_folder_references_icon,
	top_level_folder_targets_icon,
	top_level_folder_remote_targets_icon: EV_PIXMAP
			-- <Precursor>
		do
			create Result
		end
note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
