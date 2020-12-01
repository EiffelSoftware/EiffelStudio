note
	description: "Status bar of development windows."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_STATUS_BAR

inherit
	EB_STATUS_BAR

	EB_RECYCLABLE

	EB_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES

	DEBUGGER_MANAGER_OBSERVER
		export
			{NONE} all
		redefine
			on_application_exited,
			on_application_launched,
			on_application_resumed,
			on_application_stopped
		end

	EV_SHARED_APPLICATION

	EB_SHARED_INTERFACE_TOOLS

	SHARED_NOTIFICATION_SERVICE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			mg: EB_PROJECT_MANAGER
			dbg: DEBUGGER_MANAGER
		do
				-- Build all widgets.
			--copy_icons
			build_interface

			dbg := debugger_manager
			attach_to_debugger (dbg)

				-- Update the status.
			mg := eiffel_project.manager
			if mg.is_created then
				on_project_created (dbg)
				if has_modified_classes then
					on_project_edited
				end
			end
			if mg.is_project_loaded then
				on_project_loaded (dbg)
			else
				on_project_closed (dbg)
			end
				-- Handle events.
			load_agent := agent on_project_loaded (dbg)
			create_agent := agent on_project_created (dbg)
			close_agent := agent on_project_closed (dbg)
			compile_start_agent := agent on_project_compiles
			compile_stop_agent := agent on_project_compiled
			mg.create_agents.extend (create_agent)
			mg.close_agents.extend (close_agent)
			mg.load_agents.extend (load_agent)
			mg.compile_start_agents.extend (compile_start_agent)
			mg.compile_stop_agents.extend (compile_stop_agent)

			compiling_icon_index := 1
			running_icon_index := 1

			if attached notification_s.service as l_notif_service then
				create notification_manager.make (Current)
				l_notif_service.register_observer (notification_manager)
			end
		end

	build_interface
			-- Build all widgets and organize them.
		local
			vp: EV_VIEWPORT
			f: EV_FRAME
			cel: EV_CELL

			l_icon_size: INTEGER
		do
			l_icon_size := {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (16)
				-- Create all widgets.
			create widget
			create label
			black_color := label.foreground_color
			red_color := preferences.editor_data.error_text_color
			create progress_bar
			create project_label
			create coordinate_label
			create compilation_icon.make_with_size (l_icon_size, l_icon_size)
			create debugger_cell
			create debugger_icon.make_with_size (l_icon_size, l_icon_size)
			create edition_icon.make_with_size (l_icon_size, l_icon_size)
			create notifications_icon.make_with_size (l_icon_size, l_icon_size)

				-- Set widget properties.
			project_label.align_text_center
			label.align_text_left
				-- 4 characters for the line number, 4 for the column number.
				-- It should be nine with the separator, but it looks too wide then.
			coordinate_label.set_minimum_width (coordinate_label.font.width * 8)
			coordinate_label.align_text_center
			project_label.set_tooltip (Interface_names.e_Project_name)
			coordinate_label.set_tooltip (Interface_names.e_Cursor_position)
			debugger_icon.clear
			notifications_icon.clear

			create vp
			vp.extend (label)
			vp.set_offset (-1, -(l_icon_size - label.height) // 2)

			create f
			f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (vp)
			widget.extend (f)

			create f
			f.set_minimum_width (100)
			f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (progress_bar)
			widget.extend (f)
			widget.disable_item_expand (f)

			create f
			f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (project_label)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (coordinate_label)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create cel
			cel.extend (edition_icon)
				-- 16: Size of the icons.
			cel.set_minimum_width (l_icon_size)
			cel.set_minimum_height (l_icon_size)
			f.extend (cel)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create cel
			cel.extend (compilation_icon)
				-- We cannot set the minimum width on the frame directly because
				-- the width of the frame includes its border.
			cel.set_minimum_width (l_icon_size)
			f.extend (cel)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create debugger_cell
			debugger_cell.extend (debugger_icon)
			debugger_cell.set_minimum_width (l_icon_size)
			f.extend (debugger_cell)
			widget.extend (f)
			widget.disable_item_expand (f)

			if attached notification_s.service as l_notif_service then
				create f
				f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
				create cel
				notifications_cell := cel
				cel.extend (notifications_icon)
				cel.set_minimum_width (l_icon_size)
				f.extend (cel)
				widget.extend (f)
				widget.disable_item_expand (f)
			end

				-- Initialize timers.
			create running_timer.make_with_interval (0)
			running_timer.actions.extend (agent update_running_icon)
			create compiling_timer.make_with_interval (0)
			compiling_timer.actions.extend (agent update_compiling_icon)
		end

feature -- Status setting

	reset
			-- Reset status bar.
		do
			display_message ("")
			display_progress_value (0)
		end

	display_message (mess: READABLE_STRING_GENERAL)
			-- Display `mess'.
		do
			label.set_foreground_color (black_color)
			label.set_text (mess)
			label.refresh_now
		end

	display_error_message (mess: READABLE_STRING_GENERAL)
			-- Display error message `mess'.
		do
			label.set_foreground_color (red_color)
			label.set_text (mess)
			label.refresh_now
		end

	reset_progress_bar_with_range (a_range: INTEGER_INTERVAL)
			-- Reset `progress_bar' to use range `a_range'.
		require
			a_range_not_void: a_range /= Void
		do
			progress_bar.reset_with_range (a_range)
		end

	display_progress_value (a_value: INTEGER)
			-- Display `a_value' in `progress_bar'.
		do
			progress_bar.set_value (a_value)
		end

	remove_cursor_position
			-- Do not display any position for the editor cursor.
		do
			set_cursor_position (0, 0, 0)
			coordinate_label.disable_sensitive
		end

	set_cursor_position (l, c, v: INTEGER)
			-- Display a new editor coordinate.
		require
			valid_pos: l >= 0 and c >= 0
		local
			s: STRING
		do
			create s.make (10)
			s.append (l.out)
			s.append_character (':')
			s.append (c.out)
			--| FIXME IEK Uncomment when {TEXT_CURSOR}.x_in_visible_characters
			--| is fixed to update with keyboard navigation.
--			if v > c then
--				s.append_character ('-')
--				s.append (v.out)
--			end
			coordinate_label.set_text (s)
			coordinate_label.enable_sensitive
		end

	on_project_edited
			-- The project has just been edited.
		local
			p: EV_PIXMAP
		do
			p := pixmaps.icon_pixmaps.view_editor_icon
			edition_icon.set_background_color (debugger_cell.background_color)
			edition_icon.clear
			edition_icon.draw_pixmap (0, 0, p)
			edition_icon.set_tooltip (Interface_names.E_edited)
		end

feature {NONE} -- Status setting

	internal_recycle
			-- Remove references to `Current', which becomes no longer usable.
		local
			mg: EB_PROJECT_MANAGER
		do
			Debugger_manager.remove_observer (Current)

			unattach_from_debugger

			mg := Eiffel_project.manager
			mg.create_agents.prune_all (create_agent)

			mg.load_agents.prune_all (load_agent)

			mg.close_agents.prune_all (close_agent)
			mg.compile_start_agents.prune_all (compile_start_agent)
			mg.compile_stop_agents.prune_all (compile_stop_agent)
		end

feature -- Status report

	message: STRING_32
			-- Return the currently displayed message.
		do
			Result := label.text
		end

feature -- Access

	widget: EV_STATUS_BAR
			-- Widget representing `Current'.

	notification_manager: detachable ES_NOTIFICATION_MANAGER

feature -- Access

	current_progress_value: INTEGER
			-- Current value display by `progress_bar'.
		do
			Result := progress_bar.value
		end

	current_project_name: STRING_32
			-- Current project name
		local
			l_name, l_target_name: READABLE_STRING_GENERAL
		do
			if eiffel_project.initialized then
				l_target_name := eiffel_ace.lace.target_name
				if eiffel_project.system_defined then
					l_name := eiffel_system.name
				else
					l_name := eiffel_ace.lace.conf_system.name
				end
			end
			if l_name /= Void then
				if l_name.same_string (l_target_name) then
					create Result.make_from_string_general (l_name)
				else
					create Result.make (l_name.count + 1 + l_target_name.count)
					Result.append_string_general (l_name)
					Result.append_character (':')
					Result.append_string_general (l_target_name)
				end
			else
				Result := interface_names.l_no_project
			end
		ensure
			current_project_name_not_void: Result /= Void
		end

feature {EIFFEL_WORLD, EB_WINDOW_MANAGER, EB_DEVELOPMENT_WINDOW, EB_DEVELOPMENT_WINDOW_DIRECTOR} -- Access

	label: EV_LABEL
			-- Label where messages are displayed.
			-- Directly accessible.

	progress_bar: EB_PERCENT_PROGRESS_BAR
			-- Progress bar where completion status is displayed

feature {NONE} -- Implementation: widgets

	red_color, black_color: EV_COLOR
			-- Color for text of `label'.

	project_label: EV_LABEL
			-- Label that gives the name of the current project.

	coordinate_label: EV_LABEL
			-- Label that gives the current position in the editor.

	compilation_icon: EV_PIXMAP
			-- Pixmap that represents the current compilation status.

	debugger_icon: EV_PIXMAP
			-- Pixmap that represents the current debugger status.

	edition_icon: EV_PIXMAP
			-- Pixmap that represents the current edition status of the project.

	debugger_cell: EV_CELL
			-- Cell that contains the `debugger_icon`.

feature {ES_NOTIFICATION_MANAGER} -- Implementation: widgets			

	notifications_icon: EV_PIXMAP
			-- Pixmap that represents the notification messages.

	notifications_cell: EV_CELL
			-- Cell that contains the `notifications_icon`.

feature {NONE} -- Implementation: event handling

	on_application_launched (dbg: DEBUGGER_MANAGER)
			-- The application has just been launched by the debugger.
		do
			on_application_resumed (dbg)
		end

	on_application_resumed (dbg: DEBUGGER_MANAGER)
			-- The application has been resumed by the debugger.
		do
			if debugger_cell.is_empty then
				debugger_cell.extend (debugger_icon)
			end
			debugger_icon.set_tooltip (Interface_names.E_running)
			if use_animated_icons then
				update_running_icon
				running_timer.set_interval (300)
			else
				debugger_icon.set_background_color (debugger_cell.background_color)
				debugger_icon.clear
				debugger_icon.draw_pixmap (0, 0, pixmaps.icon_pixmaps.run_animation_anim.item (1))
			end
		end

	on_application_stopped (dbg: DEBUGGER_MANAGER)
			-- The application has just stopped (paused).
		local
			p: EV_PIXMAP
		do
			running_timer.set_interval (0)
			p := pixmaps.icon_pixmaps.debug_pause_icon
			debugger_icon.set_background_color (debugger_cell.background_color)
			debugger_icon.clear
			debugger_icon.draw_pixmap (0, 0, p)
			debugger_icon.set_tooltip (Interface_names.E_paused)
			if debugger_cell.is_empty then
				debugger_cell.extend (debugger_icon)
			end
		end

	on_application_exited (dbg: DEBUGGER_MANAGER)
			-- The application has just terminated (dead).
		do
			running_timer.set_interval (0)
			debugger_cell.prune_all (debugger_icon)
		end

	on_project_created (dbg: DEBUGGER_MANAGER)
			-- The project has been created.
		do
			set_project_name (current_project_name)
			on_project_updated
			on_application_exited (dbg)
		end

	on_project_loaded (dbg: DEBUGGER_MANAGER)
			-- The project has been loaded.
		do
			if not is_recycled then
				set_project_name (current_project_name)
				if has_modified_classes then
					on_project_edited
				else
					on_project_updated
				end
				if dbg.application_is_executing then
					if dbg.application_is_stopped then
						on_application_stopped (dbg)
					else
						on_application_launched (dbg)
					end
				else
					on_application_exited (dbg)
				end
				if not eiffel_project.workbench.is_compiling then
					on_project_compiled (eiffel_project.workbench.compilation_status)
				end
			end
		end

	on_project_closed (dbg: DEBUGGER_MANAGER)
			-- The project has been closed.
		do
			set_project_name (interface_names.l_no_project)
			compilation_icon.set_background_color (debugger_cell.background_color)
			compilation_icon.clear
			compilation_icon.remove_tooltip
			edition_icon.set_background_color (debugger_cell.background_color)
			edition_icon.clear
			edition_icon.remove_tooltip
				--| This is probably redundant...
			on_application_exited (dbg)
		end

	on_project_compiles
			-- The project starts to compile.
		do
			compilation_icon.set_tooltip (Interface_names.E_compiling)
			if use_animated_icons then
				update_compiling_icon
				compiling_timer.set_interval (300)
			else
				compilation_icon.set_background_color (debugger_cell.background_color)
				compilation_icon.clear
				compilation_icon.draw_pixmap (0, 0, pixmaps.icon_pixmaps.compile_animation_1_icon)
			end
			if has_modified_classes then
				on_project_edited
			end
		end

	on_project_compiled (s: like {WORKBENCH_I}.compilation_status)
			-- The project has finished compiling.
		require
			{WORKBENCH_I}.is_compilation_status (s)
		local
			p: EV_PIXMAP
		do
			set_project_name (current_project_name)
			compiling_timer.set_interval (0)
			inspect s
			when {WORKBENCH_I}.compilation_status_without_complaint then
				p := pixmaps.icon_pixmaps.compile_success_icon
				compilation_icon.set_tooltip (interface_names.e_compilation_succeeded)
				on_project_updated
			when {WORKBENCH_I}.compilation_status_with_warning then
				p := pixmaps.icon_pixmaps.tool_warning_icon
				compilation_icon.set_tooltip (interface_names.e_compilation_succeeded_with_warning)
				on_project_updated
			else
				p := pixmaps.icon_pixmaps.compile_error_icon
				compilation_icon.set_tooltip (interface_names.e_compilation_failed)
			end
			compilation_icon.set_background_color (debugger_cell.background_color)
			compilation_icon.clear
			compilation_icon.draw_pixmap (0, 0, p)
		end

	on_project_updated
			-- The project has just been updated (the exe corresponds to the class texts).
		local
			p: EV_PIXMAP
		do
			p := pixmaps.icon_pixmaps.view_unmodified_icon
			edition_icon.set_background_color (debugger_cell.background_color)
			edition_icon.clear
			edition_icon.draw_pixmap (0, 0, p)
			edition_icon.set_tooltip (Interface_names.E_up_to_date)
		end

	close_agent: PROCEDURE
			-- Agent called when the project is closed.

	load_agent: PROCEDURE
			-- Agent called when the project is loaded.

	create_agent: PROCEDURE
			-- Agent called when the project is created.

	compile_start_agent: PROCEDURE
			-- Agent called when the project is compiled.

	compile_stop_agent: PROCEDURE [like {WORKBENCH_I}.compilation_status]
			-- Agent called when the project's compilation is over.

feature {NONE} -- Implementation

	set_project_name (n: READABLE_STRING_GENERAL)
			-- Display `n' as the project name.
		require
			valid_name: n /= Void
		local
			f: EV_FONT
			s: STRING_32
			w: INTEGER
		do
			f := project_label.font
			create s.make (n.count + 2)
			s.append_character (' ')
			s.append_string_general (n)
			s.append_character (' ')
			w := f.string_width (s)
			if w > 200 then
				s := n.to_string_32
				w := f.string_width (s).min (100)
			end
			project_label.set_minimum_width (w)
			project_label.set_text (s)
		end

	update_running_icon
			-- Change the "running" icon to the next pixmap.
		local
			l_anim: ARRAY [EV_PIXMAP]
		do
				--| We do not check every time that the `use_animated_icons'
				--| preference is still set.
				--| 2 reasons: efficiency, consistency (in the other direction
				--| the preference is only effective at the next run).
			l_anim := pixmaps.icon_pixmaps.run_animation_anim
			debugger_icon.set_background_color (debugger_cell.background_color)
			debugger_icon.clear
			if l_anim.valid_index (running_icon_index) then
				debugger_icon.draw_pixmap (0, 0, l_anim.item (running_icon_index))
			else
				check not_possible: False end
				-- FIXME: Runtime bug or ...? In theory, running_icon_index's value is always between 1 and 5.
				-- So the index should always valid. But on Linux it's not the case sometimes
				-- See bug#15209
			end

			running_icon_index := running_icon_index + 1
			if running_icon_index > l_anim.count then
				running_icon_index := 1
			end
		end

	update_compiling_icon
			-- Change the "compiling" icon to the next pixmap.
		local
			l_anim: ARRAY [EV_PIXMAP]
		do
			l_anim := pixmaps.icon_pixmaps.compile_animation_anim
			compilation_icon.set_background_color (debugger_cell.background_color)
			compilation_icon.clear
			compilation_icon.draw_pixmap (0, 0, l_anim.item (compiling_icon_index.min (l_anim.count)))

			compiling_icon_index := compiling_icon_index + 1
				-- We use + 2 to ensure there is a small delay before a cycle.
				-- This is only done on the compilation icon
			if compiling_icon_index > l_anim.count + 2 then
				compiling_icon_index := 1
			end
		end

	use_animated_icons: BOOLEAN
			-- Should we use animated icons whenever possible? (compiling, running)
		do
			Result := preferences.development_window_data.use_animated_icons
		end

	running_icon_index: INTEGER
			-- Index of the currently displayed "running" icon.

	running_timer: EV_TIMEOUT
			-- Timer that updates the "running" icon.

	compiling_icon_index: INTEGER
			-- Index of the currently displayed "compiling" icon.

	compiling_timer: EV_TIMEOUT;
			-- Timer that updates the "compiling" icon.

invariant
	compiling_icon_index_positive: compiling_icon_index > 0
	running_icon_index_positive: running_icon_index > 0

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end -- class EB_DEVELOPMENT_WINDOW_STATUS_BAR
