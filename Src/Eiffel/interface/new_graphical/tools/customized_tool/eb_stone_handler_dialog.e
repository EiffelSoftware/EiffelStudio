note
	description: "Dialog to setup stone handlers for customized tools"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_STONE_HANDLER_DIALOG

inherit
	PROPERTY_DIALOG [HASH_TABLE [STRING, STRING]]
		redefine
			initialize
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_CONSTANTS
		undefine
			is_equal,
			copy,
			default_create
		end

create
	make

feature{NONE} -- Initialization

	make (a_tool_name: like tool_name; a_tools: like tools; a_stone_table: like stone_table)
			-- Initialize `tool_name' with `a_tool_name'.
		require
			a_tool_name_attached: a_tool_name /= Void
			a_tools_attached: a_tools /= Void
			a_stone_table_attached: a_stone_table /= Void
		do
			create items.make (10)
			create stone_table.make (5)
			create stone_name_table.make (5)
			create tool_table.make (5)
			create tool_name_table.make (5)

			create grid
			create grid_wrapper.make (grid)
			create add_button
			create remove_button
			set_tool_name (a_tool_name)
			set_tools (a_tools)
			set_stone_table (a_stone_table)
			initialize_internal
			default_create
			show_actions.extend (agent on_show)
			ok_button.select_actions.extend (agent on_ok_pressed)
			set_has_binded (False)
		end

	initialize
			-- Initialize.
		local
			l_tool_bar: EV_TOOL_BAR
			l_ver: EV_VERTICAL_BOX
			l_hor: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
			l_border: EV_VERTICAL_BOX
		do
			Precursor
			grid.set_column_count_to (2)
			grid.column (1).set_title (interface_names.l_stone_name)
			grid.column (2).set_title (interface_names.t_tool_name)
			grid.column (1).set_width (180)
			grid.row_select_actions.extend (agent on_row_selected)
			grid.row_deselect_actions.extend (agent on_row_deselected)
			grid.key_press_actions.extend (agent on_key_pressed)
			grid.item_select_actions.extend (agent on_item_selected)
			grid.item_select_actions.extend (agent on_item_deselected)

			grid_wrapper.set_sort_info (1, create {EVS_GRID_TWO_WAY_SORTING_INFO [TUPLE [a_tool_name: STRING; a_stone_name: STRING]]}.make (agent stone_name_tester, ascending_order))
			grid_wrapper.set_sort_info (2, create {EVS_GRID_TWO_WAY_SORTING_INFO [TUPLE [a_tool_name: STRING; a_stone_name: STRING]]}.make (agent tool_name_tester, ascending_order))
			grid_wrapper.set_sort_action (agent sort_agent)
			grid_wrapper.enable_auto_sort_order_change

			add_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			add_button.set_tooltip (interface_names.l_add_stone_handler)
			add_button.select_actions.extend (agent on_add_handler)

			remove_button.set_pixmap (pixmaps.icon_pixmaps.general_remove_icon)
			remove_button.set_tooltip (interface_names.l_remove_stone_handler)
			remove_button.select_actions.extend (agent on_remove_handler)
			remove_button.disable_sensitive

			create l_tool_bar
			l_tool_bar.extend (add_button)
			l_tool_bar.extend (remove_button)

			create l_border
			l_border.set_border_width (1)
			l_border.set_background_color ((create {EV_STOCK_COLORS}).black)
			l_border.extend (grid)

			create l_hor
			l_hor.extend (create {EV_CELL})
			l_hor.extend (l_tool_bar)
			l_hor.disable_item_expand (l_tool_bar)

			create l_ver
			l_ver.extend (l_border)
			l_ver.extend (l_hor)
			l_ver.disable_item_expand (l_hor)

			create l_cell
			l_cell.set_minimum_height (10)
			l_ver.extend (l_cell)
			l_ver.disable_item_expand (l_cell)

			element_container.extend (l_ver)
			remove_default_push_button
		end

feature -- Access

	tool_name: STRING_32
			-- Name of the tool for which stone handers are being setup in Current dialog

	tools: LIST [TUPLE [a_tool_name: STRING_GENERAL; a_tool_id: STRING]]
			-- Available tools

feature -- Status report

	has_changed: BOOLEAN
			-- Has display tool as well as view settings changed?

	has_binded: BOOLEAN
			-- Has `grid' been binded?

feature -- Setting

	set_has_changed (b: BOOLEAN)
			-- Set `has_changed' with `b'.
		do
			has_changed := b
		ensure
			has_changed_set: has_changed = b
		end

	set_has_binded (b: BOOLEAN)
			-- Set `has_binded' with `b'.
		do
			has_binded := b
		ensure
			has_binded_set: has_binded = b
		end

	set_tool_name (a_name: like tool_name)
			-- Set `tool_name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			tool_name := a_name
		ensure
			tool_name_set: tool_name /= Void
		end

	set_tools (a_tools: like tools)
			-- Set `tools' with `a_tools'.
		require
			a_tools_attached: a_tools /= Void
		do
			tools := a_tools.twin
		ensure
			tools_set: tools /= Void
		end

	set_stone_table (a_stone_table: like stone_table)
			-- Set `stone_table' with `a_stone_table'.
		require
			a_stone_table_attached: a_stone_table /= Void
		do
			stone_table := a_stone_table
		ensure
			stone_table_set: stone_table = a_stone_table
		end

feature{NONE} -- Actions

	on_show
			-- Action to be performed when Current dialog is shown
		do
			set_has_binded (False)
			grid_wrapper.disable_auto_sort_order_change
			grid_wrapper.sort (0, 0, 1, 0, 0, 0, 0, 0, 1)
			grid_wrapper.enable_auto_sort_order_change
			bind_grid
			set_has_changed (False)
			set_title (interface_names.l_setup_stone_handler (tool_name))
			grid.set_focus
		end

	on_ok_pressed
			-- Action to be performed when "OK" button is pressed
		do
			if has_changed then
				set_value (value_from_grid)
			end
		end

	on_add_handler
			-- Action to be performed to add a stone handler
		local
			l_grid_row: EV_GRID_ROW
		do
			grid.column (1).header_item.remove_pixmap
			grid.insert_new_row (grid.row_count + 1)
			l_grid_row := grid.row (grid.row_count)
			stone_name_table.start
			tool_name_table.start
			bind_row (stone_name_table.item_for_iteration, tool_name_table.item_for_iteration, l_grid_row)
			items.force_last ([tool_name_table.item_for_iteration, stone_name_table.item_for_iteration])
			grid.remove_selection
			l_grid_row.enable_select
			set_has_changed (True)
		end

	on_remove_handler
			-- Action to be performed to remove selected stone handler
		local
			l_selected_rows: LIST [EV_GRID_ROW]
			l_selected_items: LIST [EV_GRID_ITEM]
			l_row: EV_GRID_ROW
			l_row_index: INTEGER
		do
			l_selected_rows := grid.selected_rows
			if l_selected_rows.count = 1 then
				l_row := l_selected_rows.first
			else
				l_selected_items := grid.selected_items
				if l_selected_items.count = 1 then
					l_row := l_selected_items.first.row
				end
			end
			if l_row /= Void then
				l_row_index := l_row.index
				grid.column (1).header_item.remove_pixmap
				items.remove (l_row_index)
				grid.remove_row (l_row_index)
				grid.remove_selection
				if l_row_index <= grid.row_count then
					grid.row (l_row_index).enable_select
				elseif grid.row_count > 0 then
					grid.row (grid.row_count).enable_select
				end
				set_has_changed (True)
			end
		end

	on_tool_selection_change (a_choice_item: EV_GRID_CHOICE_ITEM)
			-- Action to be performed when tool choice changes
		require
			a_choice_item_valid: a_choice_item /= Void and then a_choice_item.is_parented
		local
			l_row_index: INTEGER
		do
			l_row_index := a_choice_item.row.index
			items.item (l_row_index).a_tool_id := tool_name_table.item (a_choice_item.text)
			set_has_changed (True)
		end

	on_stone_selection_change (a_choice_item: EV_GRID_CHOICE_ITEM)
			-- Action to be performed when stone choice changes
		require
			a_choice_item_valid: a_choice_item /= Void and then a_choice_item.is_parented
		local
			l_row_index: INTEGER
		do
			l_row_index := a_choice_item.row.index
			items.item (l_row_index).a_stone_name := stone_name_table.item (a_choice_item.text)
			set_has_changed (True)
		end

	on_row_selected (a_row: EV_GRID_ROW)
			-- Action to be performed when `a_row' is selected.			
		do
			remove_button.enable_sensitive
		end

	on_row_deselected (a_row: EV_GRID_ROW)
			-- Action to be performed when `a_row' is deselected.			
		do
			if grid.selected_rows.is_empty then
				remove_button.disable_sensitive
			end
		end

	on_item_selected (a_item: EV_GRID_ITEM)
			-- Action to be performed when `a_item' is selected.
		do
			remove_button.enable_sensitive
		end

	on_item_deselected (a_item: EV_GRID_ITEM)
			-- Action to be performed when `a_item' is deselected.
		do
			if grid.selected_items.is_empty then
				remove_button.disable_sensitive
			end
		end

	on_key_pressed (a_key: EV_KEY)
			-- Action to be performed if `a_key' is pressed in `item_grid'
		require
			a_key_attached: a_key /= Void
		local
			l_selected_items: LIST [EV_GRID_ITEM]
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_insert then
				on_add_handler
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_delete and then remove_button.is_sensitive then
				on_remove_handler
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_enter or a_key.code = {EV_KEY_CONSTANTS}.key_space then
				l_selected_items := grid.selected_items
				if l_selected_items.count = 1 then
					l_selected_items.first.activate
				end
			end
		end

feature{NONE} -- Implementation/Data

	value_from_grid: like value
			-- Value retrieved from `grid'
		local
			l_value: like value
			l_grid: like grid
			l_row_index: INTEGER
			l_row_count: INTEGER
			l_grid_row: EV_GRID_ROW
			l_stone_item: EV_GRID_CHOICE_ITEM
			l_tool_item: EV_GRID_CHOICE_ITEM
		do
			create l_value.make (5)
			l_grid := grid
			from
				l_row_index := 1
				l_row_count := l_grid.row_count
			until
				l_row_index > l_row_count
			loop
				l_grid_row := l_grid.row (l_row_index)
				l_stone_item ?= l_grid_row.item (1)
				l_tool_item ?= l_grid_row.item (2)
				check l_stone_item /= Void and then l_tool_item /= Void end
				l_value.put (tool_name_table.item (l_tool_item.text), stone_name_table.item (l_stone_item.text))
				l_row_index := l_row_index + 1
			end
			Result := l_value
		end

	stone_grid_item (a_selected_stone_name: STRING_32): EV_GRID_CHOICE_ITEM
			-- Grid item to provide a stone list
		local
			l_selected_name: STRING_GENERAL
		do
			create Result
			Result.set_item_strings (sorted_stone_names)
			l_selected_name := stone_table.item (a_selected_stone_name)
			if l_selected_name /= Void then
				Result.set_text (l_selected_name)
			end
			Result.deactivate_actions.extend (agent on_stone_selection_change (Result))
			Result.pointer_button_press_actions.force_extend (agent Result.activate)
		ensure
			result_attached: Result /= Void
		end

	sorted_stone_names: LIST [STRING_GENERAL]
			-- List or ascendingly sorted stone names
		local
			l_sorted: SORTED_TWO_WAY_LIST [STRING_GENERAL]
			l_table: like stone_table
		do
			create l_sorted.make
			l_table := stone_table
			from
				l_table.start
			until
				l_table.after
			loop
				l_sorted.put_front (l_table.item_for_iteration)
				l_table.forth
			end
			l_sorted.sort
			Result := l_sorted
		ensure
			result_attached: Result /= Void
		end

	sorted_tool_names: LIST [STRING_GENERAL]
			-- List or ascendingly sorted tool names
		local
			l_sorted: SORTED_TWO_WAY_LIST [STRING_GENERAL]
			l_table: like tool_table
		do
			create l_sorted.make
			l_table := tool_table
			from
				l_table.start
			until
				l_table.after
			loop
				l_sorted.put_front (l_table.item_for_iteration.as_string_32)
				l_table.forth
			end
			l_sorted.sort
			Result := l_sorted
		ensure
			result_attached: Result /= Void
		end

	tool_grid_item (a_tool_id: STRING): EV_GRID_CHOICE_ITEM
			-- Grid item to provide a tool list
		local
			l_selected_name: STRING_GENERAL
		do
			create Result
			Result.set_item_strings (sorted_tool_names)
			l_selected_name := tool_table.item (a_tool_id)
			if l_selected_name /= Void then
				Result.set_text (l_selected_name)
			end
			Result.deactivate_actions.extend (agent on_tool_selection_change (Result))
			Result.pointer_button_press_actions.force_extend (agent Result.activate)
		ensure
			result_attached: Result /= Void
		end

	initialize_internal
			-- Initialize internal data structure.
		local
			l_names: EB_CUSTOMIZED_FORMATTER_XML_CONSTANTS
			l_stone_table: like stone_table
			l_stone_name_table: like stone_name_table
			l_tools: like tools
			l_tool_table: like tool_table
			l_tool_name_table: like tool_name_table
		do
			create l_names

			l_stone_table := stone_table

			l_stone_name_table := stone_name_table
			from
				l_stone_table.start
			until
				l_stone_table.after
			loop
				l_stone_name_table.put (l_stone_table.key_for_iteration, l_stone_table.item_for_iteration)
				l_stone_table.forth
			end

			l_tools := tools
			l_tool_table := tool_table
			l_tool_name_table := tool_name_table

			from
				l_tools.start
			until
				l_tools.after
			loop
				l_tool_table.put (l_tools.item.a_tool_name, l_tools.item.a_tool_id)
				l_tool_name_table.put (l_tools.item.a_tool_id, l_tools.item.a_tool_name.as_string_32)
				l_tools.forth
			end
		end

	stone_table: HASH_TABLE [STRING_GENERAL, STRING]
			-- Table of stone [stone_display_name, stone_name]

	stone_name_table: HASH_TABLE [STRING, STRING_GENERAL]
			-- Talbe stone name [stone_name, stone_display_name]

	tool_table: HASH_TABLE [STRING_GENERAL, STRING]
			-- Table of tools [tool_display_name, tool_id]

	tool_name_table: HASH_TABLE [STRING, STRING_GENERAL]
			-- Table of tool names [tool_id, tool_display_name]

	items: DS_ARRAYED_LIST [TUPLE [a_tool_id: STRING; a_stone_name: STRING]]
			-- Items to be displayed in `grid'

feature{NONE} -- Implementation

	grid: ES_GRID
			-- Grid to display handlers

	grid_wrapper: EVS_GRID_WRAPPER [TUPLE [a_tool_id: STRING; a_stone_name: STRING]]
			-- Grid wrapper to support sorting

	add_button: EV_TOOL_BAR_BUTTON
			-- Button to add a stone handler

	remove_button: EV_TOOL_BAR_BUTTON
			-- Button to remove selected stone handler

feature{NONE} -- Implementation/Sorting

	stone_name_tester (a_item, b_item: TUPLE [a_tool_name: STRING; a_stone_name: STRING]; a_order: INTEGER): BOOLEAN
			-- Tester to decide order between `a_item' and `b_item'.
		require
			a_item_valid: a_item /= Void and then a_item.a_stone_name /= Void
			b_item_valid: b_item /= Void and then b_item.a_stone_name /= Void
		do
			if a_order = ascending_order then
				Result := stone_table.item (a_item.a_stone_name) <= stone_table.item (b_item.a_stone_name)
			else
				Result := stone_table.item (a_item.a_stone_name) > stone_table.item (b_item.a_stone_name)
			end
		end

	tool_name_tester (a_item, b_item: TUPLE [a_tool_name: STRING; a_stone_name: STRING]; a_order: INTEGER): BOOLEAN
			-- Tester to decide order between `a_item' and `b_item'.
		require
			a_item_valid: a_item /= Void and then a_item.a_tool_name /= Void
			b_item_valid: b_item /= Void and then b_item.a_tool_name /= Void
		do
			if a_order = ascending_order then
				Result := tool_table.item (a_item.a_tool_name) <= tool_table.item (b_item.a_tool_name)
			else
				Result := tool_table.item (a_item.a_tool_name) > tool_table.item (b_item.a_tool_name)
			end
		end

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [TUPLE [STRING, STRING]])
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty:
		local
			l_sorter: DS_QUICK_SORTER [TUPLE [STRING, STRING]]
			l_value: like value
			l_items: like items
			l_stone_table: like stone_table
			l_tool_table: like tool_table
		do
			if not has_binded then
				l_value := value
				if l_value = Void then
					create l_value.make (1)
				end
				l_stone_table := stone_table
				l_tool_table := tool_table
				l_items := items
				l_items.wipe_out
				from
					l_value.start
				until
					l_value.after
				loop
					if
						l_stone_table.has (l_value.key_for_iteration) and then
						l_tool_table.has (l_value.item_for_iteration)
					then
						l_items.force_last ([l_value.item_for_iteration, l_value.key_for_iteration])
					end
					l_value.forth
				end
				set_has_binded (True)
			end

			create l_sorter.make (a_comparator)
			l_sorter.sort (items)
			bind_grid
		end

feature{NONE} -- Implementaion

	bind_grid
			-- Bind `grid'.
		local
			l_grid: like grid
			l_grid_row: EV_GRID_ROW
			l_cursor: DS_ARRAYED_LIST_CURSOR [TUPLE [ a_tool_id: STRING; a_stone_name: STRING]]
		do
			l_grid := grid
			if l_grid.row_count > 0 then
				l_grid.remove_rows (1, l_grid.row_count)
			end
			l_cursor := items.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_grid.insert_new_row (l_grid.row_count + 1)
				l_grid_row := l_grid.row (l_grid.row_count)
				bind_row (l_cursor.item.a_stone_name, l_cursor.item.a_tool_id, l_grid_row)
				l_cursor.forth
			end
			if l_grid.row_count > 0 then
				l_grid.row (1).enable_select
			end
		end

	bind_row (a_stone_name: STRING; a_tool_id: STRING; a_grid_row: EV_GRID_ROW)
			-- Bind `a_stone_name' and `a_tool_id' in `a_grid_row'.
		require
			a_stone_name_attached: a_stone_name /= Void
			a_tool_id_attached: a_tool_id /= Void
			a_grid_row_attached: a_grid_row /= Void
		do
			a_grid_row.set_item (1, stone_grid_item (a_stone_name))
			a_grid_row.set_item (2, tool_grid_item (a_tool_id))
		end

invariant
	tool_name_attached: tool_name /= Void
	grid_attached: grid /= Void
	grid_wrapper_attached: grid_wrapper /= Void
	add_button_attached: add_button /= Void
	remove_button_attached: remove_button /= Void
	stone_table_attached: stone_table /= Void
	stone_name_table_attached: stone_name_table /= Void
	items_attached: items /= Void

end

