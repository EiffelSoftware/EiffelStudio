indexing
	description	: "Command to enable/disable one or all breakpoints."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DISABLE_STOP_POINTS_COMMAND

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
			Result := Interface_names.f_Disable_stop_points
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
			Result.drop_actions.set_veto_pebble_function (~can_drop)
--			Result.drop_actions.extend (~quick_refresh_on_class_drop)
--			Result.drop_actions.extend (~quick_refresh_on_brk_drop)
--			Result.select_actions.extend (window_manager~quick_refresh_all)
		end

	menu_name: STRING is
			-- Menu entry corresponding to `Current'.
		do
			Result := Interface_names.m_Disable_stop_points
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Icon for `Current'.
		do
			Result := Pixmaps.Icon_disable_bkpt
		end

	name: STRING is "Disable_bkpt"
			-- Name of `Current' to identify it.

feature -- Execution

	execute is
			-- Disable all stop points.
		local
			wd: EV_INFORMATION_DIALOG
		do
			if Application.has_breakpoints then
				Application.disable_all_breakpoints

				if Application.error_in_bkpts then
					create wd.make_with_text (Warning_messages.w_Feature_is_not_compiled)
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
					-- Update output tools
				output_manager.display_stop_points
				Window_manager.quick_refresh_all
			end
		end

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
				Application.disable_breakpoint (f, index)

				if Application.error_in_bkpts then
					create wd.make_with_text (Warning_messages.w_Feature_is_not_compiled)
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
					-- Update output tools
				output_manager.display_stop_points
				Window_manager.quick_refresh_all
			end
		end

	drop_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE
			wd: EV_INFORMATION_DIALOG
		do
			f := fs.e_feature
			if f /= Void and then f.is_debuggable and then Application.has_breakpoint_set(f) then
				Application.disable_breakpoints_in_feature (f)

				if Application.error_in_bkpts then
					create wd.make_with_text (Warning_messages.w_Feature_is_not_compiled)
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
					-- Update output tools
				output_manager.display_stop_points
				Window_manager.quick_refresh_all
			end
		end

	quick_refresh_on_class_drop (unused: CLASSC_STONE) is
			-- Quick refresh all windows.
		do
			window_manager.quick_refresh_all
		end

	quick_refresh_on_brk_drop (unused: BREAKABLE_STONE) is
			-- Quick refresh all windows.
		do
			window_manager.quick_refresh_all
		end

	drop_class (cs: CLASSC_STONE) is
			-- Process class stone
		local
			wd: EV_INFORMATION_DIALOG
			conv_fst: FEATURE_STONE
		do
			conv_fst ?= cs
			if conv_fst = Void then
				Application.disable_breakpoints_in_class (cs.e_class)
	
				if Application.error_in_bkpts then
					create wd.make_with_text (Warning_messages.w_Feature_is_not_compiled)
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
					-- Update output tools
				output_manager.display_stop_points
				Window_manager.quick_refresh_all
			end
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

end -- class EB_DISABLE_STOP_POINTS_CMD
