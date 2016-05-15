note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MATRIX

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end

	NS_USER_INTERFACE_VALIDATIONS_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make_with_frame__mode__prototype__number_of_rows__number_of_columns_,
	make_with_frame__mode__cell_class__number_of_rows__number_of_columns_,
	make

feature {NONE} -- Initialization

	make_with_frame__mode__prototype__number_of_rows__number_of_columns_ (a_frame_rect: NS_RECT; a_mode: NATURAL_64; a_cell: detachable NS_CELL; a_rows_high: INTEGER_64; a_cols_wide: INTEGER_64)
			-- Initialize `Current'.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			make_with_pointer (objc_init_with_frame__mode__prototype__number_of_rows__number_of_columns_(allocate_object, a_frame_rect.item, a_mode, a_cell__item, a_rows_high, a_cols_wide))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_frame__mode__cell_class__number_of_rows__number_of_columns_ (a_frame_rect: NS_RECT; a_mode: NATURAL_64; a_factory_id: detachable OBJC_CLASS; a_rows_high: INTEGER_64; a_cols_wide: INTEGER_64)
			-- Initialize `Current'.
		local
			a_factory_id__item: POINTER
		do
			if attached a_factory_id as a_factory_id_attached then
				a_factory_id__item := a_factory_id_attached.item
			end
			make_with_pointer (objc_init_with_frame__mode__cell_class__number_of_rows__number_of_columns_(allocate_object, a_frame_rect.item, a_mode, a_factory_id__item, a_rows_high, a_cols_wide))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSMatrix Externals

	objc_init_with_frame__mode__prototype__number_of_rows__number_of_columns_ (an_item: POINTER; a_frame_rect: POINTER; a_mode: NATURAL_64; a_cell: POINTER; a_rows_high: INTEGER_64; a_cols_wide: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item initWithFrame:*((NSRect *)$a_frame_rect) mode:$a_mode prototype:$a_cell numberOfRows:$a_rows_high numberOfColumns:$a_cols_wide];
			 ]"
		end

	objc_init_with_frame__mode__cell_class__number_of_rows__number_of_columns_ (an_item: POINTER; a_frame_rect: POINTER; a_mode: NATURAL_64; a_factory_id: POINTER; a_rows_high: INTEGER_64; a_cols_wide: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item initWithFrame:*((NSRect *)$a_frame_rect) mode:$a_mode cellClass:$a_factory_id numberOfRows:$a_rows_high numberOfColumns:$a_cols_wide];
			 ]"
		end

	objc_set_cell_class_ (an_item: POINTER; a_factory_id: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setCellClass:$a_factory_id];
			 ]"
		end

	objc_cell_class (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item cellClass];
			 ]"
		end

	objc_prototype (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item prototype];
			 ]"
		end

	objc_set_prototype_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setPrototype:$a_cell];
			 ]"
		end

	objc_make_cell_at_row__column_ (an_item: POINTER; a_row: INTEGER_64; a_col: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item makeCellAtRow:$a_row column:$a_col];
			 ]"
		end

	objc_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item mode];
			 ]"
		end

	objc_set_mode_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setMode:$a_mode];
			 ]"
		end

	objc_set_allows_empty_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setAllowsEmptySelection:$a_flag];
			 ]"
		end

	objc_allows_empty_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item allowsEmptySelection];
			 ]"
		end

	objc_send_action__to__for_all_cells_ (an_item: POINTER; a_selector: POINTER; an_object: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item sendAction:$a_selector to:$an_object forAllCells:$a_flag];
			 ]"
		end

	objc_cells (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item cells];
			 ]"
		end

	objc_sort_using_selector_ (an_item: POINTER; a_comparator: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item sortUsingSelector:$a_comparator];
			 ]"
		end

--	objc_sort_using_function__context_ (an_item: POINTER; a_compare: UNSUPPORTED_TYPE; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSMatrix *)$an_item sortUsingFunction: context:];
--			 ]"
--		end

	objc_selected_cells (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item selectedCells];
			 ]"
		end

	objc_selected_row (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item selectedRow];
			 ]"
		end

	objc_selected_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item selectedColumn];
			 ]"
		end

	objc_set_selection_by_rect_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setSelectionByRect:$a_flag];
			 ]"
		end

	objc_is_selection_by_rect (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item isSelectionByRect];
			 ]"
		end

	objc_set_selection_from__to__anchor__highlight_ (an_item: POINTER; a_start_pos: INTEGER_64; a_end_pos: INTEGER_64; a_anchor_pos: INTEGER_64; a_lit: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setSelectionFrom:$a_start_pos to:$a_end_pos anchor:$a_anchor_pos highlight:$a_lit];
			 ]"
		end

	objc_deselect_selected_cell (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item deselectSelectedCell];
			 ]"
		end

	objc_deselect_all_cells (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item deselectAllCells];
			 ]"
		end

	objc_select_cell_at_row__column_ (an_item: POINTER; a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item selectCellAtRow:$a_row column:$a_col];
			 ]"
		end

	objc_select_cell_with_tag_ (an_item: POINTER; an_int: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item selectCellWithTag:$an_int];
			 ]"
		end

	objc_cell_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSMatrix *)$an_item cellSize];
			 ]"
		end

	objc_set_cell_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setCellSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_intercell_spacing (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSMatrix *)$an_item intercellSpacing];
			 ]"
		end

	objc_set_intercell_spacing_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setIntercellSpacing:*((NSSize *)$a_size)];
			 ]"
		end

	objc_set_scrollable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setScrollable:$a_flag];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item backgroundColor];
			 ]"
		end

	objc_set_cell_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setCellBackgroundColor:$a_color];
			 ]"
		end

	objc_cell_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item cellBackgroundColor];
			 ]"
		end

	objc_set_draws_cell_background_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setDrawsCellBackground:$a_flag];
			 ]"
		end

	objc_draws_cell_background (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item drawsCellBackground];
			 ]"
		end

	objc_set_draws_background_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setDrawsBackground:$a_flag];
			 ]"
		end

	objc_draws_background (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item drawsBackground];
			 ]"
		end

	objc_set_state__at_row__column_ (an_item: POINTER; a_value: INTEGER_64; a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setState:$a_value atRow:$a_row column:$a_col];
			 ]"
		end

--	objc_get_number_of_rows__columns_ (an_item: POINTER; a_row_count: UNSUPPORTED_TYPE; a_col_count: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSMatrix *)$an_item getNumberOfRows: columns:];
--			 ]"
--		end

	objc_number_of_rows (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item numberOfRows];
			 ]"
		end

	objc_number_of_columns (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item numberOfColumns];
			 ]"
		end

	objc_cell_at_row__column_ (an_item: POINTER; a_row: INTEGER_64; a_col: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item cellAtRow:$a_row column:$a_col];
			 ]"
		end

	objc_cell_frame_at_row__column_ (an_item: POINTER; result_pointer: POINTER; a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSMatrix *)$an_item cellFrameAtRow:$a_row column:$a_col];
			 ]"
		end

--	objc_get_row__column__of_cell_ (an_item: POINTER; a_row: UNSUPPORTED_TYPE; a_col: UNSUPPORTED_TYPE; a_cell: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSMatrix *)$an_item getRow: column: ofCell:$a_cell];
--			 ]"
--		end

--	objc_get_row__column__for_point_ (an_item: POINTER; a_row: UNSUPPORTED_TYPE; a_col: UNSUPPORTED_TYPE; a_point: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSMatrix *)$an_item getRow: column: forPoint:*((NSPoint *)$a_point)];
--			 ]"
--		end

	objc_renew_rows__columns_ (an_item: POINTER; a_new_rows: INTEGER_64; a_new_cols: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item renewRows:$a_new_rows columns:$a_new_cols];
			 ]"
		end

	objc_put_cell__at_row__column_ (an_item: POINTER; a_new_cell: POINTER; a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item putCell:$a_new_cell atRow:$a_row column:$a_col];
			 ]"
		end

	objc_add_row (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item addRow];
			 ]"
		end

	objc_add_row_with_cells_ (an_item: POINTER; a_new_cells: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item addRowWithCells:$a_new_cells];
			 ]"
		end

	objc_insert_row_ (an_item: POINTER; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item insertRow:$a_row];
			 ]"
		end

	objc_insert_row__with_cells_ (an_item: POINTER; a_row: INTEGER_64; a_new_cells: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item insertRow:$a_row withCells:$a_new_cells];
			 ]"
		end

	objc_remove_row_ (an_item: POINTER; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item removeRow:$a_row];
			 ]"
		end

	objc_add_column (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item addColumn];
			 ]"
		end

	objc_add_column_with_cells_ (an_item: POINTER; a_new_cells: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item addColumnWithCells:$a_new_cells];
			 ]"
		end

	objc_insert_column_ (an_item: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item insertColumn:$a_column];
			 ]"
		end

	objc_insert_column__with_cells_ (an_item: POINTER; a_column: INTEGER_64; a_new_cells: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item insertColumn:$a_column withCells:$a_new_cells];
			 ]"
		end

	objc_remove_column_ (an_item: POINTER; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item removeColumn:$a_col];
			 ]"
		end

	objc_cell_with_tag_ (an_item: POINTER; an_int: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item cellWithTag:$an_int];
			 ]"
		end

	objc_double_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item doubleAction];
			 ]"
		end

	objc_set_double_action_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setDoubleAction:$a_selector];
			 ]"
		end

	objc_set_autosizes_cells_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setAutosizesCells:$a_flag];
			 ]"
		end

	objc_autosizes_cells (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item autosizesCells];
			 ]"
		end

	objc_size_to_cells (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item sizeToCells];
			 ]"
		end

	objc_set_validate_size_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setValidateSize:$a_flag];
			 ]"
		end

	objc_draw_cell_at_row__column_ (an_item: POINTER; a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item drawCellAtRow:$a_row column:$a_col];
			 ]"
		end

	objc_highlight_cell__at_row__column_ (an_item: POINTER; a_flag: BOOLEAN; a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item highlightCell:$a_flag atRow:$a_row column:$a_col];
			 ]"
		end

	objc_set_autoscroll_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setAutoscroll:$a_flag];
			 ]"
		end

	objc_is_autoscroll (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item isAutoscroll];
			 ]"
		end

	objc_scroll_cell_to_visible_at_row__column_ (an_item: POINTER; a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item scrollCellToVisibleAtRow:$a_row column:$a_col];
			 ]"
		end

	objc_mouse_down_flags (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item mouseDownFlags];
			 ]"
		end

	objc_send_action (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item sendAction];
			 ]"
		end

	objc_send_double_action (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item sendDoubleAction];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_text_should_begin_editing_ (an_item: POINTER; a_text_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item textShouldBeginEditing:$a_text_object];
			 ]"
		end

	objc_text_should_end_editing_ (an_item: POINTER; a_text_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item textShouldEndEditing:$a_text_object];
			 ]"
		end

	objc_text_did_begin_editing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item textDidBeginEditing:$a_notification];
			 ]"
		end

	objc_text_did_end_editing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item textDidEndEditing:$a_notification];
			 ]"
		end

	objc_text_did_change_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item textDidChange:$a_notification];
			 ]"
		end

	objc_select_text_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item selectText:$a_sender];
			 ]"
		end

	objc_select_text_at_row__column_ (an_item: POINTER; a_row: INTEGER_64; a_col: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item selectTextAtRow:$a_row column:$a_col];
			 ]"
		end

	objc_set_tool_tip__for_cell_ (an_item: POINTER; a_tool_tip_string: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setToolTip:$a_tool_tip_string forCell:$a_cell];
			 ]"
		end

	objc_tool_tip_for_cell_ (an_item: POINTER; a_cell: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item toolTipForCell:$a_cell];
			 ]"
		end

feature -- NSMatrix

	set_cell_class_ (a_factory_id: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			a_factory_id__item: POINTER
		do
			if attached a_factory_id as a_factory_id_attached then
				a_factory_id__item := a_factory_id_attached.item
			end
			objc_set_cell_class_ (item, a_factory_id__item)
		end

	cell_class: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cell_class (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cell_class} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cell_class} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	prototype: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_prototype (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like prototype} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like prototype} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_prototype_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_set_prototype_ (item, a_cell__item)
		end

	make_cell_at_row__column_ (a_row: INTEGER_64; a_col: INTEGER_64): detachable NS_CELL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_make_cell_at_row__column_ (item, a_row, a_col)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like make_cell_at_row__column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like make_cell_at_row__column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_mode (item)
		end

	set_mode_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_mode_ (item, a_mode)
		end

	set_allows_empty_selection_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_empty_selection_ (item, a_flag)
		end

	allows_empty_selection: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_empty_selection (item)
		end

	send_action__to__for_all_cells_ (a_selector: detachable OBJC_SELECTOR; an_object: detachable NS_OBJECT; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			an_object__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_send_action__to__for_all_cells_ (item, a_selector__item, an_object__item, a_flag)
		end

	cells: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cells (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cells} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cells} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	sort_using_selector_ (a_comparator: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_comparator__item: POINTER
		do
			if attached a_comparator as a_comparator_attached then
				a_comparator__item := a_comparator_attached.item
			end
			objc_sort_using_selector_ (item, a_comparator__item)
		end

--	sort_using_function__context_ (a_compare: UNSUPPORTED_TYPE; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_compare__item: POINTER
--			a_context__item: POINTER
--		do
--			if attached a_compare as a_compare_attached then
--				a_compare__item := a_compare_attached.item
--			end
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			objc_sort_using_function__context_ (item, a_compare__item, a_context__item)
--		end

	selected_cells: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_cells (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_cells} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_cells} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_row: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selected_row (item)
		end

	selected_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selected_column (item)
		end

	set_selection_by_rect_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selection_by_rect_ (item, a_flag)
		end

	is_selection_by_rect: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_selection_by_rect (item)
		end

	set_selection_from__to__anchor__highlight_ (a_start_pos: INTEGER_64; a_end_pos: INTEGER_64; a_anchor_pos: INTEGER_64; a_lit: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selection_from__to__anchor__highlight_ (item, a_start_pos, a_end_pos, a_anchor_pos, a_lit)
		end

	deselect_selected_cell
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_deselect_selected_cell (item)
		end

	deselect_all_cells
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_deselect_all_cells (item)
		end

	select_cell_at_row__column_ (a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_select_cell_at_row__column_ (item, a_row, a_col)
		end

	select_cell_with_tag_ (an_int: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_select_cell_with_tag_ (item, an_int)
		end

	cell_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_cell_size (item, Result.item)
		end

	set_cell_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_cell_size_ (item, a_size.item)
		end

	intercell_spacing: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_intercell_spacing (item, Result.item)
		end

	set_intercell_spacing_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_intercell_spacing_ (item, a_size.item)
		end

	set_scrollable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_scrollable_ (item, a_flag)
		end

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_cell_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_cell_background_color_ (item, a_color__item)
		end

	cell_background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cell_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cell_background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cell_background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_draws_cell_background_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_draws_cell_background_ (item, a_flag)
		end

	draws_cell_background: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draws_cell_background (item)
		end

	set_draws_background_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_draws_background_ (item, a_flag)
		end

	draws_background: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draws_background (item)
		end

	set_state__at_row__column_ (a_value: INTEGER_64; a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_state__at_row__column_ (item, a_value, a_row, a_col)
		end

--	get_number_of_rows__columns_ (a_row_count: UNSUPPORTED_TYPE; a_col_count: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_row_count__item: POINTER
--			a_col_count__item: POINTER
--		do
--			if attached a_row_count as a_row_count_attached then
--				a_row_count__item := a_row_count_attached.item
--			end
--			if attached a_col_count as a_col_count_attached then
--				a_col_count__item := a_col_count_attached.item
--			end
--			objc_get_number_of_rows__columns_ (item, a_row_count__item, a_col_count__item)
--		end

	number_of_rows: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_rows (item)
		end

	number_of_columns: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_columns (item)
		end

	cell_at_row__column_ (a_row: INTEGER_64; a_col: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cell_at_row__column_ (item, a_row, a_col)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cell_at_row__column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cell_at_row__column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	cell_frame_at_row__column_ (a_row: INTEGER_64; a_col: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_cell_frame_at_row__column_ (item, Result.item, a_row, a_col)
		end

--	get_row__column__of_cell_ (a_row: UNSUPPORTED_TYPE; a_col: UNSUPPORTED_TYPE; a_cell: detachable NS_CELL): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_row__item: POINTER
--			a_col__item: POINTER
--			a_cell__item: POINTER
--		do
--			if attached a_row as a_row_attached then
--				a_row__item := a_row_attached.item
--			end
--			if attached a_col as a_col_attached then
--				a_col__item := a_col_attached.item
--			end
--			if attached a_cell as a_cell_attached then
--				a_cell__item := a_cell_attached.item
--			end
--			Result := objc_get_row__column__of_cell_ (item, a_row__item, a_col__item, a_cell__item)
--		end

--	get_row__column__for_point_ (a_row: UNSUPPORTED_TYPE; a_col: UNSUPPORTED_TYPE; a_point: NS_POINT): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_row__item: POINTER
--			a_col__item: POINTER
--		do
--			if attached a_row as a_row_attached then
--				a_row__item := a_row_attached.item
--			end
--			if attached a_col as a_col_attached then
--				a_col__item := a_col_attached.item
--			end
--			Result := objc_get_row__column__for_point_ (item, a_row__item, a_col__item, a_point.item)
--		end

	renew_rows__columns_ (a_new_rows: INTEGER_64; a_new_cols: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_renew_rows__columns_ (item, a_new_rows, a_new_cols)
		end

	put_cell__at_row__column_ (a_new_cell: detachable NS_CELL; a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_new_cell__item: POINTER
		do
			if attached a_new_cell as a_new_cell_attached then
				a_new_cell__item := a_new_cell_attached.item
			end
			objc_put_cell__at_row__column_ (item, a_new_cell__item, a_row, a_col)
		end

	add_row
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_add_row (item)
		end

	add_row_with_cells_ (a_new_cells: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_cells__item: POINTER
		do
			if attached a_new_cells as a_new_cells_attached then
				a_new_cells__item := a_new_cells_attached.item
			end
			objc_add_row_with_cells_ (item, a_new_cells__item)
		end

	insert_row_ (a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_insert_row_ (item, a_row)
		end

	insert_row__with_cells_ (a_row: INTEGER_64; a_new_cells: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_cells__item: POINTER
		do
			if attached a_new_cells as a_new_cells_attached then
				a_new_cells__item := a_new_cells_attached.item
			end
			objc_insert_row__with_cells_ (item, a_row, a_new_cells__item)
		end

	remove_row_ (a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_row_ (item, a_row)
		end

	add_column
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_add_column (item)
		end

	add_column_with_cells_ (a_new_cells: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_cells__item: POINTER
		do
			if attached a_new_cells as a_new_cells_attached then
				a_new_cells__item := a_new_cells_attached.item
			end
			objc_add_column_with_cells_ (item, a_new_cells__item)
		end

	insert_column_ (a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_insert_column_ (item, a_column)
		end

	insert_column__with_cells_ (a_column: INTEGER_64; a_new_cells: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_cells__item: POINTER
		do
			if attached a_new_cells as a_new_cells_attached then
				a_new_cells__item := a_new_cells_attached.item
			end
			objc_insert_column__with_cells_ (item, a_column, a_new_cells__item)
		end

	remove_column_ (a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_column_ (item, a_col)
		end

	cell_with_tag_ (an_int: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cell_with_tag_ (item, an_int)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cell_with_tag_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cell_with_tag_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	double_action: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_double_action (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	set_double_action_ (a_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			objc_set_double_action_ (item, a_selector__item)
		end

	set_autosizes_cells_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autosizes_cells_ (item, a_flag)
		end

	autosizes_cells: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autosizes_cells (item)
		end

	size_to_cells
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_size_to_cells (item)
		end

	set_validate_size_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_validate_size_ (item, a_flag)
		end

	draw_cell_at_row__column_ (a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_cell_at_row__column_ (item, a_row, a_col)
		end

	highlight_cell__at_row__column_ (a_flag: BOOLEAN; a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_highlight_cell__at_row__column_ (item, a_flag, a_row, a_col)
		end

	set_autoscroll_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autoscroll_ (item, a_flag)
		end

	is_autoscroll: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_autoscroll (item)
		end

	scroll_cell_to_visible_at_row__column_ (a_row: INTEGER_64; a_col: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_cell_to_visible_at_row__column_ (item, a_row, a_col)
		end

	mouse_down_flags: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_mouse_down_flags (item)
		end

	send_action: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_send_action (item)
		end

	send_double_action
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_send_double_action (item)
		end

	delegate: detachable NS_MATRIX_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_delegate_ (an_object: detachable NS_MATRIX_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	text_should_begin_editing_ (a_text_object: detachable NS_TEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_text_object__item: POINTER
		do
			if attached a_text_object as a_text_object_attached then
				a_text_object__item := a_text_object_attached.item
			end
			Result := objc_text_should_begin_editing_ (item, a_text_object__item)
		end

	text_should_end_editing_ (a_text_object: detachable NS_TEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_text_object__item: POINTER
		do
			if attached a_text_object as a_text_object_attached then
				a_text_object__item := a_text_object_attached.item
			end
			Result := objc_text_should_end_editing_ (item, a_text_object__item)
		end

	text_did_begin_editing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_begin_editing_ (item, a_notification__item)
		end

	text_did_end_editing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_end_editing_ (item, a_notification__item)
		end

	text_did_change_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_change_ (item, a_notification__item)
		end

	select_text_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_text_ (item, a_sender__item)
		end

	select_text_at_row__column_ (a_row: INTEGER_64; a_col: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_select_text_at_row__column_ (item, a_row, a_col)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like select_text_at_row__column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like select_text_at_row__column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_tool_tip__for_cell_ (a_tool_tip_string: detachable NS_STRING; a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_tool_tip_string__item: POINTER
			a_cell__item: POINTER
		do
			if attached a_tool_tip_string as a_tool_tip_string_attached then
				a_tool_tip_string__item := a_tool_tip_string_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_set_tool_tip__for_cell_ (item, a_tool_tip_string__item, a_cell__item)
		end

	tool_tip_for_cell_ (a_cell: detachable NS_CELL): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			result_pointer := objc_tool_tip_for_cell_ (item, a_cell__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tool_tip_for_cell_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tool_tip_for_cell_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- NSKeyboardUI

	set_tab_key_traverses_cells_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_tab_key_traverses_cells_ (item, a_flag)
		end

	tab_key_traverses_cells: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tab_key_traverses_cells (item)
		end

	set_key_cell_ (a_key_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_key_cell__item: POINTER
		do
			if attached a_key_cell as a_key_cell_attached then
				a_key_cell__item := a_key_cell_attached.item
			end
			objc_set_key_cell_ (item, a_key_cell__item)
		end

	key_cell: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSKeyboardUI Externals

	objc_set_tab_key_traverses_cells_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setTabKeyTraversesCells:$a_flag];
			 ]"
		end

	objc_tab_key_traverses_cells (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMatrix *)$an_item tabKeyTraversesCells];
			 ]"
		end

	objc_set_key_cell_ (an_item: POINTER; a_key_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMatrix *)$an_item setKeyCell:$a_key_cell];
			 ]"
		end

	objc_key_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMatrix *)$an_item keyCell];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMatrix"
		end

end
