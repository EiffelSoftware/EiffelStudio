indexing
	description : "Objects that edit a breakpoint..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_BREAKPOINT_DIALOG

inherit
	ES_DIALOG
		redefine
			is_size_and_position_remembered
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	SHARED_DEBUGGER_MANAGER

create
	make

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	refresh_now_delayer: ES_DELAYED_ACTION

	request_refresh_now is
		do
			if refresh_now_delayer = Void then
				create refresh_now_delayer.make (agent refresh_now, 300)
			end
			refresh_now_delayer.request_call
		end

	refresh_now is
		do
			if refresh_now_delayer /= Void then
				refresh_now_delayer.cancel_request
			end

			dialog.refresh_now
			if operations_panel /= Void then
				operations_panel.refresh_now
			end
			if condition_panel /= Void then
				condition_panel.refresh_now
			end
			if hit_count_panel /= Void then
				hit_count_panel.refresh_now
			end
			if when_hits_panel /= Void then
				when_hits_panel.refresh_now
			end

			hit_count_current_lb.refresh_now
		end

feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX) is
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
--			hb: EV_HORIZONTAL_BOX
			vb_ctx,vb_when: EV_VERTICAL_BOX
			b: EV_VERTICAL_BOX
			f: EV_FRAME
			link: EVS_LINK_LABEL
		do
				--| Left
			create vb_ctx
			b := vb_ctx
			b.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			b.set_border_width ({ES_UI_CONSTANTS}.frame_border)


			build_operations_panel
			extend_non_expandable_to (b, operations_panel)
			build_condition_panel
			extend_non_expandable_to (b, condition_panel)
			build_hit_count_panel
			extend_non_expandable_to (b, hit_count_panel)

				--| Right
			create vb_when
			b := vb_when
			b.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			b.set_border_width ({ES_UI_CONSTANTS}.frame_border)

			build_when_hits_panel
			b.extend (when_hits_panel)

--			create hb
--			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
--			a_container.extend (hb)
--			hb.extend (vb_ctx)
--			hb.extend (vb_when)

			create noteb
			a_container.extend (noteb)
			noteb.extend (vb_ctx)
			noteb.extend (vb_when)
			noteb.set_tab_position ({EV_NOTEBOOK}.tab_bottom)
			noteb.item_tab (vb_ctx).set_text (Interface_names.b_bp_context_title)
			noteb.item_tab (vb_when).set_text (Interface_names.b_bp_when_hits_title)

			create link.make_with_text (interface_names.m_when_hits)
			link.select_actions.extend (agent noteb.select_item (vb_when))
			link.align_text_left
			create b; b.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			extend_non_expandable_to (b, link)
			extend_expandable_to (b, create {EV_CELL})
			create f
			f.extend (b)
			extend_expandable_to (vb_ctx, f)

			set_button_text (dialog_buttons.ok_button, interface_names.b_ok)
			set_button_text (dialog_buttons.reset_button, interface_names.b_reset)
			set_button_text (dialog_buttons.cancel_button, interface_names.b_cancel)

			set_button_action_before_close (dialog_buttons.ok_button, agent on_ok)
			set_button_action_before_close (dialog_buttons.reset_button, agent on_reset)
			set_button_action_before_close (dialog_buttons.cancel_button, agent on_cancel)

			dialog.resize_actions.force_extend (agent request_refresh_now)
		end

feature -- Access: Help

	help_context_id: !STRING_GENERAL
			-- <Precursor>
		once
			Result := "1AC830AB-7600-8E52-2351-C515BCC31D41"
		end

feature -- Widgets

	noteb: EV_NOTEBOOK
			-- Notebook holding the interface

feature -- Properties

	breakpoint_routine: E_FEATURE
			-- Associated Breakpoint's routine.

	breakpoint_index: INTEGER
			-- Associated Breakpoint's breakable index.

	associated_breakpoint: BREAKPOINT is
			-- Associated Breakpoint.
		local
			bm: BREAKPOINTS_MANAGER
			loc: BREAKPOINT_LOCATION
		do
			bm := debugger_manager.breakpoints_manager
			if bm /= Void then
				loc := bm.breakpoint_location (breakpoint_routine, breakpoint_index, False)
				if bm.is_user_breakpoint_set_at (loc) then -- user bp
					Result := bm.user_breakpoint_at (loc)
				end
			end
		end

feature -- behavior

	switch_to_context_tab is
			-- Switch to "Context" tab
		do
			noteb.select_item (noteb.i_th (1))
		end

	switch_to_when_hits_tab is
			-- Switch to "When hits" tab	
		do
			noteb.select_item (noteb.i_th (2))
		end

	focus_widget (w: EV_WIDGET) is
			-- Focus `w' is possible
		do
			if
				w /= Void and then
				w.is_displayed and then
				w.is_sensitive
			then
				w.set_focus
			end
		end

	focus_condition_panel is
			-- Focus "condition" panel
		do
			switch_to_context_tab
			focus_widget (condition_panel)
			focus_widget (condition_expression_tf)
		end

	focus_hit_count_panel is
			-- Focus "hit count" panel	
		do
			switch_to_context_tab
			focus_widget (hit_count_panel)
		end

	focus_when_hits_panel is
			-- Focus "when hits" panel
		do
			switch_to_when_hits_tab
			focus_widget (when_hits_panel)
		end

feature {NONE} -- Helpers

	register_input_widget (aw: EV_WIDGET) is
			-- Register `aw' as an input widget
		do
			suppress_confirmation_key_close  (aw)
		end

	new_panel_container (a_text: STRING_GENERAL; a_collapsable: BOOLEAN): EV_FRAME is
			-- Create a new panel container for `a_text',
			-- and make it collapsable if `a_collapsable' is True
		do
			create Result
			if a_text /= Void and then not a_text.is_empty then
				Result.set_text (a_text)
			end
			if a_collapsable then
				Result.pointer_double_press_actions.force_extend (agent (af: EV_FRAME)
						do
							if af.item /= Void then
								if af.item.is_displayed then
									af.item.hide
								else
									af.item.show
								end
							end
						end(Result)
					)
			end
		end

	new_tags_field (a_inc_bp: BOOLEAN): EVS_TAGS_FIELD is
			-- New TAGS_FIELD
		do
			create Result
			Result.set_pixmap (stock_pixmaps.general_edit_icon)
			Result.text_field.drop_actions.extend (agent (abps: BREAKABLE_STONE; atf: like new_tags_field)
					local
						s: STRING_32
					do
						s := abps.to_tag_path
						if s /= Void then
							atf.add_tag ("bp:" + s)
						end
					end(?, Result)
				)
			if a_inc_bp then
				Result.set_provider (debugger_manager.breakpoints_manager.global_tags_provider)
			else
				Result.set_provider (debugger_manager.breakpoints_manager.tags_provider)
			end
			register_input_widget (Result.text_field)
		end

	extend_non_expandable_to (b: EV_BOX; w: EV_WIDGET) is
			-- Extend `w' to `b', and disable expand
		do
			extend_to (b, w, False)
		end

	extend_expandable_to (b: EV_BOX; w: EV_WIDGET) is
			-- Extend `w' to `b', and disable expand
		do
			extend_to (b, w, True)
		end

	extend_to (b: EV_BOX; w: EV_WIDGET; is_expandable: BOOLEAN) is
			-- Extend `w' to `b', and keep expand enabled (default)
		do
			b.extend (w)
			if not is_expandable then
				b.disable_item_expand (w)
			end
		end

	add_toggle_status_on_check_button (a_cb: EV_CHECK_BUTTON; a_ws: ARRAY [EV_WIDGET]; a_cell: EV_CELL; a_wi: EV_WIDGET) is
			-- When `a_cb' is selected, depending of its status
			-- show/hide `a_wi'
			-- disable_/enable_sensitive on `a_ws' items
		require
			a_cb_not_void: a_cb /= Void
			a_wi_not_void_implies_a_cell_not_void: a_wi /= Void implies a_cell /= Void
		do
			a_cb.select_actions.extend (agent (acb: EV_CHECK_BUTTON; aws: ARRAY [EV_WIDGET]; acl: EV_CELL; awi: EV_WIDGET)
				local
--					lw,lh: INTEGER
					p: EV_CONTAINER
				do
					if acb.is_selected then
						if aws /= Void and then not aws.is_empty then
							aws.do_all (agent {EV_WIDGET}.enable_sensitive)
						end
						if awi /= Void and acl /= Void then
							acl.show
							p := awi.parent
							if p /= acl then
								if p /= Void then
									acl.wipe_out
									p.prune_all (awi)
								end
								acl.replace (awi)
							end
							awi.show
						end
					else
						if awi /= Void and acl /= Void then
							acl.hide
							awi.hide
							acl.wipe_out
						end
						if aws /= Void and then not aws.is_empty then
							aws.do_all (agent {EV_WIDGET}.disable_sensitive)
						end
					end
					refresh_now
				end(a_cb, a_ws, a_cell, a_wi)
			)
		end

	set_focus_within_crollable_area (w: EV_WIDGET; scroll: EV_SCROLLABLE_AREA) is
		do
			if
				scroll /= Void and then
				w /= Void  and then scroll.has_recursive (w)
			then
				ev_application.do_once_on_idle (agent w.set_focus)
--				scroll.set_y_offset (scroll.screen_y - w.screen_y)
--				w.set_focus
			end
		end

	toggle_show_hide_widget (a_show_text: STRING_GENERAL; a_hide_text: STRING_GENERAL; a_link: EVS_LINK_LABEL; a_w: EV_WIDGET) is
		do
			if a_w.is_displayed then
				a_w.hide
				a_link.set_text (a_show_text)
			else
				a_w.show
				a_link.set_text (a_hide_text)
			end
		end

feature {NONE} -- Operations

	vertical_scrollbar_width: INTEGER is
		once
			Result := (create {EV_VERTICAL_SCROLL_BAR}).minimum_width
		end

	horizontal_scrollbar_height: INTEGER is
		once
			Result := (create {EV_HORIZONTAL_SCROLL_BAR}).minimum_height
		end

	operations_panel: EV_WIDGET

	details_stone_hd: EV_CELL
	details_class_lb: EV_LABEL
	details_routine_lb: EV_LABEL
	details_index_lb: EV_LABEL
	details_tags_tf: like new_tags_field

	build_operations_panel is
		local
			f: EV_FRAME
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			location_lb: EV_LABEL
			tags_lb: EV_LABEL
--			move_to_bt, copy_to_bt: EV_BUTTON

			s: STRING_32
		do
			f := new_panel_container (interface_names.l_details, True)

			create vb
			vb.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			vb.set_border_width ({ES_UI_CONSTANTS}.frame_border)

			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			s := interface_names.l_location.twin
			s.append_character (':')
			s.append_character (' ')
			create location_lb.make_with_text (s)
			create details_stone_hd
			create details_class_lb
			details_class_lb.set_foreground_color (preferences.editor_data.class_text_color)
			create details_routine_lb
			details_routine_lb.set_foreground_color (preferences.editor_data.feature_text_color)
			create details_index_lb

			extend_non_expandable_to (hb, location_lb)
			extend_non_expandable_to (hb, details_stone_hd)
			extend_non_expandable_to (hb, create {EV_LABEL}.make_with_text ("{"))
			extend_non_expandable_to (hb, details_class_lb)
			extend_non_expandable_to (hb, create {EV_LABEL}.make_with_text ("}."))
			extend_non_expandable_to (hb, details_routine_lb)
			extend_non_expandable_to (hb, create {EV_LABEL}.make_with_text (" @ "))
			extend_non_expandable_to (hb, details_index_lb)

--			create move_to_bt.make_with_text ("Move to") -- FIXME
--			create copy_to_bt.make_with_text ("Copy to") -- FIXME

			extend_non_expandable_to (vb, hb)

			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create tags_lb.make_with_text (Interface_names.l_tags_colon)
			details_tags_tf := new_tags_field (False)
			extend_non_expandable_to (hb, tags_lb)
			extend_expandable_to (hb, details_tags_tf)
			extend_non_expandable_to (vb, hb)

			f.extend (vb)
			operations_panel := f
		ensure
			operations_panel_not_void:  operations_panel /= Void
		end

feature {NONE} -- Condition

	condition_panel: EV_WIDGET

	condition_expression_tf: EB_CODE_COMPLETABLE_TEXT_FIELD
	condition_is_true_rb, condition_has_changed_rb: EV_RADIO_BUTTON
	condition_continue_on_failure_cb: EV_CHECK_BUTTON

	build_condition_panel is
		local
			f: EV_FRAME
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			rem_cond_bt: EV_BUTTON
		do
				--| Widgets
			f := new_panel_container (interface_names.l_condition, True)

			create condition_expression_tf
			condition_expression_tf.set_parent_window (dialog)
			register_input_widget (condition_expression_tf)

			create condition_is_true_rb.make_with_text (Interface_names.l_Is_true)
			create condition_has_changed_rb.make_with_text (Interface_names.l_Has_changed)

			create condition_continue_on_failure_cb.make_with_text (Interface_names.b_Continue_on_condition_failure)

			create rem_cond_bt
			rem_cond_bt.set_pixmap (stock_pixmaps.general_delete_icon)
			rem_cond_bt.set_tooltip (interface_names.m_remove_condition)

				--| Layout
			create vb
			vb.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			vb.set_border_width ({ES_UI_CONSTANTS}.frame_border)

			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
--			hb.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			extend_expandable_to (hb, condition_expression_tf)
			extend_non_expandable_to (hb, rem_cond_bt)
			extend_non_expandable_to (vb, hb)

			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
--			hb.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			extend_non_expandable_to (hb, condition_is_true_rb)
			extend_non_expandable_to (hb, condition_has_changed_rb)
			extend_non_expandable_to (hb, create {EV_CELL})
			extend_non_expandable_to (hb, condition_continue_on_failure_cb)
			extend_non_expandable_to (vb, hb)

			f.extend (vb)

				--| Actions
			register_action (rem_cond_bt.select_actions, agent do
						condition_expression_tf.remove_text
						condition_is_true_rb.enable_select
					end)

				--| Default
			condition_is_true_rb.enable_select
			condition_continue_on_failure_cb.disable_select

			condition_panel := f
		ensure
			condition_panel_not_void: condition_panel /= Void
		end

feature {NONE} -- Hit count

	hit_count_panel: EV_WIDGET

	hit_count_current_lb: EV_LABEL
	hit_count_condition_combo: EV_COMBO_BOX
	hit_count_condition_combo_items: ARRAY [EV_LIST_ITEM]
	hit_count_condition_value_tf: EV_TEXT_FIELD

	build_hit_count_panel is
		local
			f: EV_FRAME
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			title_lb, hit_lb: EV_LABEL
			reset_bt: EV_BUTTON
			li: EV_LIST_ITEM
		do
				--| Widgets
			f := new_panel_container (interface_names.m_hit_count, True)

			create title_lb.make_with_text (interface_names.l_when_breakpoint_is_hit)
			create hit_count_condition_combo
			register_input_widget (hit_count_condition_combo)
			create hit_count_condition_value_tf

			create hit_lb.make_with_text (interface_names.l_current_hit_count)
			create hit_count_current_lb.make_with_text (interface_names.l_ellipsis)
			create reset_bt.make_with_text (interface_names.b_reset)

				--| Layout
			create vb
			vb.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			vb.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			title_lb.align_text_center
			extend_non_expandable_to (vb, title_lb)

			create hb --| [Combo .. ] [value]
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
--			hb.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			extend_expandable_to (hb, hit_count_condition_combo)
			extend_non_expandable_to (hb, hit_count_condition_value_tf)
			hit_count_condition_value_tf.set_minimum_width_in_characters (7)
			extend_non_expandable_to (vb, hb)

			create hb --| Current hit count: 123 [Reset]
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			extend_expandable_to (hb, create {EV_CELL})
			extend_non_expandable_to (hb, hit_lb)
			extend_non_expandable_to (hb, hit_count_current_lb)
			extend_non_expandable_to (hb, reset_bt)
			extend_non_expandable_to (vb, hb)

			f.extend (vb)

				--| Actions
			register_action (reset_bt.select_actions, agent hit_count_reset)

				--| Default
			hit_count_condition_value_tf.hide

			create hit_count_condition_combo_items.make ({BREAKPOINT}.Hits_count_condition_always, {BREAKPOINT}.hits_count_condition_continue_execution)

			create li.make_with_text (Interface_names.m_Break_always)
			register_action (li.select_actions, agent hit_count_condition_value_tf.hide)
			li.set_data ({BREAKPOINT}.Hits_count_condition_always)
			hit_count_condition_combo.extend (li)
			hit_count_condition_combo_items.put (li, {BREAKPOINT}.Hits_count_condition_always)

			create li.make_with_text (Interface_names.m_break_when_hit_count_equal)
			register_action (li.select_actions, agent hit_count_condition_value_tf.show)
			li.set_data ({BREAKPOINT}.Hits_count_condition_equal)
			hit_count_condition_combo.extend (li)
			hit_count_condition_combo_items.put (li, {BREAKPOINT}.Hits_count_condition_equal)

			create li.make_with_text (Interface_names.m_break_when_hit_count_multiple_of)
			register_action (li.select_actions, agent hit_count_condition_value_tf.show)
			li.set_data ({BREAKPOINT}.Hits_count_condition_multiple)
			hit_count_condition_combo.extend (li)
			hit_count_condition_combo_items.put (li, {BREAKPOINT}.Hits_count_condition_multiple)

			create li.make_with_text (Interface_names.m_break_when_hit_count_greater)
			register_action (li.select_actions, agent hit_count_condition_value_tf.show)
			li.set_data ({BREAKPOINT}.Hits_count_condition_greater)
			hit_count_condition_combo.extend (li)
			hit_count_condition_combo_items.put (li, {BREAKPOINT}.Hits_count_condition_greater)

			create li.make_with_text (Interface_names.m_Break_when_hit_count_continue_execution)
			register_action (li.select_actions, agent hit_count_condition_value_tf.hide)
			li.set_data ({BREAKPOINT}.Hits_count_condition_continue_execution)
			hit_count_condition_combo.extend (li)
			hit_count_condition_combo_items.put (li, {BREAKPOINT}.Hits_count_condition_continue_execution)

			hit_count_condition_combo.disable_edit
			hit_count_panel := f
		ensure
			hit_count_panel_not_void: hit_count_panel /= Void
		end

feature {NONE} -- When hits

	when_hits_panel: EV_WIDGET
	when_hits_continue_execution_cb: EV_CHECK_BUTTON
	when_hits_action_container: EV_VERTICAL_BOX
	when_hits_action_scrollable_area: EV_SCROLLABLE_AREA
	when_hits_actions_entries: LINKED_LIST [
				TUPLE [
					data: BREAKPOINT_WHEN_HITS_ACTION_I;
					data_type: TYPE [BREAKPOINT_WHEN_HITS_ACTION_I];
					is_valid_function: FUNCTION [ANY, TUPLE [BREAKPOINT], BOOLEAN];
					apply_function: FUNCTION [ANY, TUPLE [BREAKPOINT], BREAKPOINT_WHEN_HITS_ACTION_I]
					]
				]

	when_hits_actions_entries_has (t: TYPE [BREAKPOINT_WHEN_HITS_ACTION_I]): BOOLEAN is
			-- Does `when_hits_actions_entries' has an item of type `t' ?
		require
			t_not_void: t /= Void
		do
			if when_hits_actions_entries /= Void and then not when_hits_actions_entries.is_empty then
				from
					when_hits_actions_entries.start
				until
					when_hits_actions_entries.after or Result
				loop
					Result := when_hits_actions_entries.item_for_iteration.data_type.is_equal (t)
					when_hits_actions_entries.forth
				end
			end
		end

	build_when_hits_panel is
		local
			f: EV_FRAME
			body: EV_VERTICAL_BOX
			vb: EV_VERTICAL_BOX
			l_combo: EV_COMBO_BOX
			mi: EV_LIST_ITEM
			l_scroll: EV_SCROLLABLE_AREA
			l_fixed: EV_FIXED
		do
				--| Internal Data
			create when_hits_actions_entries.make

				--| Widgets
			f := new_panel_container (interface_names.m_when_hits, True)
			create when_hits_action_container
			create when_hits_continue_execution_cb.make_with_text (interface_names.l_continue_execution)

			create l_combo
			register_input_widget (l_combo)
			l_combo.disable_edit
			create mi.make_with_text (Interface_names.b_bp_add_when_hits_action)
			mi.set_pixmap (stock_pixmaps.general_add_icon)
			l_combo.extend (mi)
			register_action (l_combo.select_actions, agent mi.enable_select)
			(<<
				[interface_names.b_bp_print_message, {BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE}],
				[interface_names.b_bp_change_assertion_checking, {BREAKPOINT_WHEN_HITS_ACTION_CHANGE_ASSERTION_CHECKING}],
				[interface_names.b_bp_activate_execution_recording, {BREAKPOINT_WHEN_HITS_ACTION_EXECUTION_RECORDING}],
				[interface_names.b_bp_enable_disable_breakpoints, {BREAKPOINT_WHEN_HITS_ACTION_CHANGE_BREAKPOINTS_STATUS}],
				[interface_names.b_bp_reset_hits_count, {BREAKPOINT_WHEN_HITS_ACTION_RESET_HIT_COUNT}]
			>>).do_all (agent (t: TUPLE [s:STRING_GENERAL; type: TYPE [BREAKPOINT_WHEN_HITS_ACTION_I]]; b: EV_VERTICAL_BOX; comb: EV_COMBO_BOX)
					local
						lmi: EV_LIST_ITEM
					do
						create lmi.make_with_text (t.s)
						lmi.select_actions.extend (agent insert_when_hits_action_entry_for_type (Void, t.type, b, True))
						comb.extend (lmi)
					end(?, when_hits_action_container, l_combo)
				)

				--| Layout
			create body
			body.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			extend_non_expandable_to (body, l_combo)

			create vb
			vb.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			vb.set_border_width ({ES_UI_CONSTANTS}.frame_border)

			when_hits_action_container.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			extend_non_expandable_to (vb, when_hits_action_container)

				--| Continue execution
			extend_non_expandable_to (vb, when_hits_continue_execution_cb)
			when_hits_continue_execution_cb.disable_select

				--| End of layout and behavior

			create l_scroll
			create l_fixed
			l_scroll.extend (l_fixed)
			l_fixed.extend (vb)
			l_fixed.set_item_position (vb, 0, 0)
			l_scroll.resize_actions.extend (agent (asc: EV_SCROLLABLE_AREA; ax,ay,aw,ah: INTEGER)
					do
						asc.set_item_size (asc.item.minimum_width.max (asc.width - vertical_scrollbar_width), asc.item.minimum_height.max (asc.height - horizontal_scrollbar_height))
					end(l_scroll, ?,?,?,?)
				)
			l_fixed.resize_actions.force_extend (agent (af: EV_FIXED; avb: EV_BOX; ax,ay,aw,ah: INTEGER)
					do
						af.set_item_position (avb, 0, 0)
						af.set_item_size (avb, af.width - 1, af.height - horizontal_scrollbar_height - 1)
					end(l_fixed, vb, ?,?,?,?)
				)
--| Debugging purpose
--l_scroll.set_background_color (colors.stock_colors.red)
--l_fixed.set_background_color (colors.stock_colors.green)
--vb.set_background_color (colors.stock_colors.blue)

			when_hits_action_scrollable_area := l_scroll
			extend_expandable_to (body, l_scroll)
			f.extend (body)

			when_hits_panel := f
		ensure
			when_hits_panel_not_void: when_hits_panel /= Void
		end

	when_hits_print_message_menu (aw: EV_WIDGET; atf: EV_TEXT_FIELD) is
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			arr: ARRAY [STRING_GENERAL]
			s: STRING_GENERAL
			i: INTEGER
		do
			create m.make_with_text (Interface_names.b_bp_insert_keywords)

			arr := <<
						Interface_names.b_bp_custom_expression,
						"$HITCOUNT",
						"$ADDRESS",
						"$CALL",
						"$CALLSTACK",
						"$CLASS",
						"$FEATURE",
						"$THREADID",
						"\{", "\}", "\\"
					>>


			from
				i := arr.lower

				s := arr[i]
				create mi.make_with_text (arr[i])
				s := "{}"
				mi.select_actions.extend (agent atf.insert_text (s))
				mi.select_actions.extend (agent atf.set_focus)
				m.extend (mi)

				i := i + 1
			until
				i > arr.upper
			loop
				s := arr[i]
				create mi.make_with_text (s)
				mi.select_actions.extend (agent atf.insert_text (s))
				mi.select_actions.extend (agent atf.set_caret_position (atf.caret_position + s.count))
				mi.select_actions.extend (agent atf.set_focus)
				m.extend (mi)
				i := i + 1
			end
			m.show_at (aw, 3, 3)
		end

feature -- change

	set_stone (a_bp_stone: BREAKABLE_STONE) is
			-- Fill current with data from `a_bp_stone'
		require
			a_bp_stone_not_void: a_bp_stone /= Void
		do
			if a_bp_stone /= Void then
				breakpoint_routine := a_bp_stone.routine
				breakpoint_index := a_bp_stone.index
			else
				breakpoint_routine := Void
				breakpoint_index := 0
			end
			fill_data
		end

	fill_data is
		local
			p: EV_PIXMAP
			f: E_FEATURE
			cl: CLASS_C
			i: INTEGER
			l_provider: EB_DEBUGGER_EXPRESSION_COMPLETION_POSSIBILITIES_PROVIDER
			bp: BREAKPOINT
			wh_acts: LIST [BREAKPOINT_WHEN_HITS_ACTION_I]
			wh_a: BREAKPOINT_WHEN_HITS_ACTION_I
		do
			f := breakpoint_routine
			i := breakpoint_index
			bp := associated_breakpoint

				-- Details
			if f /= Void then
				p := Breakpoint_pixmaps_factory.pixmap_for_routine_index (debugger_manager, f, i, False)
				if p /= Void then
					p := p.twin
					details_stone_hd.replace (p)
					details_stone_hd.set_minimum_size (p.width, p.height)
					p.set_pebble (create {BREAKABLE_STONE}.make (f, i))
				else
					details_stone_hd.wipe_out
--					details_stone_hd.reset_minimum_width
--					details_stone_hd.reset_minimum_height
				end

				cl := f.associated_class
				if cl /= Void then
					details_class_lb.set_text (cl.name_in_upper)
					details_class_lb.set_pebble (create {CLASSC_STONE}.make (cl))
				else
					details_class_lb.set_text ("???")
					details_class_lb.remove_pebble
				end
				details_routine_lb.set_text (f.name)
				details_routine_lb.set_pebble (create {FEATURE_STONE}.make (f))
				details_index_lb.set_text (i.out)
			else
				details_class_lb.set_text ("???")
				details_class_lb.remove_pebble
				details_routine_lb.set_text ("???")
				details_routine_lb.remove_pebble
				details_index_lb.set_text ("?")
			end

			if bp /= Void then
				details_tags_tf.set_tags (bp.tags_as_array)
			end

				-- Condition: code completion for expression
			if f /= Void then
				create l_provider.make (f.associated_class, f.ast)
				condition_expression_tf.set_completion_possibilities_provider (l_provider)
				l_provider.set_code_completable (condition_expression_tf)
			end

				-- Has Condition ?
			if bp /= Void and then bp.has_condition then
				check
					bp.condition /= Void
				end
				condition_expression_tf.set_text (bp.condition.text)
				if bp.condition_as_is_true then
					condition_is_true_rb.enable_select
				end
				if bp.condition_as_has_changed then
					condition_has_changed_rb.enable_select
				end
				if bp.continue_on_condition_failure then
					condition_continue_on_failure_cb.enable_select
				else
					condition_continue_on_failure_cb.disable_select
				end
			else
				condition_expression_tf.remove_text
				condition_is_true_rb.enable_select
				condition_continue_on_failure_cb.disable_select
			end

				-- Hit count
			if bp /= Void then
				hit_count_current_lb.set_text (bp.hits_count.out)
			end
			if bp /= Void and then bp.has_hit_count_condition then
				inspect bp.hits_count_condition.mode
				when {BREAKPOINT}.hits_count_condition_always, {BREAKPOINT}.hits_count_condition_continue_execution then
					hit_count_condition_value_tf.hide
					hit_count_condition_value_tf.remove_text
				else
					hit_count_condition_value_tf.set_text (bp.hits_count_condition.value.out)
					hit_count_condition_value_tf.show
				end
				hit_count_condition_combo_items[bp.hits_count_condition.mode].enable_select
			else
				hit_count_condition_value_tf.hide
				hit_count_condition_value_tf.remove_text
				hit_count_condition_combo_items[{BREAKPOINT}.Hits_count_condition_always].enable_select
			end

				-- When hits ...
			if bp /= Void then
				wh_acts := bp.when_hits_actions
				from
					wh_acts.start
				until
					wh_acts.after
				loop
					wh_a := wh_acts.item_for_iteration
					insert_when_hits_action_entry (wh_a, when_hits_action_container, False)
					wh_acts.forth
				end
			end

			if bp /= Void then
				if bp.continue_execution then
					when_hits_continue_execution_cb.enable_select
				else
					when_hits_continue_execution_cb.disable_select
				end
			else
				when_hits_continue_execution_cb.disable_select
			end
		end

	insert_when_hits_action_entry (wh_a: BREAKPOINT_WHEN_HITS_ACTION_I; box: EV_VERTICAL_BOX; a_has_focus: BOOLEAN) is
		local
			t: TYPE [BREAKPOINT_WHEN_HITS_ACTION_I]
		do
			t ?= (create {INTERNAL}).type_of (wh_a)
			if t /= Void then
				insert_when_hits_action_entry_for_type (wh_a, t, box, a_has_focus)
			end
		end

	insert_when_hits_action_entry_for_type (wh_a: BREAKPOINT_WHEN_HITS_ACTION_I; wh_atype: TYPE [BREAKPOINT_WHEN_HITS_ACTION_I]; box: EV_VERTICAL_BOX; a_has_focus: BOOLEAN) is
		require
			wh_atype_not_void: wh_atype /= Void
			wh_a_related_to_wh_atype: wh_a /= Void implies ((create {INTERNAL}).type_of (wh_a)).is_equal (wh_atype)
		do
			if wh_atype.is_equal ({BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE}) then
				if wh_a = Void then
					insert_when_hits_action_print_message_entry (Void, box, a_has_focus)
				else
					if {x1: !BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE} wh_a then
						insert_when_hits_action_print_message_entry (x1, box, a_has_focus)
					end
				end
			elseif wh_atype.is_equal ({BREAKPOINT_WHEN_HITS_ACTION_CHANGE_BREAKPOINTS_STATUS}) then
				if wh_a = Void then
					insert_when_hits_action_change_breakpoints_status_entry (Void, box, a_has_focus)
				else
					if {x2: !BREAKPOINT_WHEN_HITS_ACTION_CHANGE_BREAKPOINTS_STATUS} wh_a then
						insert_when_hits_action_change_breakpoints_status_entry (x2, box, a_has_focus)
					end
				end
			elseif wh_atype.is_equal ({BREAKPOINT_WHEN_HITS_ACTION_CHANGE_ASSERTION_CHECKING}) then
				if not when_hits_actions_entries_has (wh_atype) then
					if wh_a = Void then
						insert_when_hits_action_change_assertion_checking_entry (Void, box, a_has_focus)
					else
						if {x3: !BREAKPOINT_WHEN_HITS_ACTION_CHANGE_ASSERTION_CHECKING} wh_a then
							insert_when_hits_action_change_assertion_checking_entry (x3, box, a_has_focus)
						end
					end
				end
			elseif wh_atype.is_equal ({BREAKPOINT_WHEN_HITS_ACTION_EXECUTION_RECORDING}) then
				if not when_hits_actions_entries_has (wh_atype) then
					if wh_a = Void then
						insert_when_hits_action_execution_recording_entry (Void, box, a_has_focus)
					else
						if {x4: !BREAKPOINT_WHEN_HITS_ACTION_EXECUTION_RECORDING} wh_a then
							insert_when_hits_action_execution_recording_entry (x4, box, a_has_focus)
						end
					end
				end
			elseif wh_atype.is_equal ({BREAKPOINT_WHEN_HITS_ACTION_RESET_HIT_COUNT}) then
				if not when_hits_actions_entries_has (wh_atype) then
					if wh_a = Void then
						insert_when_hits_action_reset_hits_count_entry (Void, box, a_has_focus)
					else
						if {x5: !BREAKPOINT_WHEN_HITS_ACTION_RESET_HIT_COUNT} wh_a then
							insert_when_hits_action_reset_hits_count_entry (x5, box, a_has_focus)
						end
					end
				end
			else
			end
		end

	insert_when_hits_action_print_message_entry (a: BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE; box: EV_VERTICAL_BOX; a_has_focus: BOOLEAN) is
		local
			cl: EV_CELL
			cb: EV_CHECK_BUTTON
			vb,pb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
			tf: EV_TEXT_FIELD
			msg_ins_bt: EV_BUTTON
			help_link: EVS_LINK_LABEL
		do
				--| Print message: widgets
			create cb.make_with_text (interface_names.b_bp_print_message)
			create tf
			register_input_widget (tf)
			tf.set_minimum_width_in_characters (20)

			create lab.make_with_text (Interface_names.l_Print_message_help)
			lab.align_text_left
			create help_link.make_with_text (Interface_names.l_show_help)
			help_link.select_actions.extend (agent toggle_show_hide_widget (Interface_names.l_show_help, Interface_names.l_hide_help, help_link, lab))
			help_link.align_text_left

			create msg_ins_bt
			msg_ins_bt.set_pixmap (stock_pixmaps.general_add_icon)
			msg_ins_bt.set_tooltip (interface_names.b_add_text)
				--| Print message: layout
			vb := box
			extend_non_expandable_to (vb, cb)
			create pb
			pb.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			pb.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			extend_expandable_to (hb, tf)
			extend_non_expandable_to (hb, msg_ins_bt)
			extend_non_expandable_to (pb, hb)
			extend_non_expandable_to (pb, lab)
			lab.hide
			extend_non_expandable_to (pb, help_link)
			create cl
			cl.put (pb)
			extend_non_expandable_to (vb, cl)
				--| Print message: Action
			add_toggle_status_on_check_button (cb,<<pb>>, cl, pb)
				--| Specific actions
			register_action (msg_ins_bt.select_actions, agent when_hits_print_message_menu (msg_ins_bt, tf))

				--| Fill data
			if a /= Void then
				tf.set_text (a.message)
				cb.enable_select
			else
				tf.remove_text
				cb.disable_select
			end

			when_hits_actions_entries.extend (
					[
						a, {BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE},
						Void,
						agent (a_bp: BREAKPOINT; aa: BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE;
								acb: EV_CHECK_BUTTON; atf: EV_TEXT_FIELD): BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE
							do
								if acb.is_selected and then not atf.text.is_empty then
									Result := aa
									if Result = Void then
										create Result.make (atf.text)
									else
										Result.set_message (atf.text)
									end
								end
							end(?, a, cb, tf)
					]
				)
			if a_has_focus then
				set_focus_within_crollable_area (cb, when_hits_action_scrollable_area)
			end
			extend_non_expandable_to (when_hits_action_container, create {EV_HORIZONTAL_SEPARATOR})
		end

	insert_when_hits_action_change_breakpoints_status_entry (a: BREAKPOINT_WHEN_HITS_ACTION_CHANGE_BREAKPOINTS_STATUS; box: EV_VERTICAL_BOX; a_has_focus: BOOLEAN) is
		local
			cb: EV_CHECK_BUTTON
			on_rb, off_rb: EV_RADIO_BUTTON
			cl: EV_CELL
			tf: like new_tags_field
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
			create cb.make_with_text (Interface_names.b_bp_enable_disable_breakpoints)

				--| Widgets
			create on_rb.make_with_text (interface_names.l_enabled)
			create off_rb.make_with_text (interface_names.l_disabled)
			tf := new_tags_field (True)

				--| Layout
			create vb
			vb.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			extend_expandable_to (hb, cb)
			extend_non_expandable_to (hb, create {EV_CELL})
			extend_non_expandable_to (hb, on_rb)
			extend_non_expandable_to (hb, off_rb)

			extend_non_expandable_to (vb, hb)
			create cl
			cl.extend (tf)
			extend_non_expandable_to (vb, cl)
			extend_non_expandable_to (box, vb)

				--| actions
			add_toggle_status_on_check_button (cb, <<tf, on_rb, off_rb>>, cl, tf)
				--| default
			if a /= Void then
				cb.enable_select
				if a.status then
					on_rb.enable_select
				else
					off_rb.enable_select
				end
				tf.set_text (a.tags_as_string)
			else
				cb.disable_select
				on_rb.enable_select
				tf.remove_text
			end

			when_hits_actions_entries.extend (
					[
						a, {BREAKPOINT_WHEN_HITS_ACTION_CHANGE_BREAKPOINTS_STATUS},
						Void,
						agent (a_bp: BREAKPOINT; aa: BREAKPOINT_WHEN_HITS_ACTION_CHANGE_BREAKPOINTS_STATUS;
						acb: EV_CHECK_BUTTON; atf: like new_tags_field; aon_rb,aoff_rb: EV_RADIO_BUTTON): BREAKPOINT_WHEN_HITS_ACTION_CHANGE_BREAKPOINTS_STATUS
							do
								if acb.is_selected then
									Result := aa
									if Result = Void then
										create Result.make_with_string_tags (atf.text, aon_rb.is_selected)
									else
										Result.set_tags_from_string (atf.text)
										Result.set_status (aon_rb.is_selected)
									end
								end
							end(?, a, cb, tf, on_rb, off_rb)
					]
				)
			if a_has_focus then
				set_focus_within_crollable_area (cb, when_hits_action_scrollable_area)
			end
			extend_non_expandable_to (when_hits_action_container, create {EV_HORIZONTAL_SEPARATOR})
		end

	insert_when_hits_action_reset_hits_count_entry (a: BREAKPOINT_WHEN_HITS_ACTION_RESET_HIT_COUNT; box: EV_VERTICAL_BOX; a_has_focus: BOOLEAN) is
		local
			cb: EV_CHECK_BUTTON
			tf: like new_tags_field
			cl: EV_CELL
			vb: EV_VERTICAL_BOX
		do
			create cb.make_with_text (Interface_names.b_bp_reset_hits_count)

				--| Widgets
			tf := new_tags_field (True)

				--| Layout
			create vb
			vb.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			extend_non_expandable_to (vb, cb)
			create cl
			cl.extend (tf)
			extend_non_expandable_to (vb, cl)
			extend_non_expandable_to (box, vb)

				--| actions
			add_toggle_status_on_check_button (cb, <<tf>>, cl, tf)
				--| default
			if a /= Void then
				cb.enable_select
				tf.set_text (a.tags_as_string)
			else
				cb.disable_select
				tf.remove_text
			end

			when_hits_actions_entries.extend (
					[
						a, {BREAKPOINT_WHEN_HITS_ACTION_RESET_HIT_COUNT},
						Void,
						agent (a_bp: BREAKPOINT; aa: BREAKPOINT_WHEN_HITS_ACTION_RESET_HIT_COUNT;
						acb: EV_CHECK_BUTTON; atf: like new_tags_field): BREAKPOINT_WHEN_HITS_ACTION_RESET_HIT_COUNT
							do
								if acb.is_selected then
									Result := aa
									if Result = Void then
										create Result.make_with_string_tags (atf.text)
									else
										Result.set_tags_from_string (atf.text)
									end
								end
							end(?, a, cb, tf)
					]
				)
			if a_has_focus then
				set_focus_within_crollable_area (cb, when_hits_action_scrollable_area)
			end
			extend_non_expandable_to (when_hits_action_container, create {EV_HORIZONTAL_SEPARATOR})
		end

	insert_when_hits_action_execution_recording_entry (a: BREAKPOINT_WHEN_HITS_ACTION_EXECUTION_RECORDING; box: EV_VERTICAL_BOX; a_has_focus: BOOLEAN) is
		local
			cb: EV_CHECK_BUTTON
			start_rb, stop_rb: EV_RADIO_BUTTON
			hb: EV_HORIZONTAL_BOX
		do
			create cb.make_with_text (interface_names.b_bp_activate_execution_recording)

				--| Exec replay: widgets
			create start_rb.make_with_text (interface_names.b_start)
			create stop_rb.make_with_text (interface_names.b_stop)
				--| Exec replay: layout
			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			extend_expandable_to (hb, cb)
			extend_non_expandable_to (hb, create {EV_CELL})
			extend_non_expandable_to (hb, start_rb)
			extend_non_expandable_to (hb, stop_rb)
			extend_non_expandable_to (box, hb)

				--| Exec replay: actions
			add_toggle_status_on_check_button (cb, <<start_rb, stop_rb>>, Void, Void)
				--| Exec replay: default

			if a /= Void then
				cb.enable_select
				if a.status then
					start_rb.enable_select
				else
					stop_rb.enable_select
				end
			else
				cb.disable_select
				start_rb.enable_select
			end

			when_hits_actions_entries.extend (
					[
						a, {BREAKPOINT_WHEN_HITS_ACTION_EXECUTION_RECORDING},
						Void,
						agent (a_bp: BREAKPOINT; aa: BREAKPOINT_WHEN_HITS_ACTION_EXECUTION_RECORDING;
								acb: EV_CHECK_BUTTON; astart_rb,astop_rb: EV_RADIO_BUTTON): BREAKPOINT_WHEN_HITS_ACTION_EXECUTION_RECORDING
							do
								if acb.is_selected then
									Result := aa
									if Result = Void then
										create Result.make (astart_rb.is_selected)
									else
										Result.set_status (astart_rb.is_selected)
									end
								end
							end(?, a, cb, start_rb, stop_rb)
					]
				)
			if a_has_focus then
				set_focus_within_crollable_area (cb, when_hits_action_scrollable_area)
			end
			extend_non_expandable_to (when_hits_action_container, create {EV_HORIZONTAL_SEPARATOR})
		end

	insert_when_hits_action_change_assertion_checking_entry (a: BREAKPOINT_WHEN_HITS_ACTION_CHANGE_ASSERTION_CHECKING; box: EV_VERTICAL_BOX; a_has_focus: BOOLEAN) is
		local
			cb: EV_CHECK_BUTTON
			disable_rb, restore_rb: EV_RADIO_BUTTON
			hb: EV_HORIZONTAL_BOX
		do
			create cb.make_with_text (interface_names.b_bp_change_assertion_checking)

				--| Disable/Restore/Toggle widgets
			create disable_rb.make_with_text (interface_names.b_disable)
			create restore_rb.make_with_text (interface_names.b_restore)

				--| Assertion checking: layout
			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			extend_expandable_to (hb, cb)
			extend_non_expandable_to (hb, create {EV_CELL})
			extend_non_expandable_to (hb, disable_rb)
			extend_non_expandable_to (hb, restore_rb)
			extend_non_expandable_to (box, hb)

				--| Assertion checking: actions
			add_toggle_status_on_check_button (cb, <<disable_rb, restore_rb>>, Void, Void)
				--| Assertion checking: default

			if a /= Void then
				cb.enable_select
				if a.status then
					restore_rb.enable_select
				else
					disable_rb.enable_select
				end
			else
				cb.disable_select
				disable_rb.enable_select
			end

			when_hits_actions_entries.extend (
					[
						a, {BREAKPOINT_WHEN_HITS_ACTION_CHANGE_ASSERTION_CHECKING},
						Void,
						agent (a_bp: BREAKPOINT; aa: BREAKPOINT_WHEN_HITS_ACTION_CHANGE_ASSERTION_CHECKING;
								acb: EV_CHECK_BUTTON; adisable_rb,arestore_rb: EV_RADIO_BUTTON): BREAKPOINT_WHEN_HITS_ACTION_CHANGE_ASSERTION_CHECKING
							do
								if acb.is_selected then
									Result := aa
									if Result = Void then
										create Result.make (arestore_rb.is_selected)
									else
										Result.set_status (arestore_rb.is_selected)
									end
								end
							end(?, a, cb, disable_rb, restore_rb)
					]
				)
			if a_has_focus then
				set_focus_within_crollable_area (cb, when_hits_action_scrollable_area)
			end
			extend_non_expandable_to (when_hits_action_container, create {EV_HORIZONTAL_SEPARATOR})
		end

feature -- Action

	error_background_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (255, 210, 210)
		end

	notify_error_on_text_field (a_tf: EV_TEXT_FIELD) is
			--
		local
			col: EV_COLOR
		do
			col := a_tf.background_color
			a_tf.set_background_color (error_background_color)
			a_tf.key_press_actions.extend_kamikaze (agent (atf: EV_TEXT_FIELD; acol: EV_COLOR; akey: EV_KEY)
					do
						atf.set_background_color (acol)
					end(a_tf, col, ?)
				)
		end

	hit_count_reset is
			-- Reset hit count
		local
			bp: BREAKPOINT
		do
			bp := associated_breakpoint
			hit_count_current_lb.set_text ("0")
			hit_count_current_lb.refresh_now
			if bp /= Void then
				bp.reset_hits_count
				debugger_manager.breakpoints_manager.notify_breakpoints_changes
			end
		end

	on_ok is
		local
			bp: BREAKPOINT
			loc: BREAKPOINT_LOCATION
			bpm: BREAKPOINTS_MANAGER
			err,
			new: BOOLEAN
			s: STRING
			expr: DBG_EXPRESSION
			ir: INTEGER_REF
			i,v: INTEGER
			wh_a: BREAKPOINT_WHEN_HITS_ACTION_I
			l_changes: ACTION_SEQUENCE [TUPLE [BREAKPOINT]]
			l_tags_changed: BOOLEAN
		do
			bp := associated_breakpoint
			bpm := debugger_manager.breakpoints_manager
			if bp = Void then
				new := True
				loc := bpm.breakpoint_location (breakpoint_routine, breakpoint_index, True)
				bp := bpm.new_user_breakpoint (loc)
				bpm.add_breakpoint (bp)
			end
			check bp /= Void end

				--| Create changes container
			create l_changes

			--| tags
			l_tags_changed := details_tags_tf.is_modified
			if l_tags_changed then
				l_changes.extend (agent {BREAKPOINT}.set_tags_from_array (details_tags_tf.used_tags))
			end


			--| Condition
			s := condition_expression_tf.text
			if s.is_empty then
				l_changes.extend (agent {BREAKPOINT}.remove_condition)
				--| bp.remove_condition
			else
				create expr.make_with_context (s)
				if expr.syntax_error_occurred then
					notify_error_on_text_field (condition_expression_tf)
					err := True
					prompts.show_error_prompt ((create {SHARED_BENCH_NAMES}).warnings.w_syntax_error_in_expression (s), dialog, agent condition_expression_tf.set_focus)
				else
					if condition_is_true_rb.is_selected then
						if expr.is_boolean_expression (breakpoint_routine) then
							l_changes.extend (agent {BREAKPOINT}.set_condition_as_is_true)
							l_changes.extend (agent {BREAKPOINT}.set_condition (expr))
						else
							err := True
							prompts.show_error_prompt ((create {SHARED_BENCH_NAMES}).warnings.w_not_a_condition (s), dialog, agent condition_expression_tf.set_focus)
						end
					else
						check condition_has_changed_rb.is_selected end
						l_changes.extend (agent {BREAKPOINT}.set_condition_as_has_changed)
						l_changes.extend (agent {BREAKPOINT}.set_condition (expr))
					end
				end
			end
			if err then
				expr := Void
				if new then
					bpm.remove_user_breakpoint (breakpoint_routine, breakpoint_index)
					bp := Void
				end
			else
				l_changes.extend (agent {BREAKPOINT}.set_continue_on_condition_failure (condition_continue_on_failure_cb.is_selected))
			end

			--| Hit count
			if not err then
				ir ?= hit_count_condition_combo.selected_item.data
				if ir /= Void then
					i := ir.item
					inspect i
					when {BREAKPOINT}.hits_count_condition_always,
						{BREAKPOINT}.hits_count_condition_continue_execution
					then
						--| Ok
					else
						s := hit_count_condition_value_tf.text
						if s.is_integer then
							v := s.to_integer
							err := (i = {BREAKPOINT}.Hits_count_condition_multiple) and then v = 0
						else
							err := True
						end
					end
					if err then
						notify_error_on_text_field (hit_count_condition_value_tf)
						prompts.show_error_prompt ((create {SHARED_BENCH_NAMES}).debugger_names.w_Invalid_hit_count_condition_target, dialog, agent hit_count_condition_value_tf.set_focus)
					else
						l_changes.extend (agent {BREAKPOINT}.set_hits_count_condition (i, v))
					end
				end
			end

			--| When hits actions

			if not err then
				from
					when_hits_actions_entries.start
				until
					when_hits_actions_entries.after or err
				loop
					if
						when_hits_actions_entries.item_for_iteration.is_valid_function = Void or else
						when_hits_actions_entries.item_for_iteration.is_valid_function.item ([bp])
					then
						wh_a := when_hits_actions_entries.item_for_iteration.data
						l_changes.extend (agent (a_bp:BREAKPOINT; awh: BREAKPOINT_WHEN_HITS_ACTION_I; afct: FUNCTION [ANY, TUPLE [BREAKPOINT], BREAKPOINT_WHEN_HITS_ACTION_I])
								require
									bp_not_void: a_bp /= Void
									apply_function_not_void: afct /= Void
								local
									la: BREAKPOINT_WHEN_HITS_ACTION_I
								do
									la := afct.item ([a_bp])
									if la = Void then
										if awh /= Void then
											a_bp.remove_when_hits_action (awh)
										end
									else
										if awh = Void then
											a_bp.add_when_hits_action (la)
										else
											check awh = la end
										end
									end
								end(?, wh_a, when_hits_actions_entries.item_for_iteration.apply_function)
							)
					else
						err := True
					end
					when_hits_actions_entries.forth
				end
			end

			if not err then
				l_changes.extend (agent {BREAKPOINT}.set_continue_execution (when_hits_continue_execution_cb.is_selected))
			end

			if err then
				veto_close
			else --| If no error, apply changes
				check bp /= Void end
				l_changes.call ([bp])
				if l_tags_changed then
					debugger_manager.breakpoints_manager.update_breakpoints_tags_provider
				end
				bpm.notify_breakpoints_changes
			end
		end

	on_reset is
		do
			veto_close
			when_hits_actions_entries.wipe_out
			when_hits_action_container.wipe_out
			fill_data
		end

	on_cancel is
		do
		end

feature -- Access

	Breakpoint_pixmaps_factory: BREAKPOINT_PIXMAPS_FACTORY is
		once
			create Result
		end

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.breakpoints_enable_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := interface_names.m_breakpoints_tool
		end

	buttons: DS_SET [INTEGER] is
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.reset_ok_cancel_buttons
		end

	default_button: INTEGER is
			-- The dialog's default action button
		once
			Result := dialog_buttons.ok_button
		end

	default_cancel_button: INTEGER is
			-- The dialog's default cancel button
		once
			Result := dialog_buttons.cancel_button
		end

	default_confirm_button: INTEGER is
			-- The dialog's default confirm button
		once
			Result := dialog_buttons.ok_button
		end

	is_size_and_position_remembered: BOOLEAN = False
			-- Indicates if the size and position information is remembered for the dialog	

;indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
