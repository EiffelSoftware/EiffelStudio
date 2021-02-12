note
	description: "Objects that represents a GRID containing Object values (for debugging)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID

inherit
	ES_GRID
		redefine
			initialize, grid_menu, row_type, on_row_expand, on_row_collapse
		end

	SHARED_DEBUGGER_MANAGER
		undefine
			default_create, copy
		end

	EB_EDITOR_TOKEN_GRID_SUPPORT
		rename
			on_pick_start_from_grid_pickable_item as evs_on_pebble_function
		undefine
			default_create, copy
		redefine
			evs_on_pebble_function
		end

	EB_CONSTANTS
		undefine
			default_create, copy
		end

create
	make_with_name

feature {NONE} -- Initialization

	make_with_name (a_name: like name; a_id: STRING)
			-- Create current with a_name and a_tool
		do
			default_create
			name := a_name
			id := a_id
			enable_multiple_row_selection
			enable_border
			enable_default_tree_navigation_behavior (True, False, True, True)

			load_preferences

			preferences.development_window_data.grid_preferences.change_actions.extend (agent load_preferences)

			preferences.debugger_data.generating_type_evaluation_enabled_preference.typed_change_actions.extend (agent (b: BOOLEAN)
					do
						generating_type_evaluation_enabled := b
					end
				)
		end

	load_preferences
		do
			preferences.development_window_data.grid_preferences.apply_to (Current)
			grid_font := preferences.development_window_data.grid_preferences.font
			title_font.set_height (grid_font.height)
			generating_type_evaluation_enabled := preferences.debugger_data.generating_type_evaluation_enabled_preference.value
		end

	initialize
		do
			Precursor {ES_GRID}
			make_with_grid (Current)

			col_pixmap_index := 1
			col_name_index := 1
			col_value_index := 2
			col_type_index := 3
			col_address_index := 4
			col_scoop_pid_index := 5
			col_context_index := 6

			enable_tree
			enable_row_height_fixed

			enable_partial_dynamic_content
			set_dynamic_content_function (agent compute_grid_item)

			set_item_pebble_function (agent on_pebble_function)
			enable_grid_item_pnd_support

			set_item_accept_cursor_function (agent on_pnd_accept_cursor_function)
			set_item_deny_cursor_function (agent on_pnd_deny_cursor_function)
			pointer_double_press_item_actions.extend (agent on_pointer_double_press_item)
			pointer_button_release_item_actions.extend (agent on_pointer_right_click_item)

			enable_selection_on_single_button_click

			create_kept_object_references
		end

feature {NONE} -- GRID Customization

	row_type: ES_OBJECTS_GRID_ROW do end
		-- Type used for row objects.
		-- May be redefined by EV_GRID descendents.	

feature -- Properties

	grid_font: EV_FONT
			-- Default text/label font.	

	generating_type_evaluation_enabled: BOOLEAN
			-- Is generating type representation evaluating {ANY}.generating_type ?

	name: READABLE_STRING_GENERAL
			-- associated name to identify the related grid.

	id: STRING

	col_pixmap_index: INTEGER

	col_name_index: INTEGER
	col_value_index: INTEGER
	col_type_index: INTEGER
	col_address_index: INTEGER
	col_context_index: INTEGER
	Col_scoop_pid_index: INTEGER

	col_name_id: INTEGER = 1
	col_value_id: INTEGER = 2
	col_type_id: INTEGER = 3
	col_address_id: INTEGER = 4
	col_context_id: INTEGER	= 5
	Col_scoop_pid_id: INTEGER = 6

	slices_cmd: ES_OBJECTS_GRID_SLICES_CMD

feature -- Number formatting

	hexadecimal_mode_enabled: BOOLEAN

	set_hexadecimal_mode (v: BOOLEAN)
		local
			i: INTEGER
		do
			hexadecimal_mode_enabled := v
				--| update objects grid
			from
				i := 1
			until
				i > row_count
			loop
				propagate_hexadecimal_mode (row (i))
				i := i + 1
			end
		end

	propagate_hexadecimal_mode (t: EV_GRID_ROW)
		do
			if attached {ES_OBJECTS_GRID_OBJECT_LINE} t.data as l_eb_t then
				l_eb_t.update_value
			end
		end

feature -- Change

	handle_project_specific_columns
			-- Show or hide scoop pid column
			-- depending if SCOOP concurrency mode is enabled or not.
		do
			if debugger_manager.is_scoop_concurrency_mode then
				show_column (col_scoop_pid_index)
			else
				hide_column (col_scoop_pid_index)
			end
		end

feature -- Change with preferences

	set_columns_layout_from_string_preference (spref: STRING_PREFERENCE)
		require
			default_columns_layout_not_void: default_columns_layout /= Void
		local
			s: STRING
		do
			s := spref.value
			if s = Void or else s.is_empty then
				set_columns_layout (1, default_columns_layout)
				save_columns_layout_to_string_preference (spref)
			else
				set_columns_layout_from_string (spref.value)
			end
		end

	save_columns_layout_to_string_preference (spref: STRING_PREFERENCE)
		local
			s: STRING
		do
			s := columns_layout_to_string
			if s /= Void then
				spref.set_value (s)
			end
		end

	set_columns_layout_from_string (s: STRING)
		require
			s_valid: s /= Void and then not s.is_empty
		local
			dts: ARRAY [detachable like column_layout]
			sp: LIST [STRING]
			i,n: INTEGER
			l_id: INTEGER
			l_displayed: BOOLEAN
			l_autoresize: BOOLEAN
			l_width: INTEGER
			l_title: STRING
			retried: BOOLEAN
		do
			if not retried then
				sp := s.split (':')
				from
					i := 0
					n := sp.count // 5
					create dts.make_filled (Void, 0, n - 1)
					sp.start
				until
					sp.after
				loop
					l_id         := sp.item.to_integer
					sp.forth
					l_displayed  := sp.item.to_boolean
					sp.forth
					l_autoresize := sp.item.to_boolean
					sp.forth
					l_width      := sp.item.to_integer
					sp.forth
					l_title      := sp.item
					sp.forth

					dts[i] :=  [l_id, l_displayed, l_autoresize, l_width, interface_names.find_translation (l_title), l_title]
					i := i + 1
				end
				set_columns_layout (1, dts)
			elseif default_columns_layout /= Void then
				set_columns_layout (col_pixmap_index, default_columns_layout)
			end
		rescue
			retried := True
			retry
		end

	columns_layout_to_string: STRING
		local
			t: like column_layout
			i: INTEGER
			sep: CHARACTER
			retried: BOOLEAN
		do
			if not retried then
				from
					Result := ""
					sep := ':'
					i := 1
				until
					i > column_count
				loop
					t := column_layout (i)
					Result.append_string (t.col_index.out)
					Result.append_character (sep)
					Result.append_string (t.is_displayed.out)
					Result.append_character (sep)
					Result.append_string (t.has_auto_resizing.out)
					Result.append_character (sep)
					Result.append_string (t.width.out)
					Result.append_character (sep)
					Result.append_string (t.title_for_pre)
					Result.append_character (sep)
					i := i + 1
				end
				Result.remove_tail (1)
			end
		rescue
			retried := True
			retry
		end

feature -- Columns layout access

	default_columns_layout: ARRAY [like column_layout]
			-- Default columns layout		

	columns_layout_to_array: like default_columns_layout
		local
			i: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				if column_count = 0 then
					create Result.make_empty
				else
					from
						create Result.make_filled (column_layout (1), 1, column_count)
						i := 2
					until
						i > column_count
					loop
						Result[i] := column_layout (i)
						i := i + 1
					end
				end
			end
		rescue
			retried := True
			retry
		end

	column_layout (c: INTEGER): TUPLE [col_index: INTEGER; is_displayed: BOOLEAN; has_auto_resizing: BOOLEAN; width: INTEGER; title: STRING_GENERAL; title_for_pre: STRING]
		require
			c_positive: c > 0
			c_not_greater_than_column_count: c <= column_count
		local
			col: EV_GRID_COLUMN
			cindex: INTEGER
		do
			col := column (c)
			if c = col_name_index then
				cindex := Col_name_id
			elseif c = col_value_index then
				cindex := Col_value_id
			elseif c = col_type_index then
				cindex := Col_type_id
			elseif c = col_address_index then
				cindex := Col_address_id
			elseif c = col_context_index then
				cindex := Col_context_id
			elseif c = col_scoop_pid_id then
				cindex := Col_scoop_pid_index
			end
			if attached {STRING} col.data as l_str then
				Result := [cindex, col.is_show_requested, column_has_auto_resizing (c), col.width, col.title, l_str]
			else
				check col_data_is_string: False end
				-- Should not occurs
				Result := [cindex, col.is_show_requested, column_has_auto_resizing (c), col.width, col.title, cindex.out]
			end
		end

feature -- Change

	set_default_columns_layout (d: like default_columns_layout)
			-- Set `default_columns_layout' value
		require
			d /= Void
		do
			default_columns_layout	:= d
		end

	set_columns_layout (
				a_col_pixmap_index: INTEGER;
				a_col_details: ARRAY [detachable like column_layout] --| name, address, value, type, context
				)
		require
			a_col_details.count > 0
		local
			i: INTEGER
		do
			if column_count < a_col_details.count then
				set_column_count_to (a_col_details.count)
			end
			col_pixmap_index := a_col_pixmap_index

			from
				i := a_col_details.lower
			until
				i > a_col_details.upper
			loop
				if attached a_col_details[i] as d then
					set_column_layout (1 + i - a_col_details.lower, d)
				end
				i := i + 1
			end
		end

	set_column_layout (a_pos: INTEGER; t: like column_layout)
			-- Index, width, title
		require
			a_pos_positive: a_pos > 0
			a_pos_not_greater_than_column_count: a_pos <= column_count
		local
			c,w: INTEGER
			s: STRING_GENERAL
			col: EV_GRID_COLUMN
		do
			c := t.col_index
			inspect c
			when Col_name_id then
				col_name_index := a_pos
			when Col_value_id then
				col_value_index := a_pos
			when Col_type_id then
				col_type_index := a_pos
			when Col_address_id then
				col_address_index := a_pos
			when Col_context_id then
				col_context_index := a_pos
			when col_scoop_pid_id then
				col_scoop_pid_index := a_pos
			else
			end
			col := column (a_pos)
			w := t.width
			col.set_data (t.title_for_pre)
			if w > 0 then
				s := t.title
				col.set_title (s)
				col.set_width (w)
			end
			if t.is_displayed then
				col.show
			else
				col.hide
			end
			set_auto_resizing_column (c, t.has_auto_resizing)
		end

	set_slices_cmd (v: like slices_cmd)
		do
			slices_cmd := v
		end

feature {ES_OBJECTS_TOOL_PANEL, ES_OBJECTS_GRID_MANAGER, ES_OBJECTS_GRID_LINE, ES_OBJECTS_GRID_SLICES_CMD} -- EiffelStudio specific

	attach_debug_value_from_line_to_grid_row (a_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE; a_line: ES_OBJECTS_GRID_LINE; a_title: STRING_GENERAL)
		require
			dv /= Void
		local
			litem: ES_OBJECTS_GRID_VALUE_LINE
		do
			create litem.make_with_value (dv, Current)
			if a_line /= Void then
				litem.set_related_line (a_line)
			end
			if a_title /= Void then
				litem.set_title (a_title)
			end
			litem.attach_to_row (a_row)
		end

	attach_debug_value_to_grid_row (a_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE; a_title: STRING_GENERAL)
		require
			dv /= Void
		do
			attach_debug_value_from_line_to_grid_row (a_row, dv, Void, a_title)
		end

	attach_dump_value_to_grid_row (a_row: EV_GRID_ROW; a_dumpv: DUMP_VALUE; a_title: STRING_GENERAL)
		local
			litem: ES_OBJECTS_GRID_ADDRESS_LINE
		do
			create litem.make_with_dump_value (a_dumpv, Current)
			if a_title /= Void then
				litem.set_title (a_title)
			end
			litem.attach_to_row (a_row)
		end

	object_line_from_row (a_row: EV_GRID_ROW): ES_OBJECTS_GRID_OBJECT_LINE
		require
			a_row /= Void
		do
			if attached {like object_line_from_row} a_row.data as res then
				Result := res
			end
		end

	objects_grid_item (add: DBG_ADDRESS): ES_OBJECTS_GRID_OBJECT_LINE
		require
			valid_address: add /= Void
		do
			if objects_grid_item_function /= Void then
				Result := objects_grid_item_function.item ([add])
			end
		ensure
			valid_result: Result /= Void implies (
					Result.object_address /= Void
					and then add.is_equal (Result.object_address)
				)
		end

	objects_grid_item_function: FUNCTION [DBG_ADDRESS, like objects_grid_item]
			-- Function used to retrieve the objects_grid objects line related to `addr'.

	set_objects_grid_item_function (fct: like objects_grid_item_function)
		do
			objects_grid_item_function := fct
		end

feature -- Menu

	grid_menu: EV_MENU
		local
			mci: EV_CHECK_MENU_ITEM
			mi: EV_MENU_ITEM
		do
			Result := Precursor
			Result.set_text (interface_names.m_grid_name (name))

			if layout_manager /= Void then
				create mci.make_with_text (interface_names.m_keep_grid_layout)
				if is_layout_managed then
					mci.enable_select
					mci.select_actions.extend (agent disable_layout_management)
				else
					mci.select_actions.extend (agent enable_layout_management)
				end
				Result.put_front (create {EV_MENU_SEPARATOR})
				Result.put_front (mci)
			end
			if default_columns_layout /= Void then
				Result.put_front (create {EV_MENU_SEPARATOR})
				create mi.make_with_text_and_action ("Reset layout", agent set_columns_layout (col_pixmap_index ,default_columns_layout))
				Result.put_front (mi)
			end
		end

feature -- Query

	grid_pnd_details_from_row_and_column (a_row: EV_GRID_ROW; a_col: detachable EV_GRID_COLUMN):
				detachable TUPLE [pebble:ANY; accept_cursor: EV_POINTER_STYLE; deny_cursor: EV_POINTER_STYLE]
			-- Return pnd details which may be contained in `a_row' related to `a_col'.
		do
			if a_row /= Void then
				if attached {ES_GRID_ROW_CONTROLLER} a_row.data as ctler then
					if a_col /= Void then
						Result := ctler.item_pebble_details (a_col.index)
					else
						Result := ctler.item_pebble_details (0)
					end
				end
			end
-- Leave this for debug purpose
--			if Result = Void then
--				Result := ["empty", Void, Void]
--			end
		end

	grid_pebble_from_cell (a_cell: EV_GRID_ITEM): ANY
			-- Return pebble which may be contained in `a_cell'.
		require
			a_cell_not_void: a_cell /= Void
		do
			Result := grid_pebble_from_row_and_column (a_cell.row, a_cell.column)
		end

	grid_pebble_from_row_and_column (a_row: EV_GRID_ROW; a_col: EV_GRID_COLUMN): ANY
			-- Return pebble which may be contained in `a_row' related to `a_col'.
		local
			t: like grid_pnd_details_from_row_and_column
		do
			t := grid_pnd_details_from_row_and_column (a_row, a_col)
			if t /= Void then
				Result := t.pebble
			end
		end

	grid_accept_cursor_from_cell (a_cell: EV_GRID_ITEM): EV_POINTER_STYLE
			-- Return accept_cursor which may be contained in `a_row' related to `a_col'.
		require
			a_cell_not_void: a_cell /= Void
		local
			t: like grid_pnd_details_from_row_and_column
		do
			t := grid_pnd_details_from_row_and_column (a_cell.row, a_cell.column)
			if t /= Void then
				if attached {STONE} t.pebble as s then
					Result := s.stone_cursor
				else
					Result := t.accept_cursor
				end
			end
		end

	grid_deny_cursor_from_cell (a_cell: EV_GRID_ITEM): EV_POINTER_STYLE
			-- Return deny_cursor which may be contained in `a_row' related to `a_col'.
		require
			a_cell_not_void: a_cell /= Void
		local
			t: like grid_pnd_details_from_row_and_column
		do
			t := grid_pnd_details_from_row_and_column (a_cell.row, a_cell.column)
			if t /= Void then
				if attached {STONE} t.pebble as s then
					Result := s.x_stone_cursor
				else
					Result := t.deny_cursor
				end
			end
		end

feature {NONE} -- Actions implementation

	on_row_expand (a_row: EV_GRID_ROW)
			-- <Precursor>
		do
			if attached {ES_GRID_ROW_CONTROLLER} a_row.data as ctler then
				ctler.call_expand_action (a_row)
				process_columns_auto_resizing
			end
			Precursor (a_row)
		end

	on_row_collapse (a_row: EV_GRID_ROW)
			-- <Precursor>
		do
			if attached {ES_GRID_ROW_CONTROLLER} a_row.data as ctler then
				ctler.call_collapse_action (a_row)
			end
			Precursor (a_row)
		end

	on_pebble_function (a_item: EV_GRID_ITEM): ANY
		do
			if
				not ev_application.ctrl_pressed
				and a_item /= Void
			then
				Result := grid_pebble_from_cell (a_item)
			end
		end

	evs_on_pebble_function (a_item: EV_GRID_ITEM; a_orignal_pointer_position: EV_COORDINATE; a_grid_support: EB_EDITOR_TOKEN_GRID_SUPPORT)
		local
			l_pebble: ANY
		do
			l_pebble := on_pebble_function (a_item)
			if l_pebble = Void then
				Precursor {EB_EDITOR_TOKEN_GRID_SUPPORT}(a_item, a_orignal_pointer_position, a_grid_support)
			end
		end

	on_pnd_accept_cursor_function (a_item: EV_GRID_ITEM): EV_POINTER_STYLE
		do
			if
				not ev_application.ctrl_pressed
				and a_item /= Void
			then
				Result := grid_accept_cursor_from_cell (a_item)
				if Result = Void then
						--| FIXME: this is to behave correctly with  EVS_GRID_PND_SUPPORT
						--| when the pebble in providing by EVS_GRID_PND_SUPPORT mechanism.
					Result := implementation.accept_cursor
				end
			end
		end

	on_pnd_deny_cursor_function (a_item: EV_GRID_ITEM): EV_POINTER_STYLE
		do
			if
				not ev_application.ctrl_pressed
				and a_item /= Void
			then
				Result := grid_deny_cursor_from_cell (a_item)
				if Result = Void then
						--| FIXME: this is to behave correctly with  EVS_GRID_PND_SUPPORT
						--| when the pebble in providing by EVS_GRID_PND_SUPPORT mechanism.					
					Result := implementation.deny_cursor
				end
			end
		end

	on_pointer_double_press_item (ax,ay,ab: INTEGER; a_item: EV_GRID_ITEM)
		do
			if ab = 1 then
				if attached {ES_OBJECTS_GRID_CELL} a_item as ei then
					if
						ev_application.ctrl_pressed and then
						attached {EV_GRID_LABEL_ITEM} ei as glab
					then
						ev_application.clipboard.set_text (glab.text)
					else
						activate_grid_item (ei)
					end
				end
			end
		end

	on_pointer_right_click_item (ax,ay,ab: INTEGER; a_item: EV_GRID_ITEM)
			-- Action to be performed when pointer right click on grid
			-- Behavior is launch the stone contained in pointer hovered editor token in a new development window.	
		do
			if
				a_item /= Void and then
				(ab =  {EV_POINTER_CONSTANTS}.right and ev_application.ctrl_pressed)
			then
				if attached {STONE} grid_pebble_from_cell (a_item) as l_stone and then l_stone.is_valid then
					(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_stone)
				end
			end
		end

	compute_grid_item (c, r: INTEGER): EV_GRID_ITEM
		local
			a_row: EV_GRID_ROW
		do
			if not is_processing_remove_and_clear_all_rows then
				if c <= column_count and r <= row_count then
					Result := item (c, r)
				end
				if Result = Void then
					a_row := row (r)
					if attached {ES_OBJECTS_GRID_LINE} a_row.data as obj_item then
						if not obj_item.compute_grid_display_done then
							Result := obj_item.computed_grid_item (c)
-- We don't return the item, since they have already been added to the grid ...
--							if 0 < c and c <= a_row.count then
--								Result := a_row.item (c)
--							end
						else
								--| line already computed .. but still missing cells
								--| then we fill with empty cells
							create Result
						end
					else
						create Result
					end
				end
				request_columns_auto_resizing
			end
			if Result = Void then
				create Result
			end
		end

feature {NONE} -- Grid items activation

	activate_grid_item (ei: EV_GRID_ITEM)
		require
			ei /= Void
		do
			if pre_activation_action /= Void then
				pre_activation_action.call ([ei])
			end
			ei.activate
		end

	pre_activation_action: PROCEDURE [EV_GRID_ITEM]
			-- Called before an item is activated.

feature -- Grid items activation change

	set_pre_activation_action (v: like pre_activation_action)
			-- Set `pre_activation_action' with `v'.
		do
			pre_activation_action := v
		ensure
			pre_activation_action_set: pre_activation_action = v
		end

feature {ES_OBJECTS_GRID_MANAGER} -- Keep object

	create_kept_object_references
		do
			create kept_object_references.make
			kept_object_references.compare_objects
		end

	kept_object_references: LINKED_SET [DBG_ADDRESS]

	clear_kept_object_references
		do
			Debugger_manager.release_object_references (kept_object_references)
			kept_object_references.wipe_out
		end

	keep_object_in_debugger_for_gui_need (add: DBG_ADDRESS)
		require
			application_is_executing: debugger_manager.application_is_executing
		do
			if not kept_object_references.has (add) then
				Kept_object_references.extend (add)
				Debugger_manager.application_status.keep_object (add)
			end
		end

feature {ES_OBJECTS_GRID_MANAGER} -- Layout managment

	grid_objects_on_difference_cb (a_row: EV_GRID_ROW; a_val: ANY)
		do
			debug ("es_grid_layout")
				print ("DIFF:: " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (grid_objects_id_name_from_row (a_row))
					+ " => old=[" + a_val.out + "] new=["
					+ grid_objects_id_value_from_row (a_row, False).out + "]%N")
			end
			a_row.set_background_color (Highlight_different_value_bg_color)
		end

	row_is_ready_for_grid_objects_identification (a_row: EV_GRID_ROW): BOOLEAN
		do
			if a_row.parent /= Void then
				if Col_name_index <= a_row.count then
					Result := a_row.item (Col_name_index) /= Void
				end
			end
		end

	grid_objects_id_name_from_row (a_row: EV_GRID_ROW): STRING_32
		do
			if a_row.parent /= Void then
				if Col_name_index <= a_row.count then
					if attached {EV_GRID_LABEL_ITEM} a_row.item (Col_name_index) as lab then
						Result := lab.text
					end
				end
			end
		end

	grid_objects_id_value_from_row (a_row: EV_GRID_ROW; is_recording_layout: BOOLEAN): ANY
		local
			s: STRING
			addr: detachable DBG_ADDRESS
		do
			if a_row.parent /= Void then
				if attached {like object_line_from_row} object_line_from_row (a_row) as line then
					addr := line.object_address
					if addr /= Void and then not addr.is_void then
						s := addr.output
						if is_recording_layout then
							keep_object_in_debugger_for_gui_need (addr)
							debug ("refactor_fixme")
								fixme ("We should 'adopt' the object in order to be sure the address value will stay the same")
							end
						end
					end
				end
				if s = Void then
					if Col_value_index <= a_row.count then
						s := ""
						if attached {EV_GRID_LABEL_ITEM} a_row.item (Col_value_index) as lab then
							s.append ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (lab.text))
						end
--						if Col_address_index <= a_row.count then
--							if attached {EV_GRID_LABEL_ITEM} a_row.item (Col_address_index) as lab then
--								s.append_string (lab.text)
--							end
--						end
					end
				end
			end
			Result := s
		end

feature -- Layout manager

	layout_preference: BOOLEAN_PREFERENCE

	on_layout_preferenced_changed
		do
			if layout_preference.value then
				if not is_layout_managed then
					enable_layout_management
				end
			else
				if is_layout_managed then
					disable_layout_management
				end
			end
		end

	initialize_layout_management (v: BOOLEAN_PREFERENCE)
		require
			layout_manager_void: layout_manager = Void
			layout_preference = Void
		do
			layout_preference := v
			create layout_manager.make (Current, id)
			if layout_preference /= Void then
				layout_preference.change_actions.extend (agent on_layout_preferenced_changed)
				on_layout_preferenced_changed
			end
			layout_manager.set_row_is_ready_for_identification_agent (agent row_is_ready_for_grid_objects_identification)
			layout_manager.set_identification_agent (agent grid_objects_id_name_from_row)
			layout_manager.set_value_agent (agent grid_objects_id_value_from_row)
			layout_manager.set_on_difference_callback (agent grid_objects_on_difference_cb)
		end

	reset_layout_recorded_values
		do
			if attached layout_manager as m then
				m.reset_layout_recorded_values
			end
			clear_kept_object_references
		end

	reset_layout_manager
		do
			if attached layout_manager as m then
				m.wipe_out
			end
			clear_kept_object_references
		end

	enable_layout_management
		do
			if attached layout_manager as m then
				m.enable
				is_layout_managed := True
				if
					attached layout_preference as p and then
					p.value /= is_layout_managed
				then
					p.set_value (is_layout_managed)
				end
			end
		end

	disable_layout_management
		do
			if attached layout_manager as m then
				m.disable
			end
			is_layout_managed := False
			if
				attached layout_preference as p and then
				p.value /= is_layout_managed
			then
				p.set_value (is_layout_managed)
			end
		end

	is_layout_managed: BOOLEAN

	layout_manager: ES_OBJECTS_GRID_LAYOUT_MANAGER

	record_layout
		local
			old_kept: like kept_object_references
		do
			if is_layout_managed and attached layout_manager as m then
					--| Pre recording
				old_kept := kept_object_references
				create_kept_object_references

					--| Recording
				m.record

					--| Post recording
				Debugger_manager.release_object_references (old_kept)
			end
		end

	restore_layout
		local
			retried: BOOLEAN
		do
			if not retried and is_layout_managed and attached layout_manager as m then
				m.restore
			end
		rescue
			retried := True
			retry
		end

feature -- Graphical look

	Title_font: EV_FONT
		once
			if attached grid_font as ft then
				Result := ft.twin
			else
				create Result
			end
			Result.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
		end

	folder_label_item (s: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
		do
			create Result
			Result.set_font (grid_font)
			grid_cell_set_text (Result, s)
			Result.set_foreground_color (folder_row_fg_color)
		end

	name_label_item (s: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
		do
			create Result
			Result.set_font (grid_font)
			grid_cell_set_text (Result, s)
		end

	message_label_item (s: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
		do
			create Result
			Result.set_font (grid_font)
			grid_cell_set_text (Result, s)
			Result.set_foreground_color (folder_row_fg_color)
		end

	folder_row_fg_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (60,60,190)
		end

	message_row_fg_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 106, 0)
		end

	object_folder_row_fg_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (60,60,190)
		end

	slice_row_fg_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (210, 160, 160)
		end

	disabled_row_fg_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (190, 190, 190)
		end

	error_row_fg_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (190, 130, 130)
		end

	Highlight_different_value_bg_color: EV_COLOR
		local
			l_colors: ES_COLORS
		once
			create l_colors
			Result := l_colors.grid_different_value_background_color
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
