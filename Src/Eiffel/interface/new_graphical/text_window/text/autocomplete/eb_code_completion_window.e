note
	description: "Window that displays a text area and a list of possible features for automatic completion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CODE_COMPLETION_WINDOW

inherit

	CODE_COMPLETION_WINDOW
		rename
			complete as complete_feature
		redefine
			make,
			close_and_complete,
			rebuild_list_during_matching,
			automatically_complete_words,
			complete_feature,
			scrolling_common_line_count,
			mouse_wheel_scroll_full_page,
			mouse_wheel_scroll_size,
			on_char,
			code_completable,
			sorted_names,
			name_type,
			choice_list,
			on_key_down,
			on_key_released,
			set_expanded_row_icon,
			show,
			is_applicable_item,
			exit,
			on_scroll
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create, copy
		end

	EB_RECYCLABLE
		undefine
			default_create, copy
		end

	INTERFACE_NAMES
		undefine
			default_create, copy
		end

	EB_CONTEXT_MENU_HANDLER
		undefine
			default_create, copy
		end

	PLATFORM
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	ES_SHARED_FONTS_AND_COLORS
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create
		do
			Precursor {CODE_COMPLETION_WINDOW}

			build_option_bar
			choice_list.enable_tree
			choice_list.set_configurable_target_menu_mode
			choice_list.set_configurable_target_menu_handler (agent context_menu_handler)
			choice_list.enable_single_row_selection
			register_action (choice_list.row_select_actions, agent on_row_selected)
			register_action (resize_actions, agent on_window_resize)
			set_title (Interface_names.t_Autocomplete_window)
			setup_option_buttons
			setup_accelerators
			register_accelerator_preference_change_actions
		end

	build_option_bar
			-- Build option bar
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_sep: EV_HORIZONTAL_SEPARATOR
			l_label: EV_LABEL
			l_tooltip: STRING_32
		do
				-- Separator
			create l_sep
			l_sep.set_minimum_height (2)
			option_bar_box.extend (l_sep)

			create l_hbox
			l_hbox.set_padding_width (layout_constants.small_padding_size)
			l_hbox.set_border_width (1)
			option_bar_box.extend (l_hbox)
			option_bar_box.disable_item_expand (l_hbox)

				-- "Options" label
			create l_label.make_with_text (interface_names.l_Options_colon)
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)

			create option_bar
			l_hbox.extend (option_bar)
			l_hbox.disable_item_expand (option_bar)

				-- Option buttons
			create filter_button
			filter_button.set_pixmap (pixmaps.mini_pixmaps.completion_filter_icon)
			l_tooltip := preferences.editor_data.filter_completion_list_preference.description
			if l_tooltip /= Void then
			 	filter_button.set_tooltip (locale.translation (l_tooltip))
			end
			option_bar.extend (filter_button)

			create show_return_type_button
			show_return_type_button.set_pixmap (pixmaps.mini_pixmaps.completion_show_return_type_icon)
			l_tooltip := preferences.editor_data.show_completion_type_preference.description
			if l_tooltip /= Void then
				show_return_type_button.set_tooltip (locale.translation (l_tooltip))
			end
			option_bar.extend (show_return_type_button)

			create show_signature_button
			show_signature_button.set_pixmap (pixmaps.mini_pixmaps.completion_show_signature_icon)
			l_tooltip := preferences.editor_data.show_completion_signature_preference.description
			if l_tooltip /= Void then
				show_signature_button.set_tooltip (locale.translation (l_tooltip))
			end
			option_bar.extend (show_signature_button)

			create show_disambiguated_name_button
			show_disambiguated_name_button.set_pixmap (pixmaps.mini_pixmaps.completion_show_disambiguants_icon)
			l_tooltip := preferences.editor_data.show_completion_disambiguated_name_preference.description
			if l_tooltip /= Void then
				show_disambiguated_name_button.set_tooltip (locale.translation (l_tooltip))
			end
			option_bar.extend (show_disambiguated_name_button)

			create show_obsolete_items_button
			show_obsolete_items_button.set_pixmap (pixmaps.mini_pixmaps.completion_show_obsolete_icon)
			l_tooltip := preferences.editor_data.show_completion_obsolete_items_preference.description
			if l_tooltip /= Void then
				show_obsolete_items_button.set_tooltip (locale.translation (l_tooltip))
			end
			option_bar.extend (show_obsolete_items_button)

			option_bar.extend (create {EV_TOOL_BAR_SEPARATOR})

			create show_tooltip_button
			show_tooltip_button.set_pixmap (pixmaps.mini_pixmaps.debugger_expand_info_icon)
			l_tooltip := preferences.editor_data.show_completion_tooltip_preference.description
			if l_tooltip /= Void then
				show_tooltip_button.set_tooltip (locale.translation (l_tooltip))
			end
			option_bar.extend (show_tooltip_button)

			create remember_size_button
			remember_size_button.set_pixmap (pixmaps.mini_pixmaps.completion_remember_size_icon)
			l_tooltip := preferences.development_window_data.remember_completion_list_size_preference.description
			if l_tooltip /= Void then
				remember_size_button.set_tooltip (locale.translation (l_tooltip))
			end
			option_bar.extend (remember_size_button)
		end

	setup_option_buttons
			-- Setup option buttons according to preference.
			-- Setup callbacks on option buttons.
		do
				-- Preference setup
			if filter_completion_list then
				filter_button.enable_select
			else
				filter_button.disable_select
			end
			if show_completion_type then
				show_return_type_button.enable_select
			else
				show_return_type_button.disable_select
			end
			if show_completion_signature then
				show_signature_button.enable_select
			else
				show_signature_button.disable_select
			end
			if show_completion_disambiguated_name then
				show_disambiguated_name_button.enable_select
			else
				show_disambiguated_name_button.disable_select
			end
			if show_obsolete_items then
				show_obsolete_items_button.enable_select
			else
				show_obsolete_items_button.disable_select
			end
			if remember_window_size then
				remember_size_button.enable_select
			else
				remember_size_button.disable_select
			end
			if show_completion_tooltip then
				show_tooltip_button.enable_select
			else
				show_tooltip_button.disable_select
			end

				-- Callbacks
			register_action (filter_button.select_actions, agent on_option_button_selected (filter_button))
			register_action (show_return_type_button.select_actions, agent on_option_button_selected (show_return_type_button))
			register_action (show_signature_button.select_actions, agent on_option_button_selected (show_signature_button))
			register_action (show_disambiguated_name_button.select_actions, agent on_option_button_selected (show_disambiguated_name_button))
			register_action (show_obsolete_items_button.select_actions, agent on_option_button_selected (show_obsolete_items_button))
			register_action (show_tooltip_button.select_actions, agent on_option_button_selected (show_tooltip_button))
			register_action (remember_size_button.select_actions, agent on_option_button_selected (remember_size_button))

			register_action (preferences.editor_data.filter_completion_list_preference.change_actions, agent on_option_preferenced_changed (filter_button))
			register_action (preferences.editor_data.show_completion_type_preference.change_actions, agent on_option_preferenced_changed (show_return_type_button))
			register_action (preferences.editor_data.show_completion_signature_preference.change_actions, agent on_option_preferenced_changed (show_signature_button))
			register_action (preferences.editor_data.show_completion_disambiguated_name_preference.change_actions, agent on_option_preferenced_changed (show_disambiguated_name_button))
			register_action (preferences.editor_data.show_completion_obsolete_items_preference.change_actions, agent on_option_preferenced_changed (show_obsolete_items_button))
			register_action (preferences.editor_data.show_completion_tooltip_preference.change_actions, agent on_option_preferenced_changed (show_tooltip_button))
			register_action (preferences.development_window_data.remember_completion_list_size_preference.change_actions, agent on_option_preferenced_changed (remember_size_button))
		end

	register_accelerator_preference_change_actions
		local
			l_pre: SHORTCUT_PREFERENCE
		do
			setup_accelerators_agent := agent setup_accelerators
			l_pre := preferences.editor_data.shortcuts.item ("toggle_filter")
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_type")
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_signature")
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_disambiguated_name")
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_obsolete_items")
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_remember_size")
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_tooltip")
			l_pre.change_actions.extend (setup_accelerators_agent)
		end

	setup_accelerators
			-- Build accelerators.
		local
			l_acc: EV_ACCELERATOR
			l_pre: SHORTCUT_PREFERENCE
		do
			accelerators.wipe_out
			l_pre := preferences.editor_data.shortcuts.item ("toggle_filter")
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (filter_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_type")
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (show_return_type_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_signature")
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (show_signature_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_disambiguated_name")
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (show_disambiguated_name_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_tooltip")
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (show_tooltip_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_remember_size")
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (remember_size_button))
			accelerators.extend (l_acc)
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Context menu handler
		do
			if context_menu_factory /= Void then
				context_menu_factory.standard_compiler_item_menu (a_menu, a_target_list, a_source, a_pebble)
			end
		end

feature -- Initialization

	initialize_for_features (an_editor: like code_completable;
							feature_name: STRING;
							a_remainder: INTEGER;
							completion_possibilities: like sorted_names;
							a_complete_word: BOOLEAN)
			-- Initialize to to complete for `feature_name' in `an_editor'.
		local
			l_string: STRING
		do
			feature_mode := True
			l_string := feature_name
			l_string.prune_all_leading (' ')
			l_string.prune_all_leading ('	')
			common_initialization (an_editor, l_string, a_remainder, completion_possibilities, a_complete_word)
		end

	initialize_for_classes (an_editor: like code_completable;
							class_name: STRING;
							a_remainder: INTEGER;
							completion_possibilities: like sorted_names)
			-- Initialize to to complete for `class_name' in `an_editor'.
		do
			feature_mode := False
			common_initialization (an_editor, class_name, a_remainder, completion_possibilities, True)
		end

feature -- Access

	choice_list: EB_COMPLETION_LIST_GRID
			-- Choice list

	code_completable: EB_TAB_CODE_COMPLETABLE
			-- associated window

	sorted_names: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- list of possible feature names sorted alphabetically

	name_type: EB_NAME_FOR_COMPLETION

	filter_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Filter option button.

	option_bar: EV_TOOL_BAR
			-- Option tool bar

	tooltip_window: ES_SMART_TOOLTIP_WINDOW
			-- Window to show extra info as tooltip

feature -- Widget

	show_return_type_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show return type

	show_signature_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show signature

	show_disambiguated_name_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show disambiguated name

	show_obsolete_items_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show obsolete features/classes

	remember_size_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to remember window size

	show_tooltip_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show/hide tool-tips

feature -- Query

	is_applicable_item (a_item: like name_type): BOOLEAN
			-- Determines if `a_item' is an applicable item to show in the completion list
		local
			l_eb_name: EB_NAME_FOR_COMPLETION
		do
			Result := Precursor {CODE_COMPLETION_WINDOW} (a_item)
			if Result then
				l_eb_name ?= a_item
				if l_eb_name /= Void then
					if not show_obsolete_items then
						Result := not l_eb_name.is_obsolete
					end
				end
			end
		end

feature -- Status report

	feature_mode: BOOLEAN
			-- Is `Current' used to select feature names ?

	scrolling_common_line_count : INTEGER
		do
			Result := preferences.editor_data.scrolling_common_line_count
		end

	mouse_wheel_scroll_full_page : BOOLEAN
		do
			Result := preferences.editor_data.mouse_wheel_scroll_full_page
		end

	mouse_wheel_scroll_size: INTEGER
		do
			Result := preferences.editor_data.mouse_wheel_scroll_size
		end

feature -- Status change

	show
			-- Show
		do
			Precursor {CODE_COMPLETION_WINDOW}
			setup_accelerators
		end

feature {NONE} -- Option Preferences

	filter_completion_list: BOOLEAN
		do
			Result := preferences.editor_data.filter_completion_list
		end

	show_completion_type: BOOLEAN
		do
			Result := preferences.editor_data.show_completion_type
		end

	show_completion_signature: BOOLEAN
		do
			Result := preferences.editor_data.show_completion_signature
		end

	show_completion_disambiguated_name: BOOLEAN
		do
			Result := preferences.editor_data.show_completion_disambiguated_name
		end

	show_obsolete_items: BOOLEAN
		do
			Result := preferences.editor_data.show_completion_obsolete_items
		end

	remember_window_size: BOOLEAN
		do
			Result := preferences.development_window_data.remember_completion_list_size
		end

	show_completion_tooltip: BOOLEAN
		do
			Result := preferences.editor_data.show_completion_tooltip
		end

feature {NONE} -- Option behaviour

	on_option_button_selected (a_button: EV_TOOL_BAR_TOGGLE_BUTTON)
			-- On option button selected
		require
			a_button_not_void: a_button /= Void
		local
			l_preference: BOOLEAN_PREFERENCE
		do
			clicking_option_button := True
			if a_button = filter_button then
				l_preference := preferences.editor_data.filter_completion_list_preference
				apply_filter_completion_list (a_button.is_selected)
			elseif a_button = show_return_type_button then
				l_preference := preferences.editor_data.show_completion_type_preference
				apply_show_return_type (a_button.is_selected)
			elseif a_button = show_signature_button then
				l_preference := preferences.editor_data.show_completion_signature_preference
				apply_show_completion_signature (a_button.is_selected)
			elseif a_button = show_disambiguated_name_button then
				l_preference := preferences.editor_data.show_completion_disambiguated_name_preference
				apply_show_completion_disambiguated_name (a_button.is_selected)
			elseif a_button = show_obsolete_items_button then
				l_preference := preferences.editor_data.show_completion_obsolete_items_preference
				apply_show_obsolete_items (a_button.is_selected)
			elseif a_button = show_tooltip_button then
				l_preference := preferences.editor_data.show_completion_tooltip_preference
				apply_show_tooltip (a_button.is_selected)
			elseif a_button = remember_size_button then
				l_preference := preferences.development_window_data.remember_completion_list_size_preference
				apply_remember_window_size (a_button.is_selected)
			else
				check
					error: False
				end
			end
			l_preference.set_value (a_button.is_selected)
			clicking_option_button := False
		end

	on_option_preferenced_changed (a_button: EV_TOOL_BAR_TOGGLE_BUTTON)
			-- On option button selected
		require
			a_button_not_void: a_button /= Void
		local
			l_preference: BOOLEAN_PREFERENCE
		do
			if not clicking_option_button then
				a_button.select_actions.block
				if a_button = filter_button then
					l_preference := preferences.editor_data.filter_completion_list_preference
					apply_filter_completion_list (l_preference.value)
				elseif a_button = show_return_type_button then
					l_preference := preferences.editor_data.show_completion_type_preference
					apply_show_return_type (l_preference.value)
				elseif a_button = show_signature_button then
					l_preference := preferences.editor_data.show_completion_signature_preference
					apply_show_completion_signature (l_preference.value)
				elseif a_button = show_disambiguated_name_button then
					l_preference := preferences.editor_data.show_completion_disambiguated_name_preference
					apply_show_completion_disambiguated_name (l_preference.value)
				elseif a_button = show_obsolete_items_button then
					l_preference := preferences.editor_data.show_completion_obsolete_items_preference
					apply_show_obsolete_items (l_preference.value)
				elseif a_button = show_tooltip_button then
					l_preference := preferences.editor_data.show_completion_tooltip_preference
					apply_show_tooltip (l_preference.value)
				elseif a_button = remember_size_button then
					l_preference := preferences.development_window_data.remember_completion_list_size_preference
					apply_remember_window_size (l_preference.value)
				else
					check
						error: False
					end
				end
				if l_preference.value then
					a_button.enable_select
				else
					a_button.disable_select
				end
				a_button.select_actions.resume
			end
		end

	apply_filter_completion_list (a_b: BOOLEAN)
			-- Apply filtering completion list.
		local
			local_name: like name_type
			local_index: INTEGER
			l_list: like choice_list
		do
			l_list := choice_list
				-- Save selected item
			if l_list.has_selected_row then
				local_name ?= l_list.selected_rows.first.data
				check
					local_name_not_void: local_name /= Void
				end
			end

			build_displayed_list (buffered_input)

				-- Try to selected saved item
				-- If does not exist any more, we call `ensure_item_selection'
			local_index := grid_row_by_data (local_name)
			if local_index = 0 then
				ensure_item_selection
			else
				l_list.remove_selection
				l_list.row (local_index).enable_select
				l_list.row (local_index).ensure_visible
			end
			resize_column_to_window_width
		end

	apply_show_return_type (a_b: BOOLEAN)
			-- Apply showing return type.
		local
			local_index: INTEGER
			l_row: EV_GRID_ROW
			l_list: like choice_list
		do
			l_list := choice_list
			if l_list.has_selected_row then
				local_index := l_list.selected_rows.first.index
			end
			build_displayed_list (buffered_input)
			if local_index > 0 and then l_list.row_count > 0 then
				check
					local_index_valid: local_index <= l_list.row_count
				end
				l_list.remove_selection
				l_row := l_list.row (local_index)
				if is_displayed then
					if l_row.parent_row /= Void and then
						l_row.parent_row.is_expandable and then
						not l_row.parent_row.is_expanded
					then
						l_row.parent_row.expand
					end
					l_row.enable_select
					l_row.ensure_visible
				end
			else
				ensure_item_selection
			end
			resize_column_to_window_width
		end

	apply_show_completion_signature (a_b: BOOLEAN)
			-- Apply showing completion signature.
		do
			apply_show_return_type (a_b)
		end

	apply_show_completion_disambiguated_name (a_b: BOOLEAN)
			-- Apply showing completion disambiguated name.
		do
			apply_show_return_type (a_b)
		end

	apply_show_obsolete_items (a_b: BOOLEAN)
			-- Apply showing completion obsolete items.
		do
			apply_show_return_type (a_b)
		end

	apply_show_tooltip (a_b: BOOLEAN)
			-- Apply showing completion tooltip.
		do
			if a_b then
				if attached choice_list.single_selected_row as l_row then
					on_row_selected (l_row)
				end
			else
				if attached tooltip_window as l_w and then l_w.is_shown and then not l_w.is_recycled then
					l_w.hide
				end
			end
		end

	apply_remember_window_size (a_b: BOOLEAN)
			-- Apply remembering window size.
		do
			if a_b then
				save_window_position
			else
				code_completable.position_completion_choice_window
				resize_window_to_column_width
				resize_column_to_window_width
			end
		end

feature {NONE} -- Recyclable

	internal_recycle
			-- Recycle
		do
			unregister_accelerator_preference_change_actions
			choice_list.recycle
		end

	unregister_accelerator_preference_change_actions
		local
			l_pre: SHORTCUT_PREFERENCE
		do
			l_pre := preferences.editor_data.shortcuts.item ("toggle_filter")
			l_pre.change_actions.prune_all (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_type")
			l_pre.change_actions.prune_all (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_signature")
			l_pre.change_actions.prune_all (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_disambiguated_name")
			l_pre.change_actions.prune_all (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_obsolete_items")
			l_pre.change_actions.prune_all (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_remember_size")
			l_pre.change_actions.prune_all (setup_accelerators_agent)
		end

	setup_accelerators_agent: PROCEDURE

feature {NONE} -- Action handlers

	on_row_selected (a_row: EV_GRID_ROW)
			-- Selected grid row
		require
			is_interface_usable: is_interface_usable
			a_row_attached: a_row /= Void
		do
			if show_timer = Void or show_timer.is_destroyed then
				create show_timer.make_with_interval (200)
			else
				show_timer.set_interval (200)
			end
			show_timer.actions.wipe_out
			show_timer.actions.extend_kamikaze (
			agent (a_r: EV_GRID_ROW)
			do
				if show_completion_tooltip and then a_r.parent /= Void then
						-- We check for row parent incase it has been subsequently removed from grid.
					if attached contract_widget_from_row (a_r) as l_widget then
							-- Tooltip window
						if tooltip_window = Void then
							create tooltip_window.make
						end
						tooltip_window.set_popup_widget (l_widget.widget)
						if is_displayed then
							show_tooltip (a_r)
						end
					end
				end
				show_timer.set_interval (0)
			end (a_row)
			)
		end

	on_key_released (ev_key: EV_KEY)
			-- process user input in `choice_list'.
		do
			if ev_key /= Void then
				inspect
					ev_key.code
				when key_ctrl then
					if temp_switching_show_disambiguated_name and then show_completion_disambiguated_name then
						show_disambiguated_name_button.disable_select
					end
					temp_switching_show_disambiguated_name := False
				else
					Precursor {CODE_COMPLETION_WINDOW} (ev_key)
				end
			end
		end

	on_window_resize (a_x, a_y, a_width, a_height: INTEGER)
			-- Window resized
		do
			if is_displayed and then attached tooltip_window as l_w and then l_w.is_shown and then not l_w.is_recycled then
				if attached choice_list.single_selected_row as l_row then
					show_tooltip (l_row)
				end
			end
		end

	on_scroll (a_x, a_y: INTEGER)
			-- Window resized
		do
			Precursor {CODE_COMPLETION_WINDOW}(a_x, a_y)
			if is_displayed and then attached tooltip_window as l_w and then l_w.is_shown and then not l_w.is_recycled then
				if attached choice_list.single_selected_row as l_row then
					show_tooltip (l_row)
				end
			end
		end

feature {NONE} -- Implementation

	contract_widget: TUPLE [widget: EV_WIDGET; comment: EVS_LABEL; viewer: ES_CONTRACT_VIEWER_WIDGET]
			-- Reference to the tooltip widget.

	new_contract_widget: like contract_widget
			-- Create all the necessary widgets to display the tooltip.
		local
			l_viewer: ES_CONTRACT_VIEWER_WIDGET
			l_v: EV_VERTICAL_BOX
			l_h: EV_HORIZONTAL_BOX
			l_padding: EV_CELL
			l_sep: EV_HORIZONTAL_SEPARATOR
			l_widget: EV_WIDGET
			l_comment_preview: EVS_LABEL
		do
			create l_v

			create l_padding
			l_padding.set_minimum_height ({ES_UI_CONSTANTS}.label_vertical_padding)
			l_padding.set_background_color (colors.tooltip_color)
			l_v.extend (l_padding)
			l_v.disable_item_expand (l_padding)

			create l_h
			l_v.extend (l_h)
			l_v.disable_item_expand (l_h)

			create l_padding
			l_padding.set_minimum_width ({ES_UI_CONSTANTS}.label_horizontal_padding)
			l_padding.set_background_color (colors.tooltip_color)
			l_h.extend (l_padding)
			l_h.disable_item_expand (l_padding)

			create l_comment_preview
			l_h.extend (l_comment_preview)

			create l_padding
			l_padding.set_minimum_height ({ES_UI_CONSTANTS}.label_vertical_padding)
			l_padding.set_background_color (colors.tooltip_color)
			l_v.extend (l_padding)
			l_v.disable_item_expand (l_padding)
			l_padding.set_minimum_width (300)

				-- Separator
			create l_sep
			l_sep.set_minimum_height (2)
			l_v.extend (l_sep)
			l_v.disable_item_expand (l_sep)

			l_comment_preview.align_text_left
			l_comment_preview.is_text_wrapped := True
			l_comment_preview.set_background_color (colors.tooltip_color)

			create l_viewer.make
			l_viewer.is_showing_full_contracts := True
			l_viewer.set_auto_check_visible (False)
			l_viewer.set_is_showing_comments (False)
			l_viewer.set_is_showing_edit_contract_button (False)
			l_widget := l_viewer.widget
			l_v.extend (l_widget)
			color_propogator.propagate_colors (l_widget, Void, contract_background_color, Void)

			Result := [l_v, l_comment_preview, l_viewer]
		end

	contract_widget_from_row (a_row: EV_GRID_ROW): like contract_widget
			-- Contract widget from a grid row
		require
			a_row_set: a_row /= Void
		local
			l_viewer: ES_CONTRACT_VIEWER_WIDGET
			l_c: CLASS_C
			l_f: E_FEATURE
			l_tt_text: STRING_32
			l_screen: EV_RECTANGLE
			l_comment_preview: EVS_LABEL
		do
			if attached contract_widget as l_widget then
				Result := l_widget
			else
				Result := new_contract_widget
				contract_widget := Result
			end
			l_comment_preview := Result.comment
			l_viewer := Result.viewer

			if attached {EB_FEATURE_FOR_COMPLETION} a_row.data as l_completion_feature then
				l_f := l_completion_feature.associated_feature
				l_c := l_f.associated_class
				l_screen := (create {EV_SCREEN}).monitor_area_from_position (screen_x, screen_y)
				l_viewer.set_maximum_widget_width (l_screen.width - {ES_UI_CONSTANTS}.horizontal_padding * 2)
				l_viewer.set_context (l_c, l_f)
			end

			if attached {EB_FEATURE_FOR_COMPLETION} a_row.data as l_completion_feature then
				l_tt_text := l_completion_feature.tooltip_text
			elseif attached {EB_CLASS_FOR_COMPLETION} a_row.data as l_completion_class then
				l_tt_text := l_completion_class.tooltip_text
			end
			if l_tt_text /= Void and then not l_tt_text.is_empty then
				l_tt_text.prune_all_trailing ('%N')
				if l_tt_text.count > 150 then
					l_tt_text.keep_head (147)
					l_tt_text.append ("...")
				end
				l_comment_preview.set_text (l_tt_text)
			else
				l_comment_preview.set_text (interface_names.l_no_comment)
			end
		end

	color_propogator: ES_COLOR_PROPAGATOR
			-- Color propogator
		once
			create Result
		end

	contract_background_color: EV_COLOR
			-- Pop up window background color, as well as the token background color
		do
			Result := normal_text_token.background_color
		ensure
			result_attached: Result /= Void
		end

	normal_text_token: EDITOR_TOKEN_TEXT
			-- Token used for getting foreground and background colors.
		once
			create Result.make ("")
		end

	on_char (character_string: STRING_32)
			-- Process displayable character key press event.
		local
			c: CHARACTER
		do
			if character_string.count = 1 then
				if code_completable.is_completing then
					if
						code_completable.is_char_activator_character (character_string.item (1))
					then
							-- Continue completing
						if code_completable.completing_feature then
							continue_completion := True
						end
						close_and_complete
						if code_completable.completing_feature then
							code_completable.trigger_completion
						end
						exit
					end
				end
				c := character_string.item (1).to_character_8
				if c.is_alpha or c.is_digit or c = '_' or c = '*' or c = '?' then
					buffered_input.append_character (c)
					code_completable.handle_character (c)
					select_closest_match
				elseif c = ' ' and ev_application.ctrl_pressed then
						-- Do nothing, we don't want to close the completion window when CTRL+SPACE is pressed
				elseif not code_completable.unwanted_characters.item (c.code) then
					if not code_completable.is_char_activator_character (c) then
						close_and_complete
					elseif code_completable.has_selection then
						code_completable.go_to_end_of_line
					end
					if not code_completable.has_selection then
						code_completable.handle_character (c)
					end
					if not code_completable.is_char_activator_character (c) then
						exit
					end
				end
			end
		end

	on_key_down (ev_key: EV_KEY)
			-- process user input in `choice_list'.
		do
			if ev_key /= Void then
				inspect
					ev_key.code
				when key_ctrl then
					if not show_completion_disambiguated_name then
						show_disambiguated_name_button.enable_select
						temp_switching_show_disambiguated_name := True
					end
				else
					Precursor {CODE_COMPLETION_WINDOW} (ev_key)
				end
			end
		end

	toggle_button (a_button: like filter_button)
			-- Toggle button selection
		require
			a_button_not_void: a_button /= Void
		do
			if a_button.is_selected then
				a_button.disable_select
			else
				a_button.enable_select
			end
		end

	show_tooltip (a_row: EV_GRID_ROW)
			-- Show the floating tooltip
		require
			a_row_set: a_row /= Void
			tooltip_window_attached: tooltip_window /= Void
			tooltip_window_not_recycled: not tooltip_window.is_recycled
		local
			l_choice_list_y_offset: INTEGER
			l_rec: EV_RECTANGLE
		do
			l_choice_list_y_offset := choice_list.screen_y - screen_y
				-- Show arround the selected row.
			create l_rec.make (screen_x, screen_y, width, height)
			tooltip_window.show_on_side (l_rec,
				(a_row.virtual_y_position - choice_list.virtual_y_position + l_choice_list_y_offset).max (0).min (choice_list.viewable_height),
				(a_row.virtual_y_position + a_row.height - choice_list.virtual_y_position + l_choice_list_y_offset).max (0).min (choice_list.viewable_height))
		end

	temp_switching_show_disambiguated_name: BOOLEAN

	rebuild_list_during_matching: BOOLEAN
			-- Should the list be rebuilt according to current match?
		do
		    Result := preferences.editor_data.filter_completion_list
		end

	automatically_complete_words: BOOLEAN
			-- Should completion list automatically complete words.
		do
			Result := preferences.editor_data.auto_complete_words
		end

	close_and_complete
			-- close the window and perform completion with selected item
		do
			if choice_list.has_selected_row then
					-- Delete current token so it is later replaced by the completion text
				if not buffered_input.is_empty then
					remove_characters_entered_since_display
				end
				if feature_mode then
					complete_feature
				else
					complete_class
				end
			end
			exit
		end

	exit
			-- Cancel autocomplete
		do
			Precursor
			if attached tooltip_window as l_w and then not l_w.is_recycled then
				l_w.hide
			end
			if code_completable.is_focus_back_needed then
				code_completable.post_focus_back
			end
		end

	complete_feature
			-- Complete feature name
		local
			local_feature: EB_FEATURE_FOR_COMPLETION
			l_name_item: like name_type
			local_name: STRING_GENERAL
			l_row: EV_GRID_ROW
		do
			if choice_list.has_selected_row then
				if character_to_append = '(' then
					character_to_append := '%U'
				end
				l_row := choice_list.selected_rows.first
				if ev_application.ctrl_pressed and then l_row.is_expandable then
					l_row.expand
					if l_row.subrow_count > 0 then
						l_row := l_row.subrow (1)
					end
				end
				l_name_item ?= l_row.data
				check
					l_name_item_not_void: l_name_item /= Void
				end
				if ev_application.ctrl_pressed or else show_completion_disambiguated_name then
					if l_name_item.has_dot then
						local_name := l_name_item.full_insert_name
					else
						local_name := (" ").as_string_32 + l_name_item.full_insert_name
					end
				else
					if l_name_item.has_dot then
						local_name := l_name_item.insert_name
					else
						local_name := (" ").as_string_32 + l_name_item.insert_name
					end
				end
				code_completable.complete_feature_from_window (local_name, True, character_to_append, remainder, continue_completion)
				local_feature ?= l_name_item
				if local_feature /= Void then
					last_completed_feature_had_arguments := local_feature.has_arguments
				else
					last_completed_feature_had_arguments := False
				end
			end
		end

	complete_class
			-- Complete class name
		local
			l_row: EV_GRID_ROW
			l_name_item: NAME_FOR_COMPLETION
			local_name: STRING_GENERAL
		do
			if choice_list.has_selected_row then
				l_row := choice_list.selected_rows.first
				l_name_item ?= l_row.data
				check
					l_name_item_not_void: l_name_item /= Void
				end
				local_name := l_name_item.insert_name
				code_completable.complete_class_from_window (local_name, '%U', remainder)
			else
				if not buffered_input.is_empty then
					code_completable.complete_class_from_window (buffered_input, character_to_append, remainder)
				end
			end
		end

	set_expanded_row_icon (a_item: EB_GRID_EDITOR_TOKEN_ITEM; a_name: like name_type)
			-- Set pixmap of `a_item'.
		do
			a_item.set_pixmap (pixmaps.icon_pixmaps.feature_group_icon)
		end

	resize_window_to_column_width
			-- Resize window to column width
		local
			i: INTEGER
			l_list: like choice_list
		do
			l_list := choice_list
			if l_list.column_count > 0 and then l_list.row_count > 0 then
				i := l_list.column (1).required_width_of_item_span (1, l_list.row_count) + 3
				l_list.column (1).set_width (i)
				if l_list.vertical_scroll_bar.is_displayed then
					l_list.set_minimum_width (i + l_list.vertical_scroll_bar.width)
				else
					l_list.set_minimum_width (i)
				end
				l_list.set_minimum_width (0)
			end
		end

	last_completed_feature_had_arguments: BOOLEAN;
			-- Did the last inserted completed feature name contain arguments?

	last_row_data: detachable ANY

	clicking_option_button: BOOLEAN
			-- Clicking option button?

	show_timer: EV_TIMEOUT;
			-- Timer to show the tooltip

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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

end -- class EB_COMPLETION_CHOICE_WINDOW
