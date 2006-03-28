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

	pixmap_from_cluster_i (a_group: CONF_GROUP): EV_PIXMAP is
			-- Return pixmap based on `a_group'.
		require
			a_group_not_void: a_group /= Void
		do
			if a_group.is_readonly then
				Result := (Pixmaps.Icon_read_only_cluster)
			else
				Result := (Pixmaps.Icon_cluster_symbol)
			end
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_class_i (a_class: CLASS_I): EV_PIXMAP is
			-- Return pixmap based on `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			conf_todo
--			if
--				a_class.cluster.is_library or else
--				a_class.cluster.is_precompiled or else
--				a_class.is_read_only
--			then
--				if not a_class.compiled then
--					Result := (Pixmaps.Icon_read_only_class_gray)
--				else
--					if a_class.compiled_class.is_deferred then
--						Result := (Pixmaps.Icon_deferred_read_only_class_color)
--					else
--						Result := (Pixmaps.Icon_read_only_class_color)
--					end
--				end
--			else
--				if not a_class.compiled then
--					Result := (Pixmaps.Icon_class_symbol_gray)
--				else
--					if a_class.compiled_class.is_deferred then
--						Result := (Pixmaps.Icon_deferred_class_symbol_color)
--					else
--						Result := (Pixmaps.Icon_class_symbol_color)
--					end
--				end
--			end
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
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
