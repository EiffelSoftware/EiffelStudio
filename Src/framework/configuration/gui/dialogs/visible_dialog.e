note
	description: "Dialog to choose visible classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VISIBLE_DIALOG

inherit
	PROPERTY_DIALOG [EQUALITY_HASH_TABLE [EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]], STRING]]
		redefine
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

	initialize
			-- Initialization
		local
			hb: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_btn: EV_BUTTON
		do
			Precursor {PROPERTY_DIALOG}
			element_container.set_padding (layout_constants.default_padding_size)

			create tree
			element_container.extend (tree)
			append_small_margin (element_container)

			create hb
			element_container.extend (hb)
			element_container.disable_item_expand (hb)

			create l_lbl.make_with_text (conf_interface_names.dialog_visible_name)
			hb.extend (l_lbl)
			hb.disable_item_expand (l_lbl)

			hb.extend (create {EV_CELL})

			create original_name
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

			create renamed_name
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

	show_class (a_class: STRING)
			-- Show information about `a_class'.
		require
			a_class_ok: a_class /= Void and then value /= Void and then value.has (a_class)
		do
			current_class := a_class
			current_feature := Void
		ensure
			current_class_set: current_class = a_class
			current_feature_not_set: current_feature = Void
		end

	show_feature (a_class, a_feature: STRING)
			-- Show information about `a_feature' in `a_class'.
		require
			a_class_ok: a_class /= Void and then value /= Void and then value.has (a_class)
			a_feature_ok: a_feature /= Void and then value.item (a_class).item.features /= Void and then value.item (a_class).item.features.has (a_feature)
		do
			current_class := a_class
			current_feature := a_feature
		ensure
			current_class_set: current_class = a_class
			current_feature_set: current_feature = a_feature
		end

	remove
			-- Remove `current_class' or `current_feature'.
		local
			l_features: EQUALITY_HASH_TABLE [STRING, STRING]
		do
			if value /= Void then
				if current_feature /= Void then
					l_features := value.item (current_class).item.features
					l_features.remove (current_feature)
					if l_features.is_empty then
						value.item (current_class).item.features := Void
					end
					refresh
				elseif current_class /= Void then
					value.remove (current_class)
					if value.is_empty then
						value := Void
					end
					refresh
				end
			end
		end

	add_class
			-- Add a new class.
		local
			l_name, l_vis_name: STRING
		do
			l_name := original_name.text.as_upper
			l_vis_name := renamed_name.text.as_upper
			if l_vis_name.is_empty then
				l_vis_name := l_name
			end
			if is_valid_class_name (l_name) and then is_valid_class_name (l_vis_name) and then (value = Void or else not value.has (l_name)) then
				if value = Void then
					create value.make (1)
				end

				value.force (create {EQUALITY_TUPLE [TUPLE [STRING_8, EQUALITY_HASH_TABLE [STRING_8, STRING_8]]]}.make ([l_vis_name, Void]), l_name)
				original_name.set_text ("")
				renamed_name.set_text ("")
				current_class := l_name
				refresh
			end
		end

	add_feature
			-- Add a new feature.
		local
			l_name, l_vis_name: STRING
			l_feats: EQUALITY_HASH_TABLE [STRING, STRING]
		do
			if current_class /= Void and then value /= Void and then value.has (current_class) then
				l_name := original_name.text.as_lower
				l_vis_name := renamed_name.text.as_lower
				if l_vis_name.is_empty then
					l_vis_name := l_name
				end
				l_feats := value.item (current_class).item.features
				if is_valid_feature_name (l_name) and then is_valid_feature_name (l_vis_name) and then (l_feats = Void or else not l_feats.has (l_name)) then
					if l_feats = Void then
						create l_feats.make (1)
						value.item (current_class).item.features := l_feats
					end

					l_feats.force (l_vis_name, l_name)
					original_name.set_text ("")
					renamed_name.set_text ("")
					current_feature := l_name
					refresh
				end
			end
		end

feature {NONE} -- Implementation

	current_class: STRING
			-- Currently displayed class.

	current_feature: STRING
			-- Currently displayed feature.

	refresh
			-- Refresh the displayed values.
		local
			l_sort: DS_ARRAYED_LIST [STRING]
			l_class_item, l_feat_item: EV_TREE_ITEM
			l_rena: EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]]
			l_feat: EQUALITY_HASH_TABLE [STRING, STRING]
			l_class, l_feat_name, l_vis_name: STRING
			l_cur_class: BOOLEAN
		do
			tree.wipe_out
			if value /= Void then
					-- sort class names alphabetically
				from
					create l_sort.make (value.count)
					value.start
				until
					value.after
				loop
					l_sort.put_last (value.key_for_iteration)
					value.forth
				end
				l_sort.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))

				from
					l_sort.start
				until
					l_sort.after
				loop
					l_class := l_sort.item_for_iteration
					l_vis_name := value.item (l_class).item.class_renamed
					if l_vis_name /= Void and then not l_vis_name.is_equal (l_class) then
						create l_class_item.make_with_text (l_class+" ("+l_vis_name+")")
					else
						create l_class_item.make_with_text (l_class)
					end

					l_class_item.select_actions.extend (agent show_class (l_class))

					tree.extend (l_class_item)
					l_rena := value.item (l_class)
					if current_class /= Void and then current_class.is_equal (l_class) then
						if current_feature = Void then
							l_class_item.enable_select
						else
							l_cur_class := True
						end
					end
					if l_rena /= Void and then l_rena.item.features /= Void then
						l_feat := l_rena.item.features
						from
							l_feat.start
						until
							l_feat.after
						loop
							l_vis_name := l_feat.item_for_iteration
							l_feat_name := l_feat.key_for_iteration
							if l_vis_name /= Void and then not l_vis_name.is_equal (l_feat_name) then
								create l_feat_item.make_with_text (l_feat_name+" ("+l_vis_name+")")
							else
								create l_feat_item.make_with_text (l_feat_name)
							end

							l_class_item.extend (l_feat_item)
							l_feat_item.select_actions.extend (agent show_feature (l_class, l_feat_name))
							if l_cur_class and current_feature.is_equal (l_feat_name) then
								l_feat_item.enable_select
								l_cur_class := False
							end

							l_feat.forth
						end
						l_class_item.expand
					end

					l_cur_class := False
					l_sort.forth
				end
			end
		end

invariant
	elements: is_initialized implies tree /= Void and original_name /= Void and renamed_name /= Void

note
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
