note
	description: "Information tool GUI widget"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_TOOL_WIDGET

inherit
	EV_VERTICAL_BOX

	PROGRESS_OBSERVER
		export
			{NONE} all
		undefine
			is_equal,
			default_create,
			copy
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
		undefine
			is_equal,
			default_create,
			copy
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		undefine
			is_equal,
			default_create,
			copy
		end

	EB_RECYCLABLE
		undefine
			is_equal,
			default_create,
			copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal,
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_panel: ES_INFORMATION_TOOL_PANEL)
			-- Initialization
		require
			a_panel_not_void: a_panel /= Void
		do
			default_create
			panel := a_panel
			context_menu_factory := a_panel.develop_window.menus.context_menu_factory
			build_interface
		ensure
			panel_set: panel /= Void
		end

	build_interface
			--
		local
			l_frame: EV_FRAME
--			l_hbox: EV_HORIZONTAL_BOX
--			l_search_box: like build_search_box
			l_progress_hbox: EV_HORIZONTAL_BOX
			l_toolbar: SD_TOOL_BAR
			l_vbox: EV_VERTICAL_BOX
			l_whole_vbox: EV_VERTICAL_BOX
		do
			create l_frame
			extend (l_frame)
			create l_whole_vbox
			l_whole_vbox.set_padding (layout_constants.tiny_padding_size)
			l_frame.extend (l_whole_vbox)

			-- Search is not implemented yet.
--			create l_hbox
--			l_whole_vbox.extend (l_hbox)
--			l_whole_vbox.disable_item_expand (l_hbox)

--			l_search_box := build_search_box
--			l_hbox.extend (l_search_box)
--			l_hbox.disable_item_expand (l_search_box)
--			l_hbox.extend (create {EV_CELL})

			create split_area
			l_whole_vbox.extend (split_area)

				-- Progress bar
			create l_progress_hbox
			l_progress_hbox.set_padding_width (layout_constants.tiny_padding_size)
			l_whole_vbox.extend (l_progress_hbox)
			l_whole_vbox.disable_item_expand (l_progress_hbox)
			create l_toolbar.make

				-- Edit auto EIS node button
			create edit_auto_gen_button.make
			edit_auto_gen_button.set_tooltip (interface_names.t_edit_auto_eis_node)
			edit_auto_gen_button.set_pixel_buffer (pixmaps.icon_pixmaps.information_edit_auto_node_icon_buffer)
			edit_auto_gen_button.select_actions.extend (agent on_edit_eis_auto_node)
			edit_auto_gen_button.disable_sensitive
			register_action (edit_auto_gen_button.drop_actions, agent on_drop_auto_node)
			edit_auto_gen_button.drop_actions.set_veto_pebble_function (agent is_stone_editable_for_auto_node)
			l_toolbar.extend (edit_auto_gen_button)

				-- Separator
			l_toolbar.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Auto sweep button
			create auto_sweep_button.make
			auto_sweep_button.set_tooltip (interface_names.t_auto_sweeping_the_system)
			auto_sweep_button.set_pixel_buffer (pixmaps.icon_pixmaps.information_auto_sweeping_icon_buffer)
			auto_sweep_button.select_actions.extend (agent panel.on_auto_sweep_button_selected (auto_sweep_button))
			l_toolbar.extend (auto_sweep_button)
				-- Sweep button
			create sweep_now_button.make
			sweep_now_button.set_tooltip (interface_names.t_sweeping_the_system_now)
			sweep_now_button.set_pixel_buffer (pixmaps.icon_pixmaps.information_sweep_now_icon_buffer)
			sweep_now_button.select_actions.extend (agent panel.on_sweep_now)
			l_toolbar.extend (sweep_now_button)

			l_progress_hbox.extend (l_toolbar)
			l_toolbar.compute_minimum_size
			l_progress_hbox.disable_item_expand (l_toolbar)
				-- The progress bar
			create l_vbox
			l_progress_hbox.extend (l_vbox)
			create background_sweeping_progress_bar
			l_vbox.extend (create {EV_CELL})
			l_vbox.extend (background_sweeping_progress_bar)
			l_vbox.disable_item_expand (background_sweeping_progress_bar)
			l_vbox.extend (create {EV_CELL})

			build_tree
			build_list
		end

	build_search_box: EV_HORIZONTAL_BOX
			-- Build search box
		local
			l_search_label: EV_LABEL
		do
			create Result
			create l_search_label.make_with_text (interface_names.l_search_for)
			Result.extend (l_search_label)
			create search_field
			search_field.set_minimum_width (200)
			Result.extend (search_field)
			Result.disable_item_expand (l_search_label)

			create search_button.make_with_text (interface_names.b_search)
			search_button.set_minimum_width (layout_constants.default_button_width)
			search_button.set_minimum_height (layout_constants.default_button_height)
			Result.extend (search_button)
			Result.disable_item_expand (search_button)

			Result.set_padding (layout_constants.small_padding_size)
			Result.set_border_width (layout_constants.small_border_size)
		ensure
			build_search_box_not_void: build_search_box /= Void
		end

	build_tree
			-- Build left tree of the panel.
		local
			l_tree: like tree
			l_vbox: EV_VERTICAL_BOX
--			l_toolbar: SD_TOOL_BAR
--			l_button: SD_TOOL_BAR_BUTTON
--			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_vbox
			split_area.set_first (l_vbox)

				-- The tree

			create l_tree.make_eis_tree (context_menu_factory, Current)
			l_tree.select_actions.extend (agent on_tree_selected)
			tree := l_tree
			l_vbox.extend (l_tree)
			l_tree.set_minimum_width (Layout_constants.dialog_unit_to_pixels (200))
			l_tree.refresh
			register_action (l_tree.drop_actions, agent target_stone)

--			create l_hbox
--			create l_toolbar.make
--			create l_button.make
--			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.tool_advanced_search_icon_buffer)
--			l_button.set_tooltip (interface_names.e_show_class_cluster)
--			l_button.select_actions.extend (agent on_show_editing_item)
--			l_toolbar.extend (l_button)
--			l_toolbar.compute_minimum_size
--			l_hbox.extend (l_toolbar)
--			l_hbox.disable_item_expand (l_toolbar)

--			l_hbox.extend (create {EV_CELL})

--				-- Tool bar
--			create l_toolbar.make

--			create l_button.make
--			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.general_remove_icon_buffer)
--			l_button.set_tooltip (interface_names.t_clean_up_affected_items)
--			l_button.select_actions.extend (agent on_clean_up_affected_item)
--			l_toolbar.extend (l_button)

----			create l_button.make
----			l_button.set_text ("Define variables")
----			l_toolbar.extend (l_button)

--			l_toolbar.compute_minimum_size
--			l_hbox.extend (l_toolbar)
--			l_hbox.disable_item_expand (l_toolbar)
--			l_vbox.extend (l_hbox)
--			l_vbox.disable_item_expand (l_hbox)
		end

	build_list
			-- EIS item detail panel.
		local
			l_vbox: EV_VERTICAL_BOX
			l_border: ES_BORDERED_WIDGET [EV_WIDGET]
			l_toolbar: SD_TOOL_BAR
			l_button: SD_TOOL_BAR_BUTTON
		do
			create l_vbox
			split_area.set_second (l_vbox)
			create list_area_widget
			l_vbox.extend (list_area_widget)
			l_vbox.extend (nothing_widget)

				-- Entry list
			create entry_list.make (panel)
			create l_border.make (entry_list)
			list_area_widget.extend (l_border)
			display_nothing

				-- Tool bar
			create l_toolbar.make
			toolbar := l_toolbar

				-- Add button
			create l_button.make
			add_button := l_button
			l_button.set_text (interface_names.b_add)
			l_button.set_tooltip (interface_names.t_Add_eis_entry)
			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.general_add_icon_buffer)
			l_button.select_actions.extend (agent on_entry_add)
			l_toolbar.extend (l_button)
			register_action (l_button.drop_actions, agent panel.add_information_to)

				-- Delete button
			create l_button.make
			delete_button := l_button
			l_button.set_text (interface_names.b_delete_command)
			l_button.set_tooltip (interface_names.t_delete_selected_items)
			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.general_delete_icon_buffer)
			l_button.select_actions.extend (agent on_entry_delete)
			l_toolbar.extend (l_button)

			l_toolbar.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Go to button
			create l_button.make
			l_button.set_text (interface_names.b_go_to)
			l_button.set_tooltip (interface_names.t_go_to_info)
			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.general_information_icon_buffer)
			l_button.select_actions.extend (agent on_go_to_button_pressed)
			l_toolbar.extend (l_button)

				-- Acknowledge button
			create l_button.make
			acknowledge_button := l_button
			l_button.set_text (interface_names.b_acknowledge)
			l_button.set_tooltip (interface_names.t_acknowledge_change)
			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.general_tick_icon_buffer)
			l_button.select_actions.extend (agent on_acknowledge_button_selected)
			l_toolbar.extend (l_button)

			list_area_widget.extend (l_toolbar)
			l_toolbar.compute_minimum_size
			list_area_widget.disable_item_expand (l_toolbar)

			create grid_support.make_with_grid (entry_list)
			grid_support.enable_grid_item_pnd_support
			grid_support.enable_ctrl_right_click_to_open_new_window
			grid_support.synchronize_scroll_behavior_with_editor
			grid_support.set_context_menu_factory_function (agent context_menu_factory)
			register_action (entry_list.drop_actions, agent target_stone)
		end

	context_menu_factory: EB_CONTEXT_MENU_FACTORY
			-- Context menu factory

	grid_support: EB_EDITOR_TOKEN_GRID_SUPPORT
			-- Grid support for `entry_list'

feature -- Synchronization

	refresh_list
			-- Refresh the entry list.
		do
			if tree /= Void then
				tree.rebuild_list_if_possible
			end
		end

feature -- Access

	panel: ES_INFORMATION_TOOL_PANEL
			-- Information tool panel

	tree: ES_EIS_TREE
			-- The tree showing all nodes in the system.

	entry_list: ES_EIS_ENTRY_GRID
			-- List of EIS entries

	search_field: EV_TEXT_FIELD
			-- Search text field

	split_area: EV_HORIZONTAL_SPLIT_AREA
			-- Split area for tree and list.

	search_button: EV_BUTTON
			-- Button to lauch a new search.

	edit_auto_gen_button: SD_TOOL_BAR_BUTTON
			-- Edit auto EIS node button.

	auto_sweep_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Auto sweep button

	sweep_now_button: SD_TOOL_BAR_BUTTON
			-- Sweep now button

	background_sweeping_progress_bar: EV_HORIZONTAL_PROGRESS_BAR
			-- Progress bar to display progress of background sweeping.

	list_area_widget: detachable EV_VERTICAL_BOX
			-- The widget to display entry list

	add_button: detachable SD_TOOL_BAR_BUTTON
			-- Add button

	delete_button: detachable SD_TOOL_BAR_BUTTON
			-- Delete button

	acknowledge_button: detachable SD_TOOL_BAR_BUTTON
			-- Acknowledge button

	toolbar: SD_TOOL_BAR
			-- The toolbar

feature -- Callbacks

	on_show_editing_item
			-- On show editing item selected.
		local
			l_window: EB_DEVELOPMENT_WINDOW
		do
			l_window := panel.develop_window
			if l_window /= Void and then attached l_window.stone as l_stone then
				target_stone (l_stone)
				if not last_stone_targeted then
					prompts.show_warning_prompt (Warning_messages.w_Could_not_locate (l_stone.stone_signature), l_window.window, Void)
				end
			end
		end

	on_clean_up_affected_item
			-- On clean up affected items.
		do

		end

	on_entry_add
			-- On Add button selected.
		local
			l_view: ES_EIS_COMPONENT_VIEW [ANY]
		do
			l_view := tree.current_view
			if l_view /= Void and then l_view.new_entry_possible then
				l_view.create_new_entry
			end
		end

	on_entry_delete
			-- On delete button selected.
		local
			l_view: ES_EIS_COMPONENT_VIEW [ANY]
		do
			l_view := tree.current_view
			if l_view /= Void then
				l_view.delete_selected_entries
			end
		end

	on_tree_selected
			-- On tree selected
		local
			l_enable: BOOLEAN
		do
				-- Enable/disable Auto-node button.
			if attached {EB_CLASSES_TREE_TARGET_ITEM} tree.selected_item then
				l_enable := True
			elseif attached {EB_CLASSES_TREE_FOLDER_ITEM} tree.selected_item as l_item then
				if attached {CONF_LIBRARY} l_item.stone.group as l_library then
					l_enable := not l_library.is_readonly
				end
			end
			if l_enable then
				edit_auto_gen_button.enable_sensitive
			else
				edit_auto_gen_button.disable_sensitive
			end

		end

	on_edit_eis_auto_node
			-- On edit EIS auto node property of a target
		local
			l_target: detachable CONF_TARGET
		do
			if attached {EB_CLASSES_TREE_TARGET_ITEM} tree.selected_item as l_item then
				l_target := l_item.stone.target
			elseif attached {EB_CLASSES_TREE_FOLDER_ITEM} tree.selected_item as l_folder_item then
				if l_folder_item.stone.group.is_library then
					if attached {CONF_LIBRARY} l_folder_item.stone.group as l_library and then not l_library.is_readonly then
						l_target := l_library.library_target
					end
				end
			end
			if l_target /= Void then
				show_target_auto_node_dialog (l_target)
			end
		end

	on_drop_auto_node (a_stone: STONE)
			-- Dropping a stone on the auto node button
		local
			l_target: detachable CONF_TARGET
		do
			if attached {TARGET_STONE} a_stone as l_stone then
				l_target := l_stone.target
			elseif
				attached {CLUSTER_STONE} a_stone as l_stone and then
				attached {CONF_LIBRARY} l_stone.group as l_library and then
				not l_library.is_readonly
			then
				l_target := l_library.library_target
			end
			if l_target /= Void then
				show_target_auto_node_dialog (l_target)
			end
		end

	on_go_to_button_pressed
			-- Go to button pressed
		do
			if attached tree.current_view as l_view then
				l_view.show_help
			end
		end

	on_acknowledge_button_selected
			-- On acknowledge button selected
		do
			if attached {ES_EIS_AFFECTED_VIEW} tree.current_view as l_view then
				l_view.acknowledge_selected_items
			end
		end

feature -- Progress notification

	on_progress_start
			-- On starting visiting the system
		do
			background_sweeping_progress_bar.set_proportion (0)
		end

	on_progress_progress (a_value: REAL)
			-- On progress has been made
		do
			background_sweeping_progress_bar.set_proportion (1 - a_value)
		end

	on_progress_finish
			-- On finishing progress
		do
			background_sweeping_progress_bar.set_proportion (0)
			refresh_list
		end

	on_progress_stop
			-- On stop visiting the system
		do
			background_sweeping_progress_bar.set_proportion (0)
			refresh_list
		end

feature -- Element Change

	target_stone (a_stone: STONE)
			-- Target `a_stone' in the tool
		do
			last_stone_targeted := True
			if not tree.is_built then
				tree.build
			end
			if attached {CLASSI_STONE} a_stone as l_conv_class then
				tree.show_class (l_conv_class.class_i)
				tree.item_selected
			elseif attached {CLUSTER_STONE} a_stone as l_conv_cluster then
				tree.show_subfolder (l_conv_cluster.group, l_conv_cluster.path)
				tree.item_selected
			elseif attached {TARGET_STONE} a_stone as l_target_stone then
				tree.show_target (l_target_stone.target)
				tree.item_selected
			else
				last_stone_targeted := False
			end
		end

	add_new_entry_for_stone (a_stone: STONE)
			-- Try adding new entry for `a_stone'.
		do
			if attached {FEATURE_STONE} a_stone as l_feature_stone then
					-- For a feature, we need to specify the feature when adding an entry
				if attached {ES_EIS_CLASS_VIEW} tree.current_view as l_view and then l_view.new_entry_possible then
					if attached l_feature_stone.e_feature as l_f then
						l_view.create_new_entry_for_feature (l_f)
					end
				end
			else
					-- For other items we can add a new entry directly.
				on_entry_add
			end
		end

	reset_stone
			-- Reset current targeted stone
		do
			panel.reset_stone
		end

	display_list
			-- Display entry list in the list area.
		do
			if attached list_area_widget as l_list then
				nothing_widget.hide
				l_list.show
			end
		end

	display_nothing
			-- Display nothing in the list area.
		do
			if attached list_area_widget as l_list then
				l_list.hide
				nothing_widget.show
			end
		end

	refresh_buttons (a_view: ES_EIS_COMPONENT_VIEW [ANY])
			-- Inform the widget GUI current view displayed is editable or not.
			-- Change the sensitivity of buttons accordingly.
		require
			a_view_not_void: a_view /= Void
		do
			if attached add_button as l_ab and then attached delete_button as l_db then
				if a_view.component_editable then
					l_ab.enable_sensitive
					l_db.enable_sensitive
				else
					l_ab.disable_sensitive
					l_db.disable_sensitive
				end
			end
			if attached acknowledge_button as l_b then
				if attached {ES_EIS_AFFECTED_VIEW} a_view then
					toolbar.extend (l_b)
				else
					toolbar.prune (l_b)
				end
			end
			toolbar.refresh_now
		end

feature -- Query

	last_stone_targeted: BOOLEAN
			-- Was last stone targeted by `target_stone'?

feature {NONE} -- Implementation

	is_stone_editable_for_auto_node (a_stone: STONE): BOOLEAN
			-- Is `a_stone' editable for auto node entries?
		do
			Result := attached {TARGET_STONE} a_stone or else
				(attached {CLUSTER_STONE} a_stone as l_stone and then
				attached {CONF_LIBRARY} l_stone.group as l_library and then
				not l_library.is_readonly)
		end

	show_target_auto_node_dialog (a_target: CONF_TARGET)
			-- Show auto node dialog for `a_target'.
		require
			a_target_set: a_target /= Void
		local
			l_dialog: ES_EIS_AUTO_ENTRY_DIALOG
		do
			create l_dialog.make_with_target (a_target, agent refresh_list)
			l_dialog.set_is_modal (True)
			l_dialog.show_on_active_window
		end

	nothing_widget: EV_HORIZONTAL_BOX
			-- Widget to display nothing.
		local
			l_border: ES_BORDERED_WIDGET [EV_WIDGET]
			l_hbox: EV_HORIZONTAL_BOX
		do
			if attached internal_nothing_widget as l_widget then
				Result := l_widget
			else
				create Result
				create l_hbox
				create l_border.make (l_hbox)
				Result.extend (l_border)
				l_hbox.extend (create {EV_LABEL}.make_with_text (interface_names.l_no_information_available))
				internal_nothing_widget := Result
			end
		ensure
			Result_not_void: Result /= Void
		end

	internal_nothing_widget: detachable like nothing_widget
			-- Storage for `nothing_widget'

	internal_recycle
			-- <precursor>
		do
			grid_support.desynchronize_scroll_behavior_with_editor
			entry_list.recycle
			tree.recycle
		end

invariant
	context_menu_factory_not_void: context_menu_factory /= Void
	panel_not_void: panel /= Void
	tree_not_void: tree /= Void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
