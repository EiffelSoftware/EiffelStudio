indexing
	description:
		"Stone representating a breakable point."
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

creation
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
			item.select_actions.extend (Application~enable_breakpoint (routine, index))
			item.select_actions.extend (Output_manager~display_stop_points)
			item.select_actions.extend (window_manager~quick_refresh_all)
			if Application.is_breakpoint_enabled (routine, index) then
				item.disable_sensitive
			end
			menu.extend (item)
				-- "Disable"
			create item.make_with_text (Interface_names.m_Disable_this_bkpt)
			item.select_actions.extend (Application~disable_breakpoint (routine, index))
			item.select_actions.extend (Output_manager~display_stop_points)
			item.select_actions.extend (window_manager~quick_refresh_all)
			if Application.is_breakpoint_disabled (routine, index) then
				item.disable_sensitive
			end
			menu.extend (item)
				-- "Remove"
			create item.make_with_text (Interface_names.m_Remove_this_bkpt)
			item.select_actions.extend (Application~remove_breakpoint (routine, index))
			item.select_actions.extend (Output_manager~display_stop_points)
			item.select_actions.extend (window_manager~quick_refresh_all)
			if not Application.is_breakpoint_set (routine, index) then
				item.disable_sensitive
			end
			menu.extend (item)
			menu.extend (create {EV_MENU_SEPARATOR})
			if not Application.is_breakpoint_set (routine, index) then
					-- "Set conditional breakpoint"
				create item.make_with_text (Interface_names.m_Set_conditional_breakpoint)
				item.select_actions.extend (~set_conditional_breakpoint (routine, index))
				menu.extend (item)
			else
				if Application.condition (routine, index) = Void then
						-- "Edit condition" (no remove)
					create item.make_with_text (Interface_names.m_Edit_condition)
					item.select_actions.extend (~set_conditional_breakpoint (routine, index))
					menu.extend (item)
				else
						-- "Edit condition" (with remove)
					create item.make_with_text (Interface_names.m_Edit_condition)
					item.select_actions.extend (~edit_condition (routine, index))
					menu.extend (item)
				end
			end
			create item.make_with_text (Interface_names.m_Run_to_this_point)
			conv_dev ?= window_manager.last_focused_window
			if conv_dev /= Void then
					-- `conv_dev = Void' should never happen.
				menu.extend (create {EV_MENU_SEPARATOR})
					-- "Run to breakpoint"
				item.select_actions.extend (debugger_manager~set_debugging_window (conv_dev))
				item.select_actions.extend ((debugger_manager.debug_run_cmd)~process_breakable (Current))
				menu.extend (item)
			end

			menu.show
		end

	set_conditional_breakpoint (f: E_FEATURE; pos: INTEGER) is
			-- Prompt the user for a condition and create a new breakpoint with that condition at coordinates (`f',`pos').
		local
			d: EV_DIALOG
			okb, cancelb: EV_BUTTON
			tf: EV_TEXT_FIELD
			fr: EV_FRAME
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
				-- Create all widgets.
			create d
			d.set_title (Interface_names.t_Enter_condition)
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
			create tf
			
				-- Layout all widgets
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			fr.extend (tf)
			vb.extend (fr)
			vb.extend (hb)
			d.extend (vb)
			d.set_maximum_height (d.minimum_height)
			
				-- Set up actions
			okb.select_actions.extend (~create_conditional_breakpoint (f, pos, d, tf))
			cancelb.select_actions.extend (d~destroy)
			d.set_default_push_button (okb)
			d.set_default_cancel_button (cancelb)
			d.show_actions.extend (tf~set_focus)
			d.show_modal_to_window (Window_manager.last_focused_window.window)
		end

	edit_condition (f: E_FEATURE; pos: INTEGER) is
			-- Prompt the user for a condition and update the breakpoint at coordinates (`f',`pos') with that condition.
		local
			d: EV_DIALOG
			okb, removeb, cancelb: EV_BUTTON
			tf: EV_TEXT_FIELD
			fr: EV_FRAME
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			expr: EB_EXPRESSION
		do
				-- Create all widgets.
			create d
			d.set_title (Interface_names.t_Enter_condition)
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
			vb.extend (hb)
			d.extend (vb)
			d.set_maximum_height (d.minimum_height)
			
				-- Set up actions
			okb.select_actions.extend (~create_conditional_breakpoint (f, pos, d, tf))
			removeb.select_actions.extend (Application~remove_condition (f, pos))
			removeb.select_actions.extend (d~destroy)
			cancelb.select_actions.extend (d~destroy)
			d.set_default_push_button (okb)
			d.set_default_cancel_button (cancelb)
			d.show_actions.extend (tf~set_focus)
			d.show_modal_to_window (Window_manager.last_focused_window.window)
		end

	create_conditional_breakpoint (f: E_FEATURE; pos: INTEGER; d: EV_DIALOG; tf: EV_TEXT_FIELD) is
			-- Attempt to create a conditional breakpoint.
		local
			expr: EB_EXPRESSION
		do
			create expr.make_for_context (tf.text)
			if not expr.syntax_error then
				if expr.is_condition (f) then
					if not Application.is_breakpoint_set (f, pos) then
						Application.enable_breakpoint (f, pos)
					end
					Application.set_condition (f, pos, expr)
					Output_manager.display_stop_points
					window_manager.quick_refresh_all
					d.destroy
				else
					tf.set_text (Warning_messages.w_not_a_condition (tf.text))
				end
			else
				tf.set_text (Warning_messages.w_syntax_error_in_expression (tf.text)) 
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
			Output_manager.display_stop_points
			window_manager.quick_refresh_all
		end

end -- class BREAKABLE_STONE
