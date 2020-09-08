note
	description: "Class containing features for retrieving pixmaps for Clusters, Classes and Features"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY

inherit
	EB_CONSTANTS

feature -- Query (Pixmap)

	pixmap_from_group (a_group: CONF_GROUP): EV_PIXMAP
		require
			a_group_not_void: a_group /= Void
		do
			Result := pixmaps.configuration_pixmaps.pixmap_from_group (a_group)
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_group_path (a_group: CONF_GROUP; a_path: READABLE_STRING_GENERAL): EV_PIXMAP
		require
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
			path_implies_not_library: not a_path.is_empty implies not a_group.is_library
		do
			Result := pixmaps.configuration_pixmaps.pixmap_from_group_path (a_group, a_path)
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_class_i (a_class: CLASS_I): EV_PIXMAP
			-- Return pixmap based on `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			l_compiled_class: CLASS_C
			l_conf_class: CONF_CLASS
			l_comp: CLASS_C
			l_pixcode: like none_flag
			l_overrides: ARRAYED_LIST [CONF_CLASS]
			l_overrides_valid: BOOLEAN
		do
			l_conf_class := a_class.config_class

			if a_class.is_read_only then
				l_pixcode := l_pixcode | readonly_flag
			end
			if a_class.is_compiled then
				l_pixcode := l_pixcode | compiled_flag
				l_compiled_class := a_class.compiled_class
				if l_compiled_class.is_expanded then
					l_pixcode := l_pixcode | expanded_flag
				elseif l_compiled_class.is_frozen then
					l_pixcode := l_pixcode | frozen_flag
				elseif l_compiled_class.is_deferred then
					l_pixcode := l_pixcode | deferred_flag
				elseif l_compiled_class.is_once then
					l_pixcode := l_pixcode | once_flag
				end
			end
			if l_conf_class.does_override then
				l_pixcode := l_pixcode | overrides_flag

					-- compiled if any class overriden class is compiled
				from
					l_overrides := l_conf_class.overrides
					l_overrides.start
				until
					l_overrides.after or l_comp /= Void
				loop
					if l_overrides.item.is_valid then
						l_overrides_valid := True
						if l_overrides.item.is_compiled then
							if attached {CLASS_I} l_overrides.item as l_classi then
								l_comp := l_classi.compiled_class
							else
								check is_classi: False end
							end
						end
					end
					l_overrides.forth
				end
				if l_overrides_valid then
					if l_comp = Void then
							-- No compiled version
						l_pixcode := l_pixcode & compiled_flag.bit_not
					else
						l_pixcode := l_pixcode | compiled_flag
					end
				end
			elseif l_conf_class.is_overriden and then l_conf_class.overriden_by.is_valid then
				l_pixcode := l_pixcode | overriden_flag
			end
			if l_pixcode = 0 then
				l_pixcode := none_flag
			end

			check correct_pixcode: class_icon_map.has (l_pixcode) end
			Result := class_icon_map.item (l_pixcode)
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_e_feature (a_feature: E_FEATURE): EV_PIXMAP
			-- Sets `a_item' pixmap based on `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		local
			l_name: STRING_32
			l_is_instance_free: BOOLEAN
			w: WEAK_REFERENCE [EV_PIXMAP]
		do
				-- Attempt to retieve an existing pixmap.
			w := feature_kind_pixmap [feature_kind_from_e_feature (a_feature)]
			Result := w.item
			if not attached Result then
					-- Compute pixmap.
				l_is_instance_free := a_feature.is_class
				l_name := a_feature.assigner_name_32
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
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_deferred_icon
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_deferred_icon
						else
							Result := pixmaps.icon_pixmaps.feature_deferred_icon
						end
					elseif a_feature.is_once then
						if a_feature.is_obsolete then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_once_icon
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_once_icon
							end
						elseif a_feature.is_frozen then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_frozen_instance_free_once_icon
							else
								Result := pixmaps.icon_pixmaps.feature_frozen_once_icon
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_deferred_icon
						else
							Result := pixmaps.icon_pixmaps.feature_once_icon
						end
					elseif a_feature.is_constant then
						if a_feature.is_obsolete then
							Result := pixmaps.icon_pixmaps.feature_obsolete_constant_icon
						else
							Result := pixmaps.icon_pixmaps.feature_constant_icon
						end
					elseif a_feature.is_external then
						if a_feature.associated_class = Void or else not a_feature.associated_class.is_true_external then
							if a_feature.is_obsolete then
								if l_is_instance_free then
									Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_external_icon
								else
									Result := pixmaps.icon_pixmaps.feature_obsolete_external_icon
								end
							elseif a_feature.is_frozen then
								if l_is_instance_free then
									Result := pixmaps.icon_pixmaps.feature_frozen_instance_free_external_icon
								else
									Result := pixmaps.icon_pixmaps.feature_frozen_external_icon
								end
							elseif l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_instance_free_external_icon
							else
								Result := pixmaps.icon_pixmaps.feature_external_icon
							end
						end
					end
					if Result = Void then
						if a_feature.is_obsolete then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_routine_icon
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_routine_icon
							end
						elseif a_feature.is_frozen then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_frozen_instance_free_routine_icon
							else
								Result := pixmaps.icon_pixmaps.feature_frozen_routine_icon
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_routine_icon
						else
							Result := pixmaps.icon_pixmaps.feature_routine_icon
						end
					end
				else
					if a_feature.is_deferred then
						if a_feature.is_obsolete then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_deferred_icon
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_deferred_icon
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
				if a_feature.is_ghost then
						-- Build pixmap from pixel buffer.
					Result := pixel_buffer_from_e_feature (a_feature).to_pixmap
				end
					-- Store computed pixmap for next time.
				w.put (Result)
			end
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_feature_ast (is_class_external: BOOLEAN; a_feature_as: FEATURE_AS; a_name_pos: INTEGER): EV_PIXMAP
			-- Pixmaps from features.
		require
			a_feature_as_not_void: a_feature_as /= Void
			a_feature_has_name: a_feature_as.feature_names /= Void
			a_name_pos_valid: a_name_pos >= 1 and a_name_pos <= a_feature_as.feature_names.count
		local
			a_name: FEATURE_NAME
			a_body: BODY_AS
			a_routine: ROUTINE_AS
			l_is_obsolete: BOOLEAN
			l_is_frozen: BOOLEAN
			l_assinger: BOOLEAN
			l_is_instance_free: BOOLEAN
			w: WEAK_REFERENCE [EV_PIXMAP]
			l_icon_pixmaps: like pixmaps.icon_pixmaps
		do
				-- Attempt to retieve an existing pixmap.
			w := feature_kind_pixmap [feature_kind_from_feature_ast (a_feature_as, is_class_external, a_name_pos)]
			Result := w.item
			if not attached Result then
					-- Compute pixmap.
				a_name := a_feature_as.feature_names.i_th (a_name_pos)
				a_body := a_feature_as.body
				l_assinger := a_body.assigner /= Void and then not a_body.assigner.name_8.is_empty
				if attached {ROUTINE_AS} a_body.content as l_routine_as then
					a_routine := l_routine_as
				end
				l_is_obsolete := a_routine /= Void and then a_routine.obsolete_message /= Void
				l_is_frozen := a_name.is_frozen
				l_is_instance_free := a_routine /= Void and then a_routine.has_class_postcondition

				l_icon_pixmaps := pixmaps.icon_pixmaps
				if not l_assinger then
					if a_feature_as.is_attribute then
						if l_is_obsolete then
							Result := l_icon_pixmaps.feature_obsolete_attribute_icon
						elseif l_is_frozen then
							Result := l_icon_pixmaps.feature_frozen_attribute_icon
						else
							Result := l_icon_pixmaps.feature_attribute_icon
						end
					elseif a_feature_as.is_deferred then
						if l_is_obsolete then
							if l_is_instance_free then
								Result := l_icon_pixmaps.feature_obsolete_instance_free_deferred_icon
							else
								Result := l_icon_pixmaps.feature_obsolete_deferred_icon
							end
						elseif l_is_instance_free then
							Result := l_icon_pixmaps.feature_instance_free_deferred_icon
						else
							Result := l_icon_pixmaps.feature_deferred_icon
						end
					elseif a_routine /= Void and then a_routine.is_once then
						if l_is_obsolete then
							if l_is_instance_free then
								Result := l_icon_pixmaps.feature_obsolete_instance_free_once_icon
							else
								Result := l_icon_pixmaps.feature_obsolete_once_icon
							end
						elseif l_is_frozen then
							if l_is_instance_free then
								Result := l_icon_pixmaps.feature_frozen_instance_free_once_icon
							else
								Result := l_icon_pixmaps.feature_frozen_once_icon
							end
						elseif l_is_instance_free then
							Result := l_icon_pixmaps.feature_instance_free_once_icon
						else
							Result := l_icon_pixmaps.feature_once_icon
						end
					elseif a_feature_as.is_constant then
						if l_is_obsolete then
							Result := l_icon_pixmaps.feature_obsolete_constant_icon
						else
							Result := l_icon_pixmaps.feature_constant_icon
						end
					elseif not is_class_external then
						if a_routine /= Void and then a_routine.is_external then
							if l_is_obsolete then
								if l_is_instance_free then
									Result := l_icon_pixmaps.feature_obsolete_instance_free_external_icon
								else
									Result := l_icon_pixmaps.feature_obsolete_external_icon
								end
							elseif l_is_frozen then
								if l_is_instance_free then
									Result := l_icon_pixmaps.feature_frozen_instance_free_external_icon
								else
									Result := l_icon_pixmaps.feature_frozen_external_icon
								end
							elseif l_is_instance_free then
								Result := l_icon_pixmaps.feature_instance_free_external_icon
							else
								Result := l_icon_pixmaps.feature_external_icon
							end
						end
					end
					if Result = Void then
						if l_is_obsolete then
							if l_is_instance_free then
								Result := l_icon_pixmaps.feature_obsolete_instance_free_routine_icon
							else
								Result := l_icon_pixmaps.feature_obsolete_routine_icon
							end
						elseif l_is_frozen then
							if l_is_instance_free then
								Result := l_icon_pixmaps.feature_frozen_instance_free_routine_icon
							else
								Result := l_icon_pixmaps.feature_frozen_routine_icon
							end
						elseif l_is_instance_free then
							Result := l_icon_pixmaps.feature_instance_free_routine_icon
						else
							Result := l_icon_pixmaps.feature_routine_icon
						end
					end
				else
					if l_is_obsolete then
						Result := l_icon_pixmaps.feature_obsolete_assigner_icon
					elseif l_is_frozen then
						Result := l_icon_pixmaps.feature_frozen_assigner_icon
					else
						Result := l_icon_pixmaps.feature_assigner_icon
					end
				end
				if attached a_feature_as.indexes as i and then i.is_ghost then
						-- Build pixmap from pixel buffer.
					Result := pixel_buffer_from_feature_ast (is_class_external, a_feature_as, a_name_pos).to_pixmap
				end
					-- Store computed pixmap for next time.
				w.put (Result)
			end
		ensure
			result_not_void: Result /= Void
		end

	pixmap_for_query_language_item (a_item: QL_ITEM): EV_PIXMAP
			-- Pixmap for `a_item'
		require
			a_item_attached: a_item /= Void
		do
			if a_item.is_target then
				Result := pixmaps.icon_pixmaps.metric_unit_target_icon
			elseif attached {QL_GROUP} a_item as g then
				Result := pixmap_from_group (g.group)
			elseif attached {QL_CLASS} a_item as c then
				Result := pixmap_from_class_i (c.class_i)
			elseif a_item.is_generic then
				Result := pixmaps.icon_pixmaps.metric_unit_generic_icon
			elseif attached {QL_REAL_FEATURE} a_item as f then
				Result := pixmap_from_e_feature (f.e_feature)
			elseif a_item.is_invariant_feature then
				Result := pixmaps.icon_pixmaps.class_features_invariant_icon
			elseif a_item.is_argument or a_item.is_local then
				Result := pixmaps.icon_pixmaps.metric_unit_local_or_argument_icon
			elseif a_item.is_assertion then
				Result := pixmaps.icon_pixmaps.metric_unit_assertion_icon
			elseif a_item.is_line then
				Result := pixmaps.icon_pixmaps.metric_unit_line_icon
			else
				Result := pixmaps.icon_pixmaps.general_blank_icon
			end
		ensure
			result_attached: Result /= Void
		end

	pixmap_from_stone (a_stone: STONE): detachable EV_PIXMAP
			-- Retrieves a pixmap for a given stone object
		require
			a_stone_attached: a_stone /= Void
		do
			if attached {ERROR_STONE} a_stone as l_error then
				if attached {WARNING} l_error.error_i then
					Result := pixmaps.icon_pixmaps.general_warning_icon
				else
					Result := pixmaps.icon_pixmaps.general_error_icon
				end
			elseif attached {FEATURE_STONE} a_stone as l_feature then
				Result := pixmap_from_e_feature (l_feature.e_feature)
			elseif attached {CLASSI_STONE} a_stone as l_classi then
				Result := pixmap_from_class_i (l_classi.class_i)
			elseif attached {FILED_STONE} a_stone as l_filed then
				Result := pixmaps.icon_pixmaps.general_document_icon
			elseif attached {CLUSTER_STONE} a_stone as l_group then
				Result := pixmap_from_group (l_group.group)
			end
		ensure
			not_result_is_destroyed: Result /= Void implies not Result.is_destroyed
		end

	eis_decorated_pixmap (a_pixmap: EV_PIXMAP): EV_PIXMAP
			-- Pixmap with an EIS sign on it
		require
			a_pixmap_not_void: a_pixmap /= Void
		local
			l_buffer, l_original_buffer: EV_PIXEL_BUFFER
		do
				-- This is a workaround of drawing pixmap via pixel buffer.
				-- Direct draw on pixmap results in black area at the interseption of the transparent part
				-- of original pixmap and pixels of the pixmap being drawn with.
			l_buffer := pixmaps.icon_pixmaps.information_with_info_sign_icon_buffer
			create l_original_buffer.make_with_pixmap (a_pixmap)
			l_original_buffer.draw_pixel_buffer_with_x_y (0, 0, l_buffer)
			Result := l_original_buffer.to_pixmap
		ensure
			Result_set: Result /= Void
		end

feature -- Query (Pixel buffer)

	pixel_buffer_from_class_i (a_class: CLASS_I): EV_PIXEL_BUFFER
			-- Return pixmap based on `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			l_compiled_class: CLASS_C
			l_conf_class: CONF_CLASS
			l_comp: CLASS_C
			l_pixcode: like none_flag
			l_overrides: ARRAYED_LIST [CONF_CLASS]
			l_overrides_valid: BOOLEAN
		do
			l_conf_class := a_class.config_class

			if a_class.is_read_only then
				l_pixcode := l_pixcode | readonly_flag
			end
			if a_class.is_compiled then
				l_pixcode := l_pixcode | compiled_flag
				l_compiled_class := a_class.compiled_class
				if l_compiled_class.is_expanded then
					l_pixcode := l_pixcode | expanded_flag
				elseif l_compiled_class.is_frozen then
					l_pixcode := l_pixcode | frozen_flag
				elseif l_compiled_class.is_deferred then
					l_pixcode := l_pixcode | deferred_flag
				elseif l_compiled_class.is_once then
					l_pixcode := l_pixcode | once_flag
				end
			end
			if l_conf_class.does_override then
				l_pixcode := l_pixcode | overrides_flag

					-- compiled if any class overriden class is compiled
				from
					l_overrides := l_conf_class.overrides
					l_overrides.start
				until
					l_overrides.after or l_comp /= Void
				loop
					if l_overrides.item.is_valid then
						l_overrides_valid := True
						if
							l_overrides.item.is_compiled and then
							attached {CLASS_I} l_overrides.item as l_classi
						then
							l_comp := l_classi.compiled_class
						end
					end
					l_overrides.forth
				end
				if l_overrides_valid then
					if l_comp = Void then
							-- No compiled version
						l_pixcode := l_pixcode & compiled_flag.bit_not
					else
						l_pixcode := l_pixcode | compiled_flag
					end
				end
			elseif l_conf_class.is_overriden and then l_conf_class.overriden_by.is_valid then
				l_pixcode := l_pixcode | overriden_flag
			end
			if l_pixcode = 0 then
				l_pixcode := none_flag
			end
			check correct_pixcode: class_icon_map.has (l_pixcode) end
			Result := class_icon_map_pixel_buffer.item (l_pixcode)
		ensure
			result_not_void: Result /= Void
		end

	pixel_buffer_from_e_feature (a_feature: E_FEATURE): EV_PIXEL_BUFFER
			-- Sets `a_item' pixmap based on `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		local
			l_name: STRING_32
			l_is_instance_free: BOOLEAN
			w: WEAK_REFERENCE [EV_PIXEL_BUFFER]
		do
				-- Attempt to retieve an existing pixel buffer.
			w := feature_kind_pixel_buffer [feature_kind_from_e_feature (a_feature)]
			Result := w.item
			if not attached Result then
					-- Compute pixel buffer.
				l_is_instance_free := a_feature.is_class
				l_name := a_feature.assigner_name_32
				if l_name = Void or else l_name.is_empty then
					if a_feature.is_attribute then
						if a_feature.is_obsolete then
							Result := pixmaps.icon_pixmaps.feature_obsolete_attribute_icon_buffer
						elseif a_feature.is_frozen then
							Result := pixmaps.icon_pixmaps.feature_frozen_attribute_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_attribute_icon_buffer
						end
					elseif a_feature.is_deferred then
						if a_feature.is_obsolete then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_deferred_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon_buffer
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_deferred_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_deferred_icon_buffer
						end
					elseif a_feature.is_once then
						if a_feature.is_obsolete then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_once_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_once_icon_buffer
							end
						elseif a_feature.is_frozen then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_frozen_instance_free_once_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_frozen_once_icon_buffer
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_once_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_once_icon_buffer
						end
					elseif a_feature.is_constant then
						if a_feature.is_obsolete then
							Result := pixmaps.icon_pixmaps.feature_obsolete_constant_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_constant_icon_buffer
						end
					elseif a_feature.is_external then
						if a_feature.associated_class = Void or else not a_feature.associated_class.is_true_external then
							if a_feature.is_obsolete then
								if l_is_instance_free then
									Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_external_icon_buffer
								else
									Result := pixmaps.icon_pixmaps.feature_obsolete_external_icon_buffer
								end
							elseif a_feature.is_frozen then
								if l_is_instance_free then
									Result := pixmaps.icon_pixmaps.feature_frozen_instance_free_external_icon_buffer
								else
									Result := pixmaps.icon_pixmaps.feature_frozen_external_icon_buffer
								end
							elseif l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_instance_free_external_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_external_icon_buffer
							end
						end
					end
					if Result = Void then
						if a_feature.is_obsolete then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_routine_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_routine_icon_buffer
							end
						elseif a_feature.is_frozen then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_frozen_instance_free_routine_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_frozen_routine_icon_buffer
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_routine_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_routine_icon_buffer
						end
					end
				else
					if a_feature.is_deferred then
						if a_feature.is_obsolete then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_deferred_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon_buffer
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_deferred_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_deferred_icon_buffer
						end
					else
						if a_feature.is_obsolete then
							Result := pixmaps.icon_pixmaps.feature_obsolete_assigner_icon_buffer
						elseif a_feature.is_frozen then
							Result := pixmaps.icon_pixmaps.feature_frozen_assigner_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_assigner_icon_buffer
						end
					end
				end
				if a_feature.is_ghost then
						-- Duplicate the original.
					Result := Result.sub_pixel_buffer (Result.area)
						-- Draw a ghost indicator.
					Result.draw_pixel_buffer_with_x_y (0, 0, pixmaps.icon_pixmaps.overlay_verifier_right_icon_buffer)
				end
					-- Store computed pixel buffer for next time.
				w.put (Result)
			end
		ensure
			result_not_void: Result /= Void
		end

	pixel_buffer_from_feature_ast (is_class_external: BOOLEAN; a_feature_as: FEATURE_AS; a_name_pos: INTEGER): EV_PIXEL_BUFFER
			-- Pixmaps from features.
		require
			a_feature_as_not_void: a_feature_as /= Void
			a_feature_has_name: a_feature_as.feature_names /= Void
			a_name_pos_valid: a_name_pos >= 1 and a_name_pos <= a_feature_as.feature_names.count
		local
			a_name: FEATURE_NAME
			a_body: BODY_AS
			a_routine: ROUTINE_AS
			l_is_obsolete: BOOLEAN
			l_is_frozen: BOOLEAN
			l_assinger: BOOLEAN
			l_is_instance_free: BOOLEAN
			w: WEAK_REFERENCE [EV_PIXEL_BUFFER]
		do
				-- Attempt to retieve an existing pixel buffer.
			w := feature_kind_pixel_buffer [feature_kind_from_feature_ast (a_feature_as, is_class_external, a_name_pos)]
			Result := w.item
			if not attached Result then
					-- Compute pixel buffer.
				a_name := a_feature_as.feature_names.i_th (a_name_pos)
				a_body := a_feature_as.body
				l_assinger := a_body.assigner /= Void and then not a_body.assigner.name_8.is_empty
				a_routine := {ROUTINE_AS} / a_body.content
				l_is_obsolete := a_routine /= Void and then a_routine.obsolete_message /= Void
				l_is_frozen := a_name.is_frozen
				l_is_instance_free := a_routine /= Void and then a_routine.has_class_postcondition

				if not l_assinger then
					if a_feature_as.is_attribute then
						if l_is_obsolete then
							Result := pixmaps.icon_pixmaps.feature_obsolete_attribute_icon_buffer
						elseif l_is_frozen then
							Result := pixmaps.icon_pixmaps.feature_frozen_attribute_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_attribute_icon_buffer
						end
					elseif a_feature_as.is_deferred then
						if l_is_obsolete then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_deferred_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon_buffer
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_deferred_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_deferred_icon_buffer
						end
					elseif a_routine /= Void and then a_routine.is_once then
						if l_is_obsolete then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_once_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_once_icon_buffer
							end
						elseif l_is_frozen then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_frozen_instance_free_once_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_frozen_once_icon_buffer
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_once_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_once_icon_buffer
						end
					elseif a_feature_as.is_constant then
						if l_is_obsolete then
							Result := pixmaps.icon_pixmaps.feature_obsolete_constant_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_constant_icon_buffer
						end
					elseif not is_class_external then
						if a_routine /= Void and then a_routine.is_external then
							if l_is_obsolete then
								if l_is_instance_free then
									Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_external_icon_buffer
								else
									Result := pixmaps.icon_pixmaps.feature_obsolete_external_icon_buffer
								end
							elseif l_is_frozen then
								if l_is_instance_free then
									Result := pixmaps.icon_pixmaps.feature_frozen_instance_free_external_icon_buffer
								else
									Result := pixmaps.icon_pixmaps.feature_frozen_external_icon_buffer
								end
							elseif l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_instance_free_external_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_external_icon_buffer
							end
						end
					end
					if Result = Void then
						if l_is_obsolete then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_obsolete_instance_free_routine_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_obsolete_routine_icon_buffer
							end
						elseif l_is_frozen then
							if l_is_instance_free then
								Result := pixmaps.icon_pixmaps.feature_frozen_instance_free_routine_icon_buffer
							else
								Result := pixmaps.icon_pixmaps.feature_frozen_routine_icon_buffer
							end
						elseif l_is_instance_free then
							Result := pixmaps.icon_pixmaps.feature_instance_free_routine_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_routine_icon_buffer
						end
					end
				else
					if l_is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_assigner_icon_buffer
					elseif l_is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_assigner_icon_buffer
					else
						Result := pixmaps.icon_pixmaps.feature_assigner_icon_buffer
					end
				end
				if attached a_feature_as.indexes as i and then i.is_ghost then
						-- Duplicate the original.
					Result := Result.sub_pixel_buffer (Result.area)
						-- Draw a ghost indicator.
					Result.draw_pixel_buffer_with_x_y (0, 0, pixmaps.icon_pixmaps.overlay_verifier_right_icon_buffer)
				end
					-- Store computed pixel buffer for next time.
				w.put (Result)
			end
		ensure
			result_not_void: Result /= Void
		end

	pixel_buffer_from_stone (a_stone: STONE): detachable EV_PIXEL_BUFFER
			-- Retrieves a pixel buffer for a given stone object
		require
			a_stone_attached: a_stone /= Void
		do
			if attached {ERROR_STONE} a_stone as l_error then
				if attached {WARNING} l_error.error_i then
					Result := pixmaps.icon_pixmaps.general_warning_icon_buffer
				else
					Result := pixmaps.icon_pixmaps.general_error_icon_buffer
				end
			elseif attached {FEATURE_STONE} a_stone as l_feature then
				Result := pixel_buffer_from_e_feature (l_feature.e_feature)
			elseif attached {CLASSI_STONE} a_stone as l_classi then
				Result := pixel_buffer_from_class_i (l_classi.class_i)
			elseif attached {FILED_STONE} a_stone as l_filed then
				Result := pixmaps.icon_pixmaps.general_document_icon_buffer
			elseif attached {CLUSTER_STONE} a_stone as l_group then
				create Result.make_with_pixmap (pixmap_from_group (l_group.group))
			end
		ensure
			not_result_is_destroyed: Result /= Void implies not Result.is_destroyed
		end

feature {NONE} -- Access

	class_icon_map: HASH_TABLE [EV_PIXMAP, NATURAL_16]
			-- Class icon map
		once
			create Result.make (37)
			Result.force (pixmaps.icon_pixmaps.class_normal_icon,							compiled_flag)
			Result.force (pixmaps.icon_pixmaps.class_readonly_icon,							compiled_flag | readonly_flag)
			Result.force (pixmaps.icon_pixmaps.class_frozen_icon,							compiled_flag | frozen_flag)
			Result.force (pixmaps.icon_pixmaps.class_frozen_readonly_icon,					compiled_flag | readonly_flag | frozen_flag)
			Result.force (pixmaps.icon_pixmaps.class_uncompiled_icon,						none_flag)
			Result.force (pixmaps.icon_pixmaps.class_uncompiled_readonly_icon,				readonly_flag)
			Result.force (pixmaps.icon_pixmaps.class_deferred_icon,							compiled_flag | deferred_flag)
			Result.force (pixmaps.icon_pixmaps.class_deferred_readonly_icon,				compiled_flag | readonly_flag | deferred_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_normal_icon,					compiled_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_readonly_icon,				compiled_flag | readonly_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_frozen_icon,					compiled_flag | frozen_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_frozen_readonly_icon,		compiled_flag | frozen_flag | readonly_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_uncompiled_icon,				overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_uncompiled_readonly_icon,	readonly_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_deferred_icon,				compiled_flag | deferred_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_deferred_readonly_icon,		compiled_flag | readonly_flag | deferred_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_normal_icon,					compiled_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_readonly_icon,				compiled_flag | readonly_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_frozen_icon,					compiled_flag | frozen_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_frozen_readonly_icon,			compiled_flag | frozen_flag | readonly_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_uncompiled_icon,				overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_uncompiled_readonly_icon,		readonly_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_deferred_icon,				compiled_flag | deferred_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_deferred_readonly_icon,		compiled_flag | readonly_flag | deferred_flag | overrides_flag)

			Result.force (pixmaps.icon_pixmaps.expanded_normal_icon,						compiled_flag | expanded_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_readonly_icon,						compiled_flag | expanded_flag | readonly_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_uncompiled_icon,					expanded_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_uncompiled_readonly_icon,			expanded_flag | readonly_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_normal_icon,				compiled_flag | expanded_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_readonly_icon,			compiled_flag | expanded_flag | readonly_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_uncompiled_icon,			expanded_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_uncompiled_readonly_icon,	expanded_flag | readonly_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_override_normal_icon,				compiled_flag | expanded_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_override_readonly_icon,				compiled_flag | expanded_flag | readonly_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_override_uncompiled_icon,			expanded_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_override_uncompiled_readonly_icon,	expanded_flag | readonly_flag | overrides_flag)
		ensure
			result_attached: attached Result
		end

	class_icon_map_pixel_buffer: HASH_TABLE [EV_PIXEL_BUFFER, NATURAL_16]
			-- Class icon map
		once
			create Result.make (37)
			Result.force (pixmaps.icon_pixmaps.class_normal_icon_buffer,							compiled_flag)
			Result.force (pixmaps.icon_pixmaps.class_readonly_icon_buffer,							compiled_flag | readonly_flag)
			Result.force (pixmaps.icon_pixmaps.class_frozen_icon_buffer,							compiled_flag | frozen_flag)
			Result.force (pixmaps.icon_pixmaps.class_frozen_readonly_icon_buffer,					compiled_flag | readonly_flag | frozen_flag)
			Result.force (pixmaps.icon_pixmaps.class_uncompiled_icon_buffer,						none_flag)
			Result.force (pixmaps.icon_pixmaps.class_uncompiled_readonly_icon_buffer,				readonly_flag)
			Result.force (pixmaps.icon_pixmaps.class_deferred_icon_buffer,							compiled_flag | deferred_flag)
			Result.force (pixmaps.icon_pixmaps.class_deferred_readonly_icon_buffer,				compiled_flag | readonly_flag | deferred_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_normal_icon_buffer,					compiled_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_readonly_icon_buffer,				compiled_flag | readonly_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_frozen_icon_buffer,					compiled_flag | frozen_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_frozen_readonly_icon_buffer,		compiled_flag | frozen_flag | readonly_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_uncompiled_icon_buffer,				overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_uncompiled_readonly_icon_buffer,	readonly_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_deferred_icon_buffer,				compiled_flag | deferred_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_overriden_deferred_readonly_icon_buffer,		compiled_flag | readonly_flag | deferred_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_normal_icon_buffer,					compiled_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_readonly_icon_buffer,				compiled_flag | readonly_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_frozen_icon_buffer,					compiled_flag | frozen_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_frozen_readonly_icon_buffer,			compiled_flag | frozen_flag | readonly_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_uncompiled_icon_buffer,				overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_uncompiled_readonly_icon_buffer,		readonly_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_deferred_icon_buffer,				compiled_flag | deferred_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.class_override_deferred_readonly_icon_buffer,		compiled_flag | readonly_flag | deferred_flag | overrides_flag)

			Result.force (pixmaps.icon_pixmaps.expanded_normal_icon_buffer,						compiled_flag | expanded_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_readonly_icon_buffer,						compiled_flag | expanded_flag | readonly_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_uncompiled_icon_buffer,					expanded_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_uncompiled_readonly_icon_buffer,			expanded_flag | readonly_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_normal_icon_buffer,				compiled_flag | expanded_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_readonly_icon_buffer,			compiled_flag | expanded_flag | readonly_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_uncompiled_icon_buffer,			expanded_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_overriden_uncompiled_readonly_icon_buffer,	expanded_flag | readonly_flag | overriden_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_override_normal_icon_buffer,				compiled_flag | expanded_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_override_readonly_icon_buffer,				compiled_flag | expanded_flag | readonly_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_override_uncompiled_icon_buffer,			expanded_flag | overrides_flag)
			Result.force (pixmaps.icon_pixmaps.expanded_override_uncompiled_readonly_icon_buffer,	expanded_flag | readonly_flag | overrides_flag)
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Implementation

	none_flag:  NATURAL_16 = 0x01
	compiled_flag: NATURAL_16 = 0x02
	deferred_flag: NATURAL_16 = 0x04
	expanded_flag: NATURAL_16 = 0x08
	once_flag: NATURAL_16 = 0x010
	frozen_flag: NATURAL_16 = 0x020
	overrides_flag: NATURAL_16 = 0x40
	overriden_flag: NATURAL_16 = 0x80
	readonly_flag: NATURAL_16 = 0x100
		-- Class icon state flags		

feature {NONE} -- Feature icons

	feature_kind_pixel_buffer: SPECIAL [WEAK_REFERENCE [EV_PIXEL_BUFFER]]
			-- Pixel buffers for features indexed by their kind.
		once
				-- Allocate storage.
			Result := (create {ARRAY [WEAK_REFERENCE [EV_PIXEL_BUFFER]]}.make_filled (create {WEAK_REFERENCE [EV_PIXEL_BUFFER]}, 0, feature_all_mask)).area
				-- Fill it with different elements.
			across
				Result as w
			loop
				Result [w.target_index] := create {WEAK_REFERENCE [EV_PIXEL_BUFFER]}
			end
		end

	feature_kind_pixmap: SPECIAL [WEAK_REFERENCE [EV_PIXMAP]]
			-- Pixmaps for features indexed by their kind.
		once
				-- Allocate storage.
			Result := (create {ARRAY [WEAK_REFERENCE [EV_PIXMAP]]}.make_filled (create {WEAK_REFERENCE [EV_PIXMAP]}, 0, feature_all_mask)).area
				-- Fill it with different elements.
			across
				Result as w
			loop
				Result [w.target_index] := create {WEAK_REFERENCE [EV_PIXMAP]}
			end
		end

feature {NONE} -- Feature kind

	feature_kind_from_e_feature (f: E_FEATURE): like feature_all_mask
			-- Feature kind of `f`.
		do
				-- Feature content.
			Result :=
				if f.is_constant then
					feature_content_constant
				elseif f.is_attribute then
					feature_content_variable
				elseif f.is_deferred then
					feature_content_deferred
				elseif f.is_once then
					feature_content_once
				elseif f.is_external and then 	(attached f.associated_class as c implies not c.is_true_external) then
					feature_content_external
				else
					feature_content_do
				end
					-- Feature obsolescence.
				| if f.is_obsolete then feature_obsolescence_obsolete else feature_obsolescence_contemporary end
					-- Feature freeze status.
				| if f.is_frozen then feature_freeze_frozen else feature_freeze_redefinable end
					-- Feature class status.
				| if f.is_class then feature_target_class else feature_target_instance end
					-- Feature assigner status.
				| if attached f.assigner_name_32 as n and then not n.is_empty then feature_assigner_assigner else feature_assigner_regular end
					-- Feature ghost status.
				| if f.is_ghost then feature_ghost_ghost else feature_ghost_real end
		end

	feature_kind_from_feature_ast (f: FEATURE_AS; is_class_external: BOOLEAN; name_position: INTEGER): like feature_all_mask
			-- Feature kind of `f`.
		require
			valid_name_position: f.feature_names.valid_index (name_position)
		local
			b: BODY_AS
			r: ROUTINE_AS
		do
			b := f.body
			if attached b then
				r := {ROUTINE_AS} / b.content
			end
				-- Feature content.
			Result :=
				if f.is_constant then
					feature_content_constant
				elseif f.is_attribute or else attached r and then r.is_attribute then
					feature_content_variable
				elseif f.is_deferred then
					feature_content_deferred
				elseif attached r and then r.is_once then
					feature_content_once
				elseif attached r and then r.is_external and then not is_class_external then
					feature_content_external
				else
					feature_content_do
				end
					-- Feature obsolescence.
				| if attached r and then attached r.obsolete_message then feature_obsolescence_obsolete else feature_obsolescence_contemporary end
					-- Feature freeze status.
				| if attached f.feature_names [name_position] as n and then n.is_frozen then feature_freeze_frozen else feature_freeze_redefinable end
					-- Feature class status.
				| if f.is_class then feature_target_class else feature_target_instance end
					-- Feature assigner status.
				| if attached b and then attached b.assigner as a and then not a.name_8.is_empty then feature_assigner_assigner else feature_assigner_regular end
					-- Feature ghost status.
				| if attached f.indexes as i and then i.is_ghost then feature_ghost_ghost else feature_ghost_real end
		end

	feature_content_mask: NATURAL_8 = 0x7
		-- A mask for bits indicating feature content kind.

	feature_obsolescence_mask: NATURAL_8 = 0x8
		-- A mask for bits indicating feature obsolescence status.

	feature_freeze_mask: NATURAL_8 = 0x10
		-- A mask for bits indicating feature freeze status.

	feature_target_mask: NATURAL_8 = 0x20
		-- A mask for bits indicating feature target status (instance or class).

	feature_assigner_mask: NATURAL_8 = 0x40
		-- A mask for bits indicating feature assigner status.

	feature_ghost_mask: NATURAL_8 = 0x80
		-- A mask for bits indicating feature ghost status.

	feature_all_mask: NATURAL_8 = 0xFF
		-- A mask for all feature indicators.

	feature_content_constant: NATURAL_8 = 0x0 -- Feature content: constant attribute.
	feature_content_deferred: NATURAL_8 = 0x1 -- Feature content: deferred feature.
	feature_content_do: NATURAL_8 = 0x2 -- Feature content: internal non-once routine.
	feature_content_external: NATURAL_8 = 0x3 -- Feature content: external feature.
	feature_content_once: NATURAL_8 = 0x4 -- Feature content: once routine.
	feature_content_variable: NATURAL_8 = 0x5 -- Feature content: variable attribute.

	feature_obsolescence_contemporary: NATURAL_8 = 0x0 -- Feature obsolescence: contemporary feature.
	feature_obsolescence_obsolete: NATURAL_8 = 0x8 -- Feature obsolescence: obsolete feature.

	feature_freeze_redefinable: NATURAL_8 = 0x00 -- Feature freeze: redefinable feature.
	feature_freeze_frozen: NATURAL_8 = 0x10 -- Feature freeze: frozen feature.

	feature_target_instance: NATURAL_8 = 0x00 -- Feature target status: instance feature.
	feature_target_class: NATURAL_8 = 0x20 -- Feature target status: class feature.

	feature_assigner_regular: NATURAL_8 = 0x00 -- Feature assigner status: regular feature.
	feature_assigner_assigner: NATURAL_8 = 0x40 -- Feature assigner status: assigner feature.

	feature_ghost_real: NATURAL_8 = 0x00 -- Feature ghost status: real feature.
	feature_ghost_ghost: NATURAL_8 = 0x80 -- Feature ghost status: ghost feature.

invariant
	consistent_feature_all_mask:
		feature_all_mask =
			feature_content_mask |
			feature_obsolescence_mask |
			feature_freeze_mask |
			feature_target_mask |
			feature_assigner_mask |
			feature_ghost_mask

note
	ca_ignore: "CA033", "CA033: very large class"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
