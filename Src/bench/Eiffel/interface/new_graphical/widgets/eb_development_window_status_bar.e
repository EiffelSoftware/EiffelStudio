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
			copy_icons
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
		do
				-- Create all widgets.
			create widget
			create label
			create project_label
			create coordinate_label
			create compilation_icon
			create debugger_icon
			create edition_icon
				
				-- Set widget properties.
			project_label.align_text_center
			label.align_text_left
				-- 4 characters for the line number, 4 for the column number.
				-- It should be nine with the separator, but it looks too wide then.
			coordinate_label.set_minimum_width (coordinate_label.font.width * 8)
			coordinate_label.align_text_center
			
				-- Organize widgets.
			create vp
			vp.extend (label)
			vp.set_offset (-1, -(16 - label.height) // 2)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (vp)
			widget.extend (f)
			create project_frame
			project_frame.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			project_frame.extend (project_label)
			widget.extend (project_frame)
			widget.disable_item_expand (project_frame)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (coordinate_label)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (edition_icon)
				-- 16: Size of the icons.
			edition_icon.set_minimum_width (16)
			edition_icon.set_minimum_height (16)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (compilation_icon)
			compilation_icon.set_minimum_width (16)
			widget.extend (f)
			widget.disable_item_expand (f)
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (debugger_icon)
			debugger_icon.set_minimum_width (16)
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
			fi: FORMAT_INTEGER
			s: STRING
		do
			create s.make (10)
--			create fi.make (4)
--			fi.set_fill (' ')
--			fi.right_justify
--			fi.remove_separator
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

feature {NONE} -- Implementation: widgets

	label: EV_LABEL
			-- Label where messages are displayed.

	project_label: EV_LABEL
			-- Label that gives the name of the current project.
	
	coordinate_label: EV_LABEL
			-- Label that gives the current position in the editor.
	
	compilation_icon: EV_CELL
			-- Cell that contains the icon giving the current compilation status.

	debugger_icon: EV_CELL
			-- Cell that contains the icon giving the current debugger status.

	edition_icon: EV_CELL
			-- Cell that contains the icon giving the current edition status of the project.

	project_frame: EV_FRAME
			-- Frame that contains the project name.

--| FIXME XR: Add line/column in current editor.

feature {NONE} -- Implementation: event handling

	on_application_launched is
			-- The application has just been launched by the debugger.
		do
			update_running_icon
			running_timer.set_interval (300)
		end

	on_application_stopped is
			-- The application has just stopped (paused).
		local
			p: EV_PIXMAP
		do
			running_timer.set_interval (0)
			debugger_icon.wipe_out
			p := icon_application_paused
			debugger_icon.extend (p)
		end

	on_application_killed is
			-- The application has just terminated (dead).
		do
			running_timer.set_interval (0)
			debugger_icon.wipe_out
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
				--| This is probably redundant...
			on_application_killed
		end

	on_project_compiles is
			-- The project starts to compile.
		do
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
				p := Icon_compilation_succeeded
			else
				p := Icon_compilation_failed
			end
			compilation_icon.wipe_out
			compilation_icon.extend (p)
		end

	on_project_edited is
			-- The project has just been edited.
		local
			p: EV_PIXMAP
		do
			p := icon_edited
			edition_icon.wipe_out
			edition_icon.extend (p)
		end

	on_project_updated is
			-- The project has just been updated (the exe corresponds to the class texts).
		local
			p: EV_PIXMAP
		do
			p := icon_not_edited
			edition_icon.wipe_out
			edition_icon.extend (p)
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
			cnt: EV_CONTAINER
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
			create project_label.make_with_text (s)
			project_label.set_minimum_width (w)
			project_label.set_text (s)
			project_frame.wipe_out

			project_frame.extend (project_label)
		end

	update_running_icon is
			-- Change the "running" icon to the next pixmap.
		local
			p: EV_PIXMAP
		do
			running_icon_index := (running_icon_index + 1)
			if running_icon_index > 3 then
				running_icon_index := 1
			end
			p := Icon_running.item (running_icon_index)
			if not debugger_icon.is_empty then
				debugger_icon.replace (p)
			else
				debugger_icon.extend (p)
			end
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
			p := Icon_compiling.item (compiling_icon_index)
			if not compilation_icon.is_empty then
				compilation_icon.replace (p)
			else
				compilation_icon.extend (p)
			end
		end

	running_icon_index: INTEGER
			-- Index of the currently displayed "running" icon.

	running_timer: EV_TIMEOUT
			-- Timer that updates the "running" icon.

	compiling_icon_index: INTEGER
			-- Index of the currently displayed "compiling" icon.

	compiling_timer: EV_TIMEOUT
			-- Timer that updates the "compiling" icon.

feature {NONE} -- Copy of once icons, to avoid numerous clonings

	copy_icons is
			-- Make copies of all used icons.
		require
			not_already_copied: Icon_compilation_succeeded = Void
				--| Etc...
		local
			i: INTEGER
		do
			Icon_compilation_succeeded := clone (pixmaps.Icon_compilation_succeeded)
			Icon_compilation_succeeded.set_tooltip (interface_names.e_Compilation_succeeded)
			Icon_compilation_failed := clone (pixmaps.Icon_compilation_failed)
			Icon_compilation_failed.set_tooltip (interface_names.e_Compilation_failed)
			Icon_application_paused := clone (pixmaps.Icon_application_paused)
			Icon_application_paused.set_tooltip (interface_names.e_Paused)
			Icon_edited := clone (pixmaps.Icon_edited)
			Icon_edited.set_tooltip (interface_names.e_Edited)
			Icon_not_edited := clone (pixmaps.Icon_not_edited)
			Icon_not_edited.set_tooltip (interface_names.e_Up_to_date)
			from
				i := 1
				create Icon_running.make (1, 3)
			until
				i > 3
			loop
				Icon_running.put (clone (pixmaps.Icon_running.item (i)), i)
				Icon_running.item (i).set_tooltip (Interface_names.E_running)
				i := i + 1
			end
			from
				i := 1
				create Icon_compiling.make (1, 4)
			until
				i > 4
			loop
				Icon_compiling.put (clone (pixmaps.Icon_compiling.item (i)), i)
				Icon_compiling.item (i).set_tooltip (Interface_names.E_compiling)
				i := i + 1
			end
		end

	Icon_compilation_succeeded: EV_PIXMAP
	Icon_compilation_failed: EV_PIXMAP
	Icon_application_paused: EV_PIXMAP
	Icon_edited: EV_PIXMAP
	Icon_not_edited: EV_PIXMAP
	Icon_running: ARRAY [EV_PIXMAP]
	Icon_compiling: ARRAY [EV_PIXMAP]

end -- class EB_DEVELOPMENT_WINDOW_STATUS_BAR
