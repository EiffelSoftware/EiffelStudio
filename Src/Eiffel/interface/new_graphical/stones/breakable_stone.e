indexing
	description:
		"Stone representating a breakable point."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	BREAKABLE_STONE

inherit
	STONE
		redefine
			stone_cursor,
			x_stone_cursor,
			is_storable
		end

	EB_SHARED_DEBUGGER_MANAGER

	SHARED_BENCH_NAMES
		export
			{NONE} all
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
		end

create
	make,
	make_from_breakpoint

feature {NONE} -- Initialization

	make (e_feature: E_FEATURE; break_index: INTEGER) is
		require
			not_feature_i_void: e_feature /= Void
			valid_index: break_index > 0
		do
			routine := e_feature
			index := break_index
		end -- make

	make_from_breakpoint (a_bp: BREAKPOINT) is
		require
			bp_not_void: a_bp /= Void
			bp_valid: a_bp.is_valid
		do
			make (a_bp.routine, a_bp.breakable_line_number)
		end

feature -- Properties

	routine: E_FEATURE
			-- Associated routine

	body_index: INTEGER is
			-- Breakpoint index in `routine'
		do
			Result := routine.body_index
		end

	index: INTEGER
			-- Breakpoint index in `routine'

feature -- Access

	stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Setstop
		end

	x_stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_setstop
		end

	history_name: STRING is
		do
			Result := "Breakpoint in " + routine.name
		end

	is_storable: BOOLEAN is
			-- Breakpoint stones are not kept.
		do
			Result := False
		end

	stone_signature: STRING is
		do
			Result := routine.feature_signature
		end

	header: STRING_GENERAL is
		do
			Result := "Stop point in " + routine.name + " at line " + index.out
		end

feature -- Basic operations

	display_bkpt_menu is
			-- Display a context menu associated with `bkpt', so that
			-- the user can enable/disable/remove it, or run to cursor.
		local
			menu: EV_MENU
			item: EV_MENU_ITEM
			cmi: EV_CHECK_MENU_ITEM
			conv_dev: EB_DEVELOPMENT_WINDOW
			bpm: BREAKPOINTS_MANAGER
			bp: BREAKPOINT
		do
			bpm := Debugger_manager
			if bpm.is_breakpoint_set (routine, index) then
				bp := bpm.breakpoint (routine, index)
			end

			create menu
			create item.make_with_text (Interface_names.m_Breakpoint_index)
			item.set_text (item.text + index.out)
			item.disable_sensitive
			menu.extend (item)
			menu.extend (create {EV_MENU_SEPARATOR})

				-- "Enable"
			create item.make_with_text (Interface_names.m_Enable_this_bkpt)
			item.select_actions.extend (agent bpm.enable_breakpoint (routine, index))
			item.select_actions.extend (agent debugger_manager.notify_breakpoints_changes)

			if bp /= Void and then bp.is_enabled then
				item.disable_sensitive
			end
			menu.extend (item)

				-- "Disable"
			create item.make_with_text (Interface_names.m_Disable_this_bkpt)
			item.select_actions.extend (agent bpm.disable_breakpoint (routine, index))
			item.select_actions.extend (agent debugger_manager.notify_breakpoints_changes)
			if bp /= Void and then bp.is_disabled then
				item.disable_sensitive
			end
			menu.extend (item)

			if bp /= Void then
					-- "Remove"
				create item.make_with_text (Interface_names.m_Remove_this_bkpt)
				item.select_actions.extend (agent bpm.remove_breakpoint (routine, index))
				item.select_actions.extend (agent debugger_manager.notify_breakpoints_changes)
				menu.extend (item)
			end

				--| Conditional breakpoint
			menu.extend (create {EV_MENU_SEPARATOR})
			if bp = Void then
				create item.make_with_text (Interface_names.m_Set_conditional_breakpoint)
			else
				create item.make_with_text (Interface_names.m_Edit_condition)
			end
			item.select_actions.extend (agent set_conditional_breakpoint (routine, index))
			menu.extend (item)

			if bp /= Void and then bp.has_condition then
				create item.make_with_text (Interface_names.m_Remove_condition)
				item.select_actions.extend (agent remove_condition_from_breakpoint (routine, index))
				menu.extend (item)
			end

			if bp /= Void then
				menu.extend (create {EV_MENU_SEPARATOR})

					--| Hit count
				create cmi.make_with_text (Interface_names.m_Hit_count)
				cmi.select_actions.extend (agent edit_hit_count_breakpoint (bp))
				if bp.has_hit_count_condition then
					cmi.enable_select
				end
				menu.extend (cmi)

					--| When hits breakpoint
				create cmi.make_with_text (Interface_names.m_When_hits)
				cmi.select_actions.extend (agent edit_when_hits_breakpoint (bp))
				if bp.has_message then
					cmi.enable_select
				end
				menu.extend (cmi)
			end

				--| Run to this point
			conv_dev ?= window_manager.last_focused_window
			if conv_dev /= Void then
					-- `conv_dev = Void' should never happen.
				menu.extend (create {EV_MENU_SEPARATOR})

					-- "Run to breakpoint"
				create item.make_with_text (Interface_names.m_Run_to_this_point)
				item.select_actions.extend (agent Eb_debugger_manager.set_debugging_window (conv_dev))
				item.select_actions.extend (agent (Eb_debugger_manager.debug_run_cmd).process_breakable (Current))
				menu.extend (item)
			end

			menu.show
		end

feature -- operation on conditions

	set_conditional_breakpoint (f: E_FEATURE; pos: INTEGER) is
			-- Prompt the user for a condition and create a new breakpoint with that condition at coordinates (`f',`pos').
		local
			d: EV_DIALOG
			okb, removeb, cancelb: EV_BUTTON
			tf: EB_CODE_COMPLETABLE_TEXT_FIELD
			l_provider: EB_DEBUGGER_EXPRESSION_COMPLETION_POSSIBILITIES_PROVIDER
			lab: EV_LABEL
			fr: EV_FRAME
			vb, vb2: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			rb_is_true, rb_has_changed: EV_RADIO_BUTTON
			cb_cont_on_cond_failure: EV_CHECK_BUTTON
			bp: BREAKPOINT
		do
				-- Create all widgets.
			create d
			d.set_title (Interface_names.t_Enter_condition)
			d.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			create fr.make_with_text (Interface_names.l_Condition)
			create vb
			vb.set_padding (Layout_constants.Default_padding_size)
			vb.set_border_width (Layout_constants.Small_border_size)

			create okb.make_with_text (Interface_names.b_Ok)
			create cancelb.make_with_text (Interface_names.b_Cancel)
			create removeb.make_with_text (Interface_names.b_Remove)

			Layout_constants.set_default_width_for_button (okb)
			Layout_constants.set_default_width_for_button (cancelb)
			Layout_constants.set_default_width_for_button (removeb)
			create tf.make
			tf.set_parent_window (d)
			create rb_is_true.make_with_text (Interface_names.l_Is_true)
			create rb_has_changed.make_with_text (Interface_names.l_Has_changed)
			create cb_cont_on_cond_failure.make_with_text (Interface_names.b_Continue_on_condition_failure)

			create lab

				-- Code completion
			create l_provider.make (f.associated_class, f.ast)
			tf.set_completion_possibilities_provider (l_provider)
			l_provider.set_code_completable (tf)

			if Debugger_manager.is_breakpoint_set (f, pos) then
				bp := Debugger_manager.breakpoint (f, pos)
			end

				-- Layout all widgets

			create vb2
--			vb2.set_padding (Layout_constants.Small_padding_size)
			vb2.set_border_width (Layout_constants.Small_border_size)
			fr.extend (vb2)
			vb2.extend (tf)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (rb_is_true)
			hb.disable_item_expand (rb_is_true)
			hb.extend (rb_has_changed)
			hb.disable_item_expand (rb_has_changed)
			vb2.extend (hb)
			vb2.disable_item_expand (hb)

			vb2.extend (create {EV_HORIZONTAL_SEPARATOR})
			vb2.disable_item_expand (vb2.last)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (cb_cont_on_cond_failure)
			hb.disable_item_expand (cb_cont_on_cond_failure)
			vb2.extend (hb)
			vb2.disable_item_expand (hb)

			vb.extend (fr)
			vb.disable_item_expand (fr)
			vb.extend (lab)

				--| Buttons
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			if bp /= Void then
				hb.extend (removeb)
				hb.disable_item_expand (removeb)
			end
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			vb.extend (hb)

				--| Dialog
			d.extend (vb)
			d.set_maximum_height (d.minimum_height)

			if bp /= Void and then bp.has_condition then
					-- Update widgets.
				tf.set_text (bp.condition.expression)
				if bp.condition_as_has_changed then
					rb_has_changed.enable_select
				else
					rb_is_true.enable_select
				end
				if bp.continue_on_condition_failure then
					cb_cont_on_cond_failure.enable_select
				else
					cb_cont_on_cond_failure.disable_select
				end
			end

				-- Set up actions
			okb.select_actions.extend (agent create_conditional_breakpoint (f, pos, d, rb_is_true, rb_has_changed, cb_cont_on_cond_failure, tf, lab))
			if bp /= Void then
				removeb.select_actions.extend (agent remove_condition_from_breakpoint (f, pos))
				removeb.select_actions.extend (agent d.destroy)
			end
			cancelb.select_actions.extend (agent d.destroy)
			d.set_default_push_button (okb)
			d.set_default_cancel_button (cancelb)
			d.show_actions.extend (agent tf.set_focus)
			d.show_modal_to_window (Window_manager.last_focused_window.window)
		end

	remove_condition_from_breakpoint (f: E_FEATURE; pos: INTEGER) is
		do
			Debugger_manager.remove_condition (f, pos)
			Debugger_manager.notify_breakpoints_changes
		end

	create_conditional_breakpoint (f: E_FEATURE; pos: INTEGER; d: EV_DIALOG;
				a_rb_is_true, a_rb_has_changed: EV_SELECTABLE;
				a_cb_cont_on_cond_failure: EV_SELECTABLE;
			a_input: EV_TEXTABLE; a_output: EV_LABEL) is
			-- Attempt to create a conditional breakpoint.
		local
			expr: DBG_EXPRESSION
			bpm: BREAKPOINTS_MANAGER
			bp: BREAKPOINT
		do
			create expr.make_for_context (a_input.text)
			if not expr.syntax_error_occurred then
				bpm := Debugger_manager
				if a_rb_is_true.is_selected then
					if expr.is_boolean_expression (f) then
						if not bpm.is_breakpoint_set (f, pos) then
							bpm.enable_breakpoint (f, pos)
						end
						bp := bpm.breakpoint (f, pos)
						check bp /= Void end
						bp.set_condition_as_is_true
						bp.set_condition (expr)
						Debugger_manager.notify_breakpoints_changes
						d.destroy
					else
						a_output.set_text (Warning_messages.w_not_a_condition (a_input.text))
					end
				elseif a_rb_has_changed.is_selected then
					if not bpm.is_breakpoint_set (f, pos) then
						bpm.enable_breakpoint (f, pos)
					end
					bp := bpm.breakpoint (f, pos)
					check bp /= Void end
					bp.set_condition_as_has_changed
					bp.set_condition (expr)
					Debugger_manager.notify_breakpoints_changes
					d.destroy
				else
					check should_not_occur: False end
				end
				if bp /= Void then
					bp.set_continue_on_condition_failure (a_cb_cont_on_cond_failure.is_selected)
				end
			else
				a_output.set_text (Warning_messages.w_syntax_error_in_expression (a_input.text))
			end
		end

feature -- operation on message

	edit_when_hits_breakpoint (bp: BREAKPOINT) is
		local
			d: EV_DIALOG
			okb, cancelb: EV_BUTTON
			tf: EV_TEXT_FIELD
			fr: EV_FRAME
			lab: EV_LABEL
			mesg_cb: EV_CHECK_BUTTON
			cont_cb: EV_CHECK_BUTTON
			vb, vb2: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
				-- Create all widgets.
			create d
			d.set_title (Interface_names.m_When_hits)
			d.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			create vb
			vb.set_padding (Layout_constants.Default_padding_size)
			vb.set_border_width (Layout_constants.Small_border_size)

			create mesg_cb.make_with_text (Interface_names.l_Print_message)
			create tf
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (mesg_cb)
			vb.extend (hb)
			vb.disable_item_expand (hb)

			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			create fr
			hb.extend (fr)
			create vb2
			vb2.set_padding (Layout_constants.Small_padding_size)
			fr.extend (vb2)
			vb2.extend (tf)
			tf.set_minimum_width_in_characters (20)
			vb2.disable_item_expand (tf)

			create lab.make_with_text (Interface_names.l_Print_message_help)
			lab.align_text_left
			vb2.extend (lab)
			vb2.disable_item_expand (lab)
			vb.extend (hb)
			vb.disable_item_expand (hb)

			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			create cont_cb.make_with_text (Interface_names.l_Continue_execution)
			if bp.continue_execution then
				cont_cb.enable_select
			end
			hb.extend (cont_cb)
			hb.disable_item_expand (cont_cb)
			vb.extend (hb)
			vb.disable_item_expand (hb)

			create okb.make_with_text (Interface_names.B_ok)
			create cancelb.make_with_text (Interface_names.B_cancel)
			Layout_constants.set_default_width_for_button (okb)
			Layout_constants.set_default_width_for_button (cancelb)

				-- Data and behavior
			if bp.has_message then
				mesg_cb.enable_select
				tf.set_text (bp.message)
				fr.enable_sensitive
			else
				fr.disable_sensitive
			end
			mesg_cb.select_actions.extend (agent (a_mesg_cb, a_cont_cb: EV_CHECK_BUTTON; a_frame: EV_FRAME;)
					do
						if a_mesg_cb.is_selected then
							a_frame.enable_sensitive
							a_cont_cb.enable_select
						else
							a_frame.disable_sensitive
							a_cont_cb.disable_select
						end
					end (mesg_cb, cont_cb, fr)
				)

				-- Layout all widgets
			create hb
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			vb.extend (hb)
			d.extend (vb)
			d.set_maximum_height (d.minimum_height)

				-- Set up actions
			okb.select_actions.extend (agent (a_bp: BREAKPOINT; a_mesg_cb, a_cont_cb: EV_CHECK_BUTTON; a_tf: EV_TEXT_FIELD)
					do
						if a_mesg_cb.is_selected then
							a_bp.set_message (a_tf.text)
						else
							a_bp.set_message (Void)
						end
						a_bp.set_continue_execution (a_cont_cb.is_selected)
					end(bp, mesg_cb, cont_cb, tf)
				)
			okb.select_actions.extend (agent d.destroy)
			cancelb.select_actions.extend (agent d.destroy)
			d.set_default_push_button (okb)
			d.set_default_cancel_button (cancelb)
			d.show_actions.extend (agent mesg_cb.set_focus)
			d.show_modal_to_window (Window_manager.last_focused_window.window)
		end

	edit_hit_count_breakpoint (bp: BREAKPOINT) is
		local
			d: EV_DIALOG
			okb, cancelb, resetb: EV_BUTTON
			combo: EV_COMBO_BOX
			tf: EV_TEXT_FIELD
			lab: EV_LABEL
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			li: EV_LIST_ITEM
			hcc: TUPLE [mode: INTEGER; value:INTEGER]
		do
				-- Create all widgets.
			create d
			d.set_title (Interface_names.m_Hit_count)
			d.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			create vb
			vb.set_padding (Layout_constants.Default_padding_size)
			vb.set_border_width (Layout_constants.Small_border_size)

			create lab.make_with_text (Interface_names.l_When_breakpoint_is_hit)
			vb.extend (lab)
			vb.disable_item_expand (lab)

			create combo
			create tf
			combo.disable_edit
			combo.set_minimum_width_in_characters (20)
			tf.set_minimum_width_in_characters (5)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (combo)
			hb.extend (tf)
			hb.disable_item_expand (tf)
			vb.extend (hb)
			vb.disable_item_expand (hb)

			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			create lab.make_with_text (Interface_names.l_Current_hit_count)
			hb.extend (lab)
			hb.disable_item_expand (lab)
			create lab.make_with_text (bp.hits_count.out)
			lab.align_text_left
			hb.extend (lab)
			vb.extend (hb)
			vb.disable_item_expand (hb)

			create resetb.make_with_text (Interface_names.b_Reset)
			create okb.make_with_text (Interface_names.B_ok)
			create cancelb.make_with_text (Interface_names.B_cancel)
			Layout_constants.set_default_width_for_button (resetb)
			Layout_constants.set_default_width_for_button (okb)
			Layout_constants.set_default_width_for_button (cancelb)

				-- Layout all widgets
			create hb
			hb.extend (resetb)
			hb.disable_item_expand (resetb)
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			vb.extend (hb)
			d.extend (vb)
			d.set_maximum_height (d.minimum_height)

				--| Fill data
			hcc := bp.hits_count_condition
			if hcc = Void then
				hcc := [{BREAKPOINT}.Hits_count_condition_always, 0]
			end
			tf.set_text (hcc.value.out)

			create li.make_with_text (Interface_names.m_Break_always)
			combo.extend (li)
			li.select_actions.extend (agent tf.hide)
			li.set_data ({BREAKPOINT}.Hits_count_condition_always)
			if hcc.mode = {BREAKPOINT}.Hits_count_condition_always then
				li.enable_select
				tf.hide
			end

			create li.make_with_text (Interface_names.m_Break_when_hit_count_equal)
			combo.extend (li)
			li.select_actions.extend (agent tf.show)
			li.set_data ({BREAKPOINT}.Hits_count_condition_equal)
			if hcc.mode = {BREAKPOINT}.Hits_count_condition_equal then
				li.enable_select
			end

			create li.make_with_text (Interface_names.m_Break_when_hit_count_multiple_of)
			combo.extend (li)
			li.select_actions.extend (agent tf.show)
			li.set_data ({BREAKPOINT}.Hits_count_condition_multiple)
			if hcc.mode = {BREAKPOINT}.Hits_count_condition_multiple then
				li.enable_select
			end

			create li.make_with_text (Interface_names.m_Break_when_hit_count_greater)
			combo.extend (li)
			li.select_actions.extend (agent tf.show)
			li.set_data ({BREAKPOINT}.Hits_count_condition_greater)
			if hcc.mode = {BREAKPOINT}.Hits_count_condition_greater then
				li.enable_select
			end

			create li.make_with_text (Interface_names.m_Break_when_hit_count_continue_execution)
			combo.extend (li)
			li.select_actions.extend (agent tf.hide)
			li.set_data ({BREAKPOINT}.Hits_count_condition_continue_execution)
			if hcc.mode = {BREAKPOINT}.Hits_count_condition_continue_execution then
				li.enable_select
			end

				-- Set up actions
			okb.select_actions.extend (agent (a_dlg:EV_DIALOG; a_bp: BREAKPOINT; a_combo: EV_COMBO_BOX; a_tf: EV_TEXT_FIELD)
					local
						s: STRING_32
						mr: INTEGER_REF
						m,v: INTEGER
						l_invalid: BOOLEAN
					do
						mr ?= a_combo.selected_item.data
						if mr /= Void then
							m := mr.item
						end
						s := a_tf.text

						if s.is_integer then
							v := s.to_integer
							if m = {BREAKPOINT}.Hits_count_condition_multiple and v = 0 then
								l_invalid := True
							else
								a_bp.set_hits_count_condition (m, v)
								a_dlg.destroy
							end
						else
							l_invalid := True
						end
						if l_invalid then
							(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (debugger_names.w_Invalid_hit_count_condition_target, a_dlg, Void)
							a_tf.set_focus
						end
					end(d, bp, combo, tf)
				)

			cancelb.select_actions.extend (agent d.destroy)
			resetb.select_actions.extend (agent (a_bp: BREAKPOINT; a_lab: EV_LABEL)
					do
						a_bp.reset_hits_count
						a_lab.set_text (a_bp.hits_count.out)
						a_lab.refresh_now
						debugger_manager.notify_breakpoints_changes
					end(bp, lab)
				)
			d.set_default_push_button (okb)
			d.set_default_cancel_button (cancelb)
			d.show_actions.extend (agent combo.set_focus)
			d.show_modal_to_window (Window_manager.last_focused_window.window)
		end

feature -- state of breakpoint		

	toggle_bkpt is
			-- If the corresponding breakpoint was not set or disabled, enable it.
			-- If the corresponding breakpoint was already enabled, remove it.
		local
			bpm: BREAKPOINTS_MANAGER
		do
			bpm := Debugger_manager
			if bpm.is_breakpoint_enabled (routine, index) then
				bpm.remove_breakpoint (routine, index)
			else
				bpm.enable_breakpoint (routine, index)
			end
			Debugger_manager.notify_breakpoints_changes
		end

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

end -- class BREAKABLE_STONE
