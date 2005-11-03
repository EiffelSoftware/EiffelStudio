deferred
class ES_OBJECTS_GRID_MANAGER

inherit
	REFACTORING_HELPER

	EV_SHARED_APPLICATION

	EV_GRID_HELPER

feature {ES_OBJECTS_GRID_MANAGER, ES_OBJECTS_GRID_LINE, ES_OBJECTS_GRID_SLICES_CMD} -- EiffelStudio specific

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

	objects_grid_item (add: STRING): ES_OBJECTS_GRID_LINE is
		require
			valid_address: add /= Void
		deferred
		ensure
			valid_result: Result /= Void implies (
					Result.object_address /= Void
					and then add.is_equal (Result.object_address)
				)
		end

feature -- cmd specific

	hex_format_cmd: EB_HEX_FORMAT_CMD

	slices_cmd: ES_OBJECTS_GRID_SLICES_CMD

	pretty_print_cmd: EB_PRETTY_PRINT_CMD
			-- Command that is used to display extended information concerning objects.

feature {NONE} -- Layout managment

	grid_objects_on_difference_cb (a_row: EV_GRID_ROW; a_val: ANY) is
		do
			debug ("grid_layout")
				print ("DIFF:: " + grid_objects_id_name_from_row (a_row) + " => old=[" + a_val.out + "] new=[" + grid_objects_id_value_from_row (a_row).out + "]%N")
			end
			a_row.set_background_color (Highlight_different_value_bg_color)
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

	grid_objects_id_value_from_row (a_row: EV_GRID_ROW): ANY is
		local
			lab: EV_GRID_LABEL_ITEM
			s: STRING
		do
			if a_row.parent /= Void then
				if Col_value_index <= a_row.count then
					s := ""
					lab ?= a_row.item (Col_value_index)
					if lab /= Void then
						s.append_string (lab.text)
					end
					if Col_address_index <= a_row.count then
						lab ?= a_row.item (Col_address_index)
						if lab /= Void then
							s.append_string (lab.text)
						end
					end
					Result := s
				end
			end
		end

feature -- ES grid specific

	expand_selected_rows (a_grid: EV_GRID) is
		require
			a_grid /= Void
		local
			rows: ARRAYED_LIST [EV_GRID_ROW]
			row: EV_GRID_ROW
		do
			rows := a_grid.selected_rows
			from
				rows.start
			until
				rows.after
			loop
				row := rows.item
				if not row.is_expanded and then row.is_expandable then
					row.expand
				end
				rows.forth
			end
		end

	collapse_selected_rows (a_grid: EV_GRID) is
		require
			a_grid /= Void
		local
			rows: ARRAYED_LIST [EV_GRID_ROW]
			row: EV_GRID_ROW
		do
			rows := a_grid.selected_rows
			from
				rows.start
			until
				rows.after
			loop
				row := rows.item
				if row.is_expanded then
					row.collapse
				end
				rows.forth
			end
		end

	grid_data_from_widget (a_item: EV_ANY): ANY is
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_item /= Void then
				ctler ?= a_item.data
				if ctler /= Void then
					Result := ctler.data
				else
					Result ?= a_item.data
				end
			end
		end

feature -- Clipboard related

	update_clipboard_string_with_selection (grid: ES_OBJECTS_GRID) is
		local
			dv: ABSTRACT_DEBUG_VALUE
			text_data: STRING
			lrow: EV_GRID_ROW
			gline: ES_OBJECTS_GRID_LINE
		do
			lrow := grid.selected_rows.first
			if lrow /= Void then
				gline ?= lrow.data
				if gline /= Void then
					text_data := gline.text_data_for_clipboard
				else
					dv ?= grid_data_from_widget (lrow)
					if dv /= Void then
						text_data := dv.dump_value.full_output
					else
						text_data ?= lrow.data
					end
				end
			end
			if text_data /= Void then
				ev_application.clipboard.set_text (text_data)
			else
				ev_application.clipboard.remove_text
			end
		end

	set_expression_from_clipboard (grid: ES_OBJECTS_GRID) is
			-- Sets an expression from text held in clipboard
		local
			text_data: STRING
			row: EV_GRID_ROW
			rows: ARRAYED_LIST [EV_GRID_ROW]
			empty_expression_cell: ES_OBJECTS_GRID_EMPTY_EXPRESSION_CELL
		do
			text_data := ev_application.clipboard.text
			if text_data /= Void and then not text_data.is_empty then
				rows := grid_selected_top_rows (grid)
				if not rows.is_empty then
					row := rows.first
					if
						col_name_index <= row.count
					then
						empty_expression_cell ?= row.item (col_name_index)
						if empty_expression_cell /= Void then
							empty_expression_cell.activate_with_string (text_data)
						end
					end
				end
			end
		end

feature -- numerical related processing

	hexadecimal_mode_enabled: BOOLEAN is
		deferred
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

feature -- Constants

	Col_pixmap_index: INTEGER is
		deferred
		end
	Col_name_index: INTEGER is
		deferred
		end
	Col_address_index: INTEGER is
		deferred
		end
	Col_value_index: INTEGER is
		deferred
		end
	Col_type_index: INTEGER is
		deferred
		end
	Col_context_index: INTEGER is
		deferred
		end

	Col_titles: ARRAY [STRING] is
		deferred
		end

end
