note
	description: "Shared domain item utility"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DOMAIN_ITEM_UTILITY

inherit
	EB_SHARED_ID_SOLUTION

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		end

	EB_SHARED_ID_SOLUTION

	EB_SHARED_EDITOR_TOKEN_UTILITY

feature -- Access

	domain_item_from_stone (a_stone: STONE): EB_DOMAIN_ITEM
			-- Domain item from `a_stone'
		require
			a_stone_attached: a_stone /= Void
		local
			l_folder: EB_FOLDER
			done: BOOLEAN
			l_target: CONF_TARGET
		do
			if workbench.system_defined and then workbench.is_already_compiled then
				if attached {FEATURE_STONE} a_stone as l_feature_stone then
					create {EB_FEATURE_DOMAIN_ITEM} Result.make (id_of_feature (l_feature_stone.e_feature))
					done := True
				end
				if not done then
					if attached {CLASSI_STONE} a_stone as l_classi_stone then
						create {EB_CLASS_DOMAIN_ITEM} Result.make (id_of_class (l_classi_stone.class_i.config_class))
						done := True
					end
				end
				if not done then
					if attached {CLUSTER_STONE} a_stone as l_cluster_stone then
						if attached {CLUSTER_I} l_cluster_stone.group as l_cluster_i and not l_cluster_stone.path.is_empty then
								-- For a folder
							create l_folder.make_with_name (l_cluster_i, l_cluster_stone.path, l_cluster_stone.folder_name)
							create {EB_FOLDER_DOMAIN_ITEM} Result.make (id_of_folder (l_folder))
						else
								-- For a group
							create {EB_GROUP_DOMAIN_ITEM} Result.make (id_of_group (l_cluster_stone.group))
							if l_cluster_stone.group.is_library and then attached {CONF_LIBRARY} l_cluster_stone.group as l_library then
								l_target := target_of_id (Result.id)
								if
									l_target /= Void and then
									l_target.system.same_as (universe.target.system) and then
									attached l_library.library_target as l_lib_target then
									Result.set_library_target_uuid (l_lib_target.system.uuid.out)
								end
							end
						end
					end
				end
				if not done then
					if attached {TARGET_STONE} a_stone as l_target_stone then
						create {EB_TARGET_DOMAIN_ITEM} Result.make (id_of_target (l_target_stone.target))
					end
				end
			end
		end

	pixmap_from_domain_item (a_item: EB_DOMAIN_ITEM): EV_PIXMAP
			-- Pixmap from `a_item'.
		local
			l_group: CONF_GROUP
			l_folder: EB_FOLDER
			l_feature: E_FEATURE
		do
			if a_item.is_valid then
				if a_item.is_target_item then
					Result := pixmaps.icon_pixmaps.metric_unit_target_icon
				elseif a_item.is_group_item then
					l_group := group_of_id (a_item.id)
					Result := pixmap_from_group (l_group)
				elseif a_item.is_folder_item then
					l_folder := folder_of_id (a_item.id)
					Result := pixmap_from_group_path (l_folder.cluster, l_folder.path)
				elseif a_item.is_class_item and then attached {CLASS_I} class_of_id (a_item.id) as l_class then
					Result := pixmap_from_class_i (l_class)
				elseif a_item.is_feature_item then
					l_feature := feature_of_id (a_item.id)
					Result := pixmap_from_e_feature (l_feature)
				elseif a_item.is_delayed_item then
					Result := pixmaps.icon_pixmaps.metric_domain_delayed_icon
				else
					Result := pixmaps.icon_pixmaps.general_blank_icon
				end
			else
				if a_item.is_target_item then
					Result := pixmaps.icon_pixmaps.metric_unit_target_icon
				elseif a_item.is_group_item then
					Result := pixmaps.icon_pixmaps.metric_group_icon
				elseif a_item.is_folder_item then
					Result := pixmaps.icon_pixmaps.folder_cluster_icon
				elseif a_item.is_class_item then
					Result := pixmaps.icon_pixmaps.class_normal_icon
				elseif a_item.is_feature_item then
					Result := pixmaps.icon_pixmaps.feature_routine_icon
				elseif a_item.is_delayed_item then
					Result := pixmaps.icon_pixmaps.metric_domain_delayed_icon
				else
					Result := pixmaps.icon_pixmaps.general_blank_icon
				end
			end
		ensure
			result_attached: Result /= Void
		end

	token_name_from_domain_item (a_item: EB_DOMAIN_ITEM): LIST [EDITOR_TOKEN]
			-- Editor token representation of `a_item'
		require
			a_item_attached: a_item /= Void
		local
			l_writer: like token_writer
			l_pebble_function: FUNCTION [ANY]
		do
			if a_item.is_valid then
					-- For valid item, we display its pickable name.
				if a_item.is_class_item then
						-- For class item
					ql_name_style.set_item (a_item.query_language_item)
					Result := ql_name_style.text
				elseif a_item.is_feature_item and then attached {QL_FEATURE} a_item.query_language_item as l_feature then
						-- For feature item
					feature_with_class_style.set_ql_feature (l_feature)
					Result := feature_with_class_style.text
				elseif a_item.is_folder_item then
						-- For folder item
					l_writer := token_writer
					l_writer.new_line
					if
						attached {EB_FOLDER_DOMAIN_ITEM} a_item as l_folder and then
						attached l_folder.folder.cluster as l_clu
					then
						l_writer.add_group (l_clu, a_item.string_representation)
					else
						l_writer.add_string (a_item.string_representation)
					end
					Result := l_writer.last_line.content

				elseif a_item.is_group_item then
						-- For group item
					ql_name_style.set_item (a_item.query_language_item)
					Result := ql_name_style.text

				elseif a_item.is_target_item then
						-- For target item
					if a_item.id.is_empty then
						l_pebble_function := plain_text_style.pebble_function
						plain_text_style.set_pebble_function (agent: TARGET_STONE do create{TARGET_STONE} Result.make (workbench.universe.target) Result.set_is_delayed_application_target (True) end)
						plain_text_style.set_source_text (a_item.string_representation)
						Result := plain_text_style.text
						plain_text_style.set_pebble_function (l_pebble_function)
					else
						ql_name_style.set_item (a_item.query_language_item)
						Result := ql_name_style.text
					end

				elseif a_item.is_delayed_item then
						-- For delayed item
					plain_text_style.set_source_text (a_item.string_representation)
					Result := plain_text_style.text
				else
					plain_text_style.set_source_text (a_item.string_representation)
					Result := plain_text_style.text
				end
			else
					-- For invalid item, we display its name in error style.
				l_writer := token_writer
				l_writer.new_line
				l_writer.add_error (create {SYNTAX_ERROR}.make (1, 1, "", {STRING_32} ""), a_item.string_representation)
				Result := l_writer.last_line.content
			end
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
