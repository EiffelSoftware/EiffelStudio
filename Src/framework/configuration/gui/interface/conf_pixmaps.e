note
	description: "Pixmaps for configuration objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_PIXMAPS

feature -- Access

	folder_blank_readonly_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_blank_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_namespace_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_override_blank_readonly_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_override_blank_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_override_cluster_readonly_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_override_cluster_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_hidden_blank_readonly_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_hidden_blank_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_hidden_cluster_readonly_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_hidden_cluster_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_cluster_readonly_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_precompiled_library_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_precompiled_library_readonly_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_cluster_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_library_readonly_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_library_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	folder_assembly_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_reference_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_reference_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_target_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_target_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_remote_target_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_remote_target_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_cluster_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_cluster_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_override_cluster_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_override_cluster_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_library_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_library_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	general_open_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	general_add_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	general_remove_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	general_edit_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	general_edit_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	general_delete_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	general_delete_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	general_tick_icon: EV_PIXMAP
			-- Access to 'tick' pixmap.
		deferred
		ensure
			general_tick_icon_attached: Result /= Void
		end

	general_tick_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'tick' pixmap pixel buffer.
		deferred
		ensure
			general_tick_icon_buffer_attached: Result /= Void
		end

	general_warning_icon: EV_PIXMAP
			-- Access to 'warning' pixmap.
		deferred
		ensure
			general_warning_icon_attached: Result /= Void
		end

	general_warning_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'warning' pixmap pixel buffer.
		deferred
		ensure
			general_warning_icon_buffer_attached: Result /= Void
		end

	new_precompiled_library_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_precompiled_library_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_include_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_include_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_cflag_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_cflag_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_object_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_object_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_resource_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_resource_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_linker_flag_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_linker_flag_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_makefile_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_makefile_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_pre_compilation_task_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_pre_compilation_task_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_post_compilation_task_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	new_post_compilation_task_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_edit_library_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_edit_library_icon_buffer: EV_PIXEL_BUFFER
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_system_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_tasks_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_task_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_variables_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_groups_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_assertions_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_warnings_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_externals_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_debug_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_type_mappings_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_advanced_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_include_file_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_cflag_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_object_file_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_resource_file_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_linker_flag_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_make_file_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_default_highlighted_icon: EV_PIXMAP
			-- An icon for a highlighted default option/setting.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	project_settings_default_icon: EV_PIXMAP
			-- An icon for a default option/setting.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	tool_properties_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	tool_config_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	top_level_folder_targets_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	top_level_folder_remote_targets_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	top_level_folder_references_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	top_level_folder_clusters_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	top_level_folder_overrides_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	top_level_folder_library_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	top_level_folder_precompiles_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access: iron

	library_iron_package_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	library_iron_library_icon: EV_PIXMAP
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access		

	pixmap_from_group (a_group: CONF_GROUP): EV_PIXMAP
			-- Return pixmap based on `a_group'.
		require
			a_group_not_void: a_group /= Void
		do
			Result := pixmap_from_group_path (a_group, "")
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_group_path (a_group: CONF_GROUP; a_path: READABLE_STRING_GENERAL): EV_PIXMAP
			-- Return pixmap based on `a_group' and `a_path'.
		require
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
			path_implies_not_library: not a_path.is_empty implies not a_group.is_library
		do
			if not a_path.is_empty then
				if a_group.is_override then
					if a_group.is_readonly then
						Result := folder_override_blank_readonly_icon
					else
						Result := folder_override_blank_icon
					end
				elseif attached {CONF_CLUSTER} a_group as l_cluster then
					if l_cluster.is_hidden then
						if a_group.is_readonly then
							Result := folder_hidden_blank_readonly_icon
						else
							Result := folder_hidden_blank_icon
						end
					else
						if a_group.is_readonly then
							Result := folder_blank_readonly_icon
						else
							Result := folder_blank_icon
						end
					end
				elseif a_group.is_assembly or a_group.is_physical_assembly then
					Result := folder_namespace_icon
				else
					check should_not_reach: False then end
				end
			else
				if a_group.is_override then
					if a_group.is_readonly then
						Result := folder_override_cluster_readonly_icon
					else
						Result := folder_override_cluster_icon
					end
				elseif attached {CONF_CLUSTER} a_group as l_cluster then
					if l_cluster.is_hidden then
						if a_group.is_readonly then
							Result := folder_hidden_cluster_readonly_icon
						else
							Result := folder_hidden_cluster_icon
						end
					else
						if a_group.is_readonly then
							Result := folder_cluster_readonly_icon
						else
							Result := folder_cluster_icon
						end
					end
				elseif a_group.is_precompile then
					if a_group.is_readonly then
						Result := folder_precompiled_library_readonly_icon
					else
						Result := folder_precompiled_library_icon
					end
				elseif a_group.is_library then
					if a_group.is_readonly then
						Result := folder_library_readonly_icon
					else
						Result := folder_library_icon
					end
				elseif a_group.is_assembly or a_group.is_physical_assembly then
					Result := folder_assembly_icon
				else
					check should_not_reach: False then end
				end
			end
		ensure
			result_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
