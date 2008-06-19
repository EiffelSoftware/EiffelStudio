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

feature -- Query (Pixmap)

	pixmap_from_group (a_group: CONF_GROUP): EV_PIXMAP
		require
			a_group_not_void: a_group /= Void
		do
			Result := pixmaps.configuration_pixmaps.pixmap_from_group (a_group)
		ensure
			result_not_void: Result /= Void
		end

	pixmap_from_group_path (a_group: CONF_GROUP; a_path: STRING): EV_PIXMAP
		require
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
			path_implies_not_library: not a_path.is_empty implies not a_group.is_library
		do
			Result := pixmaps.configuration_pixmaps.pixmap_from_group_path (a_group, a_path)
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
			l_pixcode: NATURAL_8
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
							l_classi ?= l_overrides.item
							check
								classi: l_classi /= Void
							end
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

	pixmap_from_feature_ast (is_class_external: BOOLEAN; a_feature_as: FEATURE_AS; a_name_pos: INTEGER): EV_PIXMAP is
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
		do
			a_name := a_feature_as.feature_names.i_th (a_name_pos)
			a_body := a_feature_as.body
			l_assinger := a_body.assigner /= Void and then not a_body.assigner.name.is_empty
			a_routine ?= a_body.content
			l_is_obsolete := (a_routine /= Void and then a_routine.obsolete_message /= Void)
			l_is_frozen := a_name.is_frozen

			if not l_assinger then
				if a_feature_as.is_attribute then
					if l_is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_attribute_icon
					elseif l_is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_attribute_icon
					else
						Result := pixmaps.icon_pixmaps.feature_attribute_icon
					end
				elseif a_feature_as.is_deferred then
					if l_is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon
					else
						Result := pixmaps.icon_pixmaps.feature_deferred_icon
					end
				elseif (a_routine /= Void and then a_routine.is_once) or else a_feature_as.is_constant then
					if l_is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_once_icon
					elseif l_is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_once_icon
					else
						Result := pixmaps.icon_pixmaps.feature_once_icon
					end
				elseif not is_class_external then
					if a_routine /= Void and then a_routine.is_external then
						if l_is_obsolete then
							Result := pixmaps.icon_pixmaps.feature_obsolete_external_icon
						elseif l_is_frozen then
							Result := pixmaps.icon_pixmaps.feature_frozen_external_icon
						else
							Result := pixmaps.icon_pixmaps.feature_external_icon
						end
					end
				end
				if Result = Void then
					if l_is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_routine_icon
					elseif l_is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_routine_icon
					else
						Result := pixmaps.icon_pixmaps.feature_routine_icon
					end
				end
			else
				if l_is_obsolete then
					Result := pixmaps.icon_pixmaps.feature_obsolete_assigner_icon
				elseif l_is_frozen then
					Result := pixmaps.icon_pixmaps.feature_frozen_assigner_icon
				else
					Result := pixmaps.icon_pixmaps.feature_assigner_icon
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	pixmap_for_query_lanaguage_item (a_item: QL_ITEM): EV_PIXMAP is
			-- Pixmap for `a_item'
		require
			a_item_attached: a_item /= Void
		local
			l_group: QL_GROUP
			l_class: QL_CLASS
			l_feature: QL_REAL_FEATURE
		do
			if a_item.is_target then
				Result := pixmaps.icon_pixmaps.metric_unit_target_icon
			elseif a_item.is_group then
				l_group ?= a_item
				Result := pixmap_from_group (l_group.group)
			elseif a_item.is_class then
				l_class ?= a_item
				Result := pixmap_from_class_i (l_class.class_i)
			elseif a_item.is_generic then
				Result := pixmaps.icon_pixmaps.metric_unit_generic_icon
			elseif a_item.is_real_feature then
				l_feature ?= a_item
				Result := pixmap_from_e_feature (l_feature.e_feature)
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

feature -- Query (Pixel buffer)

	pixel_buffer_from_class_i (a_class: CLASS_I): EV_PIXEL_BUFFER is
			-- Return pixmap based on `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			l_compiled_class: CLASS_C
			l_conf_class: CONF_CLASS
			l_classi: CLASS_I
			l_comp: CLASS_C
			l_pixcode: NATURAL_8
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
							l_classi ?= l_overrides.item
							check
								classi: l_classi /= Void
							end
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
			Result := class_icon_map.item (l_pixcode)
		ensure
			result_not_void: Result /= Void
		end

	pixel_buffer_from_e_feature (a_feature: E_FEATURE): EV_PIXEL_BUFFER is
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
						Result := pixmaps.icon_pixmaps.feature_obsolete_attribute_icon_buffer
					elseif a_feature.is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_attribute_icon_buffer
					else
						Result := pixmaps.icon_pixmaps.feature_attribute_icon_buffer
					end
				elseif a_feature.is_deferred then
					if a_feature.is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon_buffer
					else
						Result := pixmaps.icon_pixmaps.feature_deferred_icon_buffer
					end
				elseif a_feature.is_once or else a_feature.is_constant then
					if a_feature.is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_once_icon_buffer
					elseif a_feature.is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_once_icon_buffer
					else
						Result := pixmaps.icon_pixmaps.feature_once_icon_buffer
					end
				elseif a_feature.is_external then
					if a_feature.associated_class = Void or else not a_feature.associated_class.is_true_external then
						if a_feature.is_obsolete then
							Result := pixmaps.icon_pixmaps.feature_obsolete_external_icon_buffer
						elseif a_feature.is_frozen then
							Result := pixmaps.icon_pixmaps.feature_frozen_external_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_external_icon_buffer
						end
					end
				end
				if Result = Void then
					if a_feature.is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_routine_icon_buffer
					elseif a_feature.is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_routine_icon_buffer
					else
						Result := pixmaps.icon_pixmaps.feature_routine_icon_buffer
					end
				end
			else
				if a_feature.is_deferred then
					if a_feature.is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon_buffer
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
		ensure
			result_not_void: Result /= Void
		end

	pixel_buffer_from_feature_ast (is_class_external: BOOLEAN; a_feature_as: FEATURE_AS; a_name_pos: INTEGER): EV_PIXEL_BUFFER is
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
		do
			a_name := a_feature_as.feature_names.i_th (a_name_pos)
			a_body := a_feature_as.body
			l_assinger := a_body.assigner /= Void and then not a_body.assigner.name.is_empty
			a_routine ?= a_body.content
			l_is_obsolete := (a_routine /= Void and then a_routine.obsolete_message /= Void)
			l_is_frozen := a_name.is_frozen

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
						Result := pixmaps.icon_pixmaps.feature_obsolete_deferred_icon_buffer
					else
						Result := pixmaps.icon_pixmaps.feature_deferred_icon_buffer
					end
				elseif (a_routine /= Void and then a_routine.is_once) or else a_feature_as.is_constant then
					if l_is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_once_icon_buffer
					elseif l_is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_once_icon_buffer
					else
						Result := pixmaps.icon_pixmaps.feature_once_icon_buffer
					end
				elseif not is_class_external then
					if a_routine /= Void and then a_routine.is_external then
						if l_is_obsolete then
							Result := pixmaps.icon_pixmaps.feature_obsolete_external_icon_buffer
						elseif l_is_frozen then
							Result := pixmaps.icon_pixmaps.feature_frozen_external_icon_buffer
						else
							Result := pixmaps.icon_pixmaps.feature_external_icon_buffer
						end
					end
				end
				if Result = Void then
					if l_is_obsolete then
						Result := pixmaps.icon_pixmaps.feature_obsolete_routine_icon_buffer
					elseif l_is_frozen then
						Result := pixmaps.icon_pixmaps.feature_frozen_routine_icon_buffer
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
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Access

	class_icon_map: HASH_TABLE [EV_PIXMAP, NATURAL_8] is
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
			result_attached: Result /= VOid
		end

feature {NONE} -- Implementation

	none_flag:  NATURAL_8 is 0x01
	compiled_flag: NATURAL_8 is 0x02
	deferred_flag: NATURAL_8 is 0x04
	expanded_flag: NATURAL_8 is 0x08
	frozen_flag: NATURAL_8 is 0x010
	overrides_flag: NATURAL_8 is 0x20
	overriden_flag: NATURAL_8 is 0x40
	readonly_flag: NATURAL_8 is 0x80;
		-- Class icon state flags		

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
