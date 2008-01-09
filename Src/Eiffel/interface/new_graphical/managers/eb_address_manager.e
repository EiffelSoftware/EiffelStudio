indexing
	description	: "Location to enter the name of a class and the name of a feature.%
				  % Manage the history of the parent as well."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr] "

class
	EB_ADDRESS_MANAGER

inherit
	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_RECYCLABLE

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EB_HISTORY_MANAGER_OBSERVER
		redefine
			on_update,
			on_item_added,
			on_item_removed,
			on_position_changed
		end

	EB_SHARED_PREFERENCES

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		end

	EV_UTILITIES
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_CONTEXT_MENU_HANDLER

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: like parent; for_context_tool: BOOLEAN) is
			-- Initialize the widget and set up the activate actions.
			-- If `for_context_tool', do not initialize `widget', but
			-- initialize `header_info' and `address_dialog' (Saves widgets).
		require
			valid_parent: a_parent /= Void
		do
				-- Set up the parent.
			parent ?= a_parent
			set_mode (for_context_tool)
			parent.history_manager.add_observer (Current)
			enable_accept_general_group
				-- Create the widget.
			build_interface

			create label_changed_actions
		end

	build_interface is
			-- Build Vision2 architecture.
		local
			hbox: like widget
			vb: EV_VERTICAL_BOX
			label: EV_LABEL
			l_item: SD_TOOL_BAR_ITEM
			l_hbox: EV_HORIZONTAL_BOX
			l_font: EV_FONT
		do
			l_font := Default_font

			create tool_bar_items.make (10)

			create hbox
			hbox.set_padding (Layout_constants.Small_border_size)

			if mode then
					-- Cluster label.
				create label.make_with_text (interface_names.l_cluster)
				label.set_font (l_font)
				hbox.extend (label)
				hbox.disable_item_expand (label)

					-- Cluster selector.
				create cluster_address
				cluster_address.set_font (l_font)
				cluster_address.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (130))
				hbox.extend (cluster_address)
			end

				-- Class label.
			create label.make_with_text (interface_names.l_class)
			label.set_font (l_font)

			if mode then
				hbox.extend (label)
				hbox.disable_item_expand (label)
			else
				create l_hbox
				l_hbox.set_border_width (Layout_constants.Small_border_size)
				l_hbox.extend (label)

				create {SD_TOOL_BAR_WIDGET_ITEM} l_item.make (l_hbox)
				l_item.set_description (interface_names.l_class_label)

				l_item.set_name ("class label")

				tool_bar_items.extend (l_item)
			end

				-- Class selector.
			create class_address
			class_address.set_font (l_font)
			class_address.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (200))

			if mode then
				hbox.extend (class_address)
			else
				-- Then we build a `class_addre
				create {SD_TOOL_BAR_RESIZABLE_ITEM} l_item.make (class_address)
				l_item.set_description (interface_names.l_class_address)
				l_item.set_name ("class address combo")

				tool_bar_items.extend (l_item)
			end
				-- Feature label.
			create label.make_with_text (interface_names.l_feature)
			label.set_font (l_font)

			if mode then
				hbox.extend (label)
				hbox.disable_item_expand (label)
			else
				create l_hbox
				l_hbox.set_border_width (Layout_constants.Small_border_size)
				l_hbox.extend (label)

				create {SD_TOOL_BAR_WIDGET_ITEM} l_item.make (l_hbox)
				l_item.set_description (interface_names.l_feature_label)

				l_item.set_name ("feature label")

				tool_bar_items.extend (l_item)
			end
				-- Feature selector
			create feature_address
			feature_address.set_font (l_font)
			feature_address.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (200))

			if mode then
				hbox.extend (feature_address)
			else
				create {SD_TOOL_BAR_RESIZABLE_ITEM} l_item.make (feature_address)
				l_item.set_description (interface_names.l_feature_address)
				l_item.set_name ("feature address combo")
				tool_bar_items.extend (l_item)
			end
			if not mode then
					-- View label
				create label.make_with_text (interface_names.l_view)
				label.set_font (l_font)

				create l_hbox
				l_hbox.set_border_width (Layout_constants.Small_border_size)
				l_hbox.extend (label)

				create {SD_TOOL_BAR_WIDGET_ITEM} l_item.make (l_hbox)

				l_item.set_description (interface_names.l_view_label)
				l_item.set_name ("view label")

				tool_bar_items.extend (l_item)
			end
			if not mode then
				build_viewpoints
				view_points_combo.set_font (l_font)
				parent_widget.set_view_points (view_points_combo)
			end

				-- Setup the widget.
			if not mode then
				widget := hbox
			else
				create vb
				vb.extend (hbox)
				vb.disable_item_expand (hbox)
				create output_line
				output_line.align_text_right
				vb.extend (output_line)
				create address_dialog
				address_dialog.enable_border
				address_dialog.close_request_actions.extend (agent address_dialog.hide)
				address_dialog.extend (vb)
				generate_header_info

				cluster_address.key_release_actions.extend (agent cluster_key_up)
				cluster_address.key_press_actions.extend (agent cluster_key_down)
				cluster_address.change_actions.extend (agent type_cluster)
				cluster_address.select_actions.extend (agent change_hist_to_cluster)

				cluster_address.focus_out_actions.extend (agent one_lost_focus)
				class_address.focus_out_actions.extend (agent one_lost_focus)
				feature_address.focus_out_actions.extend (agent one_lost_focus)
			end

			class_address.key_release_actions.extend (agent class_key_up)
			class_address.key_press_actions.extend (agent class_key_down)
			class_address.change_actions.extend (agent type_class)
			class_address.select_actions.extend (agent change_hist_to_class)

			feature_address.key_release_actions.extend (agent feature_key_up)
			feature_address.key_press_actions.extend (agent feature_key_down)
			feature_address.select_actions.extend (agent change_hist_to_feature)
			feature_address.change_actions.extend (agent type_feature)
			feature_address.focus_in_actions.extend (agent update_current_typed_class)

			lost_focus_action_enabled := True
		end

	build_viewpoints is
			-- Build viewpoint selection list
		local
			l_label: EV_LABEL
			l_view_points_widget: EV_HORIZONTAL_BOX
			l_view_points_combo: EB_VIEWPOINT_COMBO_BOX
		do
			create l_view_points_widget
			view_points_widget := l_view_points_widget
			create l_label.make_with_text (parent_widget.interface_names.l_viewpoints_colon)
			l_view_points_widget.extend (l_label)
			l_view_points_widget.disable_item_expand (l_label)

			create l_view_points_combo
			view_points_combo := l_view_points_combo
			l_view_points_combo.disable_sensitive
			register_action (l_view_points_combo.select_actions, agent parent_widget.on_viewpoint_changed)
			l_view_points_combo.disable_edit
			l_view_points_combo.set_minimum_width (120)

			l_view_points_widget.extend (l_view_points_combo)
			l_view_points_widget.disable_item_expand (l_view_points_combo)
		end

feature -- Access

	parent: EB_HISTORY_OWNER
			-- Parent for Current.

	widget: EV_HORIZONTAL_BOX
			-- Vision2 widget representing the control.

	tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Tool bar items representing Current.

	new_view_points_tool_bar_item: SD_TOOL_BAR_ITEM is
			-- New view points docking widget
		local
			l_combo: EV_COMBO_BOX
		do
			l_combo := view_points_combo
			if l_combo.parent /= Void then
				l_combo.parent.prune (l_combo)
			end
			create {SD_TOOL_BAR_RESIZABLE_ITEM} Result.make (l_combo)
			Result.set_name ("view combo")
			Result.set_description (interface_names.l_viewpoints)
		ensure
			not_void: Result /= Void
		end

	header_info: EV_HORIZONTAL_BOX
			-- Container for Cluser, Class and Feature selector.

	cluster_label_text: STRING is
			-- Name of the class as it appears in the cluster label.
		do
			if cluster_label /= Void and then not cluster_label.text.is_equal (default_cluster_name) then
				Result := cluster_label.text
			end
		end

	class_label_text: STRING is
			-- Name of the class as it appears in the class label.
		do
			if class_label /= Void and then not class_label.text.is_equal (default_class_name) then
				Result := class_label.text
			end
		end

	feature_label_text: STRING is
			-- Name of the class as it appears in the feature label.
		do
			if feature_label /= Void and then not feature_label.text.is_equal (default_feature_name) then
				Result := feature_label.text
			end
		end

	class_name: STRING
			-- Name of the class as it appears in the combo box.
			-- Void if none.

	feature_name: STRING
			-- Name of the feature as it appears in the combo box.
			-- Void if none.

	parent_widget: EB_DEVELOPMENT_WINDOW is
			-- Development window.
		require
			not_context_mode: not mode
		do
			Result ?= parent
		ensure
			result_not_void: Result /= Void
		end

	label_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Label text change actions.

feature -- Status report

	is_general_group_acceptable: BOOLEAN
			-- Is general group acceptable in address bar?

feature -- Element change

	set_format_name (a_name: STRING_GENERAL) is
			-- Set `format_name' to `a_name'.
			-- `a_name' cannot be Void nor empty.
		require
			a_name_non_void: a_name /= Void
			a_name_non_empty: not a_name.is_empty
			-- `a_name' should be the name of a known formatter
		local
			l_str: STRING
			name_copy: STRING_GENERAL
			found: BOOLEAN
		do
			if a_name.is_valid_as_string_8 then
				l_str := a_name.as_string_8
				l_str.to_lower
				name_copy := l_str
			else
				name_copy := a_name.twin
			end
			from
				known_formatters.start
			until
				known_formatters.after or else found
			loop
				if name_copy.is_equal (known_formatters.item.command_name) then
					known_formatters.item.invalidate
					known_formatters.item.execute
					found := True
				end
				known_formatters.forth
			end
		end

	set_formatters (new_formatters: like known_formatters) is
			-- Set `known_formatters' to `new_formatters'.
		require
			formatters_not_initialized: known_formatters = Void
			new_formatters_non_void: new_formatters /= Void
			for_development_window: not mode
		local
			l_but: SD_TOOL_BAR_BUTTON
			l_cnt: INTEGER
		do
			create formatters_combo.make
			known_formatters := new_formatters
			from
				l_cnt := 1
			until
				l_cnt > 5
			loop
				l_but := known_formatters.i_th (l_cnt).new_sd_button
				tool_bar_items.extend (l_but)
				l_cnt := l_cnt + 1
			end
			widget.extend (formatters_combo)
			widget.disable_item_expand (formatters_combo)
		end

	set_viewpoints (a_view: like viewpoints) is
			-- Set `viewpoints' with `a_view'.
		require
			a_view_not_void: a_view /= Void
		DO
			widget.extend (a_view)
			widget.disable_item_expand (a_view)
			viewpoints := a_view
		end

	viewpoints: EV_HORIZONTAL_BOX
			-- Viewpoints combo box

	formatters_combo: SD_TOOL_BAR
			-- Tool bar containing class format option buttons.

	disable_formatters is
			-- Make the format combo box insensitive.
		require
			formatters_initialized: known_formatters /= Void
		local
			cur: CURSOR
		do
			cur := known_formatters.cursor
			from
				known_formatters.start
			until
				known_formatters.after
			loop
				known_formatters.item.disable_sensitive
				known_formatters.forth
			end
			known_formatters.go_to (cur)
		end

	enable_formatters is
			-- Make the format combo box insensitive.
		require
			formatters_initialized: known_formatters /= Void
		local
			cur: CURSOR
		do
			cur := known_formatters.cursor
			from
				known_formatters.start
			until
				known_formatters.after
			loop
				known_formatters.item.enable_sensitive
				known_formatters.forth
			end
			known_formatters.go_to (cur)
		end

	reset is
			-- Reset the address manager.
		do
			class_name := Void
			feature_name := Void
			class_i := Void
			class_address.remove_text
			feature_address.remove_text
		end

	set_focus is
			-- Give the focus to the class combo box.
		do
			if class_address.is_sensitive then
				if not class_address.has_focus then
					class_address.set_focus
				elseif class_address.text_length > 0 then
					-- Class address already has focus. We select all texts in it instead of doing nothing.
					-- This behavior is same as Firefox's `Ctrl + L' shortcut.
					class_address.select_all
				end
			end
		end

	set_output_line (t: EV_LABEL) is
			-- Set the textable in which messages will be displayed.
			-- `t' may be Void, this means that there will be no output.
		require
			t_not_void: t /= Void
		do
			output_line := t
		ensure
			output_line_not_void: output_line /= Void
		end

	set_feature_text_simply (s: STRING) is
			-- Set feature combo text with `s'.
		require
			s_attached: s /= Void
		do
			feature_address.change_actions.block
			feature_address.set_text (s)
			feature_address.change_actions.resume
		end

	enable_accept_general_group is
			-- Enable that general group is acceptable.
		do
			is_general_group_acceptable := True
		ensure
			general_group_acceptable: is_general_group_acceptable
		end

	disable_accept_general_group is
			-- Disable the acceptability of general group.
		do
			is_general_group_acceptable := False
		ensure
			general_group_not_acceptable: not is_general_group_acceptable
		end

feature -- Observer management

	on_update is
			-- The history has changed. Update `Current'.
		local
			cluster_stone: CLUSTER_STONE
			c: CLASSI_STONE
			f: FEATURE_STONE
			cell: CELL2 [STONE, INTEGER]
			list: LIST [CELL2 [STONE, INTEGER]]
			nitem: EV_LIST_ITEM
			cur_sel: STONE
		do
			class_address.select_actions.block
			class_address.change_actions.block
			class_address.wipe_out
			feature_address.select_actions.block
			feature_address.change_actions.block
			feature_address.wipe_out
			if mode then
				cluster_address.select_actions.block
				cluster_address.change_actions.block
				cluster_address.wipe_out
			end
			list := history_manager.feature_display_list
			cur_sel := history_manager.active
			from
				list.start
			until
				list.after
			loop
				cell := list.item
				f ?= cell.item1
				if f /= Void then
					create nitem.make_with_text (interface_names.l_from (f.feature_name, f.class_i.name))
					nitem.set_data (cell.item2)
					if f.e_feature /= Void then
						nitem.set_pixmap (pixmap_from_e_feature (f.e_feature))
					end
					feature_address.extend (nitem)
					if cell.item1 = cur_sel then
						nitem.enable_select
					end
				end
				list.forth
			end
			if not feature_address.is_empty then
				feature_address.first.disable_select
			end
			list := history_manager.class_display_list
			from
				list.start
			until
				list.after
			loop
				cell := list.item
					--| FIXME XR: The extra space is there because otherwise
					--| when the user types his class names in upper case, the combo box automatically selects the item.
				create nitem.make_with_text (cell.item1.stone_signature + l_Space)
				nitem.set_data (cell.item2)

					-- Set the appropriate pixmap for nitem.
				c ?= cell.item1
				if c /= Void and then c.class_i /= Void then
					nitem.set_pixmap (pixmap_from_class_i (c.class_i))
				end

				class_address.extend (nitem)
				if cell.item1 = cur_sel then
					nitem.enable_select
				end
				list.forth
			end
			if not class_address.is_empty then
				class_address.first.disable_select
			end
			if mode then
				list := history_manager.cluster_display_list
				from
					list.start
				until
					list.after
				loop
					cell := list.item
					create nitem.make_with_text (cell.item1.stone_signature)
					nitem.set_data (cell.item2)

					-- Set the appropriate pixmap for nitem.
					cluster_stone ?= cell.item1
					if cluster_stone /= Void and then cluster_stone.group /= Void then
						nitem.set_pixmap (pixmap_from_group_path (cluster_stone.group, cluster_stone.path))
					end
					cluster_address.extend (nitem)
					if cell.item1 = cur_sel then
						nitem.enable_select
					end
					list.forth
				end
				if not cluster_address.is_empty then
					cluster_address.first.disable_select
				end
			end
			update_combos
			if mode then
				update_labels
				address_dialog.hide
				cluster_address.select_actions.resume
				cluster_address.change_actions.resume
			end
			class_address.select_actions.resume
			class_address.change_actions.resume
			feature_address.select_actions.resume
			feature_address.change_actions.resume
		end

	on_item_added (a_stone: STONE; a_stone_position: INTEGER) is
			-- `a_stone' has just been added.
		do
			on_update
		end

	on_item_removed (a_stone: STONE; index_item: INTEGER) is
			-- `a_stone' has just been removed.
		do
			on_update
		end

	on_position_changed is
			-- Position in history has changed.
		do
			on_update
		end

	on_new_tab_command is
			-- Handle EB_NEW_TAB_EDITOR_COMMAND.
		local
			l_window: EB_DEVELOPMENT_WINDOW
			l_editor: EB_SMART_EDITOR
		do
			if class_address.is_displayed and class_address.is_sensitive then
				l_window := window_manager.last_focused_development_window
				if l_window /= Void then
					l_editor :=  l_window.editors_manager.current_editor
					if l_editor /= Void and then not l_editor.file_loaded then
						ev_application.do_once_on_idle (agent class_address.set_focus)
					end
				end
			end
		end

feature -- Memory management

	internal_recycle is
			-- Recycle `Current' and leave it in an unstable state,
			-- so that we know whether we're not referenced any longer.
		do
			if widget /= Void then
				widget.destroy
				widget := Void
			end
			parent := Void
		end

feature {EB_DEVELOPMENT_WINDOW, EB_DEVELOPMENT_WINDOW_DIRECTOR, EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Vision2 Controls

	cluster_address: EV_COMBO_BOX
			-- Cluster part of the address.

	class_address: EV_COMBO_BOX
			-- Class part of the address.

	feature_address: EV_COMBO_BOX
			-- Feature part of the address.

	view_points_combo: EB_VIEWPOINT_COMBO_BOX
			-- Combo box used to a select viewpoints

	view_points_widget: EV_HORIZONTAL_BOX
			-- Widget to contain viewpoints box

feature -- Properties

	new_class_win: EB_CREATE_CLASS_DIALOG
			-- New dialog for a class tool.

feature -- Updating

	refresh is
			-- Update the text in the widgets according to parent's stone.
		do
			update_combos
			update_colors
		end

	update_colors is
			-- Update the colors for the address manager labels
		do
			if mode then
				cluster_label.set_foreground_color (preferences.editor_data.cluster_text_color)
				class_label.set_foreground_color (preferences.editor_data.class_text_color)
				feature_label.set_foreground_color (preferences.editor_data.feature_text_color)
			end
		end

	on_project_created is
			-- A new project has been loaded. Enable all controls.
		do
			if cluster_address /= Void then
				cluster_address.enable_sensitive
				class_label.enable_sensitive
				cluster_label.enable_sensitive
				feature_label.enable_sensitive
			end
			class_address.enable_sensitive
			feature_address.enable_sensitive
		end

	on_project_unloaded is
			-- Current project has been closed. Disable all controls.
		do
			if mode then
				cluster_address.disable_sensitive
				class_label.disable_sensitive
				cluster_label.disable_sensitive
				feature_label.disable_sensitive
			end
			class_address.disable_sensitive
			feature_address.disable_sensitive
		end

	pop_up_address_bar_at_position (a_x, a_y: INTEGER; a_focus: INTEGER) is
			-- Display current address manager at position (`a_x', `a_y').
			-- `a_focus' indicates which combo box will have focus by default:
			-- 	 	1 cluster combo box
			--		2 class combo box
			--		3 feature combo box
			--		other: Focus is unset
		require
	   		for_context_tool: mode
  		local
		   window: EV_WINDOW
		   l_x: INTEGER
		   l_screen: EB_STUDIO_SCREEN
		do
			window := parent_window (header_info)
			if address_dialog.is_show_requested then
				address_dialog.hide
			end
			address_dialog.set_width (header_info.width)
			create l_screen
			if a_x + address_dialog.width > l_screen.virtual_width then
				l_x := l_screen.virtual_width - address_dialog.width
			elseif a_x < l_screen.virtual_x then
				l_x := l_screen.virtual_x
			else
				l_x := a_x
		   	end
		   	address_dialog.set_position (l_x, a_y)
			address_dialog.show
			remove_error_message
			inspect
				a_focus
			when 1 then
				cluster_address.set_focus
			when 2 then
				class_address.set_focus
			when 3 then
				feature_address.set_focus
			else
			end
		end

	hide_address_bar is
			-- Hide address bar dialog.
		do
			address_dialog.hide
		end

feature {EB_DEVELOPMENT_WINDOW, EB_DEVELOPMENT_WINDOW_DIRECTOR} -- Execution

	execute_with_cluster is
			-- The user just entered a new cluster name, process it.
		do
			extract_cluster_from_user_entry
		end

	execute_with_class is
			-- The user just entered a new class name, process it.
		do
			choosing_class := True
			process_user_entry
		end

	execute_with_feature is
			-- The user just entered a new feature name, process it.
		do
			choosing_class := False
			process_user_entry
		end

feature {NONE} -- Execution

	process_cluster_callback (pos: INTEGER) is
			-- The choice `pos' has been selected, process the choice.
		require
			looking_for_a_cluster: group_list /= Void
		do
			if pos /= 0 then
				current_group := group_list.i_th (pos)
				cluster_address.set_text (current_group.name.twin)
			end
			group_list := Void
			process_cluster
		end

	process_class_callback (pos: INTEGER) is
			-- The choice `pos' has been selected, process the choice.
		require
			looking_for_a_class: class_list /= Void
		do
			if pos /= 0 then
				class_i := class_list.i_th (pos)
				class_address.set_text (class_i.name)
			end
			class_list := Void
			if choosing_class then
				process_class
			else
				process_feature_class
			end
		end

	process_feature_callback (pos: INTEGER) is
			-- The choice `pos' has been selected, process the choice.
		require
			looking_for_a_feature: feature_list /= Void
		do
			if pos > 0 then
				current_feature := feature_list.i_th (pos)
				feature_address.set_text (current_feature.name.as_lower)
			end
			feature_list := Void
			if choosing_class then
				process_class_feature
			else
				process_feature_feature
			end
		end

	process_cluster is
			-- Finish processing the cluster after the user chose it.
		do
			if current_group = Void then
				display_error_message (Warning_messages.w_No_cluster_matches)
				if cluster_address.is_displayed then
					cluster_address.set_focus
					if not cluster_address.text.is_empty then
						cluster_address.select_all
					end
				end
			else
				remove_error_message
				parent.advanced_set_stone (create {CLUSTER_STONE}.make (current_group))
			end
		end

	process_class is
			-- Finish processing the class after the user chose it.
		local
			ctxt: STRING
			l_classc: CLASS_C
		do
			remove_error_message
			if class_i = Void then
				ctxt := class_address.text
				if
					not ctxt.is_empty and then
					not ctxt.has ('*') and then
					not ctxt.has ('?') and then
					workbench.is_in_stable_state
				then
					if (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (ctxt) then
						create new_class_win.make_default (parent)
						new_class_win.set_stone_when_finished
						new_class_win.call (class_address.text)
					else
						prompts.show_error_prompt (Warning_messages.w_Invalid_class_name (ctxt), parent.window, Void)
					end
				else
					display_error_message (Warning_messages.w_No_class_matches)
					if class_address.is_displayed then
						class_address.set_focus
						if not class_address.text.is_empty then
							class_address.select_all
						end
					end
				end
			else
				l_classc := class_i.compiled_representation
				if l_classc /= Void then
					extract_feature_from_user_entry
				else
					parent.advanced_set_stone (create {CLASSI_STONE}.make (class_i))
				end
			end
		end

	process_feature_class is
			-- Analyze the class the user chose, but we are choosing a feature.
		do
			remove_error_message
			if current_class = Void then
				if class_i = Void then
					display_error_message (Warning_messages.w_Specify_a_class)
					if class_address.is_displayed then
						class_address.set_focus
						if not class_address.text.is_empty then
							class_address.select_all
						end
					end
				else
					if not feature_address.text.is_empty then
						display_error_message (
							Warning_messages.w_not_a_compiled_class_line (class_i.name))
					end
					parent.advanced_set_stone (create {CLASSI_STONE}.make (class_i))
				end
			else
				if not feature_address.text.is_empty then
					extract_feature_from_user_entry
				else
					parent.advanced_set_stone (create {CLASSC_STONE}.make (current_class))
				end
			end
		end

	process_feature_feature is
			-- Process the feature the user has selected.
		local
			f: E_FEATURE
		do
			if current_feature = Void then
				display_error_message (Warning_messages.w_No_feature_matches)
				if feature_address.is_displayed then
						-- The selected feature is not in the selected class.
					feature_address.set_focus
					if not feature_address.text.is_empty then
						feature_address.select_all
					end
				end
				--| FIXME XR: Propose to create a new feature in current_class instead?
			else
				remove_error_message
				if mode then
					parent.advanced_set_stone (create {FEATURE_STONE}.make (current_feature))
				else
					f := current_feature.written_feature
					if f /= Void then
						parent.advanced_set_stone (create {FEATURE_STONE}.make (f))
					else
							-- Gasp, we are in the editor address and we can't find the origin feature...
						parent.advanced_set_stone (create {FEATURE_STONE}.make (current_feature))
					end
				end
			end
		end

	process_class_feature is
			-- We are choosing a class, but just in case we analyze the given feature.
		local
			l_class_c: CLASS_C
		do
			l_class_c := current_class
			check
				l_class_c_not_void: l_class_c /= Void
			end
			if
				current_feature = Void or else
				current_feature.written_class /= l_class_c and
				not mode
			then
				parent.advanced_set_stone (create {CLASSC_STONE}.make (l_class_c))
			else
				parent.advanced_set_stone (create {FEATURE_STONE}.make (current_feature))
			end
		end

feature -- Assertions

	known_formatters: ARRAYED_LIST [EB_CLASS_TEXT_FORMATTER]
			-- Formatters that can be selected in the format combo box.

	mode: BOOLEAN
			-- If `mode' then the display is for the context tool (`window', `header_info' are generated),
			-- otherwise it is for a development window (`widget' is generated).

feature {NONE} -- Implementation

	class_i: CLASS_I
			-- Current selected class.

	current_feature: E_FEATURE
			-- Current selected feature.

	current_group: CONF_GROUP
			-- Current selected group.

	choosing_class: BOOLEAN
			-- Do we want a feature or a class?

	must_show_choice: BOOLEAN
			-- Does the user have to perform a choice?

	class_list: LIST [CLASS_I]
			-- List of classes displayed in `choice'.

	group_list: LIST [CONF_GROUP]
			-- List of groups displayed in `choice'.

	feature_list: LIST [E_FEATURE]
			-- List of features of current class, if any.

	history_manager: EB_HISTORY_MANAGER is
			-- History for parent.
		do
			Result := parent.history_manager
		end

	choice: EB_CHOICE_DIALOG
			-- Dialog that gives the user the choice between possible classes, groups or features.
			-- It may be Void, destroyed, anything, so use with care.

	drop_class (cst: CLASSI_STONE) is
			-- Attempt to drop a class into the address bar.
		do
			parent.advanced_set_stone (cst)
		end

	drop_feature (fst: FEATURE_STONE) is
			-- Attempt to drop a feature into the address bar.
		do
			parent.advanced_set_stone (fst)
		end

	drop_cluster (cst: CLUSTER_STONE) is
			-- Attempt to drop a class into the address bar.
		do
			parent.advanced_set_stone (cst)
		end

	display_cluster_choice is
				-- Display cluster names from `group_list' to `choice'.
		require
			group_list_not_void: group_list /= Void
		local
			cluster_names: ARRAYED_LIST [STRING]
			cluster_pixmaps: ARRAYED_LIST [EV_PIXMAP]
			clusteri: CONF_GROUP
			cname: STRING
		do
			create cluster_names.make (group_list.count)
			create cluster_pixmaps.make (group_list.count)
			from
				group_list.start
			until
				group_list.after
			loop
				clusteri := group_list.item
				cname := clusteri.name.twin
				cluster_names.extend (cname)
				cluster_pixmaps.extend (pixmap_from_group (clusteri))
				group_list.forth
			end
			if not cluster_names.is_empty then
				remove_error_message
				if cluster_names.count = 1 then
					process_cluster_callback (1)
				else
					create choice.make_default (address_dialog, agent process_cluster_callback (?))
					choice.destroy_actions.extend (agent one_lost_focus)
					choice.set_title (Interface_names.t_Select_cluster)
					choice.set_list (cluster_names, cluster_pixmaps)
					choice.set_position (cluster_address.screen_x, cluster_address.screen_y + cluster_address.height)
					choice.set_width (cluster_address.width)
					must_show_choice := True
				end
			else
				display_error_message (Warning_messages.w_No_cluster_matches)
				process_cluster
			end
		end

	display_class_choice is
				-- Display class names from `class_list' to `choice'.
		require
			class_list_not_void: class_list /= Void
		local
			class_names: ARRAYED_LIST [STRING]
			class_pixmaps: ARRAYED_LIST [EV_PIXMAP]
			classi, last_class: CLASS_I
			cname, last_name: STRING
			first_ambiguous: BOOLEAN
		do
				-- First remove all overriden classes if any before display the choice.
			from
				class_list.start
			until
				class_list.after
			loop
				if class_list.item.config_class.is_overriden then
					class_list.remove
				else
					class_list.forth
				end
			end

				-- Fill the choice list
			create class_names.make (class_list.count)
			create class_pixmaps.make (class_list.count)
			from class_list.start until class_list.after loop
				classi := class_list.item
				cname := classi.name.twin
				if
					last_class /= Void and then
					last_class.name.is_equal (cname)
				then
					if not first_ambiguous then
						first_ambiguous := True
						last_name := class_names.last
						last_name.extend ('@')
						last_name.append (last_class.group.name)
					end
					cname.extend ('@')
					cname.append (classi.group.name)
				else
					first_ambiguous := False
				end
				class_names.extend (cname)
				class_pixmaps.extend (pixmap_from_class_i (classi))
				last_class := classi
				class_list.forth
			end
			if not class_names.is_empty then
				remove_error_message
				if class_names.count = 1 then
					process_class_callback (1)
				else
					create choice.make_default (address_dialog, agent process_class_callback (?))
					choice.destroy_actions.extend (agent one_lost_focus)
					choice.set_title (Interface_names.t_Select_class)
					choice.set_list (class_names, class_pixmaps)
					choice.set_position (class_address.screen_x, class_address.screen_y + class_address.height)
					choice.set_width (class_address.width)
					must_show_choice := True
				end
			else
				display_error_message (Warning_messages.w_No_class_matches)
				if choosing_class then
					process_class
				else
					process_feature_class
				end
			end
		end

	display_feature_choice is
			-- Display feature names from `feature_list' to `choice'.
		require
			feature_list_not_void: feature_list /= Void
		local
			feature_names: ARRAYED_LIST [STRING]
			feature_pixmaps: ARRAYED_LIST [EV_PIXMAP]
		do
			create feature_names.make (feature_list.count)
			create feature_pixmaps.make (feature_list.count)
			from
				feature_list.start
			until
				feature_list.after
			loop
				feature_names.extend (feature_list.item.name)
				feature_pixmaps.extend (pixmap_from_e_feature (feature_list.item))
				feature_list.forth
			end
			if not feature_names.is_empty then
				if feature_names.count = 1 then
					process_feature_callback (1)
				else
					create choice.make_default (address_dialog, agent process_feature_callback (?))
					choice.destroy_actions.extend (agent one_lost_focus)
					choice.set_title (Interface_names.t_Select_feature)
					choice.set_list (feature_names, feature_pixmaps)
					choice.set_position (feature_address.screen_x, feature_address.screen_y + feature_address.height)
					choice.set_width (feature_address.width)
					must_show_choice := True
				end
			else
				if choosing_class then
					process_class_feature
				else
					process_feature_feature
				end
			end
		end

feature {NONE} -- open new class

	extract_cluster_from_user_entry is
			-- Process the user entry in `cluster_address' to generate `current_group'.
		local
			fname: STRING
			cl: ARRAYED_LIST [CONF_GROUP]
			matcher: KMP_WILD
			matching: SORTED_TWO_WAY_LIST [CONF_GROUP]
		do
			if workbench.is_universe_ready then
				current_group := Void
				fname := cluster_address.text
				if fname /= Void then
					fname.left_adjust
					fname.right_adjust
				end
				if fname = Void or else fname.is_empty then
					process_cluster
				else
					fname.to_lower
					create matcher.make_empty
					matcher.set_pattern (fname)
					if not matcher.has_wild_cards then
						if is_general_group_acceptable then
							current_group := universe.group_of_name (fname)
						else
							current_group := Universe.cluster_of_name (fname)
						end
						process_cluster
					elseif Universe.target /= Void then
						from
							if is_general_group_acceptable then
								cl := Universe.groups
							else
								cl := Universe.target.clusters.linear_representation
							end
							cl.start
							create matching.make
						until
							cl.after
						loop
							matcher.set_text (cl.item.name)
							if matcher.pattern_matches then
								matching.extend (cl.item)
							end
							cl.forth
						end
						matching.sort
						group_list := matching
						display_cluster_choice
					end
				end
			else
				if address_dialog /= Void and then address_dialog.is_displayed then
					address_dialog.hide
				end
			end
		end

	process_user_entry is
			-- process the user entry
		local
			cname: STRING
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I]
			at_pos: INTEGER
			cluster: CLUSTER_I
			cluster_name: STRING
			matcher: KMP_WILD
			l_classes: DS_HASH_SET [CLASS_I]
		do
			if workbench.is_universe_ready then
				class_i := Void
				cname := class_address.text
				if cname /= Void then
					cname.left_adjust
					cname.right_adjust
				end
				if cname = Void or else cname.is_empty then
					if choosing_class then
						process_class
					else
						process_feature_class
					end
				else
					cname.to_upper
					create matcher.make_empty
					matcher.set_pattern (cname)
					if not matcher.has_wild_cards then
						at_pos := cname.index_of ('@', 1)
						if at_pos = cname.count then
							cname.keep_head (cname.count - 1)
							class_address.set_text (cname)
							at_pos := 0
						end
						if at_pos = 0 then
							if universe.target = Void then
								class_list := Void
							else
								class_list := Universe.classes_with_name (cname)
							end
							if class_list = Void or else class_list.is_empty then
								class_list := Void
								if choosing_class then
									process_class
								else
									process_feature_class
								end
							elseif class_list.count = 1 then
								class_i := class_list.first
								if choosing_class then
									process_class
								else
									process_feature_class
								end
							else
								display_class_choice
							end
						else
							cluster_name := cname.substring (at_pos + 1, cname.count)
							if at_pos > 1 then
								cname := cname.substring (1, at_pos - 1)
							else
								cname := ""
							end
							cluster := Universe.cluster_of_name (cluster_name)
							if cluster = Void then
								prompts.show_error_prompt (Warning_messages.w_Cannot_find_cluster (cluster_name), parent.window, Void)
								if class_address.is_displayed then
									class_address.set_focus
									class_address.select_region (at_pos + 1, class_address.text_length)
								end
							else
								class_i ?= cluster.classes.item (cname)
								if choosing_class then
									process_class
								else
									process_feature_class
								end
							end
						end
					else
						from
							create sorted_classes.make
							l_classes := universe.all_classes
							l_classes.start
						until
							l_classes.after
						loop
							matcher.set_text (l_classes.item_for_iteration.name)
							if matcher.pattern_matches then
								sorted_classes.put_front (l_classes.item_for_iteration)
							end
							l_classes.forth
						end
						sorted_classes.sort
						class_list := sorted_classes
						display_class_choice
					end
				end
			else
				if address_dialog /= Void and then address_dialog.is_displayed then
					address_dialog.hide
				end
			end
		end

	extract_feature_from_user_entry is
			-- Process the user entry in `feature_address' to generate `feature_name'.
		require
			give_a_class_first: current_class /= Void
		local
			fname: STRING
			sorted_features: SORTED_TWO_WAY_LIST [E_FEATURE]
			ft: E_FEATURE_TABLE
			fl: LIST [E_FEATURE]
			matcher: KMP_WILD
		do
			current_feature := Void
			fname := feature_address.text
			if not fname.is_empty then
				fname.left_adjust
				fname.right_adjust
			end
			if fname = Void or else fname.is_empty then
				if choosing_class then
					process_class_feature
				else
					process_feature_feature
				end
			else
				fname.to_lower
				create matcher.make_empty
				matcher.set_pattern (fname)
				if not matcher.has_wild_cards then
					if current_class.has_feature_table then
						current_feature := get_feature_named (fname)
					end
					if choosing_class then
						process_class_feature
					else
						process_feature_feature
					end
				else
					create sorted_features.make
					if current_class.has_feature_table then
						if mode or not choosing_class then
							from
								ft := current_class.api_feature_table
								ft.start
							until
								ft.after
							loop
								matcher.set_text (ft.item_for_iteration.name)
								if matcher.pattern_matches then
									sorted_features.put_front (ft.item_for_iteration)
								end
								ft.forth
							end
						else
								-- In the editor we only propose the written-in features
								-- if the user pressed enter in the class address.
							fl := current_class.written_in_features
							from
								fl.start
							until
								fl.after
							loop
								matcher.set_text (fl.item.name)
								if matcher.pattern_matches then
									sorted_features.put_front (fl.item)
								end
								fl.forth
							end
						end
					end
					sorted_features.sort
					feature_list := sorted_features
					display_feature_choice
				end
			end
		end

	get_feature_named (name: STRING): E_FEATURE is
			-- Return the feature named `name' of class `current_class'.
		require
			class_selected: class_i /= Void
			valid_class: current_class /= Void
		local
			t: E_FEATURE_TABLE
			found: BOOLEAN
		do
			t := current_class.api_feature_table
			if t /= Void then
					-- Even in a class_c, the feature table may be Void (if half-compiled).
				from
					t.start
				until
					t.after or else found
				loop
					if t.item_for_iteration.name.is_equal (name) then
						Result := t.item_for_iteration
						found := True
					else
						t.forth
					end
				end
			end
		end

	change_hist_to_class is
			-- Center the history manager on a different stone.
		local
			conv_int: INTEGER_REF
			item: EV_LIST_ITEM
		do
			item := class_address.selected_item
			if item /= Void then
				conv_int ?= item.data
				parent.history_manager.go_i_th (conv_int.item)
			end
		end

	change_hist_to_feature is
			-- Center the history manager on a different stone.
		local
			conv_int: INTEGER_REF
			item: EV_LIST_ITEM
		do
			item := feature_address.selected_item
			if item /= Void then
				conv_int ?= item.data
				parent.history_manager.go_i_th (conv_int.item)
			end
		end

	change_hist_to_cluster is
			-- Center the history manager on a different stone.
		local
			conv_int: INTEGER_REF
			item: EV_LIST_ITEM
		do
			item := cluster_address.selected_item
			if item /= Void then
				conv_int ?= item.data
				parent.history_manager.go_i_th (conv_int.item)
			end
		end

	cluster_key_up (k: EV_KEY) is
			-- A key was released in the cluster address.
			-- If it is return, call execute_with_cluster.
		do
			if k /= Void then
				if k.code = {EV_KEY_CONSTANTS}.key_enter then
					if must_show_choice and choice /= Void and then not choice.is_destroyed then
						lost_focus_action_enabled := False
						choice.show
						lost_focus_action_enabled := True
					end
				elseif k.code = {EV_KEY_CONSTANTS}.Key_escape then
					if mode then
						address_dialog.hide
					end
				end
			end
		end

	class_key_up (k: EV_KEY) is
			-- A key was released in the class address.
			-- If it is return, call execute_with_class.
		do
			if k /= Void then
				if k.code = {EV_KEY_CONSTANTS}.key_enter then
					if must_show_choice and choice /= Void and then not choice.is_destroyed then
						lost_focus_action_enabled := False
						choice.show
						lost_focus_action_enabled := True
					end
				elseif k.code = {EV_KEY_CONSTANTS}.Key_escape then
					if mode then
						address_dialog.hide
					end
				end
			end
		end

	feature_key_up (k: EV_KEY) is
			-- A key was released in the feature address.
			-- If it is return, call execute_with_feature.
		do
			if k /= Void then
				if k.code = {EV_KEY_CONSTANTS}.key_enter then
					if must_show_choice and choice /= Void and then not choice.is_destroyed then
						lost_focus_action_enabled := False
						choice.show
						lost_focus_action_enabled := True
					end
				elseif k.code = {EV_KEY_CONSTANTS}.Key_escape then
					if mode then
						address_dialog.hide
					end
				end
			end
		end

	class_key_down (k: EV_KEY) is
			-- A key was pressed in the class address.
			-- If it is return, call execute_with_class.
		do
			if k /= Void then
				last_key_was_delete := False
				last_key_was_backspace := False
				if k.code = {EV_KEY_CONSTANTS}.key_enter then
					execute_with_class
					if class_address.text_length > 0 then
						class_address.select_all
					end
				elseif k.code = {EV_KEY_CONSTANTS}.Key_delete then
					last_key_was_delete := True
				elseif k.code = {EV_KEY_CONSTANTS}.Key_back_space then
					last_key_was_backspace := True
					if class_address.has_selection then
						had_selection := True
					else
						had_selection := False
					end
				end
			end
		end

	cluster_key_down (k: EV_KEY) is
			-- A key was pressed in the cluster address.
			-- If it is return, call execute_with_cluster.
		do
			if k /= Void then
				last_key_was_delete := False
				last_key_was_backspace := False
				if k.code = {EV_KEY_CONSTANTS}.key_enter then
					execute_with_cluster
					if cluster_address.text_length > 0 then
						cluster_address.select_all
					end
				elseif k.code = {EV_KEY_CONSTANTS}.Key_delete then
					last_key_was_delete := True
				elseif k.code = {EV_KEY_CONSTANTS}.Key_back_space then
					last_key_was_backspace := True
					if cluster_address.has_selection then
						cluster_had_selection := True
					else
						cluster_had_selection := False
					end
				end
			end
		end

	feature_key_down (k: EV_KEY) is
			-- A key was pressed in the feature address.
			-- If it is return, call execute_with_feature.
		do
			if k /= Void then
				last_key_was_delete := False
				last_key_was_backspace := False
				if k.code = {EV_KEY_CONSTANTS}.key_enter then
					execute_with_feature
					if feature_address.text_length > 0 then
						feature_address.select_all
					end
				elseif k.code = {EV_KEY_CONSTANTS}.Key_delete then
					last_key_was_delete := True
				elseif k.code = {EV_KEY_CONSTANTS}.Key_back_space then
					last_key_was_backspace := True
					if feature_address.has_selection then
						feature_had_selection := True
					else
						feature_had_selection := False
					end
				end
			end
		end

	last_key_was_delete: BOOLEAN
			-- Was the last pressed key `delete'?

	last_key_was_backspace: BOOLEAN
			-- Was the last pressed key `back_space'?

	cluster_had_selection: BOOLEAN
			-- Did the cluster address had a selection when the user hit the key?
			-- Only meaningful if `last_key_was_backspace'.

	had_selection: BOOLEAN
			-- Did the class address had a selection when the user hit the key?
			-- Only meaningful if `last_key_was_backspace'.

	feature_had_selection: BOOLEAN
			-- Did the feature address had a selection when the user hit the key?
			-- Only meaningful if `last_key_was_backspace'.

	current_typed_class: CLASS_C
			-- May contain the class that corresponds to the name in `class_address'.
			-- Used in the feature completion.

	update_current_typed_class is
			-- Try to update `current_typed_class' based on the contents of `class_address'.
		local
			clist: CLASS_C_SERVER
			l_class: CLASS_C
			i: INTEGER
			ccname: STRING
		do
			current_typed_class := Void
			if Workbench.is_universe_ready and enable_feature_complete then
				clist := system.classes
				ccname := class_address.text
				ccname.to_upper
				from
					i := clist.lower
				until
					i > clist.upper or current_typed_class /= Void
				loop
					l_class := clist.item (i)
					if l_class /= Void and then l_class.name.is_equal (ccname) then
						current_typed_class := l_class
					end
					i := i + 1
				end
			end
		end

	type_class is
			-- Try to complete the class name.
		local
			str: STRING
			nb, minc: INTEGER
			index, j: INTEGER
			list: CLASS_C_SERVER
			current_found: STRING
			cname: STRING
			array_count: INTEGER
			do_not_complete: BOOLEAN
			same_st, dif: BOOLEAN
			last_caret_position: INTEGER
			str_area, current_area, other_area: SPECIAL [CHARACTER]
			l_class: CLASS_C
			truncated: BOOLEAN
		do
				-- The text in `class_address' has changed => we don't know what's inside.
			current_typed_class := Void

			str := class_address.text
			if not str.is_empty and then (str @ (str.count) /= ' ') then
				last_caret_position := class_address.caret_position
				class_address.change_actions.block
					-- Remove white space from classname
				str.left_adjust
				str.right_adjust
					-- Convert classname input to uppercase for classes
				str.to_upper
					-- Replace spaces with underscores for classes
				str.replace_substring_all (" ", "_")
					-- Replace dashes with underscores for classes
				str.replace_substring_all ("-", "_")
				nb := str.count
				do_not_complete :=	last_key_was_delete or
									not enable_complete or
									last_caret_position /= nb + 1 or
									not Workbench.is_universe_ready
				if nb > 0 and not do_not_complete and last_key_was_backspace and had_selection then
					str.keep_head (nb - 1)
					nb := nb - 1
					truncated := True
				end

				if not do_not_complete and nb > 1 then
					list := System.classes
					array_count := system.class_counter.count
					from
						index := 1
						str_area := str.area
					until
						index > array_count
					loop
						l_class := (list @ index)
						if l_class /= Void then
							cname := l_class.name
							other_area := cname.area
								-- We first check that other_area and str_area have the same start.
							if other_area.count >= nb then
								from
									j := 0
									same_st := True
								until
									j = nb or not same_st
								loop
									same_st := (str_area.item (j)) = (other_area.item (j))
									j := j + 1
								end
								if same_st then
									if current_found = Void then
										current_found := cname
										current_area := other_area
									else
										from
											minc := other_area.count.min (current_area.count)
											dif := False
										until
											dif or j = minc
										loop
											if (current_area.item (j)) /= (other_area.item (j)) then
												dif := True
												if (current_area.item (j)) > (other_area.item (j)) then
													current_found := cname
													current_area := other_area
												end
											end
											j := j + 1
										end
										if not dif and other_area.count < current_area.count then
												-- Other and Current have the same characters.
												-- Return the shorter one.
											current_found := cname
											current_area := other_area
										end
									end
								end
							end
						end
						index := index + 1
					end
					if current_found /= Void then
						if not last_key_was_backspace then
							current_found := current_found.as_upper
							class_address.set_text (current_found)
							if nb < current_found.count then
								class_address.select_region (nb + 1, current_found.count)
							else
								class_address.set_caret_position (current_found.count + 1)
							end
						end
					elseif not (last_key_was_backspace and had_selection) then
						str.to_upper
						class_address.set_text (str)
						class_address.set_caret_position (str.count + 1)
					end
				else
					str.to_upper
					class_address.set_text (str)
					if not truncated then
						class_address.set_caret_position (last_caret_position.min (str.count + 1))
					else
						class_address.set_caret_position (nb + 1)
					end
				end
			end
			class_address.change_actions.resume
		end

	type_cluster is
			-- Try to complete the cluster name.
		local
			str: STRING
			nb, minc: INTEGER
			j: INTEGER
			list: ARRAYED_LIST [CONF_GROUP]
			current_found: STRING
			cname: STRING
			do_not_complete: BOOLEAN
			last_caret_position: INTEGER
			same_st, dif: BOOLEAN
			str_area, current_area, other_area: SPECIAL [CHARACTER]
			truncated: BOOLEAN
		do
			cluster_address.change_actions.block
			last_caret_position := cluster_address.caret_position
			str := cluster_address.text
			if workbench.universe_defined and then universe.target /= Void and then not str.is_empty and then (str @ (str.count) /= ' ') then
				str.left_adjust
				str.right_adjust
				str.to_lower
				nb := str.count
				do_not_complete :=	last_key_was_delete or
									not enable_cluster_complete or
									last_caret_position /= str.count + 1
				if nb > 0 and not do_not_complete and last_key_was_backspace and cluster_had_selection then
					str.keep_head (nb - 1)
					nb := nb - 1
					truncated := True
				end

				if not do_not_complete and nb > 0 then
					if is_general_group_acceptable then
						list := universe.groups
					else
						list := universe.target.clusters.linear_representation
					end
					from
						str_area := str.area
						list.start
					until
						list.after
					loop
						cname := list.item.name
						other_area := cname.area
							-- We first check that other_area and str_area have the same start.
						if other_area.count >= nb then
							from
								j := 0
								same_st := True
							until
								j = nb or not same_st
							loop
								same_st := (str_area.item (j)) = (other_area.item (j))
								j := j + 1
							end
							if same_st then
								if current_found = Void then
									current_found := cname
									current_area := other_area
								else
									from
										minc := other_area.count.min (current_area.count)
										dif := False
									until
										dif or j = minc
									loop
										if (current_area.item (j)) /= (other_area.item (j)) then
											dif := True
											if (current_area.item (j)) > (other_area.item (j)) then
												current_found := cname
												current_area := other_area
											end
										end
										j := j + 1
									end
									if not dif and other_area.count < current_area.count then
											-- Other and Current have the same characters.
											-- Return the shorter one.
										current_found := cname
										current_area := other_area
									end
								end
							end
						end
						list.forth
					end
					if current_found /= Void then
						if not last_key_was_backspace then
							cluster_address.set_text (current_found)
							if nb < current_found.count then
								cluster_address.select_region (nb + 1, current_found.count)
							else
								cluster_address.set_caret_position (current_found.count + 1)
							end
						end
					elseif not (last_key_was_backspace and cluster_had_selection) then
						cluster_address.set_text (str)
						cluster_address.set_caret_position (str.count + 1)
					end
				else
					cluster_address.set_text (str)
					if not truncated then
						cluster_address.set_caret_position (last_caret_position)
					else
						cluster_address.set_caret_position (nb + 1)
					end
				end
			end
			cluster_address.change_actions.resume
		end

	type_feature is
			-- The user typed a new key in the feature combo.
			-- Try to complete the feature name.
		local
			str: STRING_32
			nb, minc: INTEGER
			j: INTEGER
			list: FEATURE_TABLE
			current_found: STRING_32
			cname: STRING_32
			do_not_complete: BOOLEAN
			last_caret_position: INTEGER
			same_st, dif: BOOLEAN
			str_area, current_area, other_area: SPECIAL [CHARACTER_32]
			truncated: BOOLEAN
		do
			feature_address.change_actions.block
			str := feature_address.text

			--|FIXME: The way used to decide if a name should be completed is bad.
--			if not str.is_empty and then not (str.substring_index (l_From, 1) > 0) then
			if not str.is_empty and then not (str.substring_index (interface_names.l_from ("", ""), 1) > 0) then
				last_caret_position := feature_address.caret_position
					-- Only perform `left_adjust' so that we can type `infix "X"' in the combo box.
				str.left_adjust
				str.to_lower
				nb := str.count
				do_not_complete :=	last_key_was_delete or
									not enable_feature_complete or
									last_caret_position /= str.count + 1
				if nb > 0 and not do_not_complete and last_key_was_backspace and feature_had_selection then
					str.keep_head (nb - 1)
					nb := nb - 1
					truncated := True
				end

				if
					current_typed_class /= Void and then
					current_typed_class.has_feature_table and
					not do_not_complete and
					nb > 0
				then
					list := current_typed_class.feature_table
					from
						list.start
						str_area := str.area
					until
						list.after
					loop
						cname := list.item_for_iteration.feature_name
						other_area := cname.area
							-- We first check that other_area and str_area have the same start.
						if other_area.count >= nb then
							from
								j := 0
								same_st := True
							until
								j = nb or not same_st
							loop
								same_st := (str_area.item (j)) = (other_area.item (j))
								j := j + 1
							end
							if same_st then
								if current_found = Void then
									current_found := cname
									current_area := other_area
								else
									from
										minc := other_area.count.min (current_area.count)
										dif := False
									until
										dif or j = minc
									loop
										if (current_area.item (j)) /= (other_area.item (j)) then
											dif := True
											if (current_area.item (j)) > (other_area.item (j)) then
												current_found := cname
												current_area := other_area
											end
										end
										j := j + 1
									end
									if not dif and other_area.count < current_area.count then
											-- Other and Current have the same characters.
											-- Return the shorter one.
										current_found := cname
										current_area := other_area
									end
								end
							end
						end
						list.forth
					end
					if current_found /= Void then
						if not last_key_was_backspace then
							feature_address.set_text (current_found)
							if nb < current_found.count then
								feature_address.select_region (nb + 1, current_found.count)
							else
								feature_address.set_caret_position (current_found.count + 1)
							end
						end
					elseif not (last_key_was_backspace and feature_had_selection) then
						feature_address.set_text (str)
						feature_address.set_caret_position (str.count + 1)
					end
				else
					feature_address.set_text (str)
					if not truncated then
						feature_address.set_caret_position (last_caret_position)
					else
						feature_address.set_caret_position (nb + 1)
					end
				end
			end
			feature_address.change_actions.resume
		end

	current_class: CLASS_C is
			-- Currently examined class_c.
			-- Either what the user typed in `class_address' or manager's stone.
		do
			if class_i /= Void then
				Result := class_i.compiled_representation
			end
		end

	launch_cluster is
			-- Send a stone representing `current_group' to `parent'.
		require
			cluster_selected: current_group /= Void
		do
			if current_group /= Void then
				parent.advanced_set_stone (create {CLUSTER_STONE}.make (current_group))
			end
		end

	launch_class is
			-- Send a stone representing `current_class' or `class_i' to `parent'.
		require
			class_selected: class_i /= Void
		do
			if current_class /= Void then
				parent.advanced_set_stone (create {CLASSC_STONE}.make (current_class))
			else
				parent.advanced_set_stone (create {CLASSI_STONE}.make (class_i))
			end
		end

	launch_feature is
			-- Send a stone representing `feature' to `parent'.
		require
			feature_selected: current_feature /= Void
		local
			st: FEATURE_STONE
		do
			create st.make (current_feature)
			parent.advanced_set_stone (st)
		end

feature {NONE} -- Implementation of the clickable labels for `header_info'

	lost_focus_action_enabled: BOOLEAN
			-- Should `one_lost_focus' do something?

	cluster_label: EV_LABEL
	class_label: EV_LABEL
	feature_label: EV_LABEL
			-- Labels displayed in the header_info.

	output_line: EV_LABEL
			-- Textable in which warnings are displayed.
			-- May be Void, warnings are then not displayed.

	address_dialog: EV_POPUP_WINDOW
			-- Window that pops up in the context tool to change the stone centering.

	set_mode (for_context_tool: BOOLEAN) is
			-- Define `Current's execution mode (generated parent_windows are different).
		do
			mode := for_context_tool
		end

	generate_header_info is
			-- Create all parent_windows used in `header_info'.
		local
			def_col: EV_STOCK_COLORS
			hb: EV_HORIZONTAL_BOX
		do
			create header_info
			create cluster_label
			create class_label
			create feature_label
			create def_col
			create hb

			update_colors

			cluster_label.pointer_enter_actions.extend (agent highlight_label (cluster_label))
			cluster_label.pointer_leave_actions.extend (agent unhighlight_label (cluster_label))
			class_label.pointer_enter_actions.extend (agent highlight_label (class_label))
			class_label.pointer_leave_actions.extend (agent unhighlight_label (class_label))
			feature_label.pointer_enter_actions.extend (agent highlight_label (feature_label))
			feature_label.pointer_leave_actions.extend (agent unhighlight_label (feature_label))

			cluster_label.pointer_button_press_actions.extend (agent button_action (cluster_address, ?, ?, ?, ?, ?, ?, ?, ?))
			class_label.pointer_button_press_actions.extend (agent button_action (class_address, ?, ?, ?, ?, ?, ?, ?, ?))
			feature_label.pointer_button_press_actions.extend (agent button_action (feature_address, ?, ?, ?, ?, ?, ?, ?, ?))

			class_label.drop_actions.extend (agent drop_class)
			feature_label.drop_actions.extend (agent drop_feature)
			cluster_label.drop_actions.extend (agent drop_cluster)

			cluster_label.enable_sensitive
			class_label.enable_sensitive
			feature_label.enable_sensitive

			cluster_label.set_accept_cursor (Cursors.cur_Cluster)
			class_label.set_accept_cursor (Cursors.cur_Class)
			feature_label.set_accept_cursor (Cursors.cur_Feature)
			cluster_label.set_deny_cursor (Cursors.cur_X_Cluster)
			class_label.set_deny_cursor (Cursors.cur_X_Class)
			feature_label.set_deny_cursor (Cursors.cur_X_Feature)

			cluster_label.set_text (default_cluster_name)
			highlight_label (cluster_label)
			unhighlight_label (cluster_label)

			class_label.set_text (default_class_name)
			highlight_label (class_label)
			unhighlight_label (class_label)

			feature_label.set_text (default_feature_name)
			highlight_label (feature_label)
			unhighlight_label (feature_label)

			cluster_label.set_configurable_target_menu_mode
			class_label.set_configurable_target_menu_mode
			feature_label.set_configurable_target_menu_mode

			cluster_label.set_configurable_target_menu_handler (agent context_menu_handler)
			class_label.set_configurable_target_menu_handler (agent context_menu_handler)
			feature_label.set_configurable_target_menu_handler (agent context_menu_handler)

			hb.set_padding (2)
			hb.extend (cluster_label)
			hb.extend (class_label)
			hb.extend (feature_label)
			hb.disable_item_expand (cluster_label)
			hb.disable_item_expand (class_label)
			hb.disable_item_expand (feature_label)
			header_info.extend (hb)
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Context menu handler
		do
			if context_menu_factory /= Void then
				context_menu_factory.standard_compiler_item_menu (a_menu, a_target_list, a_source, a_pebble)
			end
		end

	update_labels is
			-- Refresh the text of the labels according to the history status.
		require
			for_context_tool: mode
		local
			conv_clus: CLUSTER_STONE
			conv_class: CLASSI_STONE
			conv_f: FEATURE_STONE
			text: STRING
			c_stone: STONE
			l_class_c: CLASS_C
		do
			c_stone := parent.history_manager.active
			conv_clus ?= c_stone
			if conv_clus /= Void then
				text := conv_clus.group.name
				cluster_label.set_minimum_width (maximum_label_width (text))
				cluster_label.set_text (text)
				cluster_label.set_pebble (conv_clus)
				class_label.set_minimum_width (maximum_label_width (default_class_name))
				class_label.set_text (default_class_name)
				class_label.remove_pebble
				feature_label.set_minimum_width (maximum_label_width (default_feature_name))
				feature_label.set_text (default_feature_name)
				feature_label.remove_pebble
			else
				conv_f ?= c_stone
				if conv_f /= Void then
					text := conv_f.feature_name
					feature_label.set_minimum_width (maximum_label_width (text))
					feature_label.set_text (text)
					feature_label.set_pebble (create {FEATURE_STONE}.make (conv_f.e_feature))
					text := conv_f.e_feature.associated_class.name
					class_label.set_minimum_width (maximum_label_width (text))
					class_label.set_text (text)
					class_label.set_pebble (create {CLASSC_STONE}.make (conv_f.e_feature.associated_class))
					text := conv_f.e_feature.associated_class.group.name
					cluster_label.set_pebble (create {CLUSTER_STONE}.make (conv_f.e_feature.associated_class.group))
					cluster_label.set_minimum_width (maximum_label_width (text))
					cluster_label.set_text (text)
				else
					conv_class ?= c_stone
					if conv_class /= Void then
						text := conv_class.group.name
						cluster_label.set_pebble (create {CLUSTER_STONE}.make (conv_class.group))
						cluster_label.set_minimum_width (maximum_label_width (text))
						cluster_label.set_text (text)
						text := conv_class.class_i.name
						l_class_c := conv_class.class_i.compiled_representation
						if l_class_c /= Void then
							class_label.set_pebble (create {CLASSC_STONE}.make (l_class_c))
						else
							class_label.set_pebble (create {CLASSI_STONE}.make (conv_class.class_i))
						end
						class_label.set_minimum_width (maximum_label_width (text))
						class_label.set_text (text)
						feature_label.remove_pebble
						feature_label.set_minimum_width (maximum_label_width (default_feature_name))
						feature_label.set_text (default_feature_name)
					else
						cluster_label.remove_pebble
						cluster_label.set_minimum_width (maximum_label_width (default_cluster_name))
						cluster_label.set_text (default_cluster_name)
						class_label.remove_pebble
						class_label.set_minimum_width (maximum_label_width (default_class_name))
						class_label.set_text (default_class_name)
						feature_label.remove_pebble
						feature_label.set_minimum_width (maximum_label_width (default_feature_name))
						feature_label.set_text (default_feature_name)
					end
				end
			end
			label_changed_actions.call (Void)
		end

	update_combos is
			-- Refresh the text in the combo boxes in order to display the current stone.
		local
			conv_clus: CLUSTER_STONE
			conv_class: CLASSI_STONE
			conv_f: FEATURE_STONE
			c_stone: STONE
		do
			c_stone := parent.history_manager.active
			conv_clus ?= c_stone
			if conv_clus /= Void then
				if mode then
					cluster_address.set_text (conv_clus.group.name)
				end
				class_address.remove_text
				feature_address.remove_text
			else
				if not mode then
					conv_class ?= c_stone
					if conv_class /= Void then
						class_address.set_text (conv_class.class_i.name)
						conv_f ?= c_stone
						if conv_f /= Void then
							feature_address.set_text (conv_f.origin_name)
						else
							feature_address.remove_text
						end
					else
						class_address.remove_text
						feature_address.remove_text
					end
				else
					conv_f ?= c_stone
					if conv_f /= Void then
						feature_address.set_text (conv_f.feature_name)
						class_address.set_text (conv_f.e_feature.associated_class.name)
						cluster_address.set_text (conv_f.e_feature.associated_class.group.name)
					else
						conv_class ?= c_stone
						if conv_class /= Void then
							cluster_address.set_text (conv_class.group.name)
							class_address.set_text (conv_class.class_i.name)
							feature_address.remove_text
						else
							cluster_address.remove_text
							class_address.remove_text
							feature_address.remove_text
						end
					end
				end
			end
		end

	pop_up_address_bar is
			-- Display a window containing an address bar to change the stone.
		require
	   		for_context_tool: mode
		do
			pop_up_address_bar_at_position ((header_info.screen_x + header_info.width // 2) - address_dialog.width // 2, header_info.screen_y, 0)
		end

	button_action (combo: EV_COMBO_BOX; x, y, b: INTEGER; d1, d2, d3: DOUBLE; ax, ay: INTEGER) is
			-- Action performed when one of the labels is clicked.
			-- Pop up `address_dialog' and give focus to `combo'.
		require
			for_context_tool: mode
		do
			if b = 1 then
				lost_focus_action_enabled := False
				pop_up_address_bar
				if combo.is_displayed then
					combo.set_focus
				end
				lost_focus_action_enabled := True
			end
		end

	one_lost_focus is
			-- One of the widgets displayed in `address_dialog' has lost the focus.
			-- If none now has the focus, hide `address_dialog'.
		do
			if mode then
			-- Now it's for context tool, `address_dialog' exists.
				if
					lost_focus_action_enabled and then
					(class_address = Void or else not class_address.has_focus) and then
					(feature_address = Void or else not feature_address.has_focus) and then
					(cluster_address = Void or else not cluster_address.has_focus) and then
					(address_dialog = Void or else not address_dialog.has_focus) and then
					(choice = Void or else (choice.is_destroyed or else not choice.is_show_requested))
				then
					address_dialog.hide
				end
			end
		end

	Big_font: EV_FONT is
			-- Font used to highlight labels.
		do
			Result := Default_font
			Result.set_weight ({EV_FONT_CONSTANTS}.Weight_black)
		end

	Default_font: EV_FONT is
			-- Font used to display labels.
			-- FIXIT: We should use once routine instead of creating a EV_FONT every time? Because this is GDI object limitations on Windows.
		local
			l_shared: SD_SHARED -- FIXIT: After class EV_STOCK_FONTS added, we should use that instead of SD_SHARED.
		do
			create l_shared
			Result := l_shared.tool_bar_font.twin
		end

	highlight_label (lab: EV_LABEL) is
			-- Display `lab' with a bold font.
		local
			a_font: EV_FONT
		do
			a_font := big_font
			lab.set_minimum_width (maximum_label_width (lab.text))
			lab.set_font (a_font)
		end

	maximum_label_width (a_text: STRING_GENERAL): INTEGER is
			-- Maximum width of a label when set with text `a_text'
		require
			a_text_not_void: a_text /= Void
		do
			Result := Default_font.string_width (a_text).max (big_font.string_width (a_text))
		end

	unhighlight_label (lab: EV_LABEL) is
			-- Display `lab' with a bold font.
		do
			lab.set_font (Default_font)
		end

	display_error_message (a_message: STRING_GENERAL) is
			-- Display error message `a_message'.
		require
			a_message_not_void: a_message /= Void
		do
			if output_line /= Void then
				output_line.set_foreground_color (preferences.editor_data.error_text_color)
				output_line.set_text (a_message)
				output_line.refresh_now
			else
				-- FIXME: how do we warn the user?
			end
		end

	remove_error_message is
			-- Remove any message from `output_line'.
		do
			if output_line /= Void then
				output_line.remove_text
			end
		end

	enable_complete: BOOLEAN is
			-- Does the user want class names to be completed?
		do
			Result := preferences.development_window_data.class_completion --, True
		end

	enable_feature_complete: BOOLEAN is
			-- Does the user want feature names to be completed?
		do
			Result := preferences.development_window_data.class_completion --, True
		end

	enable_cluster_complete: BOOLEAN is
			-- Does the user want cluster names to be completed?
		do
			Result := preferences.development_window_data.class_completion --, True
		end

	default_class_name: STRING_GENERAL is
			-- Default name for class
		do
			Result := interface_names.l_no_class_bra
		end

	default_feature_name: STRING_GENERAL is
			-- Default name for feature
		do
			Result := interface_names.l_no_feature_bra
		end

	default_cluster_name: STRING_GENERAL is
			-- Default name for cluster		
		do
			Result := interface_names.l_no_cluster_bra
		end

	l_Space: STRING is " "

	l_From: STRING is " from "

	bold_ratio: DOUBLE is 1.19;

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

end -- class EB_ADDRESS_MANAGER
