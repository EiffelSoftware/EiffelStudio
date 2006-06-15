indexing
	description: "Class containing features for retrieving pixmaps for Clusters, Classes and Features"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY

inherit
	EB_CONSTANTS


feature {NONE} -- Implementation

	pixmap_from_group (a_group: CONF_GROUP): EV_PIXMAP is
			-- Return pixmap based on `a_group'.
		require
			a_group_not_void: a_group /= Void
		do
			conf_todo_msg ("Make sure that pixmap_from_group should be called and not pixmap_from_group_path.")
			Result := pixmap_from_group_path (a_group, "")
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_group_path (a_group: CONF_GROUP; a_path: STRING): EV_PIXMAP is
			-- Return pixmap based on `a_group' and `a_path'.
		require
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
			path_implies_not_library: not a_path.is_empty implies not a_group.is_library
		do
			if not a_path.is_empty then
				if a_group.is_override then
					Result := pixmaps.icon_pixmaps.folder_override_subcluster_icon
				elseif a_group.is_cluster then
					Result := pixmaps.icon_pixmaps.folder_subcluster_icon
				elseif a_group.is_assembly then
					Result := pixmaps.icon_pixmaps.folder_assembly_icon
				else
					check should_not_reach: false end
				end
			else
				if a_group.is_override then
					if a_group.is_readonly then
						Result := pixmaps.icon_pixmaps.folder_override_cluster_readonly_icon
					else
						Result := pixmaps.icon_pixmaps.folder_override_cluster_icon
					end
				elseif a_group.is_cluster then
					if a_group.is_readonly then
						Result := pixmaps.icon_pixmaps.folder_cluster_readonly_icon
					else
						Result := pixmaps.icon_pixmaps.folder_cluster_icon
					end
				elseif a_group.is_library then
					if a_group.is_readonly then
						Result := pixmaps.icon_pixmaps.folder_library_readonly_icon
					else
						Result := pixmaps.icon_pixmaps.folder_library_icon
					end
				elseif a_group.is_assembly then
					Result := pixmaps.icon_pixmaps.folder_assembly_icon
				else
					check should_not_reach: false end
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_class_i (a_class: CLASS_I): EV_PIXMAP is
			-- Return pixmap based on `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			l_compiled_class: CLASS_C
			l_conf_class: CONF_CLASS
			l_classi: CLASS_I
			l_comp: CLASS_C
			l_pixcode: INTEGER
			l_map: HASH_TABLE [EV_PIXMAP, INTEGER]
			l_overrides: ARRAYED_LIST [CONF_CLASS]
		do
			l_conf_class := a_class.config_class
				-- state encoding instead of dozens of ifs
				--
				-- 1 read_only
				-- 2 compiled not deferred
				-- 3 compiled deferred
				-- 4 overriden
				-- 5 does_override
				-- 6 frozen
				-- 7 expanded			
			if a_class.is_read_only then
				l_pixcode := l_pixcode | 0x1
			end

			if a_class.is_compiled then
				l_compiled_class := a_class.compiled_class
			end

			if not l_conf_class.does_override and not l_conf_class.is_overriden and a_class.is_compiled then
				if l_compiled_class.is_deferred then
					l_pixcode := l_pixcode | 0x4
				elseif l_compiled_class.is_expanded then
					l_pixcode := l_pixcode | 0x40
				elseif l_compiled_class.is_frozen then
					l_pixcode := l_pixcode | 0x20
				else
					l_pixcode := l_pixcode | 0x2
				end
			elseif l_conf_class.does_override then
					-- compiled if any class overriden class is compiled
				from
					l_overrides := l_conf_class.overrides
					l_overrides.start
				until
					l_overrides.after or l_comp /= Void
				loop
					if l_overrides.item.is_compiled then
						l_classi ?= l_overrides.item
						check
							classi: l_classi /= Void
						end
						l_comp := l_classi.compiled_class
					end
					l_overrides.forth
				end
				if l_comp /= Void then
					if l_comp.is_deferred then
						l_pixcode := l_pixcode | 0x4
					else
						l_pixcode := l_pixcode | 0x2
					end
				end
			end

			if l_conf_class.is_overriden then
				l_pixcode := l_pixcode | 0x8
			elseif l_conf_class.does_override then
				l_pixcode := l_pixcode | 0x10
			end

				-- add +1 to avoid problem with 0 value key
			l_pixcode := l_pixcode + 1
--			create l_map.make (18)
--			l_map.force (pixmaps.icon_pixmaps.class_normal_icon, 0x2+1)
--			l_map.force (pixmaps.icon_pixmaps.class_frozen_icon, 0x22+1)
--			l_map.force (pixmaps.icon_pixmaps.class_readonly_icon, 0x3+1)
--			l_map.force (pixmaps.icon_pixmaps.class_frozen_readonly_icon, 0x23+1)
--			l_map.force (pixmaps.icon_pixmaps.class_uncompiled_icon, 0+1)
--			l_map.force (pixmaps.icon_pixmaps.class_uncompiled_readonly_icon, 0x1+1)
--			l_map.force (pixmaps.icon_pixmaps.class_deferred_icon, 0x4+1)
--			l_map.force (pixmaps.icon_pixmaps.class_deferred_readonly_icon, 0x5+1)
--			l_map.force (pixmaps.icon_pixmaps.class_overriden_normal_icon, 0xA+1)
--			l_map.force (pixmaps.icon_pixmaps.class_overriden_frozen_icon, 0x2A+1)
--			l_map.force (pixmaps.icon_pixmaps.class_overriden_readonly_icon, 0xB+1)
--			l_map.force (pixmaps.icon_pixmaps.class_overriden_frozen_readonly_icon, 0x2B+1)
--			l_map.force (pixmaps.icon_pixmaps.class_overriden_uncompiled_icon, 0x8+1)
--			l_map.force (pixmaps.icon_pixmaps.class_overriden_uncompiled_readonly_icon, 0x9+1)
--			l_map.force (pixmaps.icon_pixmaps.class_overriden_deferred_icon, 0xC+1)
--			l_map.force (pixmaps.icon_pixmaps.class_overriden_deferred_readonly_icon, 0xD+1)
--			l_map.force (pixmaps.icon_pixmaps.class_override_normal_icon, 0x12+1)
--			l_map.force (pixmaps.icon_pixmaps.class_override_frozen_icon, 0x32+1)
--			l_map.force (pixmaps.icon_pixmaps.class_override_readonly_icon, 0x13+1)
--			l_map.force (pixmaps.icon_pixmaps.class_override_frozen_readonly_icon, 0x33+1)
--			l_map.force (pixmaps.icon_pixmaps.class_override_uncompiled_icon, 0x10+1)
--			l_map.force (pixmaps.icon_pixmaps.class_override_uncompiled_readonly_icon, 0x11+1)
--			l_map.force (pixmaps.icon_pixmaps.class_override_deferred_icon, 0x14+1)
--			l_map.force (pixmaps.icon_pixmaps.class_override_deferred_readonly_icon, 0x15+1)
--
--			l_map.force (pixmaps.icon_pixmaps.expanded_normal_icon, 0x42+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_readonly_icon, 0x43+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_uncompiled_icon, 0x40+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_uncompiled_readonly_icon, 0x41+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_overriden_normal_icon, 0x4A+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_overriden_readonly_icon, 0x4B+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_overriden_uncompiled_icon, 0x48+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_overriden_uncompiled_readonly_icon, 0x49+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_override_normal_icon, 0x52+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_override_readonly_icon, 0x53+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_override_uncompiled_icon, 0x50+1)
--			l_map.force (pixmaps.icon_pixmaps.expanded_override_uncompiled_readonly_icon, 0x51+1)

			check
				correct_pixcode: class_icon_map.has (l_pixcode)
			end

			Result := class_icon_map.item (l_pixcode)
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_e_feature (a_feature: E_FEATURE): EV_PIXMAP is
			-- Sets `a_item' pixmap based on `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		local
			l_name: STRING
		do
			l_name := a_feature.assigner_name
			if l_name = Void or else l_name.is_empty then
				if a_feature.is_attribute then
					if a_feature.is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_attribute_icon
					elseif a_feature.is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_attribute_icon
					else
						Result := pixmaps.icon_pixmaps.feature_attribute_icon
					end
				elseif a_feature.is_deferred then
					if a_feature.is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon
					else
						Result := pixmaps.icon_pixmaps.feature_deferred_icon
					end
				elseif a_feature.is_once or else a_feature.is_constant then
					if a_feature.is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_once_icon
					elseif a_feature.is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_once_icon
					else
						Result := pixmaps.icon_pixmaps.feature_once_icon
					end
				elseif a_feature.is_external then
					if a_feature.associated_class = Void or else not a_feature.associated_class.is_true_external then
						if a_feature.is_obsolete then
							Result := pixmaps.icon_pixmaps.feature_obsolete_external_icon
						elseif a_feature.is_frozen then
							Result := pixmaps.icon_pixmaps.feature_frozen_external_icon
						else
							Result := pixmaps.icon_pixmaps.feature_external_icon
						end
					end
				end
				if Result = Void then
					if a_feature.is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_routine_icon
					elseif a_feature.is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_routine_icon
					else
						Result := pixmaps.icon_pixmaps.feature_routine_icon
					end
				end
			else
				if a_feature.is_deferred then
					if a_feature.is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon
					else
						Result := pixmaps.icon_pixmaps.feature_deferred_icon
					end
				else
					if a_feature.is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_assigner_icon
					elseif a_feature.is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_assigner_icon
					else
						Result := pixmaps.icon_pixmaps.feature_assigner_icon
					end
				end
			end

		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	class_icon_map: HASH_TABLE [EV_PIXMAP, INTEGER] is
			-- Class icon map
		once
			create Result.make (37)
			Result.force (pixmaps.icon_pixmaps.class_normal_icon, 0x2+1)
			Result.force (pixmaps.icon_pixmaps.class_frozen_icon, 0x21+1)
			Result.force (pixmaps.icon_pixmaps.class_readonly_icon, 0x3+1)
			Result.force (pixmaps.icon_pixmaps.class_frozen_readonly_icon, 0x22+1)
			Result.force (pixmaps.icon_pixmaps.class_uncompiled_icon, 0+1)
			Result.force (pixmaps.icon_pixmaps.class_uncompiled_readonly_icon, 0x1+1)
			Result.force (pixmaps.icon_pixmaps.class_deferred_icon, 0x4+1)
			Result.force (pixmaps.icon_pixmaps.class_deferred_readonly_icon, 0x5+1)
			Result.force (pixmaps.icon_pixmaps.class_overriden_normal_icon, 0xA+1)
			Result.force (pixmaps.icon_pixmaps.class_overriden_frozen_icon, 0x29+1)
			Result.force (pixmaps.icon_pixmaps.class_overriden_readonly_icon, 0xB+1)
			Result.force (pixmaps.icon_pixmaps.class_overriden_frozen_readonly_icon, 0x2A+1)
			Result.force (pixmaps.icon_pixmaps.class_overriden_uncompiled_icon, 0x8+1)
			Result.force (pixmaps.icon_pixmaps.class_overriden_uncompiled_readonly_icon, 0x9+1)
			Result.force (pixmaps.icon_pixmaps.class_overriden_deferred_icon, 0xC+1)
			Result.force (pixmaps.icon_pixmaps.class_overriden_deferred_readonly_icon, 0xD+1)
			Result.force (pixmaps.icon_pixmaps.class_override_normal_icon, 0x12+1)
			Result.force (pixmaps.icon_pixmaps.class_override_frozen_icon, 0x31+1)
			Result.force (pixmaps.icon_pixmaps.class_override_readonly_icon, 0x13+1)
			Result.force (pixmaps.icon_pixmaps.class_override_frozen_readonly_icon, 0x32+1)
			Result.force (pixmaps.icon_pixmaps.class_override_uncompiled_icon, 0x10+1)
			Result.force (pixmaps.icon_pixmaps.class_override_uncompiled_readonly_icon, 0x11+1)
			Result.force (pixmaps.icon_pixmaps.class_override_deferred_icon, 0x14+1)
			Result.force (pixmaps.icon_pixmaps.class_override_deferred_readonly_icon, 0x15+1)

			Result.force (pixmaps.icon_pixmaps.expanded_normal_icon, 0x42+1)
			Result.force (pixmaps.icon_pixmaps.expanded_readonly_icon, 0x43+1)
			Result.force (pixmaps.icon_pixmaps.expanded_uncompiled_icon, 0x40+1)
			Result.force (pixmaps.icon_pixmaps.expanded_uncompiled_readonly_icon, 0x41+1)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_normal_icon, 0x4A+1)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_readonly_icon, 0x4B+1)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_uncompiled_icon, 0x48+1)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_uncompiled_readonly_icon, 0x49+1)
			Result.force (pixmaps.icon_pixmaps.expanded_override_normal_icon, 0x52+1)
			Result.force (pixmaps.icon_pixmaps.expanded_override_readonly_icon, 0x53+1)
			Result.force (pixmaps.icon_pixmaps.expanded_override_uncompiled_icon, 0x50+1)
			Result.force (pixmaps.icon_pixmaps.expanded_override_uncompiled_readonly_icon, 0x51+1)
		ensure
			result_attached: Result /= VOid
		end


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
