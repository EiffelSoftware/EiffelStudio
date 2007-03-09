indexing
	description: "Dialog to setup tools in which a formatter is displayed"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DISPLAYER_DIALOG

inherit
	PROPERTY_DIALOG [HASH_TABLE [TUPLE [view_name: STRING; sorting: STRING], STRING]]
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

	make (a_formatter_name: like formatter_name; a_tools: like tools) is
			-- Initialize `tools' with `a_tools'.
		require
			a_formatter_name_attached: a_formatter_name /= Void
			a_tools_attached: a_tools /= Void
		do
			create display_tool_names.make (10)
			create tool_name_table.make (10)
			create display_name_table.make (10)
			set_formatter_name (a_formatter_name)
			set_tools (a_tools)
			default_create
			show_actions.extend (agent on_show)
		end

	initialize is
			-- Initialize.
		local
			l_box: EV_VERTICAL_BOX
		do
			Precursor
			create grid
			create grid_wrapper.make (grid)
			grid.set_column_count_to (3)
			grid.column (1).set_title (interface_names.l_display)
			grid.column (2).set_title (interface_names.t_tool_name)
			grid.column (3).set_title (interface_names.t_formatter_displayer_name)
			grid_wrapper.set_sort_info (2, create {EVS_GRID_TWO_WAY_SORTING_INFO [STRING_GENERAL]}.make (agent tool_name_tester, ascending_order))
			grid_wrapper.set_sorting_status (grid_wrapper.sorted_columns_from_string ("2:1"))
			grid_wrapper.set_sort_action (agent sort_agent)
			create l_box
			l_box.set_background_color ((create {EV_STOCK_COLORS}).black)
			l_box.set_border_width (1)
			element_container.extend (l_box)
			l_box.extend (grid)
			ok_button.select_actions.extend (agent on_ok_pressed)
		end

feature -- Access

	display_tool_names: DS_ARRAYED_LIST [STRING_GENERAL]
			-- Displayed names for tools

	tool_name_table: HASH_TABLE [STRING, STRING_GENERAL]
			-- [Store name, Display name]

	display_name_table: HASH_TABLE [STRING_GENERAL, STRING]
			-- [Display name, Store name]

	tools: HASH_TABLE [TUPLE [display_name: STRING_GENERAL; pixmap: EV_PIXMAP], STRING]
			-- Supported tools

	formatter_name: STRING_32
			-- Formatter name

feature -- Status report

	has_changed: BOOLEAN
			-- Has display tool as well as view settings changed?

feature -- Setting

	set_has_changed (b: BOOLEAN) is
			-- Set `has_changed' with `b'.
		do
			has_changed := b
		ensure
			has_changed_set: has_changed = b
		end

	set_tools (a_tools: like tools) is
			-- Set `tools' with `a_tools'.
		require
			a_tools_attached: a_tools /= Void
		do
			display_tool_names.wipe_out
			tool_name_table.wipe_out
			display_name_table.wipe_out
			tools := a_tools
			from
				a_tools.start
			until
				a_tools.after
			loop
				display_tool_names.force_last (a_tools.item_for_iteration.display_name)
				tool_name_table.put (a_tools.key_for_iteration, a_tools.item_for_iteration.display_name)
				display_name_table.put (a_tools.item_for_iteration.display_name, a_tools.key_for_iteration)
				a_tools.forth
			end
		end

	set_formatter_name (a_name: like formatter_name) is
			-- Set `formatter_name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			formatter_name := a_name
		ensure
			formatter_name_set: formatter_name /= Void
		end

feature{NONE} -- Actions

	on_tool_checkbox_change (a_checkbox: EV_GRID_CHECKABLE_LABEL_ITEM) is
			-- Action to be performed when selection status of `a_checkbox' changed
		do
			set_has_changed (True)
		end

	on_view_change (a_view: EV_GRID_CHOICE_ITEM) is
			-- Action to be performed when view changes
		do
			a_view.set_data ("")
			set_has_changed (True)
		end

	on_ok_pressed is
			-- Action to be performed when "OK" button is pressed
		do
			if has_changed then
				set_value (value_from_grid)
			end
		end

	on_show is
			-- Action to be performed when Current dialog is shown
		do
			grid_wrapper.disable_auto_sort_order_change
			grid_wrapper.sort (0, 0, 1, 0, 0, 0, 0, 0, 2)
			grid_wrapper.enable_auto_sort_order_change
			bind_grid
			set_has_changed (False)
			set_title (interface_names.t_setup_formatter_tools (formatter_name))
		end

feature{NONE} -- Implementation

	grid: ES_GRID
			-- Grid to display tools

	grid_wrapper: EVS_GRID_WRAPPER [STRING_GENERAL]
			-- Grid wrapper for `grid' to support sorting

	value_from_grid: like value is
			-- Value from `grid'
		local
			i: INTEGER
			l_row: EV_GRID_ROW
			l_row_count: INTEGER
			l_grid: like grid
			l_checkbox: EV_GRID_CHECKABLE_LABEL_ITEM
			l_view: EV_GRID_CHOICE_ITEM
			l_tool_name: STRING
			l_sorting: STRING
			l_view_name: STRING
		do
			create Result.make (2)
			from
				l_grid := grid
				l_row_count := grid.row_count
				i := 1
			until
				i > l_row_count
			loop
				l_row := l_grid.row (i)
				l_tool_name ?= l_row.data
				l_checkbox ?= l_row.item (1)
				l_view ?= l_row.item (3)
				l_sorting ?= l_view.data
				l_view_name ?= view_name_table.item (l_view.text)
				if l_checkbox.is_checked then
					Result.put ([l_view_name, l_sorting], l_tool_name)
				end
				i := i + 1
			end
		ensure
			result_attached: Result /= Void
		end

	view_name_table: HASH_TABLE [STRING, STRING_GENERAL] is
			--
		local
			l_tbl: like view_table
		do
			l_tbl := view_table
			create Result.make (l_tbl.count)
			from
				l_tbl.start
			until
				l_tbl.after
			loop
				Result.put (l_tbl.key_for_iteration, l_tbl.item_for_iteration)
				l_tbl.forth
			end
		ensure
			result_attached: Result /= Void
		end

	view_name_list: LINKED_LIST [STRING_GENERAL] is
			-- List of supported view names.
		local
			l_view_table: like view_table
		do
			create Result.make
			l_view_table := view_table
			from
				l_view_table.start
			until
				l_view_table.after
			loop
				Result.extend (l_view_table.item_for_iteration)
				l_view_table.forth
			end
		ensure
			result_attached: Result /= Void
		end

	view_table: HASH_TABLE [STRING_GENERAL, STRING] is
			-- View table.
			-- [View display name, View store name]
		local
			l_displayers: EB_FORMATTER_DISPLAYERS
		once
			create Result.make (7)
			create l_displayers
			Result.put (interface_names.l_class_tree_displayer, l_displayers.class_tree_displayer)
			Result.put (interface_names.l_class_flat_displayer, l_displayers.class_flat_displayer)
			Result.put (interface_names.l_class_feature_displayer, l_displayers.class_feature_displayer)
			Result.put (interface_names.l_feature_displayer, l_displayers.feature_displayer)
			Result.put (interface_names.l_feature_caller_displayer, l_displayers.feature_caller_displayer)
			Result.put (interface_names.l_feature_callee_displayer, l_displayers.feature_callee_displayer)
			Result.put (interface_names.l_dependency_displayer, l_displayers.dependency_displayer)
			Result.put (interface_names.l_domain_displayer, l_displayers.domain_displayer)
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation/Sorting

	tool_name_tester (a_tool, b_tool: STRING_GENERAL; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order between `a_tool' and `b_tool' according to `a_order'
		require
			a_tool_attached: a_tool /= Void
			b_tool_attached: b_tool /= Void
		do
			if a_order = ascending_order then
				Result := a_tool <= b_tool
			else
				Result := a_tool > b_tool
			end
		end

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [STRING_GENERAL]) is
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty:
		local
			l_sorter: DS_QUICK_SORTER [STRING_GENERAL]
		do
			create l_sorter.make (a_comparator)
			l_sorter.sort (display_tool_names)
			bind_grid
		end

feature{NONE} -- Implementation/Binding

	bind_grid is
			-- Bind grid.
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [STRING_GENERAL]
			l_grid: like grid
			l_value: like value
			l_grid_row: EV_GRID_ROW
			l_info: TUPLE [view_name: STRING; sorting: STRING]
			l_tool_name: STRING
			l_displayers: EB_FORMATTER_DISPLAYERS
			l_size_table: HASH_TABLE [TUPLE [INTEGER, INTEGER], INTEGER]
		do
			create l_displayers
			l_value := value
			if l_value = Void then
				create l_value.make (1)
			end
			l_grid := grid
			if l_grid.row_count > 0 then
				l_grid.remove_rows (1, l_grid.row_count)
			end
			l_cursor := display_tool_names.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_grid.insert_new_row (l_grid.row_count + 1)
				l_grid_row := l_grid.row (l_grid.row_count)
				l_tool_name := tool_name_table.item (l_cursor.item)
				l_info := l_value.item (l_tool_name)
				if l_info = Void then
					bind_row (l_grid_row, l_tool_name, False, l_displayers.domain_displayer, "")
				else
					bind_row (l_grid_row, l_tool_name, True, l_info.view_name, l_value.item (l_tool_name).sorting)
				end
				l_cursor.forth
			end
			create l_size_table.make (2)
			l_size_table.put ([70, 80], 1)
			l_size_table.put ([150, 200], 2)
			grid_wrapper.auto_resize_columns (grid, l_size_table)
		end

	bind_row (a_grid_row: EV_GRID_ROW; a_tool: STRING; a_selected: BOOLEAN; a_view: STRING; a_sorting: STRING) is
			-- Bind `a_tool' with view `a_view' and selected status `a_selected' in `a_grid_row'.
		require
			a_grid_row_attached: a_grid_row /= Void
			a_tool_attached: a_tool /= Void
			a_view_attached: a_view /= Void
			a_sorting_attached: a_sorting /= Void
		local
			l_checkbox: EV_GRID_CHECKABLE_LABEL_ITEM
			l_tool: EV_GRID_LABEL_ITEM
			l_view: EV_GRID_CHOICE_ITEM
		do
			create l_checkbox
			l_checkbox.set_is_checked (a_selected)
			l_checkbox.checked_changed_actions.extend (agent on_tool_checkbox_change)
			a_grid_row.set_item (1, l_checkbox)

			create l_tool.make_with_text (display_name_table.item (a_tool))
			l_tool.set_pixmap (tools.item (a_tool).pixmap)
			l_tool.set_data (a_tool)
			a_grid_row.set_item (2, l_tool)

			create l_view
			l_view.set_item_strings (view_name_list)
			l_view.set_text (view_table.item (a_view))
			l_view.pointer_button_press_actions.force_extend (agent l_view.activate)
			l_view.select_actions.extend (agent on_view_change (l_view))
			l_view.set_data (a_sorting)
			a_grid_row.set_data (a_tool)
			a_grid_row.set_item (3, l_view)
		end

end

