deferred 
class ES_OBJECTS_GRID_MANAGER

inherit
	REFACTORING_HELPER

	EV_SHARED_APPLICATION

	EV_GRID_HELPER

feature {ES_OBJECTS_GRID_MANAGER, ES_OBJECTS_GRID_LINE, ES_OBJECTS_GRID_SLICES_CMD} -- EiffelStudio specific

	add_debug_value_to_grid_row (a_parent_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE) is
		require
			dv /= Void
		local
			litem: ES_OBJECTS_GRID_VALUE_LINE
		do
			create litem.make_with_value (dv, Current)
			litem.attach_as_subrow (a_parent_row)
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
		
feature -- numerical related processing

	hexadecimal_mode_enabled: BOOLEAN is
		deferred
		end

feature -- Graphical look

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
