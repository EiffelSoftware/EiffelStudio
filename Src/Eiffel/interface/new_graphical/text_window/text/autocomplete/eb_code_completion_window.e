note
	description: "Window that displays a text area and a list of possible features for automatic completion."
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
			is_binary_search_supported,
			choice_list,
			build_full_list,
			on_key_down,
			on_key_released,
			set_expanded_row_icon,
			show,
			hide,
			is_applicable_item, is_applicable_item_with_name,
			exit,
			on_scroll,
			initialize_completion_possibilities
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

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
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
			-- Initialize completion window.
		local
			hb: EV_HORIZONTAL_BOX
			sep: EV_VERTICAL_SEPARATOR
		do
			Precursor {CODE_COMPLETION_WINDOW}
			current_panel_id := features_panel_id

			create hb
			header_box.extend (hb)

			header_box.disable_item_expand (hb)
			build_info_associated_class_box (hb)--footer_box)
--			hb.extend (create {EV_CELL})
			create sep
			hb.extend (sep)
			hb.disable_item_expand (sep)
			build_option_bar_template (hb)--header_box)

			build_option_bar (footer_box)


			choice_list.enable_tree
			choice_list.set_configurable_target_menu_mode
			choice_list.set_configurable_target_menu_handler (agent context_menu_handler)
			choice_list.enable_single_row_selection
			register_action (choice_list.row_select_actions, agent on_row_selected)
			register_action (choice_list.pointer_motion_item_actions, agent (i_x, i_y: INTEGER; i_item: detachable EV_GRID_ITEM) do on_pointer_hovering_item (i_item) end)
			register_action (choice_list.pointer_button_press_actions, agent mouse_selection)
			register_action (resize_actions, agent on_window_resize)
			register_action (dpi_changed_actions, agent on_dpi_window_resize)
			set_title (Interface_names.t_Autocomplete_window)
			setup_option_buttons
			setup_accelerators
			register_accelerator_preference_change_actions
		end

	build_option_bar (a_box: EV_BOX)
			-- Build option bar.
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_sep: EV_HORIZONTAL_SEPARATOR
			l_label: EV_LINK_LABEL
			l_tooltip: STRING_32
		do
			create option_bar_box
			a_box.extend (option_bar_box)
			a_box.disable_item_expand (option_bar_box)

				-- Separator
			create l_sep
			l_sep.set_minimum_height ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (2))
			option_bar_box.extend (l_sep)

			create l_hbox
			l_hbox.set_padding_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (layout_constants.small_padding_size))
			l_hbox.set_border_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (1))
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

			create show_completion_unicode_symbols_button
			show_completion_unicode_symbols_button.set_pixmap (pixmaps.mini_pixmaps.completion_show_unicode_symbol_icon)
			l_tooltip := preferences.editor_data.show_completion_unicode_symbols_preference.description
			if l_tooltip /= Void then
				show_completion_unicode_symbols_button.set_tooltip (locale.translation (l_tooltip))
			end
			option_bar.extend (show_completion_unicode_symbols_button)

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

			create show_target_class_button
			show_target_class_button.set_pixmap (pixmaps.mini_pixmaps.completion_show_target_class_icon)
			l_tooltip := preferences.editor_data.show_completion_target_class_preference.description
			if l_tooltip /= Void then
				show_target_class_button.set_tooltip (locale.translation (l_tooltip))
			end
			option_bar.extend (show_target_class_button)

			create remember_size_button
			remember_size_button.set_pixmap (pixmaps.mini_pixmaps.completion_remember_size_icon)
			l_tooltip := preferences.development_window_data.remember_completion_list_size_preference.description
			if l_tooltip /= Void then
				remember_size_button.set_tooltip (locale.translation (l_tooltip))
			end
			option_bar.extend (remember_size_button)
		end

	build_info_associated_class_box (a_box: EV_BOX)
		local
			b: like info_associated_target_class_box
			hb: EV_HORIZONTAL_BOX
		do
			create b
			info_associated_target_class_box := b
			a_box.extend (b)

			create hb
			hb.set_padding_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (layout_constants.small_padding_size))
			hb.set_border_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (1))

			b.extend (hb)
			b.disable_item_expand (hb)
			info_associated_target_class_inner_box := hb
		end

	set_associated_target_class (cl: detachable CLASS_C)
		local
			l_cl_lab: EVS_ELLIPSIS_LABEL
			hb: EV_HORIZONTAL_BOX
			pix: EV_PIXMAP
			st: CLASSC_STONE
		do
			hb := info_associated_target_class_inner_box
			hb.wipe_out
			if cl = Void then
				hide_info_associated_target_class
				info_associated_target_class_set := False
			else
				create st.make (cl)
				create pix.make_with_pixel_buffer (pixel_buffer_from_class_i (cl.original_class))
				hb.extend (pix)
				hb.set_padding_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (2))
				pix.set_minimum_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (16))
				pix.set_minimum_height ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (16))
				pix.set_pebble (st)
				hb.disable_item_expand (pix)

				create l_cl_lab.make_with_text (cl.name)
				l_cl_lab.set_minimum_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (l_cl_lab.font.width * 3) )
				l_cl_lab.set_tooltip (cl.name)
				l_cl_lab.set_pebble (st)
				l_cl_lab.align_text_left
				hb.extend (l_cl_lab)
				l_cl_lab.align_text_top
				l_cl_lab.refresh_now
				info_associated_target_class_set := True
				if show_completion_target_class then
					show_info_associated_target_class
				end
			end
		end

	build_option_bar_template (a_box: EV_BOX)
			-- Build option bar.
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_tpl_box: like option_template_feature
		do
			create l_tpl_box
			option_template_feature := l_tpl_box
			a_box.extend (l_tpl_box)
			a_box.disable_item_expand (l_tpl_box)

			create l_hbox
			l_hbox.set_padding_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (layout_constants.small_padding_size))
			l_hbox.set_border_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (1))
			l_tpl_box.extend (l_hbox)
			l_tpl_box.disable_item_expand (l_hbox)

				-- Show next panel label
			next_panel_label.set_text (next_panel_title)
			l_hbox.extend (next_panel_label)
			l_hbox.disable_item_expand (next_panel_label)

				-- Callback
			register_action (next_panel_label.select_actions, agent on_option_label_selected (next_panel_label))
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
			if show_completion_unicode_symbols then
				show_completion_unicode_symbols_button.enable_select
			else
				show_completion_unicode_symbols_button.disable_select
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
			if show_completion_target_class then
				show_target_class_button.enable_select
			else
				show_target_class_button.disable_select
			end

				-- Callbacks
			register_action (filter_button.select_actions, agent on_option_button_selected (filter_button))
			register_action (show_return_type_button.select_actions, agent on_option_button_selected (show_return_type_button))
			register_action (show_signature_button.select_actions, agent on_option_button_selected (show_signature_button))
			register_action (show_disambiguated_name_button.select_actions, agent on_option_button_selected (show_disambiguated_name_button))
			register_action (show_completion_unicode_symbols_button.select_actions, agent on_option_button_selected (show_completion_unicode_symbols_button))
			register_action (show_obsolete_items_button.select_actions, agent on_option_button_selected (show_obsolete_items_button))
			register_action (show_tooltip_button.select_actions, agent on_option_button_selected (show_tooltip_button))
			register_action (show_target_class_button.select_actions, agent on_option_button_selected (show_target_class_button))
			register_action (remember_size_button.select_actions, agent on_option_button_selected (remember_size_button))

			register_action (preferences.editor_data.filter_completion_list_preference.change_actions, agent on_option_preferenced_changed (filter_button))
			register_action (preferences.editor_data.show_completion_type_preference.change_actions, agent on_option_preferenced_changed (show_return_type_button))
			register_action (preferences.editor_data.show_completion_signature_preference.change_actions, agent on_option_preferenced_changed (show_signature_button))
			register_action (preferences.editor_data.show_completion_disambiguated_name_preference.change_actions, agent on_option_preferenced_changed (show_disambiguated_name_button))
			register_action (preferences.editor_data.show_completion_unicode_symbols_preference.change_actions, agent on_option_preferenced_changed (show_completion_unicode_symbols_button))
			register_action (preferences.editor_data.show_completion_obsolete_items_preference.change_actions, agent on_option_preferenced_changed (show_obsolete_items_button))
			register_action (preferences.editor_data.show_completion_tooltip_preference.change_actions, agent on_option_preferenced_changed (show_tooltip_button))
			register_action (preferences.editor_data.show_completion_target_class_preference.change_actions, agent on_option_preferenced_changed (show_target_class_button))
			register_action (preferences.development_window_data.remember_completion_list_size_preference.change_actions, agent on_option_preferenced_changed (remember_size_button))
		end

	register_accelerator_preference_change_actions
		local
			l_pre: SHORTCUT_PREFERENCE
		do
			setup_accelerators_agent := agent setup_accelerators
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_filter)
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_type)
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_signature)
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_disambiguated_name)
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_unicode_symbols)
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_obsolete_items)
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_tooltip)
			l_pre.change_actions.extend (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_remember_size)
			l_pre.change_actions.extend (setup_accelerators_agent)
		end

	setup_accelerators
			-- Build accelerators.
		local
			l_acc: EV_ACCELERATOR
			l_pre: SHORTCUT_PREFERENCE
		do
			accelerators.wipe_out
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_filter)
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (filter_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_type)
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (show_return_type_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_signature)
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (show_signature_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_disambiguated_name)
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (show_disambiguated_name_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_unicode_symbols)
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (show_completion_unicode_symbols_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_obsolete_items)
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (show_obsolete_items_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_show_tooltip)
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (show_tooltip_button))
			accelerators.extend (l_acc)
			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_toggle_remember_size)
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent toggle_button (remember_size_button))
			accelerators.extend (l_acc)

			l_pre := preferences.editor_data.shortcuts.item ({EB_EDITOR_DATA}.completion_shortcut_next_completion_panel)
			create l_acc.make_with_key_combination (l_pre.key, l_pre.is_ctrl, l_pre.is_alt, l_pre.is_shift)
			l_acc.actions.extend (agent show_next_panel)
			accelerators.extend (l_acc)
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Context menu handler.
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
			option_bar_box.show
			option_template_feature.show
			completion_mode := feature_completion_mode
			l_string := feature_name
			l_string.prune_all_leading (' ')
			l_string.prune_all_leading ('	')
			common_initialization (an_editor, l_string, a_remainder, completion_possibilities, a_complete_word)
			set_associated_target_class (target_class_c)
		end

	initialize_for_classes (an_editor: like code_completable;
							class_name: STRING;
							a_remainder: INTEGER;
							completion_possibilities: like sorted_names)
			-- Initialize to to complete for `class_name' in `an_editor'.
		do
			option_bar_box.show
			option_template_feature.hide
			set_associated_target_class (Void)
			completion_mode := class_completion_mode
			common_initialization (an_editor, class_name, a_remainder, completion_possibilities, True)
		end

	initialize_for_alias_name (an_editor: like code_completable;
							a_text: STRING;
							a_remainder: INTEGER;
							completion_possibilities: like sorted_names)
			-- Initialize to to complete for `class_name' in `an_editor'.
		do
			option_bar_box.show
			option_template_feature.hide
			completion_mode := alias_name_completion_mode
			common_initialization (an_editor, "", 0, completion_possibilities, True)
		end

	initialize_completion_possibilities (a_completion_possibilities: like sorted_names)
			-- Initialize `sorted_names'  to completion possiblities.
		do
			next_panel_label.set_text (next_panel_title)
			sorted_names := Void
			internal_delayed_unicode_symbol_list := Void
			internal_unicode_symbol_list := Void
			template_sorted_names := Void
			if a_completion_possibilities /= Void then
					-- For alias name completion, it could be Void or empty.
				across a_completion_possibilities as ic loop
					if attached {EB_TEMPLATE_FOR_COMPLETION} ic.item as l_item then
						add_template_item (l_item)
					else
						add_item (ic.item)
					end
				end
			end
		end

	add_template_item (a_item: EB_TEMPLATE_FOR_COMPLETION)
			-- Add item `a_item' to the list of template_sorted_names.
		local
			l_templates: like template_sorted_names
		do
			l_templates := template_sorted_names
			if l_templates = Void then
				create l_templates.make_empty
				l_templates.force (a_item, l_templates.count + 1)
			else
				l_templates.force (a_item, l_templates.count + 1)
			end
			template_sorted_names := l_templates
		end

	add_item (a_item: like name_type)
			-- Add item `a_item' to the list of sorted_names.
		local
			l_sorted_names: like sorted_names
		do
			l_sorted_names := sorted_names
			if l_sorted_names = Void then
				create l_sorted_names.make_filled (a_item, 1, 1)
			else
				l_sorted_names.force (a_item, l_sorted_names.count + 1)
			end
			sorted_names := l_sorted_names
		end

feature -- Access

	choice_list: EB_COMPLETION_LIST_GRID
			-- Choice list.

	code_completable: EB_TAB_CODE_COMPLETABLE
			-- Associated window.

	sorted_names: SORTABLE_ARRAY [like name_type]
			-- List of possible feature names sorted alphabetically.

	target_class_c: detachable CLASS_C
			-- Targetted class c when feature completing.
			-- It may be Void if there is not a unique target class.
		require
			is_feature_mode: feature_mode
		local
			l_stop: BOOLEAN
		do
			if feature_mode and attached sorted_names as arr and then not arr.is_empty then
				across
					arr as ic
				until
					l_stop
				loop
					if
						attached {EB_FEATURE_FOR_COMPLETION} ic.item as l_item and then
						attached l_item.associated_feature as f and then
						attached f.associated_class as cl
					then
						if Result = Void then
							Result := cl
						elseif Result.class_id /= cl.class_id then
							Result := Void
							l_stop := True
						end
					end
				end
			end
		end

	template_sorted_names: SORTABLE_ARRAY [like name_type]
			-- List of possible template names sorted alphabetically.

	filter_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Filter option button.

	option_bar: EV_TOOL_BAR
			-- Option tool bar.

	tooltip_window: ES_SMART_TOOLTIP_WINDOW
			-- Window to show extra info as tooltip.

	option_template_feature: EV_VERTICAL_BOX
			-- Widget to show template/feature CTRL +SPACE

	info_associated_target_class_box: EV_VERTICAL_BOX
			-- Box to hold `info_associated_target_class_inner_box`

	info_associated_target_class_inner_box: EV_HORIZONTAL_BOX
			-- Box to show associated target class if any.

	show_info_associated_target_class
		do
			if info_associated_target_class_set then
				info_associated_target_class_box.show
			end
		end

	hide_info_associated_target_class
		do
			info_associated_target_class_box.hide
		end

	info_associated_target_class_set: BOOLEAN
			-- Is associated target class set ?

feature -- Widget

	show_return_type_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show return type.

	show_signature_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show signature.

	show_target_class_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show/hide target class info.

	show_disambiguated_name_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show disambiguated name.

	show_completion_unicode_symbols_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show unicode symbols.

	show_obsolete_items_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show obsolete features/classes.

	remember_size_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to remember window size.

	show_tooltip_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show/hide tool-tips.

feature -- Query

	is_applicable_item (a_item: like name_type): BOOLEAN
			-- Determines if `a_item' is an applicable item to show in the completion list
		do
			Result := Precursor {CODE_COMPLETION_WINDOW} (a_item)
			if Result and then a_item /= Void then
				if
					not show_obsolete_items and then
					attached {EB_NAME_FOR_COMPLETION} a_item as eb_item and then eb_item.is_obsolete
				then
					Result := False
				elseif
					not show_completion_unicode_symbols and then
					attached {EB_SYMBOLS_FOR_COMPLETION} a_item
				then
					Result := False
				end
			end
		end

	is_applicable_item_with_name (a_item: like name_type; a_name: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Determines if `a_item' is an applicable item to show in the completion list
			-- when name is `a_name`.
		do
			Result := Precursor (a_item, a_name)
			if
				Result and then
				(a_name = Void or else a_name.is_whitespace)
			then
					-- Do not display unicode symbols when no prefix is typed.
					-- otherwise all unicode symbols will be listed for any feature completion!
				if attached {EB_SYMBOLS_FOR_COMPLETION} a_item as l_uc_item then
					Result := l_uc_item.begins_with (if a_name = Void then "" else a_name end)
				end
			end
		end

feature {NONE} -- Status report: completion mode.

	feature_completion_mode: INTEGER = 1
	class_completion_mode: INTEGER = 2
	alias_name_completion_mode: INTEGER = 3

	completion_mode: INTEGER
			-- Completion mode value.

feature -- Status report

	feature_mode: BOOLEAN
			-- Is `Current' used to select feature names ?
		do
			Result := completion_mode = feature_completion_mode
		end

	class_mode: BOOLEAN
			-- Is `Current' used to select class names ?
		do
			Result := completion_mode = class_completion_mode
		end

	alias_name_mode: BOOLEAN
			-- Is `Current' used to select feature names ?
		do
			Result := completion_mode = alias_name_completion_mode
		end

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

	hide
			-- <Precursor>
		do
			if attached tooltip_window as w then
				w.hide
				contract_widget := Void
				template_widget := Void
				w.reset_pop_widget
			end
			Precursor {CODE_COMPLETION_WINDOW}
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

	show_completion_target_class: BOOLEAN
		do
			Result := preferences.editor_data.show_completion_target_class
		end

	show_completion_disambiguated_name: BOOLEAN
		do
			Result := preferences.editor_data.show_completion_disambiguated_name
		end

	show_completion_unicode_symbols: BOOLEAN
		do
			Result := preferences.editor_data.show_completion_unicode_symbols
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

	on_option_label_selected (a_label: EV_LINK_LABEL)
			-- On option button selected
		require
			a_label_not_void: a_label /= Void
		do
			show_next_panel
		end

	on_option_button_selected (a_button: EV_TOOL_BAR_TOGGLE_BUTTON)
			-- On option button selected
		require
			a_button_not_void: a_button /= Void
		local
			l_preference: BOOLEAN_PREFERENCE
			l_update_selection: BOOLEAN
		do
			clicking_option_button := True
			if a_button = filter_button then
				l_preference := preferences.editor_data.filter_completion_list_preference
				l_preference.set_value (a_button.is_selected)
				apply_filter_completion_list (a_button.is_selected)
				l_update_selection := True
			elseif a_button = show_return_type_button then
				l_preference := preferences.editor_data.show_completion_type_preference
				apply_option_changes (a_button.is_selected)
			elseif a_button = show_signature_button then
				l_preference := preferences.editor_data.show_completion_signature_preference
				apply_show_completion_signature (a_button.is_selected)
			elseif a_button = show_disambiguated_name_button then
				l_preference := preferences.editor_data.show_completion_disambiguated_name_preference
				apply_show_completion_disambiguated_name (a_button.is_selected)
			elseif a_button = show_completion_unicode_symbols_button then
				l_preference := preferences.editor_data.show_completion_unicode_symbols_preference
				l_preference.set_value (a_button.is_selected)
				apply_show_completion_unicode_symbols (a_button.is_selected)
				l_update_selection := True
			elseif a_button = show_obsolete_items_button then
				l_preference := preferences.editor_data.show_completion_obsolete_items_preference
				l_preference.set_value (a_button.is_selected)
				apply_show_obsolete_items (a_button.is_selected)
				l_update_selection := True
			elseif a_button = show_tooltip_button then
				l_preference := preferences.editor_data.show_completion_tooltip_preference
				apply_show_tooltip (a_button.is_selected)
			elseif a_button = show_target_class_button then
				l_preference := preferences.editor_data.show_completion_target_class_preference
				apply_show_target_class (a_button.is_selected)
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
			if l_update_selection then
				select_closest_match
			end
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
					apply_option_changes (l_preference.value)
				elseif a_button = show_signature_button then
					l_preference := preferences.editor_data.show_completion_signature_preference
					apply_show_completion_signature (l_preference.value)
				elseif a_button = show_disambiguated_name_button then
					l_preference := preferences.editor_data.show_completion_disambiguated_name_preference
					apply_show_completion_disambiguated_name (l_preference.value)
				elseif a_button = show_completion_unicode_symbols_button then
					l_preference := preferences.editor_data.show_completion_unicode_symbols_preference
					apply_show_completion_unicode_symbols (l_preference.value)
				elseif a_button = show_obsolete_items_button then
					l_preference := preferences.editor_data.show_completion_obsolete_items_preference
					apply_show_obsolete_items (l_preference.value)
				elseif a_button = show_tooltip_button then
					l_preference := preferences.editor_data.show_completion_tooltip_preference
					apply_show_tooltip (l_preference.value)
				elseif a_button = show_target_class_button then
					l_preference := preferences.editor_data.show_completion_target_class_preference
					apply_show_target_class (l_preference.value)
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
				local_name := {like name_type} / l_list.selected_rows.first.data
				check
					local_name_not_void: local_name /= Void
				end
			end

			build_displayed_list (buffered_input)

				-- Try to selected saved item
				-- If does not exist any more, we call `ensure_item_selection'
			if local_name /= Void then
				local_index := grid_row_by_data (local_name)
			end
			if local_index = 0 then
				ensure_item_selection
			else
				l_list.remove_selection
				l_list.row (local_index).enable_select
				l_list.row (local_index).ensure_visible
			end
			resize_column_to_window_width
		end

	apply_option_changes (a_b: BOOLEAN)
			-- Apply options changes.
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
			if local_index > l_list.row_count then
				local_index := 0
			end
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
			apply_option_changes (a_b)
		end

	apply_show_completion_disambiguated_name (a_b: BOOLEAN)
			-- Apply showing completion disambiguated name.
		do
			apply_option_changes (a_b)
		end

	apply_show_completion_unicode_symbols (b: BOOLEAN)
		do
			apply_option_changes (b)
		end

	apply_show_obsolete_items (a_b: BOOLEAN)
			-- Apply showing completion obsolete items.
		do
			apply_option_changes (a_b)
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

	apply_show_target_class (b: BOOLEAN)
			-- Apply showing completion target class.
		do
			if b then
				if feature_mode then
					show_info_associated_target_class
				end
			else
				hide_info_associated_target_class
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
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_unicode_symbols")
			l_pre.change_actions.prune_all (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_show_obsolete_items")
			l_pre.change_actions.prune_all (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("toggle_remember_size")
			l_pre.change_actions.prune_all (setup_accelerators_agent)
			l_pre := preferences.editor_data.shortcuts.item ("next_completion_panel")
			l_pre.change_actions.prune_all (setup_accelerators_agent)
		end

	setup_accelerators_agent: PROCEDURE

feature {NONE} -- Action handlers

	on_pointer_hovering_item (a_item: detachable EV_GRID_ITEM)
			-- Mouse is hovering `a_item`.
		do
			if
				a_item /= Void and then
				not a_item.is_destroyed and then
				attached a_item.row as l_row
			then
				l_row.enable_select
			end
		end

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
								-- We check for row parent incase it has been subsequently removed from grid

							if attached {EB_TEMPLATE_FOR_COMPLETION} a_r.data then
									-- Template tooltip
								if attached template_widget_from_row (a_r) as l_widget then
										-- Tooltip window
									if tooltip_window = Void then
										create tooltip_window.make
									end
									tooltip_window.set_popup_widget (l_widget.widget)
									if is_displayed then
										show_tooltip (a_r)
									end
								end
							else
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
						end
						show_timer.set_interval (0)
					end (a_row)
				)
		end

	on_key_released (ev_key: EV_KEY)
			-- Process user input in `choice_list'.
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
			-- React on window resizing.
		do
			if
				is_displayed and then
				attached tooltip_window as l_w and then
				l_w.is_shown and then
				not l_w.is_recycled and then
				attached choice_list.single_selected_row as l_row
			then
				show_tooltip (l_row)
			end
		end

	on_dpi_window_resize (a_dpi, a_x, a_y, a_width, a_height: INTEGER)
			-- React on window resizing.
		do
			on_window_resize (a_x, a_y, a_width, a_height)
		end

	on_scroll (a_x, a_y: INTEGER)
			-- React on window scrolling.
		do
			Precursor {CODE_COMPLETION_WINDOW}(a_x, a_y)
			if
				is_displayed and then
				attached tooltip_window as l_w and then
				l_w.is_shown and then
				not l_w.is_recycled and then
				attached choice_list.single_selected_row as l_row
			then
				show_tooltip (l_row)
			end
		end

feature {NONE} -- String matching		

	build_full_list
		local
			cnt: INTEGER
			l_sorted_names: like sorted_names
			lst: like unicode_symbol_list
		do
				-- For feature completion, also include unicode symbols if completion is requested.
			if
				show_completion_unicode_symbols and then
				ev_application.ctrl_pressed and then -- Only on demand!
				(feature_mode or alias_name_mode)
			then
				if feature_mode then
					lst := internal_delayed_unicode_symbol_list
				else
					lst := internal_unicode_symbol_list
				end
				if lst = Void then
						-- Only once!
					lst := unicode_symbol_list (feature_mode) -- i.e for text_mode, using the non delayed list.
					internal_delayed_unicode_symbol_list := lst
					if not lst.is_empty then
						l_sorted_names := sorted_names
						if l_sorted_names = Void then
							cnt := 0
							create l_sorted_names.make_filled (lst [lst.lower], cnt + 1, cnt + lst.count)
							sorted_names := l_sorted_names
						else
							cnt := l_sorted_names.upper
							l_sorted_names.conservative_resize_with_default (lst [lst.lower], l_sorted_names.lower, cnt + lst.count)
						end
						across
							lst as ic
						loop
							cnt := cnt + 1
							l_sorted_names.force (ic.item, cnt)
						end
						l_sorted_names.sort
					end
				end
			end
			Precursor
		end

	unicode_symbol_list (a_is_delayed: BOOLEAN): SORTABLE_ARRAY [EB_SYMBOLS_FOR_COMPLETION]
			-- Unicode symbols for completion.
			-- if `a_is_delayed` then symbol are suggested after N inserted characters.
		local
			cnt: INTEGER
			tb: like unicode_symbols
			n: EB_SYMBOLS_FOR_COMPLETION
		do
			tb := unicode_symbols
			create Result.make_filled (create {EB_SYMBOLS_FOR_COMPLETION}.make ("_", {STRING_32} "_"), 1, tb.count)
			cnt := 0
			across
				tb as ic
			loop
				cnt := cnt + 1

				if a_is_delayed then
					create {EB_SYMBOLS_FOR_DELAYED_COMPLETION} n.make (ic.key, ic.item)
				else
					create {EB_SYMBOLS_FOR_COMPLETION} n.make (ic.key, ic.item)
				end
				Result.force (n, cnt)
			end
		end

	internal_delayed_unicode_symbol_list,
	internal_unicode_symbol_list: like unicode_symbol_list

	unicode_symbols: EB_COMPLETION_UNICODE_SYMBOLS
		once
			create Result.make
		end

feature -- Panel

	show_next_panel
			-- Display next panel (features, templates, symbols, ...)
		do
			if attached tooltip_window as l_w and then l_w.is_shown and then not l_w.is_recycled then
					-- Discard tooltip when changing panel
				l_w.hide
			end
			show_panel_by_id (next_panel_id (current_panel_id))
		end

	show_panel_by_id (a_panel_id: INTEGER)
		do
			inspect a_panel_id
			when template_panel_id then
				show_template_panel
			when symbols_panel_id then
				show_symbol_panel
			when features_panel_id then
				show_features_panel
			else
				show_features_panel
			end
			resize_column_to_window_width
			show
		end

	show_features_panel
		do
			current_panel_id := features_panel_id
			next_panel_label.set_text (panel_title (next_panel_id (current_panel_id)))
			next_panel_label.refresh_now

			option_bar_box.show
			if show_completion_target_class then
				show_info_associated_target_class
			end
			build_full_list

			resize_column_to_window_width
			show
		end

	show_template_panel
		do
			current_panel_id := template_panel_id
			next_panel_label.set_text (panel_title (next_panel_id (current_panel_id)))
			next_panel_label.refresh_now

			option_bar_box.hide
			hide_info_associated_target_class

				-- Build template list.
			if attached template_sorted_names as l_names then
				full_list := l_names
			else
					-- Empty full list if we don't have templates to show.
				reset_full_list
			end

			resize_column_to_window_width
			show
		end

	show_symbol_panel
		local
			l_names: like unicode_symbol_list
		do
			current_panel_id := symbols_panel_id
			next_panel_label.set_text (panel_title (next_panel_id (current_panel_id)))
			next_panel_label.refresh_now

			option_bar_box.hide
			hide_info_associated_target_class

				-- Build template list.
			l_names := internal_unicode_symbol_list
			if l_names = Void then
				l_names := unicode_symbol_list (False)
				l_names.sort
				internal_unicode_symbol_list := l_names
			end
			if l_names /= Void then
				full_list := l_names
			else
					-- Empty full list if we don't have templates to show.
				reset_full_list
			end
			resize_column_to_window_width
			show
		end

	current_panel_id: INTEGER

	next_panel_id (a_id: INTEGER): INTEGER
		do
			inspect a_id
			when features_panel_id then
				Result := template_panel_id
			when template_panel_id then
				Result := symbols_panel_id
			when symbols_panel_id then
				Result := features_panel_id
			else
				Result := features_panel_id
			end
		end

	next_panel_title: STRING_32
		do
			Result := panel_title (next_panel_id (current_panel_id))
		end

	panel_title (a_panel_id: INTEGER): STRING_32
		do
			inspect a_panel_id
			when features_panel_id then
				Result := interface_names.l_show_features
			when template_panel_id then
				Result := interface_names.l_show_templates
			when symbols_panel_id then
				Result := interface_names.l_show_symbols
			else
				Result := "../.."
			end
			if attached preferences.editor_data.shortcuts.item ("next_completion_panel") as l_pref then
				Result := Result + {STRING_32} " (" + l_pref.display_string + {STRING_32} ")"
			end
		end

	features_panel_id: INTEGER = 1
	template_panel_id: INTEGER = 2
	symbols_panel_id: INTEGER = 3

feature {NONE} -- Implementation

	contract_widget: TUPLE [widget: EV_WIDGET; comment: EVS_LABEL; viewer: ES_CONTRACT_VIEWER_WIDGET]
			-- Reference to the tooltip widget.

	template_widget: TUPLE [widget: EV_WIDGET; comment: EVS_LABEL; viewer: ES_TEMPLATE_VIEWER_WIDGET]
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
			l_padding.set_minimum_height ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size ({ES_UI_CONSTANTS}.label_vertical_padding))
			l_padding.set_background_color (colors.tooltip_color)
			l_v.extend (l_padding)
			l_v.disable_item_expand (l_padding)

			create l_h
			l_v.extend (l_h)
			l_v.disable_item_expand (l_h)

			create l_padding
			l_padding.set_minimum_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size ({ES_UI_CONSTANTS}.label_horizontal_padding))
			l_padding.set_background_color (colors.tooltip_color)
			l_h.extend (l_padding)
			l_h.disable_item_expand (l_padding)

			create l_comment_preview
			l_h.extend (l_comment_preview)

			create l_padding
			l_padding.set_minimum_height ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size ({ES_UI_CONSTANTS}.label_vertical_padding))
			l_padding.set_background_color (colors.tooltip_color)
			l_v.extend (l_padding)
			l_v.disable_item_expand (l_padding)
			l_padding.set_minimum_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (300))

				-- Separator
			create l_sep
			l_sep.set_minimum_height ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (2))
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


	new_template_widget: like template_widget
			-- Create all the necessary widgets to display the tooltip.
		local
			l_viewer: ES_TEMPLATE_VIEWER_WIDGET
			l_v: EV_VERTICAL_BOX
			l_h: EV_HORIZONTAL_BOX
			l_padding: EV_CELL
			l_sep: EV_HORIZONTAL_SEPARATOR
			l_widget: EV_WIDGET
			l_comment_preview: EVS_LABEL
		do
			create l_v

			create l_padding
			l_padding.set_minimum_height ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size ({ES_UI_CONSTANTS}.label_vertical_padding))
			l_padding.set_background_color (colors.tooltip_color)
			l_v.extend (l_padding)
			l_v.disable_item_expand (l_padding)

			create l_h
			l_v.extend (l_h)
			l_v.disable_item_expand (l_h)

			create l_padding
			l_padding.set_minimum_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size ({ES_UI_CONSTANTS}.label_horizontal_padding))
			l_padding.set_background_color (colors.tooltip_color)
			l_h.extend (l_padding)
			l_h.disable_item_expand (l_padding)

			create l_comment_preview
			l_h.extend (l_comment_preview)

			create l_padding
			l_padding.set_minimum_height ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size ({ES_UI_CONSTANTS}.label_vertical_padding))
			l_padding.set_background_color (colors.tooltip_color)
			l_v.extend (l_padding)
			l_v.disable_item_expand (l_padding)
			l_padding.set_minimum_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (300))

				-- Separator
			create l_sep
			l_sep.set_minimum_height ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (2))
			l_v.extend (l_sep)
			l_v.disable_item_expand (l_sep)

			l_comment_preview.align_text_left
			l_comment_preview.is_text_wrapped := True
			l_comment_preview.set_background_color (colors.tooltip_color)

			create l_viewer.make
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
			elseif attached {EB_TEMPLATE_FOR_COMPLETION} a_row.data as l_completion_template then
				l_tt_text := l_completion_template.tooltip_text
			elseif attached {EB_CLASS_FOR_COMPLETION} a_row.data as l_completion_class then
				l_tt_text := l_completion_class.tooltip_text
			elseif attached {NAME_FOR_COMPLETION} a_row.data as l_completion_name then
				l_tt_text := l_completion_name.tooltip_text
			end
			if l_tt_text /= Void and then not l_tt_text.is_whitespace then
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


	template_widget_from_row (a_row: EV_GRID_ROW): like template_widget
			-- Contract widget from a grid row
		require
			a_row_set: a_row /= Void
		local
			l_viewer: ES_TEMPLATE_VIEWER_WIDGET
			l_tt_text: STRING_32
			l_cc_text: STRING_32
			l_screen: EV_RECTANGLE
			l_comment_preview: EVS_LABEL
		do
			if attached template_widget as l_widget then
				Result := l_widget
			else
				Result := new_template_widget
				template_widget := Result
			end
			l_comment_preview := Result.comment
			l_viewer := Result.viewer

			if attached {EB_TEMPLATE_FOR_COMPLETION} a_row.data as l_completion_template then
				l_tt_text := l_completion_template.tooltip_text
				l_cc_text := l_completion_template.code_texts.code
				l_cc_text.right_adjust
				l_screen := (create {EV_SCREEN}).monitor_area_from_position (screen_x, screen_y)
				l_viewer.set_maximum_widget_width (l_screen.width - {ES_UI_CONSTANTS}.horizontal_padding * 2)
				l_viewer.set_content (l_cc_text)
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
			uc: CHARACTER_32
			c: CHARACTER
		do
			if character_string.count = 1 then
				uc := character_string [1]
				if
					code_completable.is_completing and then
					code_completable.is_char_activator_character (uc)
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
				c := uc.to_character_8
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
			-- Process user input in `choice_list'.
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
			-- Сlose the window and perform completion with selected item.
		do
			if choice_list.has_selected_row then
					-- Delete current token so it is later replaced by the completion text
				if not buffered_input.is_empty then
					remove_characters_entered_since_display
				end
				if feature_mode then
					complete_feature
				elseif class_mode then
					complete_class
				else
					complete_alias_name
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
				if attached {like name_type} l_row.data as l_name_item then
					if attached {EB_TEMPLATE_FOR_COMPLETION} l_name_item as l_code_complete then
							-- Complete template

						code_completable.complete_code_template_from_window (l_code_complete)
					else
						-- Complete feature
						if ev_application.ctrl_pressed or else show_completion_disambiguated_name then
							if attached {EB_NAME_FOR_COMPLETION} l_name_item as eb_name_item and then eb_name_item.has_dot then
								local_name := l_name_item.full_insert_name
							elseif attached {EB_SYMBOLS_FOR_COMPLETION} l_name_item as eb_uc_item then
								local_name := eb_uc_item.full_insert_name
							else
								local_name := {STRING_32} " " + l_name_item.full_insert_name
							end
						else
							if attached {EB_NAME_FOR_COMPLETION} l_name_item as eb_name_item and then eb_name_item.has_dot then
								local_name := l_name_item.insert_name
							elseif attached {EB_SYMBOLS_FOR_COMPLETION} l_name_item as eb_uc_item then
								local_name := eb_uc_item.insert_name
							else
								local_name := {STRING_32} " " + l_name_item.insert_name
							end
						end
						code_completable.complete_feature_from_window (local_name, True, character_to_append, remainder, continue_completion)
						if attached {EB_FEATURE_FOR_COMPLETION} l_name_item as local_feature then
							last_completed_feature_had_arguments := local_feature.has_arguments
						else
							last_completed_feature_had_arguments := False
						end
					end
				else
					check row_data_is_name_type: False end
				end
			end
		end

	complete_class
			-- Complete class name
		local
			local_name: STRING_GENERAL
		do
			if choice_list.has_selected_row then
				if
					attached choice_list.selected_rows.first as l_first_row and then
					attached {NAME_FOR_COMPLETION} l_first_row.data as l_name_item
				then
					local_name := l_name_item.insert_name
					code_completable.complete_class_from_window (local_name, '%U', remainder)
				else
					check has_name_item: False end
				end
			elseif not buffered_input.is_empty then
				code_completable.complete_class_from_window (buffered_input, character_to_append, remainder)
			end
		end

	complete_alias_name
			-- Complete class name
		local
			local_name: STRING_GENERAL
		do
			if choice_list.has_selected_row then
				if
					attached choice_list.selected_rows.first as l_first_row and then
					attached {NAME_FOR_COMPLETION} l_first_row.data as l_name_item
				then
					local_name := l_name_item.insert_name
					code_completable.complete_alias_name_from_window (local_name, '%U', remainder)
				else
					check has_name_item: False end
				end
			elseif not buffered_input.is_empty then
				code_completable.complete_alias_name_from_window (buffered_input, character_to_append, remainder)
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

	last_completed_feature_had_arguments: BOOLEAN
			-- Did the last inserted completed feature name contain arguments?

	clicking_option_button: BOOLEAN
			-- Clicking option button?

	show_timer: EV_TIMEOUT
			-- Timer to show the tooltip

	name_type: WILD_NAME_FOR_COMPLETION
			-- <Precursor>
		do
		end

	is_binary_search_supported (a_name: STRING_32): BOOLEAN
		do
			Result := not show_completion_unicode_symbols and then Precursor (a_name)
		end

note
	ca_ignore:
		"CA011", "CA011: too many arguments",
		"CA033", "CA033: too large class"
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
