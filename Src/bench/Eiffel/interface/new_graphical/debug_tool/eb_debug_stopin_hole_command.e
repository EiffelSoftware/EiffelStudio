indexing
	description	: "Command to stop in a feature while debugging."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEBUG_STOPIN_HOLE_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item
		end

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	EB_SHARED_MANAGERS

	EB_CONSTANTS

feature -- Access

	description: STRING is
			-- What is printed in the customize dialog.
		do
			Result := Interface_names.f_Enable_stop_points
		end

	tooltip: STRING is
			-- Pop-up help on buttons.
		do
			Result := description
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for `Current'.
		do
			Result := {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} Precursor (display_text, use_gray_icons)
			Result.drop_actions.extend (~drop_breakable (?))
			Result.drop_actions.extend (~drop_feature (?))
			Result.drop_actions.extend (~drop_class (?))
			Result.drop_actions.extend (~quick_refresh_on_class_drop)
			Result.drop_actions.extend (~quick_refresh_on_brk_drop)
			Result.select_actions.extend (window_manager~quick_refresh_all)
		end

	menu_name: STRING is
			-- Menu entry corresponding to `Current'.
		do
			Result := Interface_names.m_Enable_stop_points
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Icon for `Current'.
		do
			Result := Pixmaps.Icon_enable_bkpt
		end

	name: STRING is "Enable_bkpt"
			-- Name of `Current' to identify it.

feature -- Update

	drop_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone
		local
			index: INTEGER
			f: E_FEATURE
			body_index: INTEGER
			wd: EV_INFORMATION_DIALOG
		do
			f := bs.routine
			if f.is_debuggable then
				index := bs.index
				body_index := bs.body_index
				Application.enable_breakpoint (f, index)

				if Application.error_in_bkpts then
					create wd.make_with_text (Warning_messages.w_Feature_is_not_compiled)
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				end

				output_manager.display_stop_points
				Window_manager.quick_refresh_all
			end
		end

	drop_call_stack (dropped: CALL_STACK_STONE) is
			-- Accept all stone types
		do
--			Project_window.process_call_stack (dropped)
		end
--| FIXME

	drop_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE
			wd: EV_WARNING_DIALOG
		do
			f := fs.e_feature
			if f.is_debuggable then
				Application.enable_first_breakpoint_of_feature (f)

				if Application.error_in_bkpts then
					create wd.make_with_text (Warning_messages.w_Feature_is_not_compiled)
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				end

				output_manager.display_stop_points
				Window_manager.quick_refresh_all
			end
		end

	drop_class (cs: CLASSC_STONE) is
			-- Process class stone
		local
			wd: EV_INFORMATION_DIALOG
			conv_fst: FEATURE_STONE
		do
			conv_fst ?= cs
				-- If a feature stone was dropped, it is handled by the drop_feature feature.
			if conv_fst = Void then
				Application.enable_first_breakpoints_in_class (cs.e_class)
	
				if Application.error_in_bkpts then
					create wd.make_with_text (Warning_messages.w_Feature_is_not_compiled)
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
	
				output_manager.display_stop_points
				Window_manager.quick_refresh_all
			end
		end

feature -- Execution

	execute is
			-- Enable all breakpoints in the application.
		do
			Application.enable_all_breakpoints
			output_manager.display_stop_points
		end

feature {NONE} -- Implementation

	update_debuggable_for (f: E_FEATURE) is
			-- Update the debuggable information for feature `f'.
			-- Set all breakpoints in `f'.
		require
			f_is_valid: f /= Void
			is_debuggable: f.is_debuggable
--		local
--			body_index: INTEGER
		do
			Application.enable_breakpoints_in_feature (f)
--| FIXME ARNAUD
--			body_index := f.body_index
--			tool_supervisor.feature_tool_mgr.show_stoppoint (body_index, 1)
--			debug_tool.show_stoppoint (body_index, 1)
--| END FIXME
		end

	quick_refresh_on_class_drop (unused: CLASSI_STONE) is
			-- Quick refresh all windows.
		do
			window_manager.quick_refresh_all
		end

	quick_refresh_on_brk_drop (unused: BREAKABLE_STONE) is
			-- Quick refresh all windows.
		do
			window_manager.quick_refresh_all
		end

	is_fst_debuggable (fst: FEATURE_STONE): BOOLEAN is
			-- Does `fst' represent a feature that is debuggable?
		do
			Result := fst.e_feature.is_debuggable
		end

feature -- Obsolete

	display_stop_points is
		obsolete "use `output_manager.display_stop_points' instead"
		do
			output_manager.display_stop_points
		end

end -- class EB_DEBUG_STOPIN_HOLE_COMMAND
