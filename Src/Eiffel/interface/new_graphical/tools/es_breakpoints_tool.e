indexing
	description: "Tool that displays breakpoints"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_BREAKPOINTS_TOOL

inherit
	EB_TOOL
		redefine
			menu_name,
			pixmap,
			on_shown
		end

	EB_RECYCLABLE

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	build_interface is
			-- Build all the tool's widgets.
		local
			box: EV_VERTICAL_BOX
		do
			row_highlight_bg_color := Preferences.debug_tool_data.row_highlight_background_color
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.extend (agent set_row_highlight_bg_color)

			create box
			box.set_padding (3)

			create grid
			grid.enable_tree
			grid.enable_single_row_selection
			grid.enable_border

			grid.set_column_count_to (3)
			grid.column (1).set_title ("Data")
			grid.column (2).set_title ("Details")
			grid.column (3).set_title ("Condition")

			grid.pointer_double_press_actions.force_extend (agent on_row_double_clicked)
			grid.set_auto_resizing_column (1, True)
			grid.set_auto_resizing_column (2, True)
			grid.set_auto_resizing_column (3, True)
			grid.row_expand_actions.force_extend (agent grid.request_columns_auto_resizing)
			grid.row_collapse_actions.force_extend (agent grid.request_columns_auto_resizing)

			grid.set_item_pebble_function (agent on_item_pebble_function)
			grid.set_item_accept_cursor_function (agent on_item_pebble_accept_cursor)
			grid.set_item_deny_cursor_function (agent on_item_pebble_deny_cursor)

			box.extend (grid)

			grid.build_delayed_cleaning
			grid.set_delayed_cleaning_action (agent clean_breakpoints_info)
			widget := box
		end

	build_mini_toolbar is
			-- Build the associated tool bar
		local
			scmd: EB_STANDARD_CMD
			tb: EV_TOOL_BAR_BUTTON
		do
			create mini_toolbar

			create scmd.make
			scmd.set_mini_pixmap (pixmaps.small_pixmaps.icon_on_off)
			scmd.set_tooltip ("Display breakpoints separated by status")
			scmd.enable_sensitive
			tb := scmd.new_mini_toolbar_item
			scmd.add_agent (agent toggle_breakpoint_layout_mode (tb))
			mini_toolbar.extend (tb)
			toggle_layout_cmd := scmd

		ensure
			mini_toolbar_exists: mini_toolbar /= Void
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			if mini_toolbar = Void then
				build_mini_toolbar
			end
			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make_with_mini_toolbar (explorer_bar, widget, title, True, mini_toolbar)

			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar_item.show_actions.extend (agent on_bar_item_shown)
			explorer_bar.add (explorer_bar_item)
		end

feature -- Properties

	grid: ES_GRID
			-- Grid containing the breakpoints list

feature -- Access

	mini_toolbar: EV_TOOL_BAR
			-- Associated mini toolbar.

	widget: EV_WIDGET
			-- Widget representing Current.

	title: STRING is
			-- Title of the tool.
		do
			Result := Interface_names.t_Breakpoints_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Breakpoints_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap as it may appear in toolbars and menus.
		do
			Result := Pixmaps.icon_bkpt_info
		end

feature {NONE} -- Commands

	toggle_layout_cmd: EB_STANDARD_CMD

feature -- Events

	on_item_pebble_function (gi: EV_GRID_ITEM): STONE is
		do
			if gi /= Void then
				Result ?= gi.data
			end
		end

	on_item_pebble_accept_cursor (gi: EV_GRID_ITEM): EV_CURSOR is
		local
			st: STONE
		do
			st := on_item_pebble_function (gi)
			if st /= Void then
				Result := st.stone_cursor
			end
		end

	on_item_pebble_deny_cursor (gi: EV_GRID_ITEM): EV_CURSOR is
		local
			st: STONE
		do
			st := on_item_pebble_function (gi)
			if st /= Void then
				Result := st.x_stone_cursor
			end
		end

	on_row_double_clicked is
		local
			row: EV_GRID_ROW
		do
			row := grid.single_selected_row
			if row /= Void then
			end
		end

	refresh is
			-- Class has changed in `development_window'.
		do
			update
		end

	synchronize	is
		do
			update
		end

	on_project_loaded is
		do
			update
		end

	on_shown is
		do
			update
		end

	update is
			-- Refresh `Current's display.
		do
			if eb_debugger_manager.application_initialized then
				grid.request_delayed_clean
				refresh_breakpoints_info
			end
		end

	change_manager_and_explorer_bar (a_manager: EB_TOOL_MANAGER; an_explorer_bar: EB_EXPLORER_BAR) is
			-- Change the window and explorer bar `Current' is in.
		require
			a_manager_exists: a_manager /= Void
			an_explorer_bar_exists: an_explorer_bar /= Void
		do
			if explorer_bar_item.is_visible then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
				-- Link with the manager and the explorer.
			manager := a_manager
			set_explorer_bar (an_explorer_bar)
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
		end

feature {NONE} -- Grid layout Implementation

	grid_layout_manager: ES_GRID_LAYOUT_MANAGER

	record_grid_layout is
		do
			if grid_layout_manager = Void then
				create grid_layout_manager.make (grid, "Breakpoints")
			end
			grid_layout_manager.record
		end

	restore_grid_layout is
		do
			if grid_layout_manager /= Void then
				grid_layout_manager.restore
			end
		end

feature {NONE} -- Implementation

	toggle_breakpoint_layout_mode (tt: EV_TOOLTIPABLE) is
			-- toggle `breakpoints_separated_by_status' mode
		do
			breakpoints_separated_by_status := not breakpoints_separated_by_status
			if breakpoints_separated_by_status then
				tt.set_tooltip ("Display breakpoints separated by status")
			else
				tt.set_tooltip ("All breakpoints together")
			end
			refresh_breakpoints_info
		end

	breakpoints_separated_by_status: BOOLEAN
			-- Display list of breakpoints in two parts
			-- enabled and disabled

	clean_breakpoints_info is
			-- Clean the breakpoints's grid
		do
			record_grid_layout
			grid.default_clean
		end

	refresh_breakpoints_info is
			-- Refresh and recomputed breakpoints's grid
		local
			row: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
			f_list: LIST[E_FEATURE]
			col: EV_COLOR
			app_exec: APPLICATION_EXECUTION
		do
			if shown then
				class_color := preferences.editor_data.class_text_color
				feature_color := preferences.editor_data.feature_text_color
				condition_color := preferences.editor_data.string_text_color

				col := preferences.editor_data.comments_text_color
				app_exec := eb_debugger_manager.application
				grid.call_delayed_clean
				if not app_exec.has_breakpoints then
					grid.insert_new_row (1)
					create lab.make_with_text ("No breakpoints")
					lab.set_foreground_color (col)
					grid.set_item (1, 1, lab)
				else
					if not breakpoints_separated_by_status then
						if app_exec.has_breakpoints then
							f_list := app_exec.features_with_breakpoint_set
							insert_bp_features_list (f_list, Void, True, True)
						end
					else
						if app_exec.has_enabled_breakpoints then
							row := grid.extended_new_row
							row.set_background_color (bg_separator_color)
							create lab.make_with_text ("Enabled")
							lab.set_foreground_color (col)
							row.set_item (1, lab)
							row.set_item (2, create {EV_GRID_ITEM})
							row.set_item (3, create {EV_GRID_ITEM})

							f_list := app_exec.features_with_breakpoint_set
							insert_bp_features_list (f_list, row, True, False)
							row.expand
						end
						if app_exec.has_disabled_breakpoints then
							row := grid.extended_new_row
							row.set_background_color (bg_separator_color)
							create lab.make_with_text ("Disabled")
							lab.set_foreground_color (col)
							row.set_item (1, lab)
							row.set_item (2, create {EV_GRID_ITEM})
							row.set_item (3, create {EV_GRID_ITEM})

							f_list := app_exec.features_with_breakpoint_set
							insert_bp_features_list (f_list, row, False, True)
							row.expand
						end
					end
				end
				grid.request_columns_auto_resizing
				restore_grid_layout
			end
		end

feature {NONE} -- Impl bp

	insert_bp_features_list (routine_list: LIST [E_FEATURE]; a_row: EV_GRID_ROW; display_enabled, display_disabled: BOOLEAN) is
			-- Insert `routine_list' into `a_row'
		require
			routine_list /= Void
		local
			r, sr: INTEGER
			lab: EV_GRID_LABEL_ITEM
			subrow: EV_GRID_ROW

			table: HASH_TABLE [PART_SORTED_TWO_WAY_LIST[E_FEATURE], INTEGER]
			stwl: PART_SORTED_TWO_WAY_LIST [E_FEATURE]
			f: E_FEATURE
			c: CLASS_C
			bp_list: LIST [INTEGER]
			has_bp: BOOLEAN
--			cs: CLASSI_STONE
			cs: CLASSC_STONE
			app_exec: APPLICATION_EXECUTION
		do
				--| Prepare data .. mainly sorting
			from
				create table.make (5)
				routine_list.start
			until
				routine_list.after
			loop
				f := routine_list.item
				c := f.written_class
				stwl := table.item (c.class_id)
				if stwl = Void then
					create stwl.make
					table.put (stwl, c.class_id)
				end
				stwl.extend (f)
				routine_list.forth
			end

				--| Process insertion
			app_exec := debugger_manager.application
			from
				table.start
				r := 1
			until
				table.after
			loop
				stwl := table.item_for_iteration
				c := Eiffel_system.class_of_id (table.key_for_iteration)
				has_bp := False
					--| Check if there are any valid and displayable breakpoints
				from
					stwl.start
				until
					stwl.after or has_bp
				loop
					f := stwl.item
					if display_enabled and display_disabled then
						bp_list := app_exec.breakpoints_set_for (f)
					elseif display_enabled then
						bp_list := app_exec.breakpoints_enabled_for (f)
					else
						bp_list := app_exec.breakpoints_disabled_for (f)
					end
					has_bp := not bp_list.is_empty
					stwl.forth
				end

				if has_bp then
					create lab.make_with_text (c.name_in_upper) --c.lace_class
					lab.set_foreground_color (class_color)
					create cs.make (c)
					lab.set_data (cs)

					if a_row = Void then
						r := grid.row_count + 1
						grid.insert_new_row (r)
						subrow := grid.row (r)
					else
						a_row.insert_subrow (r)
						subrow := a_row.subrow (r)
						r := r + 1
					end

					sr := 1
					subrow.set_item (1, lab)
					subrow.set_item (2, create {EV_GRID_ITEM})
					subrow.set_item (3, create {EV_GRID_ITEM})

					from
						stwl.start
					until
						stwl.after
					loop
						f := stwl.item
						insert_feature_bp_detail (f, subrow, display_enabled, display_disabled)
						stwl.forth
					end
					if subrow.is_expandable then
						subrow.expand
					end
				end
				table.forth
			end
		end

	insert_feature_bp_detail (f: E_FEATURE; a_row: EV_GRID_ROW; display_enabled, display_disabled: BOOLEAN) is
		require
			f /= Void
			a_row /= Void
		local
			bp_list: LIST [INTEGER]
			sorted_bp_list: SORTED_TWO_WAY_LIST [INTEGER]
			s: STRING
			ir, sr: INTEGER
			subrow: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
			first_bp: BOOLEAN
			i: INTEGER
			fs: FEATURE_STONE
			bp: BREAKPOINT
			app_exec: APPLICATION_EXECUTION
		do
			app_exec := eb_debugger_manager.application
			if display_enabled and display_disabled then
				bp_list := app_exec.breakpoints_set_for (f)
			elseif display_enabled then
				bp_list := app_exec.breakpoints_enabled_for (f)
			elseif display_disabled then
				bp_list := app_exec.breakpoints_disabled_for (f)
			end
			if not bp_list.is_empty then
				sr := a_row.subrow_count + 1
				a_row.insert_subrow (sr)
				subrow := a_row.subrow (sr)

				create lab.make_with_text (f.name) -- f
				lab.set_foreground_color (feature_color)
				create fs.make (f)
				lab.set_data (fs)

				subrow.set_item (1, lab)
				from
					s := ""
					first_bp := True
					create sorted_bp_list.make
					sorted_bp_list.fill (bp_list)
					bp_list := sorted_bp_list
					bp_list.start
					ir := 1
					subrow.insert_subrows (bp_list.count, ir)
				until
					bp_list.after
				loop
					i := bp_list.item

					if app_exec.is_breakpoint_set (f, i) then
						bp := app_exec.debug_info.breakpoint (f, i)
						if not first_bp then
							s.append_string (", ")
						else
							first_bp := False
						end
						create lab.make_with_text ("offset " + i.out)
						create fs.make (f)
						lab.set_data (fs)
						subrow.subrow (ir).set_item (1, lab)
						if bp.is_enabled then
							create lab.make_with_text (" enabled")
							if bp.has_condition then
								lab.set_pixmap (Breakable_icons.icon_bp_enabled_condition)
							else
								lab.set_pixmap (Breakable_icons.icon_bp_enabled)
							end
						elseif bp.is_disabled then
							create lab.make_with_text (" disabled")
							if bp.has_condition then
								lab.set_pixmap (Breakable_icons.icon_bp_disabled_condition)
							else
								lab.set_pixmap (Breakable_icons.icon_bp_disabled)
							end
						else
							create lab.make_with_text (" error")
						end
						lab.pointer_button_press_actions.force_extend (agent on_line_cell_right_clicked (f, i, lab, ?, ?, ?))
						subrow.subrow (ir).set_item (2, lab)

						s.append_string (i.out)
						if bp.has_condition then
							if bp.is_disabled then
								s.append_string (Disabled_conditional_bp_symbol)
							else
								s.append_string (Conditional_bp_symbol)
							end
							create lab.make_with_text (bp.condition.expression)
							lab.set_tooltip (lab.text)
							lab.set_font (condition_font)
							subrow.subrow (ir).set_item (3, lab)
						else
							if bp.is_disabled then
								s.append_string (Disabled_bp_symbol)
							else
								subrow.subrow (ir).set_item (3, create {EV_GRID_ITEM})
							end
						end
					else
						create lab.make_with_text ("Error with " + f.name + " line " + i.out)
						subrow.subrow (ir).set_item (2, lab)
					end
					ir := ir + 1
					bp_list.forth
				end
				create lab.make_with_text (s)
				subrow.set_item (2, lab)
				subrow.set_item (3, create {EV_GRID_ITEM})
				subrow.ensure_expandable
			end
		end

	on_line_cell_right_clicked (f: E_FEATURE; i: INTEGER; gi: EV_GRID_ITEM; x, y, button: INTEGER) is
		require
			f /= Void
			i > 0
			gi /= Void
		local
			bp_stone: BREAKABLE_STONE
		do
			grid.remove_selection
			gi.row.enable_select
			if button = 3 then
				create bp_stone.make (f, i)
				bp_stone.display_bkpt_menu
			end
		end

feature {NONE} -- Implementation, cosmetic

	Disabled_bp_symbol: STRING is "-"
	Conditional_bp_symbol: STRING is "*"
	Disabled_conditional_bp_symbol: STRING is "*-"

	Breakable_icons: EB_SHARED_PIXMAPS_12 is
		once
			create Result
		end

	bg_separator_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (220, 220, 240)
		end

	class_color: EV_COLOR
	feature_color: EV_COLOR
	condition_color: EV_COLOR
	condition_font: EV_FONT is
		once
			create Result
			Result.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
		end

	set_row_highlight_bg_color (v: COLOR_PREFERENCE) is
		do
			row_highlight_bg_color := v.value
		end

	row_highlight_bg_color: EV_COLOR;

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
