note
	description: "[
			Abstraction of an control allowing adding, removal and in-place editing of
			program arguments.

			]"
	comments:"(jfiat) Left commented lines for futur implementation (postponed for now)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGING_OPTIONS_CONTROL

inherit
	ES_WIDGET [EV_VERTICAL_BOX]
		redefine
			on_before_initialize,
			on_after_initialized
		end

	EB_SHARED_INTERFACE_TOOLS

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_DEBUGGER_MANAGER

	KL_SHARED_FILE_SYSTEM

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	build_widget_interface (a_widget: attached EV_VERTICAL_BOX)
			-- Builds widget's interface.
			-- `a_widget': The widget to initialize of build upon.
		local
			vbox: EV_VERTICAL_BOX
		do
			create execution_panel
			a_widget.extend (execution_panel)

				-- Create all widgets.
			build_display_profiles_box

			create vbox
			vbox.extend (display_profiles_box)
			execution_panel.extend (vbox)

				-- Global actions.
			a_widget.focus_in_actions.extend (agent on_focused)
		end

    on_before_initialize
            -- Use to perform additional creation initializations, before the UI has been created.
			-- Note: No user interface initialization should be done here! Use `build_dialog_interface' instead
		do
			control_in_tool := False
	    end

    on_after_initialized
            -- Use to perform additional creation initializations, after the UI has been created.
        do
        	Precursor
			update
        end

	Layout_constants: EV_LAYOUT_CONSTANTS
			-- Constants for vision2 layout
		once
				--| FIXME: get rid of this feature
			create Result
		end

	control_in_tool: BOOLEAN
			-- Current control embedded in ES tool ?
			-- (unused for now)

feature -- Interface access

	set_focus_on_widget
			-- Set focus on widget
		do
			if is_shown then
				widget.set_focus
			end
		end

feature {EB_ARGUMENT_DIALOG} -- Storage

	load_dbg_options
			-- Retrieve and initialize the arguments from user options.
		local
			l_row: EV_GRID_ROW
			l_prof: like profile_from_row
			dm: DEBUGGER_MANAGER
			profs: DEBUGGER_PROFILE_MANAGER
		do
				--| Reset cached data
			internal_sorted_environment_variables := Void

				--| Load data
			profiles_grid.set_row_count_to (0)

				--| Default
			l_row := added_profile_text_row (Void, False)

			dm := debugger_manager
			profs := dm.profiles
			if profs /= Void then
					--| It is safer to work on a copy to be able to cancel
					--| changes easily
				profs := profs.duplication
				from
					profs.start
				until
					profs.after
				loop
					l_row := added_profile_text_row (profs.item_for_iteration, False)
					profs.forth
				end

				l_prof := profs.last_profile
				if l_prof /= Void then
					l_row := grid_row_with_profile (l_prof)
					if l_row = Void then
						l_row := added_profile_text_row (l_prof, True)
					else
						request_select_row (l_row)
					end
					if l_row.is_expandable and then not l_row.is_expanded then
						l_row.expand
					end
				else
					request_select_row (default_profile_row)
				end
				if profiles_grid.column_count > 0 then
					profiles_grid.safe_resize_column_to_content (profiles_grid.column (1), False, False)
					if profiles_grid.column_count > 1 then
						profiles_grid.safe_resize_column_to_content (profiles_grid.column (2), False, False)
					end
				end
			else
				request_select_row (default_profile_row)
			end

			set_changed (Void, False)
		end

	store_dbg_options
			-- Store the current arguments and set current
			-- arguments for system execution.
		local
			profs: DEBUGGER_PROFILE_MANAGER
			r: INTEGER
			p: like profile_from_row
			toprows: LINKED_LIST [EV_GRID_ROW]
			lrow: EV_GRID_ROW
		do
				--| Find the top rows (containing the profile data)
			from
				create toprows.make
				r := 1
			until
				r > profiles_grid.row_count
			loop
				lrow := profiles_grid.row (r)
				check lrow.parent_row_root = lrow end
				toprows.extend (lrow)
				r := r + lrow.subrow_count_recursive + 1
			end

				--| Set profiles
			profs := debugger_manager.profiles
			from
				profs.wipe_out
				toprows.start
			until
				toprows.after
			loop
				p := profile_from_row (toprows.item)
				if p /= Void then
					profs.add (p)
				end
				toprows.forth
			end

			p := selected_profile
			if p = Void then
				lrow := default_profile_row
				if lrow /= Void then
					lrow.enable_select
				end
			end
			profs.set_last_profile (p)
			debugger_manager.save_profiles_data

			set_changed (Void, False)
		end

feature {NONE} -- Implementation

	request_select_row (a_row: EV_GRID_ROW)
			-- Request `a_row' to be selected
		do
			ev_application.add_idle_action_kamikaze (agent process_select_row (a_row))
		end

	process_select_row (a_row: EV_GRID_ROW)
			-- Select `a_row'
		do
			if a_row /= Void and then a_row.parent /= Void then
				a_row.enable_select
			end
		end

feature -- Query

	selected_profile: like profile_from_row
		local
			lrow: EV_GRID_ROW
		do
			if profiles_grid.row_count > 0 and then not profiles_grid.selected_rows.is_empty then
				lrow := profiles_grid.selected_rows.first
				Result := profile_from_row (lrow)
			end
		end

	default_profile_row: EV_GRID_ROW
			-- "Default" profile's row.
		do
			if profiles_grid.row_count > 0 then
				Result := profiles_grid.row (1)
			end
		end

feature {NONE} -- GUI

	on_focused
			-- Widget focused in
		do
				--| Set focus to a new argument field or to a check box
				--| to allow arguments if they are not allowed yet.
			if profiles_grid.is_sensitive then
				profiles_grid.set_focus
			end
		end

feature {NONE} -- Display profiles impl

	build_display_profiles_box
		local
			f: EV_FRAME
			g: ES_GRID
			l_border_box,vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			create display_profiles_box
			display_profiles_box.set_padding_width ({ES_UI_CONSTANTS}.vertical_padding)
			display_profiles_box.set_border_width ({ES_UI_CONSTANTS}.frame_border)

			create f.make_with_text (interface_names.t_execution_parameters)
			create vb
			f.extend (vb)

			vb.set_padding_width ({ES_UI_CONSTANTS}.vertical_padding)
--			vb.set_border_width (layout_constants.Small_border_size)

				--| Buttons
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.set_padding_width ({ES_UI_CONSTANTS}.horizontal_padding)
			create add_button.make_with_text_and_action (interface_names.b_add, agent add_new_profile)
			layout_constants.set_default_width_for_button (add_button)
			add_button.enable_sensitive

			create remove_button.make_with_text_and_action (interface_names.b_remove, agent remove_selected_profile)
			layout_constants.set_default_width_for_button (remove_button)
			remove_button.disable_sensitive

			create dup_button.make_with_text_and_action (interface_names.b_duplicate, agent duplicate_selected_profile)
			layout_constants.set_default_width_for_button (dup_button)
			dup_button.disable_sensitive

--			if control_in_tool then --| provide a way to "Apply" changes
				create apply_button.make_with_text_and_action (interface_names.b_apply, agent apply_changes)
				layout_constants.set_default_width_for_button (apply_button)
				apply_button.disable_sensitive
--			end

			create reset_button.make_with_text_and_action (interface_names.b_reset, agent reset_changes)
			layout_constants.set_default_width_for_button (reset_button)
			reset_button.disable_sensitive

			hb.extend (add_button)
			hb.disable_item_expand (add_button)
			hb.extend (dup_button)
			hb.disable_item_expand (dup_button)
			hb.extend (remove_button)
			hb.disable_item_expand (remove_button)
			hb.extend (create {EV_HORIZONTAL_SEPARATOR})
			if apply_button /= Void then
				hb.extend (apply_button)
				hb.disable_item_expand (apply_button)
			end
			hb.extend (reset_button)
			hb.disable_item_expand (reset_button)

				--| Grid
			create g
			profiles_grid := g

			g.enable_tree
			g.hide_header
			g.enable_border
			g.enable_always_selected
			g.set_separator_color (Stock_colors.color_3d_face)
			g.enable_single_row_selection
			g.enable_default_tree_navigation_behavior (True, True, True, True)
			g.row_select_actions.extend (agent on_row_selected)
			g.row_deselect_actions.extend (agent on_row_unselected)
			g.set_auto_resizing_column (1, True)
			g.set_auto_resizing_column (2, True)
			g.pointer_double_press_item_actions.extend (agent on_item_double_clicked)
			g.key_press_actions.extend (agent on_profiles_grid_key_pressed)

			g.row_expand_actions.force_extend (agent profiles_grid.request_columns_auto_resizing)
			g.row_collapse_actions.force_extend (agent profiles_grid.request_columns_auto_resizing)

			create l_border_box
			l_border_box.set_border_width (1)
			l_border_box.set_background_color (stock_colors.black)
			l_border_box.extend (profiles_grid)

			vb.extend (l_border_box)
			create display_profiles_box
			display_profiles_box.extend (f)
		end

feature {NONE} -- Factory

	create_widget: attached EV_VERTICAL_BOX
			-- Creates a new widget, which will be initialized when `build_interface' is called.
		do
			create Result
		end

feature {NONE} -- GUI Properties

	execution_panel: EV_VERTICAL_BOX
			-- Frame widget containing argument controls.

	profiles_grid: ES_GRID
			-- Current list of profiles.

	display_profiles_box: EV_VERTICAL_BOX
			-- Widget containing profile settings.

	add_button, dup_button, remove_button: EV_BUTTON
	apply_button, reset_button: EV_BUTTON

feature {NONE} -- Grid events

	on_profiles_grid_key_pressed (a_key: EV_KEY)
			-- `a_key' has been pressed on `profiles_grid'
		local
			l_row: EV_GRID_ROW
			l_editable_item: EV_GRID_ITEM
			c: INTEGER
		do
			l_row := profiles_grid.single_selected_row
			if l_row /= Void then
				if attached {ES_GRID_ROW_CONTROLLER} l_row.data as l_ctler then
					l_ctler.call_key_pressed_action (a_key)
				elseif l_row.count > 0 then
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_enter then
						from
							c := 1
						until
							l_editable_item /= Void or c > l_row.count
						loop
							if attached {EV_GRID_EDITABLE_ITEM} l_row.item (c) as gi then
								l_editable_item := gi
							elseif attached {EV_GRID_EDITABLE_SPAN_LABEL_ITEM} l_row.item (c) as gsi then
								l_editable_item := gsi
							end
							c := c + 1
						end
						if l_editable_item /= Void then
							l_editable_item.activate
						end
					when {EV_KEY_CONSTANTS}.key_numpad_add then
						if ev_application.ctrl_pressed then
							move_first_selected_row_by (+1)
						end
					when {EV_KEY_CONSTANTS}.key_numpad_subtract then
						if ev_application.ctrl_pressed then
							move_first_selected_row_by (-1)
						end
					else
					end
				end
			end
		end

	move_first_selected_row_by (offset: INTEGER)
			-- Move first selected row by `offset'
		local
			c: INTEGER
			d: INTEGER
		do
			if attached profiles_grid.grid_selected_top_rows (profiles_grid) as lst then
				if lst.count > 0 then
					if attached lst.first as row then
						d := default_profile_row.index
							--| Do not move the first row (which is the default profile)
						if row.index /= d and row.index + offset /= d then
							c := profiles_grid.grid_move_top_row_node_by (profiles_grid, row.index, offset)
							if c > 0 then
								set_changed (Void, True)
							end
							profiles_grid.remove_selection
							row.enable_select
						end
					end
				end
			end
		end

	on_row_selected (a_row: EV_GRID_ROW)
			-- `a_row' has been selected
		local
			r: EV_GRID_ROW
		do
			if not inside_row_operation and a_row /= Void then
				set_row_root_as_selected (False, default_profile_row)
				r := a_row.parent_row_root
				check r /= Void end

				if r = a_row then
					r.set_background_color (profiles_grid.focused_selection_color)
					r.set_foreground_color (profiles_grid.focused_selection_text_color)
				end

				set_row_root_as_selected (True, r)

				if r.data /= Void then
					remove_button.enable_sensitive
					dup_button.enable_sensitive
				else
					remove_button.disable_sensitive
					dup_button.disable_sensitive
				end
			end
		end

	set_row_root_as_selected (a_is_selected: BOOLEAN; a_row: EV_GRID_ROW)
		require
			a_row /= Void implies a_row.parent_row_root = a_row
		local
			gi: EV_GRID_SPAN_LABEL_ITEM
		do
			if a_row /= Void and then a_row.count > 0 then
				gi ?= a_row.item (1)
				if gi /= Void then
					if a_is_selected then
						gi.set_pixmap (mini_stock_pixmaps.general_next_icon)
					else
						gi.remove_pixmap
					end
					profiles_grid.safe_resize_column_to_content (gi.column, False, False)
				end
			end
		end

	on_row_unselected (a_row: EV_GRID_ROW)
			-- `a_row' has been unselected
		local
			gi: EV_GRID_SPAN_LABEL_ITEM
			r: EV_GRID_ROW
		do
			if not inside_row_operation then
				remove_button.disable_sensitive
				dup_button.disable_sensitive
				if a_row /= Void then
					r := a_row.parent_row_root
					if r = a_row then
						r.set_background_color (profiles_grid.separator_color)
						r.set_foreground_color (profiles_grid.foreground_color)
					end
					if r.count > 0 then
						gi ?= r.item (1)
						if gi /= Void then
							gi.remove_pixmap
							profiles_grid.safe_resize_column_to_content (gi.column, False, False)
						end
					end
				end
				set_row_root_as_selected (True, default_profile_row)
			end
		end

	on_item_double_clicked (ax, ay, ab: INTEGER; gi: EV_GRID_ITEM)
			-- `gi' has been double clicked
		local
			gei: EV_GRID_EDITABLE_ITEM
		do
			if ab = 1 then
				gei ?= gi
				if gei /= Void then
					gei.activate
				end
			end
		end

feature -- Status

	has_changed: BOOLEAN
			-- Profile data changed ?

feature -- Status Setting

	set_changed (p: like profile_from_row; b: BOOLEAN)
			-- Notify change
		do
			if has_changed /= b then
				has_changed := b
				if has_changed then
					if p /= Void then
						p.incremente_version
					end

					if apply_button /= Void then
						apply_button.enable_sensitive
					end
					reset_button.enable_sensitive
				else
					if apply_button /= Void then
						apply_button.disable_sensitive
					end
					reset_button.disable_sensitive
				end
			end
		end

	update
			-- Update all elements after changes.
		do
			load_dbg_options
		end

	on_show
		local
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			if profiles_grid /= Void then
				l_selected_rows := profiles_grid.selected_rows
				if not l_selected_rows.is_empty then
					l_selected_rows.first.ensure_visible
				end
			end
		end

feature -- Data change

	new_profile: like profile_from_row
			-- New empty profile
		do
			create Result.make
			update_title (Result)
		ensure
			Result_not_void: Result /= Void
		end

	update_title (p: like new_profile)
			-- Update profile's title of `p'
			-- with a new unused name
		require
			p_not_void: p /= Void
		local
			s32, s: STRING_32
			args: STRING
			i: INTEGER
		do
			if p.title = Void or else p.title.is_empty then
				args := p.arguments
				if not args.is_empty then
					s32 := args.to_string_32
					from
						i := 1
						create s.make_from_string (s32)
					until
						profile_named (s) = Void
					loop
						s.keep_head (s32.count)
						s.append_character (' ')
						s.append_character ('#')
						s.append_integer (i)
						i := i + 1
					end
					s32 := s
				else
					s32 := interface_names.l_profile
					from
						i := 1
						create s.make_from_string (s32)
					until
						s.count > s32.count and then profile_named (s) = Void
					loop
						s.keep_head (s32.count)
						s.append_character (' ')
						s.append_character ('#')
						s.append_integer (i)
						i := i + 1
					end
					s32 := s
				end
				p.set_title (s32)
			end
		ensure
			title_not_empty: p.title /= Void and then not p.title.is_empty
		end

	same_string_value (s1, s2: STRING_GENERAL): BOOLEAN
			-- is `s1' and `s2' the same text ?
		require
			same_type: (s1 /= Void and s2 /= Void) implies s1.same_type (s2)
		do
			if s1 = Void and s2 = Void then
				Result := True
			elseif s1 = Void or s2 = Void then
				Result := False
			else --| s1 /= Void and s2 /= Void
				Result := s1.same_string (s2)
			end
		end

	change_title_on (v: STRING_32; p: like profile_from_row)
		require
			v /= Void
		local
			s: STRING_32
			old_title: STRING_32
		do
			old_title := p.title
			if v.is_empty then
				s := Void
			else
				s := v.as_string_32
			end
			p.set_title (s)
			update_title (p)

			if not same_string_value (old_title, p.title) then
				update_title_row_of (p)
				set_changed (p, True)
			end
		end

	change_cwd_on (v: STRING; p: like profile_from_row)
		require
			v /= Void
			p /= Void
		local
			s: STRING
		do
			if v.is_empty then
				s := Void
			else
				s := v
			end
			if not same_string_value (p.working_directory, s) then
				p.set_working_directory (s)
				update_title_row_of (p)
				set_changed (p, True)
			end
		end

	change_args_on (v: STRING; p: like profile_from_row)
		require
			v /= Void
			p /= Void
		local
			s: STRING
		do
			if v.is_empty then
				s := Void
			else
				s := v
			end
			if not same_string_value (p.arguments, s) then
				p.set_arguments (s)
				update_title_row_of (p)
				set_changed (p, True)
			end
		end

	change_env_on (v: HASH_TABLE [STRING_32, STRING_32]; p: like profile_from_row)
		require
			p /= Void
		do
			if v = Void or else v.is_empty then
				p.set_environment_variables (Void)
			else
				p.set_environment_variables (v)
			end
			update_title_row_of (p)
			set_changed (p, True)
		end

	update_title_row_of (p: like profile_from_row)
		local
			l_row: EV_GRID_ROW
		do
			l_row := grid_row_with_profile (p)
			if l_row /= Void then
				refresh_title_row_text (l_row)
			end
		end

feature {EB_ARGUMENT_DIALOG} -- Status change

	apply_changes
			--
		require
			has_changed: has_changed
		do
			store_dbg_options
		ensure
			not_has_changed: not has_changed
		end

	reset_changes
			--
		require
			has_changed: has_changed
		do
			load_dbg_options
		ensure
			not_has_changed: not has_changed
		end

	validate
			-- Update the selected profile in user options
		local
			sp, p: like profile_from_row
			l_uuid, k: UUID
		do
			if attached debugger_manager.profiles as l_profs then
				sp := selected_profile
				if sp = Void then
					l_profs.set_last_profile (Void) -- Default profile
				else
					l_uuid := sp.uuid
					from
						l_profs.start
					until
						l_profs.after or p /= Void
					loop
						k := l_profs.key_for_iteration
						if k /= Void and then k ~ l_uuid then
							--| Let's consider it as same profile.
							p := l_profs.item_for_iteration
						end
						l_profs.forth
					end
					if p /= Void then
						l_profs.set_last_profile (p)
					end
				end
			end
		end

feature {NONE} -- Button Actions

	add_new_profile
			-- Add a new profile
		local
			r: EV_GRID_ROW
		do
			profiles_grid.remove_selection
			r := added_profile_text_row (new_profile, True)
			if r.is_expandable and then not r.is_expanded then
				r.expand
			end
		end

	duplicate_selected_profile
			-- Duplicate selected profile
		local
			r: EV_GRID_ROW
			p: like profile_from_row
		do
			r := profiles_grid.single_selected_row
			profiles_grid.remove_selection
			if r /= Void then
				p := profile_from_row (r)
				if p /= Void then
					p := p.duplication (True)
					if p.title = Void then
						p.set_title (description_from_profile (p))
					end
					p.set_title (interface_names.m_copy_of (p.title))
					r := added_profile_text_row (p, True)
					if r.is_expandable and then not r.is_expanded then
						r.expand
					end
				end
			end
		end

	remove_selected_profile
			-- Remove selected profile
		local
			r: EV_GRID_ROW
		do
			r := profiles_grid.single_selected_row
			if r /= Void then
				r := r.parent_row_root
				profiles_grid.remove_row (r.index)
			end
			set_changed (Void, True)
		end

	profile_named (a_name: STRING_32): like profile_from_row
			-- Profile named `a_name' if any
		local
			r: INTEGER_32
			l_row: EV_GRID_ROW
		do
			if profiles_grid.row_count > 0 then
				from
					r := 1
				until
					r > profiles_grid.row_count or Result /= Void
				loop
					l_row := profiles_grid.row (r)
					Result := profile_from_row (l_row)
					if Result /= Void and then not same_string_value (a_name, Result.title) then
						Result := Void
					end
					r := r + l_row.subrow_count_recursive + 1
				end
			end
		end

	profiles_count: INTEGER
			-- Number of displayed profiles.
		local
			r: INTEGER
		do
			if profiles_grid.row_count > 0 then
				from
					r := 1
				until
					r > profiles_grid.row_count
				loop
					Result := Result + 1
					r := r + profiles_grid.row (r).subrow_count_recursive + 1
				end
			end
		end

feature {NONE} -- Queries

	description_from_profile (a_profile: like profile_from_row): STRING_32
			-- String describing `a_profile'.
		local
			params: DEBUGGER_EXECUTION_PROFILE
		do
			create Result.make (5)
			if not a_profile.arguments.is_empty then
				Result.append ("%"" + a_profile.arguments + "%"")
			end
			if not a_profile.working_directory.is_empty then
				Result.append (" ")
				Result.append (interface_names.l_cwd (params.working_directory))
			end
			if a_profile.environment_variables /= Void and then not a_profile.environment_variables.is_empty then
				Result.append (" (")
				Result.append (interface_names.l_variable_count (a_profile.environment_variables.count))
				Result.append (")")
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Profile actions

	added_profile_text_row (a_profile: like profile_from_row; is_selected: BOOLEAN): EV_GRID_ROW
			-- Action to take when user chooses to add a new argument.
			-- if `store_arguments' is true, store_arguments if any change occurred
		do
			if a_profile = Void then
				Result := profiles_grid.extended_new_row
				Result.set_data (Void)
				add_title_to_row (Void, Result)
			else
				Result := grid_row_with_profile (a_profile)
				if Result = Void then
					Result := profiles_grid.extended_new_row
					Result.set_data (a_profile)

						-- Entitled the row `a_row'
					add_title_to_row (a_profile, Result)
					Result.expand_actions.extend_kamikaze (agent fill_row_from_embedded_profile (Result))
					if is_selected then
						Result.ensure_visible
						Result.enable_select
						profiles_grid.safe_resize_column_to_content (profiles_grid.column (1), False, False)
					end
					set_changed (a_profile, True)
				end
			end
		end

	fill_row_from_embedded_profile (a_row: EV_GRID_ROW)
		require
			a_row_not_void: a_row /= Void
			row_has_embedded_profile: profile_from_row (a_row) /= Void
		local
			p: like profile_from_row
			gi: EV_GRID_LABEL_ITEM
			srow: EV_GRID_ROW
			l_title: STRING_32
			l_args: STRING
			l_cwd: STRING
			l_env: HASH_TABLE [STRING_32, STRING_32]
			gdi: EV_GRID_DIRECTORY_ITEM
			gti: EV_GRID_TEXT_ITEM
			gli: EV_GRID_LABEL_ITEM
			ctrler: ES_GRID_ROW_CONTROLLER
			was_expanded: BOOLEAN
			s: STRING
			was_changed: BOOLEAN
		do
			was_changed := has_changed
			p := profile_from_row (a_row)
			l_title := p.title
			l_cwd := p.working_directory
			l_args := p.arguments
			l_env := p.environment_variables

				-- Clean a_row
			if a_row.subrow_count > 0 then
				was_expanded := a_row.is_expanded
				a_row.parent.remove_rows (a_row.index + 1, a_row.index + a_row.subrow_count_recursive)
			end

				--| Arguments
			a_row.insert_subrow (a_row.subrow_count + 1)
			srow := a_row.subrow (a_row.subrow_count)
			create gi.make_with_text (interface_names.l_arguments)
			srow.set_item (1, gi)
			s := l_args
			check s /= Void end

			create gti.make_with_text (s)
			gti.set_dialog_title (interface_names.l_edit_text)
			gti.set_ok_button_string (interface_names.b_ok)
			gti.set_reset_button_string (interface_names.b_reset)
			gti.set_cancel_button_string (interface_names.b_cancel)
			gti.disable_multiline_string
			gti.change_actions.extend (agent
					(a_prof: like profile_from_row; a_gi: EV_GRID_LABEL_ITEM)
						do
							change_args_on (a_gi.text, a_prof)
						end (p, gti)
				)
			srow.set_item (2, gti)

				--| Working directory						
			a_row.insert_subrow (a_row.subrow_count + 1)
			srow := a_row.subrow (a_row.subrow_count)
			create gi.make_with_text (interface_names.l_working_directory)
			srow.set_item (1, gi)
			s := l_cwd
			if s = Void then
				s := ""
			end
			create gdi.make_with_text (s)
			gdi.change_actions.extend (agent
					(a_prof: like profile_from_row; a_gi: EV_GRID_LABEL_ITEM)
							do
								change_cwd_on (a_gi.text, a_prof)
							end (p, gdi)
				)
			gdi.set_start_directory (default_working_directory)
			srow.set_item (2, gdi)

				--| Environment
			a_row.insert_subrow (a_row.subrow_count + 1)
			srow := a_row.subrow (a_row.subrow_count)
			create gi.make_with_text (interface_names.l_environment)
			srow.set_item (1, gi)
			if l_env /= Void then
				fill_row_with_environment (srow, l_env)
			end

			create gli.make_with_text (interface_names.l_add_a_valuable)
			gli.set_tooltip (interface_names.f_add_a_new_variable)

			gli.pointer_button_press_actions.force_extend (agent on_environment_variables_row_clicked (srow, ?,?,?))
			gli.set_font (Operation_font)
			srow.set_item (2, gli)
			create ctrler

			ctrler.set_key_pressed_action (agent (r: EV_GRID_ROW; k: EV_KEY)
						do
							if k /= Void then
								inspect k.code
								when {EV_KEY_CONSTANTS}.key_enter then
									if ev_application.ctrl_pressed then
										on_environment_variables_row_clicked (r, 0,0,3)
									else
										on_new_environ_event (r)
									end
								else
								end
							end
						end(srow, ?)
					)
			srow.set_data (ctrler)
			gli.pointer_double_press_actions.force_extend (agent on_new_environ_event (srow))

			if was_expanded and then a_row.is_expandable then
				a_row.expand
			end
			profiles_grid.safe_resize_column_to_content (profiles_grid.column (1), False, False)
			profiles_grid.safe_resize_column_to_content (profiles_grid.column (2), False, False)
			if not was_changed then
				set_changed (p, was_changed)
			end
		end

	add_title_to_row (p: like profile_from_row; a_row: EV_GRID_ROW)
			-- Add title items to `a_row' for profile `p'
		require
			a_row /= Void
		local
			l_master_item: EV_GRID_EDITABLE_SPAN_LABEL_ITEM
			l_item: EV_GRID_SPAN_LABEL_ITEM
		do
			a_row.set_data (p)

			create l_master_item.make_master (1)
			l_master_item.set_font (title_font)
			a_row.set_item (1, l_master_item)


			create l_item.make_span (1)
			a_row.set_item (2, l_item)
			a_row.set_background_color (profiles_grid.separator_color)

			refresh_title_row_text (a_row)
			if p /= Void then
				-- DEBUG --
				l_master_item.set_tooltip (p.debug_output)

				a_row.item (1).pointer_double_press_actions.force_extend (agent l_master_item.activate)
				l_master_item.deactivate_actions.extend (agent (ia_master_item: EV_GRID_EDITABLE_SPAN_LABEL_ITEM)
						do
							if
								attached ia_master_item.row as l_row and then
								attached profile_from_row (l_row) as ia_p
							then
								change_title_on (ia_master_item.text, ia_p)
							end
						end(l_master_item)
					)
				a_row.item (2).pointer_double_press_actions.force_extend (agent l_master_item.activate)
				a_row.ensure_expandable
			end
			set_changed (p, True)
		end

	refresh_title_row_text (a_row: EV_GRID_ROW)
			-- Refresh `a_row' by recomputing the title's text related to `a_row'
		require
			a_row /= Void
		local
			p: like profile_from_row
			s: STRING_32
		do
			p := profile_from_row (a_row)
			if p = Void then
				s := interface_names.l_default
			else
				s := p.title
				if s = Void or else s.is_empty then
					s := description_from_profile (p).as_string_32
				end
			end
			if attached {EV_GRID_SPAN_LABEL_ITEM} a_row.item (1) as l_item then
				l_item.set_text (s)
			else
				check False end
			end
		end

	profile_from_row (a_row: EV_GRID_ROW): detachable DEBUGGER_EXECUTION_PROFILE
			-- Profile related to `a_row'.
		require
			a_row_not_void: a_row /= Void
		do
			Result ?= a_row.parent_row_root.data
		end

	grid_row_with_profile (a_profile: like profile_from_row): EV_GRID_ROW
			-- Grid's row related to `a_profile'.
		require
			a_profile_not_void: a_profile /= Void
		local
			r: INTEGER
			p: like profile_from_row
		do
			from
				r := 1
			until
				r > profiles_grid.row_count or Result /= Void
			loop
				p := profile_from_row (profiles_grid.row (r))
				if p /= Void and then p.is_equal (a_profile) then
					Result := profiles_grid.row (r)
				end
				r := r + 1
			end
		end

feature {NONE} -- Environment queries

	environment_from_row (a_row: EV_GRID_ROW): HASH_TABLE [STRING_32, STRING_32]
			-- Environment bloc related to `a_row'.
		require
			a_row /= Void
		local
			p: like profile_from_row
		do
			p := profile_from_row (a_row)
			if p /= Void then
				Result := p.environment_variables
			end
		end

	environment_variable_name_from_row (a_row: EV_GRID_ROW): STRING_32
			-- Environment variable name related to `a_row'.
		require
			a_row /= Void
		do
			if attached {ES_GRID_ROW_CONTROLLER} a_row.data as ctrler then
				Result ?= ctrler.data
			else
				Result ?= a_row.data
			end
		end

feature {NONE} -- Environment actions

	fill_row_with_environment (a_row: EV_GRID_ROW; env: like environment_from_row)
			-- Fill `a_row' with environment `env'
		require
			a_row_not_void: a_row /= Void
			env_not_void: env /= Void
		do
			if a_row.subrow_count > 0 then
				a_row.parent.remove_rows (a_row.index + 1, a_row.index + a_row.subrow_count_recursive)
			end
			if env.count > 0 then
				from
					env.start
				until
					env.after
				loop
					add_env_to_row (a_row, env.key_for_iteration, env.item_for_iteration, 0)
					env.forth
				end
			end
		end

	add_env_to_row (a_row: EV_GRID_ROW; k,v: STRING_32; editing_ith: INTEGER)
			-- Add a new environment variable `k'=`v' to `a_row'
			-- if `editing_ith' is not 0, edit the `editing_ith'
		require
			a_row_not_void: a_row /= Void
			valid_arguments: k /= Void or else (k = Void and v = Void)
		local
			srow: EV_GRID_ROW
			gei: EV_GRID_EDITABLE_ITEM
			gti: EV_GRID_TEXT_ITEM
			ctrler: ES_GRID_ROW_CONTROLLER
			s: STRING
		do
			a_row.insert_subrow (a_row.subrow_count + 1)
			srow := a_row.subrow (a_row.subrow_count)
			create ctrler
			ctrler.set_data (k)
			srow.set_data (ctrler)

				-- VarName item
			create gei
			if k /= Void then
				gei.set_text (k)
			end
				-- VarValue item
			create gti
			gti.set_dialog_title (interface_names.l_edit_text)
			gti.set_ok_button_string (interface_names.b_ok)
			gti.set_reset_button_string (interface_names.b_reset)
			gti.set_cancel_button_string (interface_names.b_cancel)

			if v /= Void then
				gti.set_text (v)
			elseif k /= Void and then not k.is_empty then
				s := execution_env.get (k)
				if s /= Void then
					gti.set_text (s)
				end
			end
			gti.disable_multiline_string

			gei.activate_actions.extend (agent add_edition_tab_action_to_item (gti, ?))
			gti.activate_actions.extend (agent add_edition_tab_action_to_item (gei, ?))

			gei.deactivate_actions.extend (agent change_environment_entry_from_row (srow, False))
			gti.change_actions.extend (agent change_environment_entry_from_row (srow, False))
			gti.deactivate_actions.extend (agent change_environment_entry_from_row (srow, False))

			gei.pointer_button_press_actions.force_extend (agent on_environment_variable_clicked (srow, ?,?,?))
			gti.pointer_button_press_actions.force_extend (agent on_environment_variable_clicked (srow, ?,?,?))

			srow.set_item (1, gei)
			srow.set_item (2, gti)

			refresh_environ_row (srow)

			ctrler.set_key_pressed_action (agent (a_gei: EV_GRID_EDITABLE_ITEM; a_key: EV_KEY)
						do
							check a_gei.row /= Void end
							if a_key /= Void then
								inspect a_key.code
								when {EV_KEY_CONSTANTS}.key_delete then
									a_gei.remove_text
									change_environment_entry_from_row (a_gei.row, True)
								when {EV_KEY_CONSTANTS}.key_enter then
									a_gei.activate
								else
								end
							end
						end(gei, ?)
					)

			if editing_ith > 0 then
				if a_row.is_expandable and then not a_row.is_expanded then
					a_row.expand
				end
				srow.ensure_visible
				srow.parent.remove_selection
				srow.enable_select
				if editing_ith = 2 then
					gti.activate
				else
					gei.activate
				end
			end
			set_changed (profile_from_row (a_row), True)
		end

	refresh_environ_row (a_row: EV_GRID_ROW)
			-- Refresh environment variabel row `a_row' items
		require
			a_row /= Void and then a_row.item(1) /= Void
		local
			gei: EV_GRID_EDITABLE_ITEM
			gti: EV_GRID_TEXT_ITEM
			old_k, k: STRING_32
			s, sv: STRING
			ctrler: ES_GRID_ROW_CONTROLLER
		do
			gei ?= a_row.item (1)
			if gei /= Void then
					--| Embedded data				
				ctrler ?= a_row.data
				check ctrler /= Void end

				old_k ?= ctrler.data

				k := gei.text
				k.left_adjust
				k.right_adjust
				ctrler.set_data (k)

					--| Check if it is "inherited" variable
					--| And update the graphical look
				if old_k = Void then
						--| New environ variable row
					a_row.set_background_color (Void)
					gei.remove_pixmap
					gei.set_tooltip (Void)
					a_row.set_foreground_color (Void)
				elseif k /= Void and then k.is_empty then
					a_row.set_background_color (stock_colors.red)
					gei.set_pixmap (mini_stock_pixmaps.debugger_error_icon)
					gei.set_tooltip (Void)
					a_row.set_foreground_color (Void)
				else
					s := Execution_env.get (k)
					if s = Void then
						a_row.set_background_color (Void)
						gei.set_pixmap (stock_pixmaps.debugger_object_watched_disabled_icon)
						gei.set_tooltip (Void)
						a_row.set_foreground_color (Void)
					else
						gti ?= a_row.item (2)
						sv := gti.text
						if s.is_equal (sv) then
							a_row.set_background_color (inherit_color)
						else
							a_row.set_background_color (override_color)
						end

						gei.set_pixmap (stock_pixmaps.debugger_object_watched_icon)
						gei.set_tooltip (interface_names.f_original_value_is (k, s))
					end
				end
			end
		end

	on_new_environ_event (a_row: EV_GRID_ROW)
			-- New environ variable event on a_row
		require
			a_row /= Void
		do
			add_env_to_row (a_row, Void, Void, 1) --"name_" + (a_row.subrow_count + 1).out, "enter value", True)
		end

	on_environment_variables_row_clicked (a_row: EV_GRID_ROW; ax,ay, abut:INTEGER_32)
		local
			m: EV_MENU
			malpha: EV_MENU
			mi: EV_MENU_ITEM
			lst: DS_LIST [STRING_32]
			ch: CHARACTER_32
			k: STRING_32
		do
			if abut = 3 then
				create m.make_with_text (interface_names.m_use_current_environment_variables)
				create mi.make_with_text (m.text)
				mi.disable_sensitive
				m.extend (mi)
				m.extend (create {EV_MENU_SEPARATOR})

				lst := sorted_environment_variables
				from
					lst.start
				until
					lst.after
				loop
					k := lst.item_for_iteration
					if ch /= k.item(1) then
						ch := k.item (1)
						create malpha.make_with_text (create {STRING_32}.make_filled (ch, 1))
						m.extend (malpha)
					end
					check malpha /= Void end
					create mi.make_with_text (k)
					mi.select_actions.extend (agent add_env_to_row (a_row, k, Void, 2))
					malpha.extend (mi)
					lst.forth
				end
				if ax + ay /= 0 then
					m.show
				else
					m.show_at (profiles_grid, profiles_grid.width // 3, a_row.virtual_y_position - profiles_grid.virtual_y_position)
				end
			end
		end

	on_environment_variable_clicked (a_row: EV_GRID_ROW; ax,ay, abut:INTEGER_32)
			-- Environment variable row is clicked
		require
			a_row /= Void
			a_row.parent /= Void
		local
			gei: EV_GRID_EDITABLE_ITEM
			gti: EV_GRID_TEXT_ITEM
			k: STRING_32
			s: STRING
			m, mmi: EV_MENU
			mi: EV_MENU_ITEM
		do
			if
				abut = 3
				and not ev_application.ctrl_pressed
				and not ev_application.alt_pressed
				and not ev_application.shift_pressed
			then
--				a_row.enable_select

				create m.make_with_text (interface_names.m_environment_variables)
				gei ?= a_row.item (1)
				k := gei.text
				if k.is_empty then
					create mi.make_with_text (interface_names.b_delete_command)
					mi.select_actions.extend (agent safe_remove_env_row (a_row))
					m.extend (mi)
				else
					create mmi.make_with_text (k)
					s := execution_env.get (k)
					if s /= Void then
						gti ?= a_row.item (2)
						check gti /= Void end
						create mi.make_with_text_and_action (interface_names.m_use_current_environment_value, agent gti.set_text (s))
						mmi.extend (mi)
					end
					create mi.make_with_text (interface_names.b_delete_command)
					mi.select_actions.extend (agent safe_remove_env_row (a_row))
					mmi.extend (mi)

					m.extend (mmi)
				end

				m.extend (create {EV_MENU_SEPARATOR})
				create mi.make_with_text (interface_names.m_add_new_variable)
				mi.select_actions.extend (agent on_new_environ_event (a_row.parent_row))
				mi.select_actions.extend (agent change_environment_entry_from_row (a_row, True))
				m.extend (mi)

				m.show
			end
		end

	change_environment_entry_from_row (a_row: EV_GRID_ROW; safe_grid_operation: BOOLEAN)
			-- Change environment related to `a_row'
		require
			a_row_parented: a_row /= Void and then a_row.parent /= Void
			a_row.item(1) /= Void and a_row.item (2) /= Void
		local
			p: like profile_from_row
			env: like environment_from_row
			gli: EV_GRID_LABEL_ITEM
			k,v: STRING_32
			old_k: STRING_32
			c: BOOLEAN
		do
			if safe_grid_operation or else not inside_row_operation then
				old_k := environment_variable_name_from_row (a_row)
				p := profile_from_row (a_row)
				check p /= Void end
				env := p.environment_variables
				if env = Void then
					create env.make (3)
				end
					--| Get Key
				gli ?= a_row.item (1)
				check gli /= Void end
				k := gli.text
				k.left_adjust
				k.right_adjust

					--| Get Value
				gli ?= a_row.item (2)
				check gli /= Void end
				v := gli.text

				if k /= Void and then not k.is_empty then
					if old_k = Void then
						c := True
					elseif not k.is_case_insensitive_equal (old_k) then
						env.remove (old_k)
						c := True
					elseif
						not env.has (old_k)
						or else not same_string_value (v, env.item (old_k))
					then
						c := True
					end
					if c then
						env.force (v, k)
						refresh_environ_row	(a_row)
						change_env_on (env, p)
					end
				else
					if old_k /= Void then
						env.remove (old_k)
					end
					refresh_environ_row	(a_row)
					change_env_on (env, p)
				end
			end
			validate_env_row (a_row)
		end

	safe_remove_env_row (a_row: EV_GRID_ROW)
			--
		do
			if a_row /= Void and a_row.parent /= Void then
				remove_env_row (a_row)
			end
		end

	remove_env_row (a_row: EV_GRID_ROW)
			-- Remove environment variable related to `a_row'
		require
			a_row /= Void
			a_row.parent /= Void
		local
			k: like environment_variable_name_from_row
			p: like profile_from_row
			par: EV_GRID_ROW
			r, i: INTEGER
			gi: EV_GRID_ITEM
			g: EV_GRID
		do
			inside_row_operation := True
			if a_row.parent /= Void then
				par := a_row.parent_row
			end
			k := environment_variable_name_from_row (a_row)
			p := profile_from_row (a_row)
			if k /= Void and (p /= Void and then p.environment_variables /= Void) then
				p.environment_variables.remove (k)
			end
			r := a_row.index
			g := a_row.parent
			from
				i := 1
			until
				i > a_row.count
			loop
				gi := a_row.item (i)
				if gi /= Void and then not gi.is_destroyed and then gi.is_parented then
					gi.deactivate
				end
				i := i + 1
			end
			a_row.clear
			g.remove_row (r)
			change_env_on (p.environment_variables, p)
			inside_row_operation := False
			if r > 1 then
				g.select_row (r - 1)
			end
		end

	validate_env_row (a_row: EV_GRID_ROW)
			-- Set `a_row' has error
		require
			a_row /= Void
			a_row.parent /= Void
		local
			k: like environment_variable_name_from_row
			p: like profile_from_row
		do
			k := environment_variable_name_from_row (a_row)
			p := profile_from_row (a_row)
			if k = Void or else k.is_empty then
				if
					k /= Void and
					p /= Void and then
					attached p.environment_variables as envs
				then
					envs.remove (k)
					change_env_on (envs, p)
				end
			end
		end

feature {NONE} -- Environment implementation

	internal_sorted_environment_variables: like sorted_environment_variables

	sorted_environment_variables: DS_LIST [STRING_32]
		do
			Result := internal_sorted_environment_variables
			if Result = Void then
				Result := debugger_manager.sorted_comparable_string32_keys_from (Debugger_manager.environment_variables_table)
				internal_sorted_environment_variables := Result
			end
		end

feature {NONE} -- Implementation

	default_working_directory: STRING
		do
			Result := Eiffel_system.lace.directory_name
			if not file_system.directory_exists (Result) then
					--| If lace.directory_name does not exist,
					--| let's use the project's location
				Result := eiffel_system.project_location.location
			end
		end

	stock_colors: EV_STOCK_COLORS
		once
			create Result
		end

	execution_env: EXECUTION_ENVIRONMENT
		once
			create Result
		end

	title_font: EV_FONT
		once
			create Result
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		end

	operation_font: EV_FONT
		once
			create Result
			Result.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
		end

	override_color: EV_COLOR
			-- Background color for values that do override.
		once
			create Result.make_with_8_bit_rgb (255, 245, 245)
		end

	inherit_color: EV_COLOR
			-- Background color for values that are inherited.
		once
			create Result.make_with_8_bit_rgb (245, 245, 245)
		end

	inside_row_operation: BOOLEAN
			-- Is inside a grid row operation processing.

	add_edition_tab_action_to_item (gi: EV_GRID_ITEM; pop: EV_POPUP_WINDOW)
		local
			acc: EV_ACCELERATOR
		do
			create acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_tab),
							False, False, False)
			acc.actions.extend (agent (a_gi: EV_GRID_ITEM)
				do
					inside_row_operation := True
						-- We need to protect the case when `gi' has already been deactivated.
					if not a_gi.is_destroyed and then a_gi.is_parented then
						a_gi.activate
					end
					inside_row_operation := False
				end (gi)
			)
			pop.accelerators.extend (acc)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end
