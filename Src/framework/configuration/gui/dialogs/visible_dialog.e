note
	description: "Dialog to choose visible classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VISIBLE_DIALOG

inherit
	PROPERTY_DIALOG [STRING_TABLE [TUPLE [class_renamed: READABLE_STRING_32; features: detachable STRING_TABLE [READABLE_STRING_32]]]]
		redefine
			create_interface_objects,
			initialize
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy
		end

	EIFFEL_SYNTAX_CHECKER
		undefine
			default_create,
			copy
		end

	EV_LAYOUT_CONSTANTS
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
			create renamed_name
			create original_name
			create tree
		end

	initialize
			-- Initialization
		local
			hb: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_btn: EV_BUTTON
		do
			Precursor {PROPERTY_DIALOG}
			element_container.set_padding (layout_constants.default_padding_size)

--			create tree
			element_container.extend (tree)
			append_small_margin (element_container)

			create hb
			element_container.extend (hb)
			element_container.disable_item_expand (hb)

			create l_lbl.make_with_text (conf_interface_names.dialog_visible_name)
			hb.extend (l_lbl)
			hb.disable_item_expand (l_lbl)

			hb.extend (create {EV_CELL})

--			create original_name
			hb.extend (original_name)
			hb.disable_item_expand (original_name)
			original_name.set_minimum_width (250)

			create hb
			element_container.extend (hb)
			element_container.disable_item_expand (hb)

			create l_lbl.make_with_text (conf_interface_names.dialog_visible_renamed_name)
			hb.extend (l_lbl)
			hb.disable_item_expand (l_lbl)

			hb.extend (create {EV_CELL})

--			create renamed_name
			hb.extend (renamed_name)
			hb.disable_item_expand (renamed_name)
			renamed_name.set_minimum_width (250)

			create hb
			hb.set_padding (layout_constants.default_padding_size)
			element_container.extend (hb)
			element_container.disable_item_expand (hb)

			hb.extend (create {EV_CELL})

			create l_btn.make_with_text_and_action (conf_interface_names.dialog_visible_add_class, agent add_class)
			l_btn.set_pixmap (conf_pixmaps.general_add_icon)
			set_default_width_for_button (l_btn)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			create l_btn.make_with_text_and_action (conf_interface_names.dialog_visible_add_feature, agent add_feature)
			l_btn.set_pixmap (conf_pixmaps.general_add_icon)
			set_default_width_for_button (l_btn)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			create l_btn.make_with_text_and_action (conf_interface_names.dialog_visible_remove, agent remove)
			l_btn.set_pixmap (conf_pixmaps.general_remove_icon)
			set_default_width_for_button (l_btn)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			set_size (350, 500)
			show_actions.extend (agent on_show)
		end

feature {NONE} -- Gui elements

	tree: EV_TREE
			-- Tree that displays the visible classes/features.

	original_name: EV_TEXT_FIELD
			-- Original class/feature name.

	renamed_name: EV_TEXT_FIELD
			-- Renamed class/feature name.

feature {NONE} -- Agents

	on_show
			-- Called if the dialog is shown.
		require
			initialized: is_initialized
		do
			refresh
		end

	show_class (a_class: READABLE_STRING_GENERAL)
			-- Show information about `a_class'.
		require
			a_class_ok: a_class /= Void and then attached value as v and then v.has (a_class)
		do
			current_class := a_class.as_string_32
			current_feature := Void
		ensure
			current_class_set: current_class = a_class
			current_feature_not_set: current_feature = Void
		end

	show_feature (a_class, a_feature: READABLE_STRING_GENERAL)
			-- Show information about `a_feature' in `a_class'.
		require
			value_attached: attached value as v
			a_class_ok: a_class /= Void and then v.has (a_class)
			a_feature_ok: a_feature /= Void and then attached v.item (a_class) as v_item and then attached v_item.features as l_features and then
							l_features.has (a_feature)
		do
			current_class := a_class.as_string_32
			current_feature := a_feature.as_string_32
		ensure
			current_class_set: current_class = a_class
			current_feature_set: current_feature = a_feature
		end

	remove
			-- Remove `current_class' or `current_feature'.
		do
			if
				attached value as v and then
				attached current_class as c
			then
				if not attached current_feature as f then
						-- No feature is selected.
					v.remove (c)
					if v.is_empty then
						value := Void
					end
					refresh
				elseif
					attached v.item (c) as v_item and then
					attached v_item.features as fs
				then
						-- A feature is selected.
					fs.remove (f)
					if fs.is_empty then
						v_item.features := Void
					end
					refresh
				end
			end
		end

	add_class
			-- Add a new class.
		local
			l_name, l_vis_name: STRING_32
			tu: like value.item
			tb: detachable STRING_TABLE [READABLE_STRING_32]
			l_value: like value
		do
			l_name := original_name.text.as_upper
			l_vis_name := renamed_name.text.as_upper
			if l_vis_name.is_empty then
				l_vis_name := l_name
			end

			l_value := value
			if
				is_valid_class_name (l_name) and then
				is_valid_class_name (l_vis_name) and then
				(l_value = Void or else not l_value.has (l_name))
			then
				if l_value = Void then
					create l_value.make_equal (1)
					value := l_value
				end
				tu := [l_vis_name, tb]
				tu.compare_objects
				l_value.force (tu, l_name)
				original_name.set_text ("")
				renamed_name.set_text ("")
				current_class := l_name
				refresh
			end
		end

	add_feature
			-- Add a new feature.
		local
			l_name, l_vis_name: READABLE_STRING_32
			l_feats: STRING_TABLE [READABLE_STRING_32]
		do
			if attached current_class as c and then attached value as l_value and then l_value.has (c) then
				l_name := original_name.text.as_lower
				l_vis_name := renamed_name.text.as_lower
				if l_vis_name.is_empty then
					l_vis_name := l_name
				end
				if attached l_value.item (c) as l_value_item then
					l_feats := l_value_item.features
					if
						is_valid_feature_name (l_name) and then
						is_valid_feature_name (l_vis_name) and then
						(l_feats = Void or else not l_feats.has (l_name))
					then
						if l_feats = Void then
							create l_feats.make_equal (1)
							l_value_item.features := l_feats
						end

						l_feats.force (l_vis_name, l_name)
						original_name.set_text ("")
						renamed_name.set_text ("")
						current_feature := l_name
						refresh
					end
				end
			end
		end

feature {NONE} -- Implementation

	current_class: detachable STRING_32
			-- Currently displayed class.

	current_feature: detachable STRING_32
			-- Currently displayed feature.

	refresh
			-- Refresh the displayed values.
		local
			l_sorted_list: ARRAYED_LIST [READABLE_STRING_32]
			l_class_item, l_feat_item: EV_TREE_ITEM
			l_class: READABLE_STRING_32
			l_vis_name: READABLE_STRING_32
			l_feat_name: READABLE_STRING_32
			l_cur_class: BOOLEAN
			l_sorter: QUICK_SORTER [READABLE_STRING_32]
		do
			tree.wipe_out
			if attached value as l_value then
					-- sort class names alphabetically
				from
					create l_sorted_list.make (l_value.count)
					l_value.start
				until
					l_value.after
				loop
					l_sorted_list.extend (l_value.key_for_iteration)
					l_value.forth
				end
				create l_sorter.make (create {COMPARABLE_COMPARATOR [READABLE_STRING_32]})
				l_sorter.sort (l_sorted_list)

				from
					l_sorted_list.start
				until
					l_sorted_list.after
				loop
					l_class := l_sorted_list.item_for_iteration
					if attached l_value.item (l_class) as l_item then
						l_vis_name := l_item.class_renamed
					else
						l_vis_name := Void
					end
					if l_vis_name /= Void and then not l_vis_name.same_string_general (l_class) then
						create l_class_item.make_with_text (l_class+" ("+l_vis_name+")")
					else
						create l_class_item.make_with_text (l_class)
					end

					l_class_item.select_actions.extend (agent show_class (l_class))

					tree.extend (l_class_item)
					if attached current_class as l_current_class and then l_current_class.same_string_general (l_class) then
						if current_feature = Void then
							l_class_item.enable_select
						else
							l_cur_class := True
						end
					end
					if
						attached l_value.item (l_class) as l_rena and then
						attached l_rena.features as l_feat
					then
						from
							l_feat.start
						until
							l_feat.after
						loop
							l_vis_name := l_feat.item_for_iteration
							l_feat_name := l_feat.key_for_iteration
							if l_vis_name /= Void and then not l_vis_name.same_string_general (l_feat_name) then
								create l_feat_item.make_with_text (l_feat_name+" ("+l_vis_name+")")
							else
								create l_feat_item.make_with_text (l_feat_name)
							end

							l_class_item.extend (l_feat_item)
							l_feat_item.select_actions.extend (agent show_feature (l_class, l_feat_name))
							if
								l_cur_class and then
								attached current_feature as l_current_feature and then
								l_current_feature.same_string_general (l_feat_name)
							then
								l_feat_item.enable_select
								l_cur_class := False
							end

							l_feat.forth
						end
						l_class_item.expand
					end

					l_cur_class := False
					l_sorted_list.forth
				end
			end
		end

invariant
	elements: is_initialized implies tree /= Void and original_name /= Void and renamed_name /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
