deferred 
class ES_OBJECTS_GRID_MANAGER

inherit
	REFACTORING_HELPER

	EV_SHARED_APPLICATION

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

feature -- ES slice specific

	slices_cmd: ES_OBJECTS_GRID_SLICES_CMD

feature -- ES grid specific

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

--	column_layout: ARRAY [INTEGER] is
--		deferred
--		end

	folder_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result.make_with_text (s)
			Result.set_foreground_color (folder_row_fg_color)
		end

	name_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result.make_with_text (s)
		end

	dummy_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result.make_with_text (s)
			Result.set_foreground_color (dummy_row_fg_color)
		end

	folder_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (60,60,190)
		end

	object_folder_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (60,60,190)
		end

	dummy_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (210, 210, 210)
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


feature -- Grid helpers

	grid_cell_set_tooltip (a_cell: EV_GRID_ITEM; v: STRING) is
		require
			cell_not_void: a_cell /= Void
		do
			a_cell.set_tooltip (v)
		end

--	pixmap_enabled: BOOLEAN is True
--
--	grid_cell_set_pixmap (a_cell: EV_GRID_ITEM; v: EV_PIXMAP) is
--		require
--			cell_not_void: a_cell /= Void
--		local
--			glab: EV_GRID_LABEL_ITEM
--		do
--			if pixmap_enabled then
--				glab ?= a_cell
--				if glab /= Void then
--					if v /= Void then
--						glab.set_pixmap (v)
--					else
--						glab.remove_pixmap
--					end
--				end
--			end
--		end

end
