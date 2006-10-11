indexing
	description: 	"Abstraction of an control allowing adding, removal and in-place editing of%
					%program arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGING_OPTIONS_CONTROL

inherit

	EV_VERTICAL_BOX
		redefine
			set_focus
		end

	EB_CONSTANTS
		undefine
			default_create, copy, is_equal
		end

	EB_SHARED_INTERFACE_TOOLS
		rename
			mode as text_mode
		undefine
			default_create, copy, is_equal
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_ARGUMENTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: EV_WINDOW) is
			-- Initialization
		require
			parent_not_void: a_parent /= Void
		do
			default_create
			parent_window := a_parent
			set_padding (Layout_constants.Default_padding_size)
			build_interface
			parent_window.show_actions.extend (
				agent
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
				)
			update
		end

feature {NONE} -- Retrieval

	load_dbg_options is
			-- Retrieve and initialize the arguments from user options.
		local
			l_profs: ARRAYED_LIST [like profile_from_row]
			l_user_opts: TARGET_USER_OPTIONS
			l_row: EV_GRID_ROW
			l_prof: like profile_from_row
			i: INTEGER
		do
				--| Reset cached data
			internal_sorted_environment_variables := Void

				--| Load data
			profiles_grid.set_row_count_to (0)
			l_user_opts := lace.user_options.target
			l_profs := l_user_opts.profiles
			if l_profs /= Void and then l_profs.count > 0 then
					--| It is safer to work on a copy to be able to cancel
					--| changes easily
				l_profs := l_profs.deep_twin
				from
					l_profs.start
				until
					l_profs.after
				loop
					l_prof := l_profs.item
					l_row := added_profile_text_row (l_prof, False, False)
					l_profs.forth
				end
				i := l_user_opts.last_profile_index
				if l_profs.valid_index (i) then
					enable_profiles_button.enable_select
					l_prof := l_profs[i]
					l_row := grid_row_with_profile (l_prof)
					if l_row = Void then
						l_row := added_profile_text_row (l_prof, False, True)
					else
--| Issue with grid:	l_row.ensure_visible
						l_row.enable_select
					end
					if l_row.is_expandable and then not l_row.is_expanded then
						l_row.expand
					end
					if profiles_grid.column_count > 0 then
						profiles_grid.safe_resize_column_to_content (profiles_grid.column (1), False, False)
					end
				else
					enable_profiles_button.disable_select
				end
			end
		end

feature -- Storage

	store_dbg_options is
			-- Store the current arguments and set current
			-- arguments for system execution.
		local
			l_profs: ARRAYED_LIST [like profile_from_row]
			l_user_opts: TARGET_USER_OPTIONS
			l_user_factory: USER_OPTIONS_FACTORY
			r: INTEGER
			t: like profile_from_row
			lrow: EV_GRID_ROW
		do
			l_user_opts := lace.user_options.target
			create l_profs.make (profiles_grid.row_count)
			from
				r := 1
			until
				r > profiles_grid.row_count
			loop
				t := profile_from_row (profiles_grid.row (r))
				if t /= Void then
					l_profs.extend (t)
				end
				r := r + 1
			end
			l_user_opts.set_profiles (l_profs)

			if profiles_grid.row_count > 0 and then not profiles_grid.selected_rows.is_empty then
				lrow := profiles_grid.selected_rows.first
				t := profile_from_row (lrow)
				l_user_opts.set_last_profile (t)
			else
				l_user_opts.set_last_profile (Void)
			end

			create l_user_factory
			l_user_factory.store (lace.user_options)
			synch_with_others
		end

feature {NONE} -- GUI

	build_interface is
		local
			vbox: EV_VERTICAL_BOX
		do
			create execution_panel
			extend (execution_panel)

				-- Create all widgets.
			build_display_profiles_box

			create vbox
			vbox.extend (display_profiles_box)
			execution_panel.extend (vbox)

				-- Global actions.
			pointer_leave_actions.extend (agent synch_with_others)
		end

feature {NONE} -- Display profiles impl

	build_display_profiles_box is
		local
			f: EV_FRAME
			g: ES_GRID
			l_border_box,vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			create display_profiles_box
			display_profiles_box.set_padding_width (Layout_constants.Small_padding_size)
			display_profiles_box.set_border_width (Layout_constants.Small_border_size)

			create f.make_with_text ("Debugging options")
			create vb
			f.extend (vb)

			vb.set_padding_width (layout_constants.small_padding_size)
			vb.set_border_width (layout_constants.Small_border_size)

				--| Buttons
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.set_padding_width (layout_constants.small_padding_size)
			create add_button.make_with_text_and_action ("Add Profile", agent add_new_profile)
--			add_button.set_minimum_width (layout_constants.default_button_width)

			create enable_profiles_button.make_with_text ("Enable Profiles")
			enable_profiles_button.select_actions.extend (agent on_enable_profiles_clicked)
--			enable_profiles_button.set_minimum_width (layout_constants.default_button_width)

			create remove_button.make_with_text_and_action ("Remove Profile", agent remove_selected_profile)
--			remove_button.set_minimum_width (layout_constants.default_button_width)

			hb.extend (add_button)
			hb.disable_item_expand (add_button)
			hb.extend (remove_button)
			hb.disable_item_expand (remove_button)
			hb.extend (create {EV_CELL})
			hb.extend (enable_profiles_button)
			hb.disable_item_expand (enable_profiles_button)

				--| Grid
			create g
			profiles_grid := g

			g.enable_tree
			g.hide_header
			g.enable_border
			g.set_separator_color (Stock_colors.color_3d_face)
			g.enable_single_row_selection
			g.enable_default_tree_navigation_behavior (True, True, True, True)
			g.row_select_actions.extend (agent on_row_selected)
			g.row_deselect_actions.extend (agent on_row_unselected)
			g.set_auto_resizing_column (1, True)
			g.pointer_double_press_item_actions.extend (agent on_item_double_clicked)
			g.key_press_actions.extend (agent on_key_pressed)

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

feature {NONE} -- GUI Properties

	execution_panel: EV_VERTICAL_BOX
			-- Frame widget containing argument controls.

	profiles_grid: ES_GRID
			-- Current list of profiles.

	display_profiles_box: EV_VERTICAL_BOX
			-- Widget containing profile settings.

	add_button, remove_button: EV_BUTTON

	enable_profiles_button: EV_CHECK_BUTTON

feature {NONE} -- Grid events

	on_key_pressed (a_key: EV_KEY) is
			-- `a_key' has been pressed on `profiles_grid'
		local
			l_ctler: ES_GRID_ROW_CONTROLLER
			l_row: EV_GRID_ROW
			l_gi: EV_GRID_EDITABLE_ITEM
			c: INTEGER
		do
			l_row := profiles_grid.single_selected_row
			if l_row /= Void then
				l_ctler ?= l_row.data
				if l_ctler /= Void then
					l_ctler.call_key_pressed_action (a_key)
				elseif l_row.count > 0 then
					from
						c := 1
					until
						l_gi /= Void or c > l_row.count
					loop
						l_gi ?= l_row.item (c)
						c := c + 1
					end
					if l_gi /= Void then
						inspect a_key.code
						when {EV_KEY_CONSTANTS}.key_enter then
							l_gi.activate
						else
						end
					end
				end
			end
		end

	on_row_selected (a_row: EV_GRID_ROW) is
			-- `a_row' has been selected
		local
			gi: EV_GRID_SPAN_LABEL_ITEM
			r: EV_GRID_ROW
		do
			if a_row /= Void then
				r := a_row.parent_row_root
				check r /= Void end

--				r.set_background_color (selected_background_color)
				if r = a_row then
					r.set_background_color (profiles_grid.focused_selection_color)
					r.set_foreground_color (profiles_grid.focused_selection_text_color)
				end
--				propagate_background_color_on (r, selected_background_color)
				if r.count > 0 then
					gi ?= r.item (1)
					if gi /= Void then
						gi.set_pixmap (pixmaps.mini_pixmaps.general_next_icon)
						profiles_grid.safe_resize_column_to_content (gi.column, False, False)
					end
				end
				remove_button.enable_sensitive
			end
		end

	on_row_unselected (a_row: EV_GRID_ROW) is
			-- `a_row' has been unselected
		local
			gi: EV_GRID_SPAN_LABEL_ITEM
			r: EV_GRID_ROW
		do
			remove_button.disable_sensitive
			if a_row /= Void then
				r := a_row.parent_row_root
				if r = a_row then
					r.set_background_color (profiles_grid.separator_color)
					r.set_foreground_color (profiles_grid.foreground_color)
				end
--				propagate_background_color_on (r, Void)
				if r.count > 0 then
					gi ?= r.item (1)
					if gi /= Void then
						gi.remove_pixmap
						profiles_grid.safe_resize_column_to_content (gi.column, False, False)
					end
				end
			end
		end

	on_item_double_clicked (ax, ay, ab: INTEGER; gi: EV_GRID_ITEM) is
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

feature -- Status Setting

	synch_with_others is
			-- Synchronize other open controls due to changes in Current.
		local
			mem: MEMORY
			l_control: like Current
			l_controls_list: SPECIAL [ANY]
			l_counter: INTEGER
		do
			create mem
			l_controls_list := mem.objects_instance_of (Current)
			from
				l_counter := 0
			until
				l_counter = l_controls_list.count
			loop
				if l_controls_list.item (l_counter) /= Current then
					l_control ?= l_controls_list.item (l_counter)
					l_control.update
				end
				l_counter := l_counter + 1
			end
		end

	update is
			-- Update all elements after changes.
		do
			load_dbg_options
		end

	set_focus is
			-- Grab keyboard focus.
		do
				-- Set focus to a new argument field or to a check box
				-- to allow arguments if they are not allowed yet.
			if profiles_grid.is_sensitive then
				profiles_grid.set_focus
			else
				enable_profiles_button.set_focus
			end
		end

feature -- Data change

	change_title_on (v: STRING; p: like profile_from_row) is
		require
			v /= Void
		do
			if v.is_empty then
				p.title := Void
			else
				p.title := v
			end
			update_title_row_of (p)
		end

	change_cwd_on (v: STRING; p: like profile_from_row) is
		require
			v /= Void
		do
			if v.is_empty then
				p.cwd := Void
			else
				p.cwd := v
			end
			update_title_row_of (p)
		end

	change_args_on (v: STRING; p: like profile_from_row) is
		require
			v /= Void
		do
			if v.is_empty then
				p.args := Void
			else
				p.args := v
			end
			update_title_row_of (p)
		end

	change_env_on (v: HASH_TABLE [STRING_32, STRING_32]; p: like profile_from_row) is
		require
			v /= Void
		do
			if v.is_empty then
				p.env := Void
			else
				p.env := v
			end
			update_title_row_of (p)
		end

	update_title_row_of (p: like profile_from_row) is
		local
			l_row: EV_GRID_ROW
		do
			l_row := grid_row_with_profile (p)
			if l_row /= Void then
				refresh_title_row_text (l_row)
			end
		end


feature {NONE} -- Button Actions

	add_new_profile is
			-- Add a new profile
		local
			r: EV_GRID_ROW
		do
			profiles_grid.remove_selection
			r := added_profile_text_row (["profile #" + profiles_count.out, Void, Void, Void], True, True)
			if r.is_expandable and then not r.is_expanded then
				r.expand
			end
		end

	on_enable_profiles_clicked is
			-- `enable_profiles_button' has been clicked
		do
			if not enable_profiles_button.is_selected then
				profiles_grid.remove_selection
				set_sensitive_state_on_grid (profiles_grid, False)
			else
				set_sensitive_state_on_grid (profiles_grid, True)
			end
		end

	remove_selected_profile is
			-- Remove selected profile
		local
			r: EV_GRID_ROW
		do
			r := profiles_grid.single_selected_row
			if r /= Void then
				r := r.parent_row_root
				profiles_grid.remove_row (r.index)
			end
		end

	profiles_count: INTEGER is
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

	description_from_profile (a_profile: like profile_from_row): STRING is
			-- String describing `a_profile'.
		do
			create Result.make (5)
			if a_profile.args /= Void then
				Result.append ("%"" + a_profile.args + "%"")
			end
			if a_profile.cwd /= Void and then not a_profile.cwd.is_empty then
				Result.append (" cwd=%"" + a_profile.cwd + "%"")
			end
			if a_profile.env /= Void and then not a_profile.env.is_empty then
				Result.append (" (" + a_profile.env.count.out)
				if a_profile.env.count > 1 then
					Result.append (" variables)")
				else
					Result.append (" variables)")
				end
			end
		end

feature {NONE} -- Profile actions

	added_profile_text_row (a_profile: like profile_from_row; store_right_after: BOOLEAN; is_selected: BOOLEAN): EV_GRID_ROW is
			-- Action to take when user chooses to add a new argument.
			-- if `store_arguments' is true, store_arguments if any change occurred
		do
			if a_profile /= Void then
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
					if store_right_after then
							--| Maybe we should not store right away .. but only on Ok, or Run ...
						store_dbg_options
					end
				end
			end
		end

	fill_row_from_embedded_profile (a_row: EV_GRID_ROW) is
		require
			a_row_not_void: a_row /= Void
			row_has_embedded_profile: profile_from_row (a_row) /= Void
		local
			p: like profile_from_row
			gi: EV_GRID_LABEL_ITEM
			srow: EV_GRID_ROW
			l_title: STRING
			l_args: STRING
			l_cwd: STRING
			l_env: HASH_TABLE [STRING_32, STRING_32]
			gei: EV_GRID_EDITABLE_ITEM
			gdi: EV_GRID_DIRECTORY_ITEM
			gti: EV_GRID_TEXT_ITEM
			gli: EV_GRID_LABEL_ITEM
			ctrler: ES_GRID_ROW_CONTROLLER
			was_expanded: BOOLEAN
			s: STRING
		do
			p := profile_from_row (a_row)
			l_title := p.title
			l_cwd := p.cwd
			l_args := p.args
			l_env := p.env

				-- Clean a_row
			if a_row.subrow_count > 0 then
				was_expanded := a_row.is_expanded
				a_row.parent.remove_rows (a_row.index + 1, a_row.index + a_row.subrow_count_recursive)
			end

				--| Note
			a_row.insert_subrow (a_row.subrow_count + 1)
			srow := a_row.subrow (a_row.subrow_count)
			create gi.make_with_text ("Note")
			srow.set_item (1, gi)
			s := l_title
			if s = Void then
				s := ""
			end
			create gei.make_with_text (s)
			srow.set_item (2, gei)
			gei.deactivate_actions.extend (agent
					(a_prof: like profile_from_row; a_gi: EV_GRID_EDITABLE_ITEM)
						do
							change_title_on (a_gi.text, a_prof)
						end(p, gei)
				)

				--| Working directory						
			a_row.insert_subrow (a_row.subrow_count + 1)
			srow := a_row.subrow (a_row.subrow_count)
			create gi.make_with_text ("Working directory")
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
			gdi.set_start_directory (eiffel_system.project_location.location)
			srow.set_item (2, gdi)

				--| Arguments
			a_row.insert_subrow (a_row.subrow_count + 1)
			srow := a_row.subrow (a_row.subrow_count)
			create gi.make_with_text ("Arguments")
			srow.set_item (1, gi)
			s := l_args
			if s = Void then
				s := ""
			end
			create gti.make_with_text (s)
			gti.disable_multiline_string
			gti.change_actions.extend (agent
					(a_prof: like profile_from_row; a_gi: EV_GRID_LABEL_ITEM)
						do
							change_args_on (a_gi.text, a_prof)
						end (p, gti)
				)
			srow.set_item (2, gti)

				--| Environment
			a_row.insert_subrow (a_row.subrow_count + 1)
			srow := a_row.subrow (a_row.subrow_count)
			create gi.make_with_text ("Environment")
			srow.set_item (1, gi)
			if l_env /= Void then
				fill_row_with_environment (srow, l_env)
			end

			create gli.make_with_text ("Add a variable (double click or Enter); Use an existing variable (right click or Ctrl+Enter)")
			gli.set_tooltip ("[
					Add a new variable : double click or [enter]
					Use an existing variable: right click or [Ctrl+enter]
					]")

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
		end


	add_title_to_row (p: like profile_from_row; a_row: EV_GRID_ROW) is
			-- Add title items to `a_row' for profile `p'
		require
			a_row /= Void
		local
			l_item: EV_GRID_SPAN_LABEL_ITEM
		do
			a_row.set_data (p)

			create l_item.make_master (1)
			l_item.set_font (title_font)
			a_row.set_item (1, l_item)

			create l_item.make_span (1)
			a_row.set_item (2, l_item)
			a_row.set_background_color (profiles_grid.separator_color)

			refresh_title_row_text (a_row)
			a_row.ensure_expandable
		end

	refresh_title_row_text (a_row: EV_GRID_ROW) is
			-- Refresh `a_row' by recomputing the title's text related to `a_row'
		require
			a_row /= Void
			profile_from_row (a_row) /= Void
		local
			p: like profile_from_row
			l_item: EV_GRID_SPAN_LABEL_ITEM
			s: STRING
		do
			p := profile_from_row (a_row)
			s := p.title
			if s = Void or else s.is_empty then
				s := description_from_profile (p)
			end
			l_item ?= a_row.item (1)
			l_item.set_text (s)
		end

	profile_from_row (a_row: EV_GRID_ROW): TUPLE [title:STRING; cwd:STRING; args:STRING; env:HASH_TABLE [STRING_32, STRING_32]] is
			-- Profile related to `a_row'.
		require
			a_row_not_void: a_row /= Void
		do
			Result ?= a_row.parent_row_root.data
		end

	grid_row_with_profile (a_profile: like profile_from_row): EV_GRID_ROW is
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
				if
					p /= Void
					and then p.is_equal (a_profile)
				then
					Result := profiles_grid.row (r)
				end
				r := r + 1
			end
		end


feature {NONE} -- Environment queries

	environment_from_row (a_row: EV_GRID_ROW): HASH_TABLE [STRING_32, STRING_32] is
			-- Environment bloc related to `a_row'.
		require
			a_row /= Void
		local
			p: like profile_from_row
		do
			p := profile_from_row (a_row)
			if p /= Void then
				Result := p.env
			end
		end

	environment_variable_name_from_row (a_row: EV_GRID_ROW): STRING_32 is
			-- Environment variable name related to `a_row'.
		require
			a_row /= Void
		local
			ctrler: ES_GRID_ROW_CONTROLLER
		do
			ctrler ?= a_row.data
			if ctrler /= Void then
				Result ?= ctrler.data
			else
				Result ?= a_row.data
			end
		end

feature {NONE} -- Environment actions

	fill_row_with_environment (a_row: EV_GRID_ROW; env: like environment_from_row) is
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

	add_env_to_row (a_row: EV_GRID_ROW; k,v: STRING_32; editing_ith: INTEGER) is
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

			gei.deactivate_actions.extend (agent change_environment_entry_from_row (srow))
			gti.change_actions.extend (agent change_environment_entry_from_row (srow))

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
									change_environment_entry_from_row (a_gei.row)
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
		end

	refresh_environ_row (a_row: EV_GRID_ROW) is
			-- Refresh environment variabel row `a_row' items
		require
			a_row /= Void and then a_row.item(1) /= Void
		local
			gei: EV_GRID_EDITABLE_ITEM
			gti: EV_GRID_TEXT_ITEM
			k: STRING_32
			s, sv: STRING
			ctrler: ES_GRID_ROW_CONTROLLER
		do
			gei ?= a_row.item (1)
			if gei /= Void then
				k := gei.text
					--| Update embedded data
				ctrler ?= a_row.data
				check ctrler /= Void end
				ctrler.set_data (k)

					--| Check if it is "inherited" variable
					--| And update the graphical look
				s := Execution_env.get (k)
				if s = Void then
					a_row.set_background_color (Void)
					gei.set_pixmap (pixmaps.icon_pixmaps.debugger_object_watched_disabled_icon)
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

					gei.set_pixmap (pixmaps.icon_pixmaps.debugger_object_watched_icon)
					gei.set_tooltip ("Original value is %"" + k + "=" + s + "%"")
				end
			end
		end

	on_new_environ_event (a_row: EV_GRID_ROW) is
			-- New environ variable event on a_row
		require
			a_row /= Void
		do
			add_env_to_row (a_row, Void, Void, 1) --"name_" + (a_row.subrow_count + 1).out, "enter value", True)
		end

	on_environment_variables_row_clicked (a_row: EV_GRID_ROW; ax,ay, abut:INTEGER_32) is
		local
			m: EV_MENU
			malpha: EV_MENU
			mi: EV_MENU_ITEM
			lst: DS_LIST [STRING_32]
			ch: CHARACTER_32
			k: STRING_32
		do
			if abut = 3 then
				create m.make_with_text ("Use current environment variables")
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
					m.show_at (profiles_grid, profiles_grid.width // 3, a_row.virtual_y_position - profiles_grid.viewable_y_offset)
				end
			end
		end

	on_environment_variable_clicked (a_row: EV_GRID_ROW; ax,ay, abut:INTEGER_32) is
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
				a_row.enable_select

				create m.make_with_text ("Environment variables")
				gei ?= a_row.item (1)
				k := gei.text
				if not k.is_empty then
					create mmi.make_with_text (k)
					s := execution_env.get (k)
					if s /= Void then
						gti ?= a_row.item (2)
						check gti /= Void end
						create mi.make_with_text_and_action ("Use current environment value", agent gti.set_text (s))
						mmi.extend (mi)
					end
					create mi.make_with_text ("Delete")
					mi.select_actions.extend (agent remove_env_row (a_row))
					mmi.extend (mi)

					m.extend (mmi)
				end

				m.extend (create {EV_MENU_SEPARATOR})
				create mi.make_with_text ("Add new variable")
				mi.select_actions.extend (agent on_new_environ_event (a_row.parent_row))
				mi.select_actions.extend (agent change_environment_entry_from_row (a_row))
				m.extend (mi)

				m.show
			end
		end

	change_environment_entry_from_row (a_row: EV_GRID_ROW) is
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
		do
			old_k := environment_variable_name_from_row (a_row)
			p := profile_from_row (a_row)
			check p /= Void end
			env := p.env
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
				if not k.is_case_insensitive_equal (old_k) then
					env.remove (old_k)
				end
				env.force (v, k)
				refresh_environ_row	(a_row)
				change_env_on (env, p)
			else
				remove_env_row (a_row)
			end
		end

	remove_env_row (a_row: EV_GRID_ROW) is
			-- Remove environment variable related to `a_row'
		require
			a_row /= Void
			a_row.parent /= Void
		local
			k: like environment_variable_name_from_row
			p: like profile_from_row
			r: INTEGER
			g: EV_GRID
		do
			k := environment_variable_name_from_row (a_row)
			p := profile_from_row (a_row)
			if k /= Void and (p /= Void and then p.env /= Void) then
				p.env.remove (k)
			end
			r := a_row.index
			g := a_row.parent
			g.remove_row (r)
			if r > 1 then
				g.select_row (r - 1)
			end
			change_env_on (p.env, p)
		end

feature {NONE} -- Environment implementation

	internal_sorted_environment_variables: like sorted_environment_variables

	sorted_environment_variables: DS_LIST [STRING_32] is
		do
			Result := internal_sorted_environment_variables
			if Result = Void then
				Result := application.sorted_keys_from_environment_variables (application.debugger_manager.environment_variables_table)
				internal_sorted_environment_variables := Result
			end
		end

feature {NONE} -- Implementation

	stock_colors: EV_STOCK_COLORS is
		once
			create Result
		end

	parent_window: EV_WINDOW
			-- Parent window.

	execution_env: EXECUTION_ENVIRONMENT is
		once
			create Result
		end

	title_font: EV_FONT is
		once
			create Result
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		end

	operation_font: EV_FONT is
		once
			create Result
			Result.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
		end

	Selected_background_color: EV_COLOR
		local
			c1,c2: EV_COLOR
		once
			c1 := profiles_grid.separator_color
			c2 := profiles_grid.focused_selection_color
--			create Result.make_with_8_bit_rgb (190,255,190)
			create Result.make_with_8_bit_rgb (
					(c1.red_8_bit + c2.red_8_bit) // 2,
					(c1.green_8_bit + c2.green_8_bit) // 2,
					(c1.blue_8_bit + c2.blue_8_bit) // 2
				)
		end

	override_color: EV_COLOR is
			-- Background color for values that do override.
		once
			create Result.make_with_8_bit_rgb (255, 245, 245)
		end

	inherit_color: EV_COLOR is
			-- Background color for values that are inherited.
		once
			create Result.make_with_8_bit_rgb (245, 245, 245)
		end

	add_edition_tab_action_to_item (gi: EV_GRID_ITEM; pop: EV_POPUP_WINDOW) is
		local
			acc: EV_ACCELERATOR
		do
			create acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_tab),
							False, False, False)
--			acc.actions.extend (agent gi.enable_select)
			acc.actions.extend (agent gi.activate)
			pop.accelerators.extend (acc)
		end

	set_sensitive_state_on_grid (a_grid: EV_GRID; a_is_sensitive: BOOLEAN) is
		do
			if a_is_sensitive then
				a_grid.enable_sensitive
				a_grid.set_background_color (stock_colors.color_read_write)
			else
				a_grid.disable_sensitive
				a_grid.set_background_color (stock_colors.Color_read_only)
			end
		end

--	propagate_background_color_on (a_row: EV_GRID_ROW; a_color: EV_COLOR) is
--		require
--			a_row /= Void
--			a_row.parent /= Void
--		local
--			g: EV_GRID
--			ri, rmax: INTEGER
--		do
--			g := a_row.parent
--			if a_row.subrow_count > 0 then
--				from
--					ri := a_row.index
--					rmax := a_row.index + a_row.subrow_count_recursive
--				until
--					ri > rmax
--				loop
--					check g.row (ri) /= Void end
--					g.row (ri).set_background_color (a_color)
--					ri := ri + 1
--				end
--			end
--		end

invariant
	parent_not_void: parent_window /= Void

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

end
