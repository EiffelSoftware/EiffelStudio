indexing
	description: "Class containing features for retrieving pixmaps for Clusters, Classes and Features"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY

inherit
	EB_CONSTANTS


feature {NONE} -- Implementation

	pixmap_from_cluster_i (a_cluster: CLUSTER_I): EV_PIXMAP is
			-- Return pixmap based on `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			if a_cluster.is_library or else a_cluster.is_precompiled then
				Result := (Pixmaps.Icon_read_only_cluster)
			else
				Result := (Pixmaps.Icon_cluster_symbol @ 1)
			end
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_class_i (a_class: CLASS_I): EV_PIXMAP is
			-- Return pixmap based on `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			if
				a_class.cluster.is_library or else
				a_class.cluster.is_precompiled or else
				a_class.is_read_only
			then
				if not a_class.compiled then
					Result := (Pixmaps.Icon_read_only_class_gray)
				else
					if a_class.compiled_class.is_deferred then
						Result := (Pixmaps.Icon_deferred_read_only_class_color)
					else
						Result := (Pixmaps.Icon_read_only_class_color)
					end
				end
			else
				if not a_class.compiled then
					Result := (Pixmaps.Icon_class_symbol_gray)
				else
					if a_class.compiled_class.is_deferred then
						Result := (Pixmaps.Icon_deferred_class_symbol_color)
					else
						Result := (Pixmaps.Icon_class_symbol_color)
					end
				end
			end
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
				if a_feature.is_obsolete then
					Result := Pixmaps.Icon_external_obsolete_feature
				elseif a_feature.is_frozen then
					Result := Pixmaps.Icon_external_frozen_feature
				else
					Result := Pixmaps.Icon_external_feature
				end
			else
				if a_feature.is_obsolete then
					Result := Pixmaps.Icon_obsolete_feature
				elseif a_feature.is_frozen then
					Result := Pixmaps.Icon_frozen_feature
				else
					Result := Pixmaps.Icon_feature @ 1
				end
			end
		ensure
			result_not_void: Result /= Void
		end

end
