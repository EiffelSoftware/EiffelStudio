indexing
	description: "Status bar of development windows."
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

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end
	
	EB_DEBUGGER_OBSERVER
		export
			{NONE} all
		redefine
			on_application_killed,
			on_application_launched,
			on_application_stopped
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		local
			mg: EB_PROJECT_MANAGER
		do
				-- Build all widgets.
			--copy_icons
			build_interface
				-- Update the status.
			mg := eiffel_project.manager
			if mg.is_created then
				on_project_created
				if mg.has_edited_classes then
					on_project_edited
				end
			end
			if mg.is_project_loaded then
				on_project_loaded
				if application.status /= Void then
					if application.status.is_stopped then
						on_application_stopped
					else
						on_application_launched
					end
				else
					on_application_killed
				end
			else
				on_project_closed
			end
				-- Handle events.
			edition_agent := ~on_project_edited
			load_agent := ~on_project_loaded
			create_agent := ~on_project_created
			close_agent := ~on_project_closed
			compile_start_agent := ~on_project_compiles
			compile_stop_agent := ~on_project_compiled
			mg.edition_agents.extend (edition_agent)
			mg.create_agents.extend (create_agent)
			mg.close_agents.extend (close_agent)
			mg.load_agents.extend (load_agent)
			mg.compile_start_agents.extend (compile_start_agent)
			mg.compile_stop_agents.extend (compile_stop_agent)
			
			debugger_manager.observers.extend (Current)
		end

	build_interface is
			-- Build all widgets and organize them.
		local
			vp: EV_VIEWPORT
			f: EV_FRAME
			cel: EV_CELL
		do
				-- Create all widgets.
			create widget
			create label
			create project_label
			create coordinate_label
			create compilation_icon.make_with_size (16, 16)
			create debugger_cell
			create debugger_icon.make_with_size (16, 16)
			create edition_icon.make_with_size (16, 16)
				
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
			
				-- Organize widgets.
			create vp
			vp.extend (label)
			vp.set_offset (-1, -(16 - label.height) // 2)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (vp)
			widget.extend (f)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (project_label)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (coordinate_label)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create cel
			cel.extend (edition_icon)
				-- 16: Size of the icons.
			cel.set_minimum_width (16)
			cel.set_minimum_height (16)
			f.extend (cel)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create cel
			cel.extend (compilation_icon)
				-- We cannot set the minimum width on the frame directly because
				-- the width of the frame includes its border.
			cel.set_minimum_width (16)
			f.extend (cel)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create debugger_cell
			debugger_cell.extend (debugger_icon)
			debugger_cell.set_minimum_width (16)
			f.extend (debugger_cell)
			widget.extend (f)
			widget.disable_item_expand (f)
			
				-- Initialize timers.
			create running_timer.make_with_interval (0)
			running_timer.actions.extend (~update_running_icon)
			create compiling_timer.make_with_interval (0)
			compiling_timer.actions.extend (~update_compiling_icon)
		end

feature -- Status setting

	display_message (mess: STRING) is
			-- Display `mess'.
		do
			label.set_text (mess)
		end

	remove_cursor_position is
			-- Do not display any position for the editor cursor.
		do
			set_cursor_position (0, 0)
			coordinate_label.disable_sensitive
		end

	set_cursor_position (l, c: INTEGER) is
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
			coordinate_label.set_text (s)
			coordinate_label.enable_sensitive
		end

feature {EB_RECYCLER} -- Status setting

	recycle is
			-- Remove references to `Current', which becomes no longer usable.
		local
			mg: EB_PROJECT_MANAGER
		do
			debugger_manager.observers.prune_all (Current)
			
			mg := Eiffel_project.manager
			mg.create_agents.prune_all (create_agent)
			mg.load_agents.prune_all (load_agent)
			mg.close_agents.prune_all (close_agent)
			mg.edition_agents.prune_all (edition_agent)
			mg.compile_start_agents.prune_all (compile_start_agent)
			mg.compile_stop_agents.prune_all (compile_stop_agent)
		end

feature -- Status report

	message: STRING is
			-- Return the currently displayed message.
		do
			Result := label.text
		end

feature -- Access

	widget: EV_STATUS_BAR
			-- Widget representing `Current'.

	label: EV_LABEL
			-- Label where messages are displayed.
			-- Directly accessible.

feature {NONE} -- Implementation: widgets

	project_label: EV_LABEL
			-- Label that gives the name of the current project.
	
	coordinate_label: EV_LABEL
			-- Label that gives the current position in the editor.
	
	compilation_icon: EV_PIXMAP
			-- Pixmap that represents the current compilation status.

	debugger_icon: EV_PIXMAP
			-- Pixmap that represents the current debugger status.

	edition_icon: EV_PIXMAP
			-- Cell that contains the icon giving the current edition status of the project.

	debugger_cell: EV_CELL
			-- Cell that contains the debugger_icon.

feature {NONE} -- Implementation: event handling

	on_application_launched is
			-- The application has just been launched by the debugger.
		do
			if debugger_cell.is_empty then
				debugger_cell.extend (debugger_icon)
			end
			debugger_icon.set_tooltip (Interface_names.E_running)
			update_running_icon
			running_timer.set_interval (300)
		end

	on_application_stopped is
			-- The application has just stopped (paused).
		local
			p: EV_PIXMAP
		do
			running_timer.set_interval (0)
			p := Pixmaps.icon_application_paused
			debugger_icon.set_background_color (debugger_cell.background_color)
			debugger_icon.clear
			debugger_icon.draw_pixmap (0, 0, p)
			debugger_icon.set_tooltip (Interface_names.E_paused)
			if debugger_cell.is_empty then
				debugger_cell.extend (debugger_icon)
			end
		end

	on_application_killed is
			-- The application has just terminated (dead).
		do
			running_timer.set_interval (0)
			debugger_cell.prune_all (debugger_icon)
		end

	on_project_created is
			-- The project has been created.
		do
			on_project_updated
			on_application_killed
		end

	on_project_loaded is
			-- The project has been loaded.
		do
			set_project_name (eiffel_system.name)
			if eiffel_project.manager.has_edited_classes then
				on_project_edited
			else
				on_project_updated
			end
			if application.status /= Void then
				if application.status.is_stopped then
					on_application_stopped
				else
					on_application_launched
				end
			else
				on_application_killed
			end
			if not eiffel_project.workbench.is_compiling then
				on_project_compiled
			end
		end

	on_project_closed is
			-- The project has been closed.
		do
			set_project_name ("No project")
			compilation_icon.set_background_color (debugger_cell.background_color)
			compilation_icon.clear
			compilation_icon.remove_tooltip
			edition_icon.set_background_color (debugger_cell.background_color)
			edition_icon.clear
			edition_icon.remove_tooltip
				--| This is probably redundant...
			on_application_killed
		end

	on_project_compiles is
			-- The project starts to compile.
		do
			compilation_icon.set_tooltip (Interface_names.E_compiling)
			update_compiling_icon
			compiling_timer.set_interval (300)
			if Eiffel_project.Manager.has_edited_classes then
				on_project_edited
			else
				on_project_updated
			end
		end

	on_project_compiled is
			-- The project has finished compiling.
		local
			p: EV_PIXMAP
		do
			compiling_timer.set_interval (0)
			if eiffel_project.workbench.successful then
				p := Pixmaps.Icon_compilation_succeeded
				compilation_icon.set_tooltip (Interface_names.E_compilation_succeeded)
			else
				p := Pixmaps.Icon_compilation_failed
				compilation_icon.set_tooltip (Interface_names.E_compilation_failed)
			end
			compilation_icon.set_background_color (debugger_cell.background_color)
			compilation_icon.clear
			compilation_icon.draw_pixmap (0, 0, p)
		end

	on_project_edited is
			-- The project has just been edited.
		local
			p: EV_PIXMAP
		do
			p := Pixmaps.icon_edited
			edition_icon.set_background_color (debugger_cell.background_color)
			edition_icon.clear
			edition_icon.draw_pixmap (0, 0, p)
			edition_icon.set_tooltip (Interface_names.E_edited)
		end

	on_project_updated is
			-- The project has just been updated (the exe corresponds to the class texts).
		local
			p: EV_PIXMAP
		do
			p := Pixmaps.icon_not_edited
			edition_icon.set_background_color (debugger_cell.background_color)
			edition_icon.clear
			edition_icon.draw_pixmap (0, 0, p)
			edition_icon.set_tooltip (Interface_names.E_up_to_date)
		end

	edition_agent: PROCEDURE [EB_DEVELOPMENT_WINDOW_STATUS_BAR, TUPLE]
			-- Agent called when the project is edited.

	close_agent: PROCEDURE [EB_DEVELOPMENT_WINDOW_STATUS_BAR, TUPLE]
			-- Agent called when the project is closed.

	load_agent: PROCEDURE [EB_DEVELOPMENT_WINDOW_STATUS_BAR, TUPLE]
			-- Agent called when the project is loaded.

	create_agent: PROCEDURE [EB_DEVELOPMENT_WINDOW_STATUS_BAR, TUPLE]
			-- Agent called when the project is created.

	compile_start_agent: PROCEDURE [EB_DEVELOPMENT_WINDOW_STATUS_BAR, TUPLE]
			-- Agent called when the project is compiled.

	compile_stop_agent: PROCEDURE [EB_DEVELOPMENT_WINDOW_STATUS_BAR, TUPLE]
			-- Agent called when the project's compilation is over.

feature {NONE} -- Implementation

	set_project_name (n: STRING) is
			-- Display `n' as the project name.
		require
			valid_name: n /= Void
		local
			f: EV_FONT
			s: STRING
			w: INTEGER
		do
			f := project_label.font
			create s.make (n.count + 2)
			s.append_character (' ')
			s.append (n)
			s.append_character (' ')
			w := f.string_width (s)
			if w > 200 then
				s := n
				w := f.string_width (s).min (100)
			end
			project_label.set_minimum_width (w)
			project_label.set_text (s)
		end

	update_running_icon is
			-- Change the "running" icon to the next pixmap.
		local
			p: EV_PIXMAP
			op: EV_PIXMAP
		do
			running_icon_index := (running_icon_index + 1)
			if running_icon_index > 3 then
				running_icon_index := 1
			end
			p := Pixmaps.Icon_running.item (running_icon_index)
			debugger_icon.set_background_color (debugger_cell.background_color)
			debugger_icon.clear
			debugger_icon.draw_pixmap (0, 0, p)
		end

	update_compiling_icon is
			-- Change the "compiling" icon to the next pixmap.
		local
			p: EV_PIXMAP
		do
			compiling_icon_index := (compiling_icon_index + 1)
			if compiling_icon_index > 4 then
				compiling_icon_index := 1
			end
			p := Pixmaps.Icon_compiling.item (compiling_icon_index)
			compilation_icon.set_background_color (debugger_cell.background_color)
			compilation_icon.clear
			compilation_icon.draw_pixmap (0, 0, p)
		end

	running_icon_index: INTEGER
			-- Index of the currently displayed "running" icon.

	running_timer: EV_TIMEOUT
			-- Timer that updates the "running" icon.

	compiling_icon_index: INTEGER
			-- Index of the currently displayed "compiling" icon.

	compiling_timer: EV_TIMEOUT
			-- Timer that updates the "compiling" icon.

end -- class EB_DEVELOPMENT_WINDOW_STATUS_BAR
