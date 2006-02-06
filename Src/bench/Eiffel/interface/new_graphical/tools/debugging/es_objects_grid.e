indexing
	description: "Objects that represents a GRID containing Object values (for debugging)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID

inherit
	ES_GRID
		redefine
			initialize, grid_menu, row_type
		end

	EB_SHARED_DEBUG_TOOLS
		undefine
			default_create, copy
		end

create
	make_with_name

feature {NONE} -- Initialization

	make_with_name (a_name: STRING; a_id: STRING) is
			-- Create current with a_name and a_tool
		do
			default_create
			name := a_name
			id := a_id
			enable_single_row_selection
			enable_border
		end

	initialize is
		do
			Precursor {ES_GRID}

			col_pixmap_index := 1
			col_name_index := 1
			col_value_index := 2
			col_type_index := 3
			col_address_index := 4
			col_context_index := 5

			enable_tree
			enable_row_height_fixed

			enable_partial_dynamic_content
			set_dynamic_content_function (agent compute_grid_item)

			row_expand_actions.extend (agent on_row_expand)
			row_collapse_actions.extend (agent on_row_collapse)
			set_item_pebble_function (agent on_pebble_function)
			set_item_accept_cursor_function (agent on_pnd_accept_cursor_function)
			set_item_deny_cursor_function (agent on_pnd_deny_cursor_function)
			pointer_double_press_item_actions.extend (agent on_pointer_double_press_item)

			enable_selection_on_single_button_click

			create_kept_object_references
		end

feature {NONE} -- GRID Customization

	row_type: ES_OBJECTS_GRID_ROW is do end
		-- Type used for row objects.
		-- May be redefined by EV_GRID descendents.		

feature -- Properties

	name: STRING
			-- associated name to identify the related grid.

	id: STRING

	col_pixmap_index: INTEGER

	col_name_index: INTEGER
	col_value_index: INTEGER
	col_type_index: INTEGER
	col_address_index: INTEGER
	col_context_index: INTEGER

	col_name_id: INTEGER is 1
	col_value_id: INTEGER is 2
	col_type_id: INTEGER is 3
	col_address_id: INTEGER is 4
	col_context_id: INTEGER	is 5

	slices_cmd: ES_OBJECTS_GRID_SLICES_CMD

feature -- Number formatting

	hexadecimal_mode_enabled: BOOLEAN

	set_hexadecimal_mode (v: BOOLEAN) is
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

	propagate_hexadecimal_mode (t: EV_GRID_ROW) is
		local
			l_eb_t: ES_OBJECTS_GRID_LINE
		do
			l_eb_t ?= t.data
			if l_eb_t /= Void then
				l_eb_t.update_value
			end
		end

feature -- Change with preferences

	set_columns_layout_from_string_preference (spref: STRING_PREFERENCE; dft_value: ARRAY [like column_layout]) is
		local
			dts: ARRAY [like column_layout]
			s: STRING
			sp: LIST [STRING]
			i,n: INTEGER
			l_id: INTEGER
			l_displayed: BOOLEAN
			l_autoresize: BOOLEAN
			l_width: INTEGER
			l_title: STRING
			retried: BOOLEAN
		do
			s := spref.value
			if retried or (s = Void or else s.is_empty) then
				set_columns_layout ( 5, 1, dft_value)
				save_columns_layout_to_string_preference (spref)
			else
				sp := s.split (';')
				from
					i := 0
					n := sp.count // 5
					create dts.make (0, n - 1)
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

					dts[i] :=  [l_id, l_displayed, l_autoresize, l_width, l_title]
					i := i + 1
				end
				set_columns_layout (5, 1, dts)
			end
		rescue
			retried := True
			retry
		end

	save_columns_layout_to_string_preference (spref: STRING_PREFERENCE) is
		local
			t: like column_layout
			i: INTEGER
			s: STRING
			retried: BOOLEAN
		do
			if not retried then
				from
					s := ""
					i := 1
				until
					i > column_count
				loop
					t := column_layout (i)
					s.append_string (t.item (1).out)
					s.append_character (';')
					s.append_string (t.item (2).out)
					s.append_character (';')
					s.append_string (t.item (3).out)
					s.append_character (';')
					s.append_string (t.item (4).out)
					s.append_character (';')
					s.append_string (t.item (5).out)
					s.append_character (';')
					i := i + 1
				end
				s.remove_tail (1)
				spref.set_value (s)
			end
		rescue
			retried := True
			retry
		end

feature -- Change

	set_columns_layout (
				a_cols_count: INTEGER;
				a_col_pixmap_index: INTEGER;
				a_col_details: ARRAY [like column_layout] --| name, address, value, type, context
				) is
		require
			a_col_details.count = 5
			a_cols_count >= a_col_details.count
		local
			i: INTEGER
		do
			set_column_count_to (a_cols_count)
			col_pixmap_index := a_col_pixmap_index

			from
				i := a_col_details.lower
			until
				i > a_col_details.upper
			loop
				set_column_layout (1 + i - a_col_details.lower, a_col_details[i])
				i := i + 1
			end
		end

	set_column_layout (a_pos: INTEGER; t: like column_layout) is
			-- Index, width, title
		require
			a_pos_positive: a_pos > 0
			a_pos_not_greater_than_column_count: a_pos <= column_count
		local
			c,w: INTEGER
			s: STRING
			col: EV_GRID_COLUMN
		do
			c := t.integer_item (1)
			inspect c
			when Col_name_id then
				col_name_index := a_pos
			when Col_address_id then
				col_address_index := a_pos
			when Col_value_id then
				col_value_index := a_pos
			when Col_type_id then
				col_type_index := a_pos
			when Col_context_id then
				col_context_index := a_pos
			else
			end
			col := column (a_pos)
			w := t.integer_item (4)
			if w > 0 then
				s ?= t.item (5)
				col.set_title (s)
				col.set_width (w)
			end
			if t.boolean_item (2) then
				col.show
			else
				col.hide
			end
			set_auto_resizing_column (c, t.boolean_item (3))
		end

	column_layout (c: INTEGER): TUPLE [INTEGER, BOOLEAN, BOOLEAN, INTEGER, STRING] is
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
			elseif c = col_address_index then
				cindex := Col_address_id
			elseif c = col_value_index then
				cindex := Col_value_id
			elseif c = col_type_index then
				cindex := Col_type_id
			elseif c = col_context_index then
				cindex := Col_context_id
			end
			Result := [cindex, col.is_displayed, column_has_auto_resizing (c), col.width, col.title]
		end

	set_slices_cmd (v: like slices_cmd) is
		do
			slices_cmd := v
		end

feature {ES_OBJECTS_TOOL, ES_OBJECTS_GRID_MANAGER, ES_OBJECTS_GRID_LINE, ES_OBJECTS_GRID_SLICES_CMD} -- EiffelStudio specific

	attach_debug_value_from_line_to_grid_row (a_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE; a_line: ES_OBJECTS_GRID_LINE) is
		require
			dv /= Void
		local
			litem: ES_OBJECTS_GRID_VALUE_LINE
		do
			create litem.make_with_value (dv, Current)
			if a_line /= Void then
				litem.set_related_line (a_line)
			end
			litem.attach_to_row (a_row)
		end

	attach_debug_value_to_grid_row (a_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE) is
		require
			dv /= Void
		do
			attach_debug_value_from_line_to_grid_row (a_row, dv, Void)
		end

	object_line_from_row (a_row: EV_GRID_ROW): ES_OBJECTS_GRID_LINE is
		require
			a_row /= Void
		do
			Result ?= a_row.data
		end

	objects_grid_item (add: STRING): ES_OBJECTS_GRID_LINE is
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

	objects_grid_item_function: FUNCTION [ANY, TUPLE [STRING], ES_OBJECTS_GRID_LINE]

	set_objects_grid_item_function (fct: like objects_grid_item_function) is
		do
			objects_grid_item_function := fct
		end

feature -- Menu

	grid_menu: EV_MENU is
		local
			sm: EV_MENU
			mci: EV_CHECK_MENU_ITEM
			c: INTEGER
			s: STRING
			col: EV_GRID_COLUMN
		do
			if layout_manager /= Void then
				create Result.make_with_text ("Grid %"" + name + "%"")

				create mci.make_with_text ("Keep grid layout")
				if is_layout_managed then
					mci.enable_select
					mci.select_actions.extend (agent disable_layout_management)
				else
					mci.select_actions.extend (agent enable_layout_management)
				end
				Result.extend (mci)
				Result.extend (create {EV_MENU_SEPARATOR})
				from
					c := 1
				until
					c > column_count
				loop
					col := column (c)
					if not col.title.is_empty then
						s := "Column %"" + col.title + "%""
					else
						s := "Column #" + c.out
					end
					create sm.make_with_text (s)
					Result.extend (sm)

					create mci.make_with_text ("Auto resize")
					if column_has_auto_resizing (c) then
						mci.enable_select
					end
					mci.select_actions.extend (agent set_auto_resizing_column (c, not column_has_auto_resizing (c)))
					sm.extend (mci)

					create mci.make_with_text ("Displayed")
					if col.is_displayed then
						mci.enable_select
						mci.select_actions.extend (agent col.hide)
					else
						mci.select_actions.extend (agent col.show)
					end
					sm.extend (mci)
					c := c + 1
				end
			end
		end

feature -- Query

	grid_pebble_from_cell (a_cell: EV_GRID_ITEM): ANY is
			-- Return pebble which may be contained in `a_cell'
		do
				--| Nota: At this point we could try to return
				--| special stone depending of the clicked cell
			Result := grid_pebble_from_row (a_cell.row)
		end

	grid_pebble_from_row (a_row: EV_GRID_ROW): ANY is
			-- Return pebble which may be contained in `a_row'
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_row /= Void then
				ctler ?= a_row.data
				if ctler /= Void then
					Result := ctler.pebble
				end
			end
		end

feature {NONE} -- Actions implementation

	on_pebble_function (a_item: EV_GRID_ITEM): ANY is
		do
			if
				not ev_application.ctrl_pressed
				and a_item /= Void
			then
				Result := grid_pebble_from_cell (a_item)
			end
		end

	on_pnd_accept_cursor_function (a_item: EV_GRID_ITEM): EV_CURSOR is
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_item /= Void then
				ctler ?= a_item.row.data
				if ctler /= Void then
					Result := ctler.pnd_accept_cursor
				end
			end
		end

	on_pnd_deny_cursor_function (a_item: EV_GRID_ITEM): EV_CURSOR is
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_item /= Void then
				ctler ?= a_item.row.data
				if ctler /= Void then
					Result := ctler.pnd_deny_cursor
				end
			end
		end

	on_pointer_double_press_item (ax,ay,ab: INTEGER; a_item: EV_GRID_ITEM) is
		local
			ei: ES_OBJECTS_GRID_CELL
		do
			if ab = 1 then
				ei ?= a_item
				if ei /= Void then
					ei.activate
				end
			end
		end

	on_row_expand (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			ctler ?= a_row.data
			if ctler /= Void then
				ctler.call_expand_actions (a_row)
				process_columns_auto_resizing
			end
			request_columns_auto_resizing
		end

	on_row_collapse (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			ctler ?= a_row.data
			if ctler /= Void then
				ctler.call_collapse_actions (a_row)
			end
			request_columns_auto_resizing
		end

	compute_grid_item (c, r: INTEGER): EV_GRID_ITEM is
		local
			a_row: EV_GRID_ROW
			obj_item: ES_OBJECTS_GRID_LINE
		do
debug ("debugger_interface")
	print (generator + ".compute_grid_item ("+c.out+", "+r.out+") %N")
end
			if not is_processing_remove_and_clear_all_rows then
				if c <= column_count and r <= row_count then
					Result := item (c, r)
				end
				if Result = Void then
					a_row := row (r)
					obj_item ?= a_row.data
					if obj_item /= Void then
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
		end

feature {ES_OBJECTS_GRID_MANAGER} -- Keep object

	create_kept_object_references is
		do
			create kept_object_references.make
			kept_object_references.compare_objects
		end

	kept_object_references: LINKED_SET [STRING]

	clear_kept_object_references is
		do
			release_object_references (kept_object_references)
			kept_object_references.wipe_out
		end

	release_object_references (kobjs: LIST [STRING]) is
		local
			st: APPLICATION_STATUS
		do
			if debugger_manager.application_is_executing then
				st := debugger_manager.application.status
				from
					kobjs.start
				until
					kobjs.after
				loop
					st.release_object (kobjs.item)
					kobjs.forth
				end
			end
		end

	keep_object_in_debugger_for_gui_need (add: STRING) is
		do
			if not kept_object_references.has (add) then
				Kept_object_references.extend (add)
				debugger_manager.application.status.keep_object_for_gui (add)
			end
		end

feature {ES_OBJECTS_GRID_MANAGER} -- Layout managment

	grid_objects_on_difference_cb (a_row: EV_GRID_ROW; a_val: ANY) is
		do
			debug ("es_grid_layout")
				print ("DIFF:: " + grid_objects_id_name_from_row (a_row)
					+ " => old=[" + a_val.out + "] new=["
					+ grid_objects_id_value_from_row (a_row, False).out + "]%N")
			end
			a_row.set_background_color (Highlight_different_value_bg_color)
		end

	row_is_ready_for_grid_objects_identification (a_row: EV_GRID_ROW): BOOLEAN is
		do
			if a_row.parent /= Void then
				if Col_name_index <= a_row.count then
					Result := a_row.item (Col_name_index) /= Void
				end
			end
		end

	grid_objects_id_name_from_row (a_row: EV_GRID_ROW): STRING is
		local
			lab: EV_GRID_LABEL_ITEM
		do
			if a_row.parent /= Void then
				if Col_name_index <= a_row.count then
					lab ?= a_row.item (Col_name_index)
					if lab /= Void then
						Result := lab.text
					end
				end
			end
		end

	grid_objects_id_value_from_row (a_row: EV_GRID_ROW; is_recording_layout: BOOLEAN): ANY is
		local
			lab: EV_GRID_LABEL_ITEM
			s: STRING
			line: like object_line_from_row
			addr: STRING
		do
			if a_row.parent /= Void then
				line ?= object_line_from_row (a_row)
				if line /= Void then
					addr := line.object_address
					if addr /= Void then
						s := addr.twin
						if is_recording_layout then
							keep_object_in_debugger_for_gui_need (addr)
							fixme ("We should 'adopt' the object in order to be sure the address value will stay the same")
						end
					end
				end
				if s = Void then
					if Col_value_index <= a_row.count then
						s := ""
						lab ?= a_row.item (Col_value_index)
						if lab /= Void then
							s.append_string (lab.text)
						end
--						if Col_address_index <= a_row.count then
--							lab ?= a_row.item (Col_address_index)
--							if lab /= Void then
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

	on_layout_preferenced_changed is
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

	initialize_layout_management (v: BOOLEAN_PREFERENCE) is
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

	reset_layout_recorded_values is
		do
			if layout_manager /= Void then
				layout_manager.reset_layout_recorded_values
			end
			clear_kept_object_references
		end

	reset_layout_manager is
		do
			if layout_manager /= Void then
				layout_manager.wipe_out
			end
			clear_kept_object_references
		end

	enable_layout_management is
		do
			if layout_manager /= Void then
				layout_manager.enable
				is_layout_managed := True
				if
					layout_preference /= Void
					and then layout_preference.value /= is_layout_managed
				then
					layout_preference.set_value (is_layout_managed)
				end
			end
		end

	disable_layout_management is
		do
			if layout_manager /= Void then
				layout_manager.disable
			end
			is_layout_managed := False
			if
				layout_preference /= Void
				and then layout_preference.value /= is_layout_managed
			then
				layout_preference.set_value (is_layout_managed)
			end
		end

	is_layout_managed: BOOLEAN

	layout_manager: ES_OBJECTS_GRID_LAYOUT_MANAGER

	record_layout is
		local
			old_kept: like kept_object_references
		do
			if is_layout_managed and layout_manager /= Void then
					--| Pre recording
				old_kept := kept_object_references
				create_kept_object_references

					--| Recording
				layout_manager.record

					--| Post recording
				release_object_references (old_kept)
			end
		end

	restore_layout is
		do
			if is_layout_managed and layout_manager /= Void then
				layout_manager.restore
			end
		end

feature -- Graphical look

	Title_font: EV_FONT is
		once
			create Result
			Result.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
		end

	folder_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result
			grid_cell_set_text (Result, s)
			Result.set_foreground_color (folder_row_fg_color)
		end

	name_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result
			grid_cell_set_text (Result, s)
		end

	folder_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (60,60,190)
		end

	object_folder_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (60,60,190)
		end

	slice_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (210, 160, 160)
		end

	disabled_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (190, 190, 190)
		end

	error_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (190, 130, 130)
		end

	Highlight_different_value_bg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (255,210,210)
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
