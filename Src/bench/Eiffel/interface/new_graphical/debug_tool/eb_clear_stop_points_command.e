indexing
	description	: "Command to clear debugging information."
	date		: "$Date$"
	revision	: "$Revision$"

class EB_CLEAR_STOP_POINTS_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			tooltext
		end
		
	EB_SHARED_DEBUG_TOOLS

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	EB_SHARED_MANAGERS

	EB_CONSTANTS
	
	EB_SHARED_PREFERENCES

feature -- Access

	description: STRING is
			-- What is printed in the customize dialog.
		do
			Result := Interface_names.f_Clear_breakpoints
		end

	tooltip: STRING is
			-- Pop-up help on buttons.
		do
			Result := description
		end

	tooltext: STRING is
			-- Text for toolbar button
		do
			Result := Interface_names.b_bkpt_remove
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text, use_gray_icons)
			Result.drop_actions.extend (agent drop_breakable (?))
			Result.drop_actions.extend (agent drop_feature (?))
			Result.drop_actions.extend (agent drop_class (?))
			Result.drop_actions.set_veto_pebble_function (agent can_drop)
--			Result.drop_actions.extend (~quick_refresh_on_class_drop)
--			Result.drop_actions.extend (~quick_refresh_on_brk_drop)
--			Result.select_actions.extend (window_manager~quick_refresh_all_margins)
		end

	menu_name: STRING is
			-- Menu entry corresponding tp `Current'.
		do
			Result := Interface_names.m_Clear_breakpoints
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Icon for `Current'.
		do
			Result := Pixmaps.Icon_forget_bkpt
		end

	name: STRING is "Clear_bkpt"
			-- Name of `Current' to identify it.

feature -- Events

	drop_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone
		local
			index: INTEGER
			f: E_FEATURE
			body_index: INTEGER
			id: EV_INFORMATION_DIALOG
		do
			f := bs.routine
			if f.is_debuggable then
				body_index := bs.body_index
				index := bs.index

				Application.remove_breakpoint (f, index)
				if Application.error_in_bkpts then
					create id.make_with_text (Warning_messages.w_Feature_is_not_compiled)
					id.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
					-- Update output tools
				debugger_manager.notify_breakpoints_changes
			end
		end

	drop_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE
			id: EV_INFORMATION_DIALOG
		do
			f := fs.e_feature
			if f /= Void and then f.is_debuggable and then Application.has_breakpoint_set (f) then
				Application.remove_breakpoints_in_feature (f)

				if Application.error_in_bkpts then
					create id.make_with_text (Warning_messages.w_Feature_is_not_compiled)
					id.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
					-- Update output tools
				debugger_manager.notify_breakpoints_changes
			end
		end

	drop_class (cs: CLASSC_STONE) is
			-- Process class stone.
		local
			id: EV_INFORMATION_DIALOG
			conv_fst: FEATURE_STONE
		do
			conv_fst ?= cs
			if conv_fst = Void then
				Application.remove_breakpoints_in_class (cs.e_class)
	
				if Application.error_in_bkpts then
					create id.make_with_text (Warning_messages.w_Feature_is_not_compiled)
					id.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
					-- Update output tools
				debugger_manager.notify_breakpoints_changes
			end
		end

feature -- Execution

	execute is
			-- Execute with confirmation dialog.
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if Application.has_breakpoints then
				create cd.make_initialized (
					2, preferences.dialog_data.confirm_clear_breakpoints_string,
					Warning_messages.w_Clear_breakpoints, Interface_names.l_Dont_ask_me_again,
					preferences.preferences
				)
				cd.set_ok_action (agent clear_breakpoints)
				cd.show_modal_to_window (window_manager.last_focused_development_window.window)
				
					-- Update output tools
				debugger_manager.notify_breakpoints_changes
			end
		end

feature {NONE} -- Implementation

	quick_refresh_on_class_drop (unused: CLASSC_STONE) is
			-- Quick refresh all windows.
		do
			Window_manager.synchronize_all_about_breakpoints
		end

	quick_refresh_on_brk_drop (unused: BREAKABLE_STONE) is
			-- Quick refresh all windows.
		do
			Window_manager.synchronize_all_about_breakpoints
		end

	can_drop (st: ANY): BOOLEAN is
			-- Can `st' be dropped onto `Current's toolbar buttons?
		local
			fst: FEATURE_STONE
			cst: CLASSC_STONE
		do
			fst ?= st
			if fst /= Void then
				Result := fst.e_feature.is_debuggable
			else
				cst ?= st
				if cst /= Void then
					Result := cst.e_class.is_debuggable
				end
			end
		end

	clear_breakpoints is
			-- Execute with confirmation dialog.
		local
			id: EV_INFORMATION_DIALOG
		do
			Application.clear_debugging_information
			if Application.error_in_bkpts then
				create id.make_with_text (Warning_messages.w_Feature_is_not_compiled)
				id.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
				-- Update output tools
			debugger_manager.notify_breakpoints_changes
		end

end -- class EB_CLEAR_STOP_POINTS_COMMAND
