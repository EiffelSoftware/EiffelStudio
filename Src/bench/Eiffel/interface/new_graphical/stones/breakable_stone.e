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

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	EB_CONSTANTS
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
	make

feature {NONE} -- Initialization

	make (e_feature: E_FEATURE; break_index: INTEGER) is
		require
			not_feature_i_void: e_feature /= Void
		do
			routine := e_feature
			index := break_index
		end -- make

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

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Setstop
		end

	x_stone_cursor: EV_CURSOR is
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

	header: STRING is
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
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			create menu
				-- "Enable"
			create item.make_with_text (Interface_names.m_Enable_this_bkpt)
			item.select_actions.extend (agent Application.enable_breakpoint (routine, index))
			item.select_actions.extend (agent debugger_manager.notify_breakpoints_changes)
			if Application.is_breakpoint_enabled (routine, index) then
				item.disable_sensitive
			end
			menu.extend (item)
				-- "Disable"
			create item.make_with_text (Interface_names.m_Disable_this_bkpt)
			item.select_actions.extend (agent Application.disable_breakpoint (routine, index))
			item.select_actions.extend (agent debugger_manager.notify_breakpoints_changes)
			if Application.is_breakpoint_disabled (routine, index) then
				item.disable_sensitive
			end
			menu.extend (item)
				-- "Remove"
			create item.make_with_text (Interface_names.m_Remove_this_bkpt)
			item.select_actions.extend (agent Application.remove_breakpoint (routine, index))
			item.select_actions.extend (agent debugger_manager.notify_breakpoints_changes)
			if not Application.is_breakpoint_set (routine, index) then
				item.disable_sensitive
			end
			menu.extend (item)
			menu.extend (create {EV_MENU_SEPARATOR})
			if not Application.is_breakpoint_set (routine, index) then
					-- "Set conditional breakpoint"
				create item.make_with_text (Interface_names.m_Set_conditional_breakpoint)
				item.select_actions.extend (agent set_conditional_breakpoint (routine, index))
				menu.extend (item)
			else
				if Application.condition (routine, index) = Void then
						-- "Edit condition" (no remove)
					create item.make_with_text (Interface_names.m_Edit_condition)
					item.select_actions.extend (agent set_conditional_breakpoint (routine, index))
					menu.extend (item)
				else
						-- "Edit condition" (with remove)
					create item.make_with_text (Interface_names.m_Edit_condition)
					item.select_actions.extend (agent edit_condition (routine, index))
					menu.extend (item)

						-- "Remove condition"
					create item.make_with_text (Interface_names.m_Remove_condition)
					item.select_actions.extend (agent remove_condition_from_breakpoint (routine, index))
					menu.extend (item)
				end
			end
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

	set_conditional_breakpoint (f: E_FEATURE; pos: INTEGER) is
			-- Prompt the user for a condition and create a new breakpoint with that condition at coordinates (`f',`pos').
		local
			d: EV_DIALOG
			okb, cancelb: EV_BUTTON
			tf: EB_CODE_COMPLETABLE_TEXT_FIELD
			l_provider: EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER
			lab: EV_LABEL
			fr: EV_FRAME
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
				-- Create all widgets.
			create d
			d.set_title (Interface_names.t_Enter_condition)
			d.set_icon_pixmap (pixmaps.icon_dialog_window)
			create fr.make_with_text (Interface_names.l_Condition)
			create vb
			vb.set_padding (Layout_constants.Default_padding_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			create okb.make_with_text (Interface_names.B_ok)
			create cancelb.make_with_text (Interface_names.B_cancel)
			Layout_constants.set_default_size_for_button (okb)
			Layout_constants.set_default_size_for_button (cancelb)
			create tf.make
			create lab

				-- Code completion
			create l_provider.make (f.associated_class, f.ast, true)
			tf.set_completion_possibilities_provider (l_provider)
			l_provider.set_code_completable (tf)

				-- Layout all widgets
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			fr.extend (tf)
			vb.extend (fr)
			vb.extend (lab)
			vb.extend (hb)
			d.extend (vb)
			d.set_maximum_height (d.minimum_height)

				-- Set up actions
			okb.select_actions.extend (agent create_conditional_breakpoint (f, pos, d, tf, lab))
			cancelb.select_actions.extend (agent d.destroy)
			d.set_default_push_button (okb)
			d.set_default_cancel_button (cancelb)
			d.show_actions.extend (agent tf.set_focus)
			d.show_modal_to_window (Window_manager.last_focused_window.window)
		end

	edit_condition (f: E_FEATURE; pos: INTEGER) is
			-- Prompt the user for a condition and update the breakpoint at coordinates (`f',`pos') with that condition.
		local
			d: EV_DIALOG
			okb, removeb, cancelb: EV_BUTTON
			tf: EV_TEXT_FIELD
			lab: EV_LABEL
			fr: EV_FRAME
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			expr: EB_EXPRESSION
		do
				-- Create all widgets.
			create d
			d.set_title (Interface_names.t_Enter_condition)
			d.set_icon_pixmap (pixmaps.icon_dialog_window)
			create fr.make_with_text (Interface_names.l_Condition)
			create vb
			vb.set_padding (Layout_constants.Default_padding_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			create okb.make_with_text (Interface_names.B_ok)
			create removeb.make_with_text (Interface_names.B_remove)
			create cancelb.make_with_text (Interface_names.B_cancel)
			Layout_constants.set_default_size_for_button (okb)
			Layout_constants.set_default_size_for_button (removeb)
			Layout_constants.set_default_size_for_button (cancelb)
			create tf
			create lab

				-- Update widgets.
			expr := Application.condition (f, pos)
			if expr /= Void then
				tf.set_text (expr.expression)
			end

				-- Layout all widgets
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (removeb)
			hb.disable_item_expand (removeb)
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			fr.extend (tf)
			vb.extend (fr)
			vb.extend (lab)
			vb.extend (hb)
			d.extend (vb)
			d.set_maximum_height (d.minimum_height)

				-- Set up actions
			okb.select_actions.extend (agent create_conditional_breakpoint (f, pos, d, tf, lab))
			removeb.select_actions.extend (agent remove_condition_from_breakpoint (f, pos))
			removeb.select_actions.extend (agent d.destroy)
			cancelb.select_actions.extend (agent d.destroy)
			d.set_default_push_button (okb)
			d.set_default_cancel_button (cancelb)
			d.show_actions.extend (agent tf.set_focus)
			d.show_modal_to_window (Window_manager.last_focused_window.window)
		end

	remove_condition_from_breakpoint (f: E_FEATURE; pos: INTEGER) is
		do
			Application.remove_condition (f, pos)
			Debugger_manager.notify_breakpoints_changes
		end

	create_conditional_breakpoint (f: E_FEATURE; pos: INTEGER; d: EV_DIALOG; a_input, a_output: EV_TEXTABLE) is
			-- Attempt to create a conditional breakpoint.
		local
			expr: EB_EXPRESSION
		do
			create expr.make_for_context (a_input.text)
			if not expr.syntax_error_occurred then
				if expr.is_condition (f) then
					if not Application.is_breakpoint_set (f, pos) then
						Application.enable_breakpoint (f, pos)
					end
					Application.set_condition (f, pos, expr)
					Debugger_manager.notify_breakpoints_changes
					d.destroy
				else
					a_output.set_text (Warning_messages.w_not_a_condition (a_input.text))
				end
			else
				a_output.set_text (Warning_messages.w_syntax_error_in_expression (a_input.text))
			end
		end

	toggle_bkpt is
			-- If the corresponding breakpoint was not set or disabled, enable it.
			-- If the corresponding breakpoint was already enabled, remove it.
		do
			if Application.is_breakpoint_enabled (routine, index) then
				Application.remove_breakpoint (routine, index)
			else
				Application.enable_breakpoint (routine, index)
			end
			Debugger_manager.notify_breakpoints_changes
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
