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
			bp_valid: a_bp.location.is_valid
		do
			make (a_bp.location.routine, a_bp.location.breakable_line_number)
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

	to_tag_path: STRING_32
			-- Tag path representation of Current.
			-- Group_name.class_name.feature_name.index
		local
			bpm: BREAKPOINTS_MANAGER
			bp: BREAKPOINT
		do
			bpm := breakpoints_manager
			if bpm.is_breakpoint_set (routine, index, False) then
				bp := bpm.user_breakpoint (routine, index)
				Result := bp.to_tag_path
			end
		end

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
			-- History name.
		do
			Result := "Breakpoint in " + routine.name
		end

	is_storable: BOOLEAN is
			-- Breakpoint stones are not kept.
		do
			Result := False
		end

	stone_signature: STRING is
			-- Stone signature
		do
			Result := routine.feature_signature
		end

	header: STRING_GENERAL is
			-- Header's string.
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
			bpm := breakpoints_manager
			if {loc: !BREAKPOINT_LOCATION} bpm.breakpoint_location (routine, index, False) then
				if bpm.is_user_breakpoint_set_at (loc) then
					bp := bpm.user_breakpoint_at (loc)
				end
			end

			create menu
			create item.make_with_text (Interface_names.m_Breakpoint_index)
			item.set_text (item.text + index.out)
			item.select_actions.extend (agent (abp: BREAKPOINT)
					do
						if abp /= Void then
							(create {EV_SHARED_APPLICATION}).ev_application.clipboard.set_text (abp.to_tag_path)
						end
					end(bp)
				)
			menu.extend (item)
			menu.extend (create {EV_MENU_SEPARATOR})

				-- "Enable"
			create item.make_with_text (Interface_names.m_Enable_this_bkpt)
			item.select_actions.extend (agent bpm.enable_user_breakpoint (routine, index))
			item.select_actions.extend (agent bpm.notify_breakpoints_changes)

			if bp /= Void and then bp.is_enabled then
				item.disable_sensitive
			end
			menu.extend (item)

				-- "Disable"
			create item.make_with_text (Interface_names.m_Disable_this_bkpt)
			item.select_actions.extend (agent bpm.disable_user_breakpoint (routine, index))
			item.select_actions.extend (agent bpm.notify_breakpoints_changes)
			if bp /= Void and then bp.is_disabled then
				item.disable_sensitive
			end
			menu.extend (item)

			if bp /= Void then
					-- "Remove"
				create item.make_with_text (Interface_names.m_Remove_this_bkpt)
				item.select_actions.extend (agent bpm.remove_user_breakpoint (routine, index))
				item.select_actions.extend (agent bpm.notify_breakpoints_changes)
				menu.extend (item)
			end

				--| Conditional breakpoint
			menu.extend (create {EV_MENU_SEPARATOR})
			if bp /= Void then
					-- "Edit"
				create item.make_with_text (Interface_names.m_Edit_this_bkpt)
				item.select_actions.extend (agent open_breakpoint_dialog)
				menu.extend (item)
			end

			if bp = Void then
				create item.make_with_text (Interface_names.m_Set_conditional_breakpoint)
			else
				create item.make_with_text (Interface_names.m_Edit_condition)
			end
			item.select_actions.extend (agent edit_conditional_breakpoint)
			menu.extend (item)

			if bp /= Void and then bp.has_condition then
				create item.make_with_text (Interface_names.m_Remove_condition)
				item.select_actions.extend (agent bp.remove_condition)
				item.select_actions.extend (agent bpm.notify_breakpoints_changes)
				menu.extend (item)
			end

			if bp /= Void then
				menu.extend (create {EV_MENU_SEPARATOR})

					--| Hit count
				create cmi.make_with_text (Interface_names.m_Hit_count)
				cmi.select_actions.extend (agent edit_hit_count_breakpoint)
				if bp.has_hit_count_condition then
					cmi.enable_select
				end
				menu.extend (cmi)

					--| When hits breakpoint
				create cmi.make_with_text (Interface_names.m_When_hits)
				cmi.select_actions.extend (agent edit_when_hits_breakpoint)
				if bp.has_when_hits_action then
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

feature -- operation on breakpoint

	last_dialogs: LINKED_LIST [ES_BREAKPOINT_DIALOG] is
			-- Opened dialogs
			-- to avoid the dialog to be destroy on GC cycle.
		once
			create Result.make
		end

	new_breakpoint_dialog: ES_BREAKPOINT_DIALOG is
			-- New breakpoint dialog.
 		do
 			create Result.make
 			Result.set_stone (Current)
 			Result.set_is_modal (False)
 			last_dialogs.extend (Result)
 			breakpoints_manager.update_breakpoints_tags_provider
 			Result.register_kamikaze_action (Result.hide_actions, agent last_dialogs.prune_all (Result))
 		ensure
 			Result_not_void: Result /= Void
		end

 	open_breakpoint_dialog is
 			-- Open a new breakpoint dialog for Current
 		do
 			new_breakpoint_dialog.show_on_active_window
 		end

	edit_conditional_breakpoint is
			-- Prompt the user for a condition and create a new breakpoint with that condition at coordinates (`f',`pos').
		local
			dlg: like new_breakpoint_dialog
 		do
 			dlg := new_breakpoint_dialog
			dlg.show_actions.extend_kamikaze (agent dlg.focus_condition_panel)
			dlg.show_on_active_window
		end

	edit_hit_count_breakpoint is
			-- Open new breakpoint dialog and focus the hit_count panel
		local
			dlg: like new_breakpoint_dialog
 		do
 			dlg := new_breakpoint_dialog
			dlg.show_actions.extend_kamikaze (agent dlg.focus_hit_count_panel)
			dlg.show_on_active_window
 		end

	edit_when_hits_breakpoint is
			-- Open new breakpoint dialog and focus the when_hits panel	
		local
			dlg: like new_breakpoint_dialog
 		do
 			dlg := new_breakpoint_dialog
			dlg.show_actions.extend_kamikaze (agent dlg.focus_when_hits_panel)
			dlg.show_on_active_window
 		end

feature -- state of breakpoint		

	toggle_bkpt is
			-- If the corresponding breakpoint was not set or disabled, enable it.
			-- If the corresponding breakpoint was already enabled, remove it.
		local
			bpm: BREAKPOINTS_MANAGER
			loc: BREAKPOINT_LOCATION
			bp: BREAKPOINT
		do
			bpm := breakpoints_manager
			loc := bpm.breakpoint_location (routine, index, True)
			if bpm.is_user_breakpoint_set_at (loc) then
				bp := bpm.user_breakpoint_at (loc)
				if bp.is_enabled then
					bpm.delete_breakpoint (bp)
				else
					bp.enable
				end
			else
				bp := bpm.new_user_breakpoint (loc)
				bpm.add_breakpoint (bp)
			end
			bpm.notify_breakpoints_changes
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
