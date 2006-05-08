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
					Result := pixmaps.icon_override_folder_symbol
				elseif a_group.is_cluster then
					Result := pixmaps.icon_folder_symbol
				elseif a_group.is_assembly then
					Result := pixmaps.icon_assembly_namespace
				else
					check should_not_reach: false end
				end
			else
				if a_group.is_override then
					if a_group.is_readonly then
						Result := Pixmaps.icon_read_only_override
					else
						Result := Pixmaps.icon_override_symbol
					end
				elseif a_group.is_cluster then
					if a_group.is_readonly then
						Result := Pixmaps.Icon_read_only_cluster
					else
						Result := Pixmaps.Icon_cluster_symbol
					end
				elseif a_group.is_library then
					if a_group.is_readonly then
						Result := Pixmaps.icon_read_only_library
					else
						Result := Pixmaps.icon_library_symbol
					end
				elseif a_group.is_assembly then
					Result := Pixmaps.icon_read_only_assembly
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
				--				
			if a_class.is_read_only then
				l_pixcode := l_pixcode | 0x1
			end

			if not l_conf_class.does_override and not l_conf_class.is_overriden and a_class.is_compiled then
				if a_class.compiled_class.is_deferred then
					l_pixcode := l_pixcode | 0x4
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
			create l_map.make (18)
			l_map.force (pixmaps.icon_class_symbol, 0x2+1)
			l_map.force (pixmaps.icon_read_only_class_color, 0x3+1)
			l_map.force (pixmaps.icon_class_symbol_gray, 0+1)
			l_map.force (pixmaps.icon_read_only_class_gray, 0x1+1)
			l_map.force (pixmaps.icon_deferred_class_symbol_color, 0x4+1)
			l_map.force (pixmaps.icon_deferred_read_only_class_color, 0x5+1)
			l_map.force (pixmaps.icon_overriden_class, 0xA+1)
			l_map.force (pixmaps.icon_overriden_light_class, 0xB+1)
			l_map.force (pixmaps.icon_overriden_grey_class, 0x8+1)
			l_map.force (pixmaps.icon_overriden_light_grey_class, 0x9+1)
			l_map.force (pixmaps.icon_overriden_deferred_class, 0xC+1)
			l_map.force (pixmaps.icon_overriden_deferred_light_class, 0xD+1)
			l_map.force (pixmaps.icon_overrider_class, 0x12+1)
			l_map.force (pixmaps.icon_overrider_light_class, 0x13+1)
			l_map.force (pixmaps.icon_overrider_grey_class, 0x10+1)
			l_map.force (pixmaps.icon_overrider_light_grey_class, 0x11+1)
			l_map.force (pixmaps.icon_overrider_deferred_class, 0x14+1)
			l_map.force (pixmaps.icon_overrider_deferred_light_class, 0x15+1)

			check
				correct_pixcode: l_map.has (l_pixcode)
			end

			Result := l_map.item (l_pixcode)
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_e_feature (a_feature: E_FEATURE): EV_PIXMAP is
			-- Sets `a_item' pixmap based on `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		do
			if a_feature.is_attribute then
				if a_feature.is_obsolete then
					Result := Pixmaps.Icon_obsolete_attribute
				elseif a_feature.is_frozen then
					Result := Pixmaps.Icon_frozen_attribute
				else
					Result := Pixmaps.Icon_attributes
				end
			elseif a_feature.is_deferred then
				if a_feature.is_obsolete then
					Result := Pixmaps.Icon_deferred_obsolete_feature
				else
					Result := Pixmaps.Icon_deferred_feature
				end
			elseif a_feature.is_once or else a_feature.is_constant then
				if a_feature.is_obsolete then
					Result := Pixmaps.Icon_once_obsolete_objects
				elseif a_feature.is_frozen then
					Result := Pixmaps.Icon_once_frozen_objects
				else
					Result := Pixmaps.Icon_once_objects
				end
			elseif a_feature.is_external then
				if a_feature.associated_class = Void or else not a_feature.associated_class.is_true_external then
					if a_feature.is_obsolete then
						Result := Pixmaps.Icon_external_obsolete_feature
					elseif a_feature.is_frozen then
						Result := Pixmaps.Icon_external_frozen_feature
					else
						Result := Pixmaps.Icon_external_feature
					end
				end
			end
			if Result = Void then
				if a_feature.is_obsolete then
					Result := Pixmaps.Icon_obsolete_feature
				elseif a_feature.is_frozen then
					Result := Pixmaps.Icon_frozen_feature
				else
					Result := Pixmaps.Icon_feature
				end
			end
		ensure
			result_not_void: Result /= Void
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
