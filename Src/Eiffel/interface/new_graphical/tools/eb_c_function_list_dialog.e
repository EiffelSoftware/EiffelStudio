indexing
	description: "Dialog to list all deriviation versions for a class/feature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_C_FUNCTION_LIST_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	EB_CONSTANTS
		undefine
			default_create,
			copy,
			is_equal
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER
		undefine
			default_create,
			copy,
			is_equal
		end

	EB_SHARED_EDITOR_TOKEN_UTILITY
		undefine
			default_create,
			copy,
			is_equal
		end

	SHARED_WORKBENCH
		undefine
			default_create,
			copy,
			is_equal
		end

create
	default_create

feature {NONE} -- Initialization

	initialize
			-- Initialize Current.
		local
			l_ver: EV_VERTICAL_BOX
			l_lbl: EV_LABEL
			l_grid_area: EV_VERTICAL_BOX
			l_cell: EV_CELL
			l_button_area: EV_HORIZONTAL_BOX
			l_main_area: EV_VERTICAL_BOX
		do
			create rows.make (20)
			create class_name_table.make (10)
			create l_main_area
			l_main_area.set_border_width (10)
			create grid
			grid.set_column_count_to (2)
			grid.column (2).set_width (40)
			grid.column (1).set_title (interface_names.t_class)
			create grid_wrapper.make (grid)
			grid_wrapper.set_sort_info (1, create {EVS_GRID_TWO_WAY_SORTING_INFO [TUPLE [EV_GRID_ITEM, EV_GRID_ITEM]]}.make (agent class_name_tester, ascending_order))
			grid_wrapper.enable_auto_sort_order_change
			grid_wrapper.set_sort_action (agent sort_agent)
			create close_button.make_with_text (interface_names.b_close)
			close_button.set_minimum_width (80)
			create l_lbl.make_with_text (interface_names.l_choose_class_version)
			l_lbl.align_text_left
			Precursor
			create l_ver
			l_ver.set_padding (3)
			l_ver.extend (l_lbl)
			l_ver.disable_item_expand (l_lbl)
			create l_grid_area
			l_grid_area.set_background_color ((create {EV_STOCK_COLORS}).black)
			l_grid_area.set_border_width (1)
			l_grid_area.extend (grid)
			l_ver.extend (l_grid_area)
			create l_cell
			l_cell.set_minimum_height (15)
			l_ver.extend (l_cell)
			l_ver.disable_item_expand (l_cell)
			create l_button_area
			l_button_area.extend (create {EV_CELL})
			l_button_area.extend (close_button)
			l_button_area.disable_item_expand (close_button)
			l_button_area.extend (create {EV_CELL})
			l_ver.extend (l_button_area)
			l_ver.disable_item_expand (l_button_area)
			close_button.select_actions.extend (agent do hide end)
			l_main_area.extend (l_ver)
			extend (l_main_area)
			set_icon_pixmap (pixmaps.icon_pixmaps.new_target_icon)
			set_title (interface_names.t_open_c_file)
			set_minimum_size (400, 300)
			key_press_actions.extend (agent on_key_pressed_on_dialog)
			grid.key_press_actions.extend (agent on_key_pressed_on_dialog)
		end

feature -- Access

	open_file_agent: PROCEDURE [ANY, TUPLE [STRING_8, INTEGER_32]]
			-- Action to open a file and scroll to a givne line number.
			-- Arguments: [file name, line number]

	mapper: EB_EIFFEL_C_FUNCTION_MAPPER
			-- Mapper in which information of files to be open is contained.

feature -- Setting

	set_mapper (a_mapper: like mapper)
			-- Set `mapper' with `a_mapper'.
			-- Refresh `grid'.
		require
			a_mapper_attached: a_mapper /= Void
		do
			mapper := a_mapper
			valid_file_table := mapper.valid_c_file_table
			fill_rows
			grid_wrapper.disable_auto_sort_order_change
			grid_wrapper.sort (0, 0, 1, 0, 0, 0, 0, 0, 1)
			grid_wrapper.enable_auto_sort_order_change
		ensure
			mapper_set: mapper = a_mapper
		end

	set_open_file_agent (a_open_file_agent: like open_file_agent)
			-- Set `open_file_agent' with `a_open_file_agent'.
		do
			open_file_agent := a_open_file_agent
		ensure
			open_file_agent_st: open_file_agent = a_open_file_agent
		end

feature {NONE} -- Implementation

	close_button: EV_BUTTON
			-- Button to close Current dialog

	grid: ES_GRID
			-- Grid to display class/feature list

	rows: DS_ARRAYED_LIST [TUPLE [EV_GRID_ITEM, EV_GRID_ITEM]]
			-- Rows to be displayed in `grid'

	target_grid_item (a_class_type: CLASS_TYPE): EV_GRID_ITEM
			-- Grid item for `a_class_type'
		require
			mapper_attached: mapper /= Void
			a_class_type_attached: a_class_type /= Void
			a_class_type_valid: mapper.valid_c_file_table.has_item (a_class_type)
		local
			l_mapper: like mapper
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_feature_style: like feature_name_style
			l_plain_style: like plain_text_style
			l_tokens: LINKED_LIST [EDITOR_TOKEN]
		do
			create l_item
			create l_tokens.make
			l_mapper := mapper
			l_plain_style := plain_text_style
			if l_mapper.is_for_feature then
				l_plain_style.set_symbol_text (ti_l_curly)
				l_tokens.append (l_plain_style.text)
			end
			l_plain_style.set_source_text (a_class_type.type.dump)
			l_tokens.append (l_plain_style.text)
			if mapper.is_for_feature then
				l_plain_style.set_symbol_text (ti_r_curly + ti_dot)
				l_tokens.append (l_plain_style.text)
				l_feature_style := feature_name_style
				l_feature_style.set_e_feature (mapper.e_feature)
				l_tokens.append (l_feature_style.text)
			end
			l_item.set_text_with_tokens (l_tokens)
			l_item.set_data (l_item.text)
			Result := l_item
		ensure
			result_attached: Result /= Void
		end

	open_file_grid_item (a_file_name: STRING_8): EV_GRID_ITEM
			-- Grid item to display an icon to open external editor
		require
			mapper_attached: mapper /= Void
			a_file_name_attached: a_file_name /= Void
		local
			l_item: EV_GRID_LABEL_ITEM
		do
			create l_item
			l_item.set_pixmap (pixmaps.icon_pixmaps.general_open_icon)
			l_item.pointer_button_press_actions.extend (agent on_open_file (?, ?, ?, ?, ?, ?, ?, ?, a_file_name))
			l_item.set_tooltip (interface_names.h_click_to_open)
			Result := l_item
		ensure
			result_attached: Result /= Void
		end

	class_name_table: HASH_TABLE [LIST [EDITOR_TOKEN], STRING_8]
			-- Class name table

	grid_wrapper: EVS_SEARCHABLE_COMPONENT [TUPLE [EV_GRID_ITEM, EV_GRID_ITEM]]
			-- Grid wrapper for `grid' to enable sorting

	valid_file_table: HASH_TABLE [CLASS_TYPE, STRING_8]
			-- Valid file table

feature {NONE} -- Grid binding

	fill_rows
			-- Fill rows in `rows'.
		local
			l_rows: like rows
			l_file_table: HASH_TABLE [CLASS_TYPE, STRING_8]
			l_mapper: like mapper
		do
			l_rows := rows
			l_rows.wipe_out
			l_mapper := mapper
			l_file_table := valid_file_table
			from
				l_file_table.start
			until
				l_file_table.after
			loop
				l_rows.force_last ([target_grid_item (l_file_table.item_for_iteration), open_file_grid_item (l_file_table.key_for_iteration)])
				l_file_table.forth
			end
		end

	bind_grid
			-- Bind `grid' with `rows'.
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [TUPLE [a_target_item: EV_GRID_ITEM; a_open_dialog_item: EV_GRID_ITEM]]
			l_grid_row: EV_GRID_ROW
			l_grid: like grid
			l_table: HASH_TABLE [TUPLE [INTEGER_32, INTEGER_32], INTEGER_32]
		do
			l_grid := grid
			if l_grid.row_count > 0 then
				l_grid.remove_rows (1, l_grid.row_count)
			end
			l_cursor := rows.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_grid.insert_new_row (l_grid.row_count + 1)
				l_grid_row := l_grid.row (l_grid.row_count)
				l_grid_row.set_item (1, l_cursor.item.a_target_item)
				l_grid_row.set_item (2, l_cursor.item.a_open_dialog_item)
				l_cursor.forth
			end
			create l_table.make (1)
			l_table.put ([300, 350], 1)
			grid_wrapper.auto_resize_columns (grid, l_table)
		end

feature{NONE} -- Implementation/Actions

	on_open_file (x, y, button: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32; a_file_name: STRING_8)
			-- Open file `a_file_name' in external editor
		require
			a_file_name_attached: a_file_name /= Void
		do
			if button = {EV_POINTER_CONSTANTS}.left then
				if open_file_agent /= Void then
					open_file_agent.call ([a_file_name, mapper.line_number (a_file_name)])
				end
			end
		end

	on_key_pressed_on_dialog (a_key: EV_KEY) is
			-- Action to be performed when `a_key' is pressed.
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_escape then
				hide
			end
		end

feature{NONE} -- Implementation/Sorting

	sort_agent (a_column_list: LIST [INTEGER_32]; a_comparator: AGENT_LIST_COMPARATOR [TUPLE [EV_GRID_ITEM, EV_GRID_ITEM]])
			-- Sort `rows'.
		require
			a_column_list_attached: a_column_list /= Void
		local
			l_sorter: DS_QUICK_SORTER [TUPLE [EV_GRID_ITEM, EV_GRID_ITEM]]
		do
			create l_sorter.make (a_comparator)
			l_sorter.sort (rows)
			bind_grid
		end

	class_name_tester (a_mapper, b_mapper: TUPLE [a_target_item: EV_GRID_ITEM; a_open_dialog_item: EV_GRID_ITEM]; a_sorting_order: INTEGER_32): BOOLEAN
			-- Tester to decide order between `a_mapper' and `b_mapper'
		require
			a_mapper_attached: a_mapper /= Void
			b_mapper_attached: b_mapper /= Void
		local
			l_name_a: STRING_8
			l_name_b: STRING_8
		do
			l_name_a ?= a_mapper.a_target_item.data
			l_name_b ?= b_mapper.a_target_item.data
			if l_name_a /= Void and then l_name_b /= Void then
				if a_sorting_order = ascending_order then
					Result := l_name_a <= l_name_b
				elseif a_sorting_order = descending_order then
					Result := l_name_a > l_name_b
				end
			end
		end

invariant
	close_button_attached: close_button /= Void
	grid_attached: grid /= Void
	rows_attached: rows /= Void
	class_name_table_attached: class_name_table /= Void
	grid_wrapper_attached: grid_wrapper /= Void
	file_table_valid: mapper /= Void implies valid_file_table /= Void

end -- class EB_C_FUNCTION_LIST_DIALOG

