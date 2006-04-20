indexing
	description	: "Window to display results from a query."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Christophe BONNARD, Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILE_QUERY_WINDOW

inherit
	EV_TITLED_WINDOW

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SHARED_QUERY_VALUES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_INTERFACE_TOOLS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	E_PROFILER_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_default

feature {NONE} -- Initialization

	make_default is
			-- Create Current.
		do
			default_create
			set_title (Interface_names.t_Profile_query_window)
			set_icon_pixmap (Pixmaps.Icon_profiler_window)

			create all_subqueries.make
			create all_operators.make

			init_commands
			build_interface
			resize_actions.extend (agent resize_columns)
		end

	init_commands is
		do
			create run_query_cmd.make (Current)
			create save_result_cmd.make (Current)
		end

	resize_columns (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Resize the columns for the active & inactive query lists
		do
			active_query_window.set_column_width (active_query_window.width, 1)
			inactive_subqueries_window.set_column_width (inactive_subqueries_window.width, 1)
		end

	build_interface is
			-- Build the user interfac			-- Initialize the commands
		local
			container: EV_VERTICAL_BOX			-- Widget containing all others
			query_box: EV_HORIZONTAL_BOX		-- Form for the query
			subquery_box: EV_HORIZONTAL_BOX		-- Box for `subquery_text'
			query_button_form: EV_VERTICAL_BOX	-- Form with buttons allowing subqueries activation/inactivation
			grid_border: EV_VERTICAL_BOX		-- A border to be placed around `output_grid'.
			subquery_frame: EV_FRAME			-- Frame for the subquery
			button_box: EV_HORIZONTAL_BOX		-- Box for the buttons
			--| FIXME help_button: EV_BUTTON	-- Button for `help'
			run_button: EV_BUTTON 				-- Button for `run_subquery_cmd'
			save_as_button: EV_BUTTON			-- Button for `save_result_cmd'
			close_button: EV_BUTTON				-- Button to close Current
			add_or_operator_button: EV_BUTTON	-- Button to add a subquery with 'or' operator
			add_and_operator_button: EV_BUTTON	-- Button to add a subquery with 'and' operator
			set_and_operator_button: EV_BUTTON	-- Button to set all the selected subqueries operators to 'and'
			set_or_operator_button: EV_BUTTON	-- Button to set all the selected subqueries operators to 'or'
			reactivate_button: EV_BUTTON		-- Button to reactivate one or more subqueries
			inactivate_button: EV_BUTTON		-- Button to inactivate one or more subqueries
		do
			close_request_actions.extend (agent close)

				--| Create the Active & Inactive list
			create active_query_window
			active_query_window.enable_multiple_selection
			active_query_window.set_column_title (Interface_names.l_Active_query, 1)
			create inactive_subqueries_window
			inactive_subqueries_window.enable_multiple_selection
			inactive_subqueries_window.set_column_title (Interface_names.l_Inactive_subqueries, 1)

				--| Query buttons (Activate, Inactivate, Or, And)
			create reactivate_button.make_with_text_and_action ("< Activate", agent reactivate)
			create inactivate_button.make_with_text_and_action ("Inactivate >", agent inactivate)
			create set_or_operator_button.make_with_text_and_action (Interface_names.b_Or, agent change_operator (profiler_or))
			create set_and_operator_button.make_with_text_and_action (Interface_names.b_And, agent change_operator (profiler_and))
			create query_button_form
			query_button_form.set_padding (Layout_constants.Small_border_size)
			extend_button (query_button_form, reactivate_button)
			extend_button (query_button_form, inactivate_button)
			extend_button (query_button_form, set_or_operator_button)
			extend_button (query_button_form, set_and_operator_button)
			query_button_form.extend (create {EV_CELL}) -- Expandable item

				--| Query box (contain Active Query, Add/Remove Buttons, Inactive Subqueries)
			create query_box
			query_box.set_padding (Layout_constants.Small_border_size)
			query_box.extend (active_query_window) -- expandable item
			query_box.extend (query_button_form)
			query_box.disable_item_expand (query_button_form)
			query_box.extend (inactive_subqueries_window) -- expandable item

				--| Subquery frame
			create add_and_operator_button.make_with_text_and_action (Interface_names.b_And, agent add_subquery (profiler_and))
			create add_or_operator_button.make_with_text_and_action (Interface_names.b_Or, agent add_subquery (profiler_or))
			create subquery_text

			create subquery_box
			subquery_box.set_border_width (Layout_constants.Small_border_size)
			subquery_box.set_padding (Layout_constants.Small_border_size)
			subquery_box.extend (subquery_text) -- expandable item
			extend_button (subquery_box, add_and_operator_button)
			extend_button (subquery_box, add_or_operator_button)

			create subquery_frame.make_with_text (Interface_names.l_Subquery)
			subquery_frame.extend (subquery_box)

			create output_grid
			output_grid.enable_multiple_row_selection
			output_grid.set_item_pebble_function (agent retrieve_pebble)
			output_grid.pointer_motion_item_actions.extend (agent record_mouse_relative_to_item)
			output_grid.row_expand_actions.extend (agent row_expanded)
			output_grid.row_collapse_actions.extend (agent row_collapsed)
			output_grid.pointer_button_press_item_actions.extend (agent item_pressed)
			output_grid.key_press_actions.extend (agent key_pressed)
			output_grid.mouse_wheel_actions.extend (agent mouse_wheel_received)

			create grid_border
			grid_border.set_border_width (1)
			grid_border.set_background_color (gray)
			grid_border.extend (output_grid)

			create tree_nodes_enabled_button.make_with_text ("Nest Output?")
			tree_nodes_enabled_button.select_actions.extend (agent tree_node_state_toggled)

				--| Build button bar
			--|FIXME: Put the Help button back when help is available.
			--|FIXME create help_button.make_with_text (Interface_names.b_Help)
			create run_button.make_with_text_and_action (Interface_names.b_Update, agent run_query_cmd.execute)
			create save_as_button.make_with_text_and_action (Interface_names.b_Save, agent save_result_cmd.execute)
			create close_button.make_with_text_and_action (Interface_names.b_Close, agent close)
			create button_box
			button_box.set_border_width (Layout_constants.Small_border_size)
			button_box.set_padding (Layout_constants.Small_border_size)
			--| FIXME extend_button (button_box, help_button)
			button_box.extend (create {EV_CELL}) -- expandable item
			extend_button (button_box, run_button)
			extend_button (button_box, save_as_button)
			extend_button (button_box, close_button)

				--| Build forms
			create container
			container.set_padding (Layout_constants.Small_padding_size)
			container.set_border_width (Layout_constants.Small_border_size)
			container.extend (query_box)
			container.disable_item_expand (query_box)
			container.extend (subquery_frame)
			container.disable_item_expand (subquery_frame)
			container.extend (tree_nodes_enabled_button)
			container.disable_item_expand (tree_nodes_enabled_button)
			container.extend (grid_border) -- expandable item
			container.extend (button_box)
			container.disable_item_expand (button_box)
			extend (container)

				--| Sizing
			set_window_size

				-- Retrieve colors from the preferences
			handle_color_change

				-- Connect agents to the preferences so we can update the display as required.
			colors_changed_agent := agent handle_color_change
			preferences.editor_data.feature_text_color_preference.change_actions.extend (colors_changed_agent)
			preferences.editor_data.cluster_text_color_preference.change_actions.extend (colors_changed_agent)
			preferences.editor_data.class_text_color_preference.change_actions.extend (colors_changed_agent)

		end

feature {EB_SAVE_RESULT_CMD} -- Save commands

	save_it (ptf: RAW_FILE) is
			-- Save window content in `ptf'.
		require
			pft_not_void: ptf /= Void
		local
			a_string: STRING
			i: INTEGER
			current_row: EV_GRID_ROW
		do
			a_string := ""
			ptf.create_read_write
			from
				i := 1
			until
				i > output_grid.row_count
			loop
				current_row := output_grid.row (i)
				append_row_to_string (current_row, a_string)
				i := i + 1
			end
			ptf.put_string (a_string)
			ptf.put_new_line
			ptf.close
		end

feature -- Status Setting

	set_window_size is
			-- Set window size, according to preferences.
		do
--| FIXME ARNAUD: To be fixed (Save window size into preferences and restore it)
			set_size (Layout_constants.Dialog_unit_to_pixels(600), Layout_constants.Dialog_unit_to_pixels(500))
--| END FIXME ARNAUD.
		end

	update_window (pq: PROFILER_QUERY;
				po: PROFILER_OPTIONS; pi: PROFILE_INFORMATION) is
			-- Update User Interface Widgets to reflect the parameters:
			-- This window will be associated with `pq', will
			-- use `po' and `profinfo', and display `st'.
		local
			i, j, k, l: INTEGER
			profile_set: PROFILE_SET
			profile_set_count: INTEGER
			quick_sorter: DS_ARRAY_QUICK_SORTER [EB_PROFILE_QUERY_GRID_ROW]
			equality_tester: AGENT_BASED_EQUALITY_TESTER [EB_PROFILE_QUERY_GRID_ROW]
			current_eiffel_profile_data: EIFFEL_PROFILE_DATA
			current_c_profile_data: C_PROFILE_DATA
			current_cycle_profile_data: CYCLE_PROFILE_DATA
			current_profile_data: PROFILE_DATA
			function: EIFFEL_FUNCTION
			last_cluster_string: STRING
			last_class_id: INTEGER
			class_lower, class_upper, cluster_lower, cluster_upper: INTEGER
			current_cluster_string: STRING
			current_class_id: INTEGER
			query_grid_item: EB_PROFILE_QUERY_GRID_ROW
			last_cluster, last_class: EB_PROFILE_QUERY_GRID_ROW
			row: EB_PROFILE_QUERY_GRID_ROW
			sorted_tuple: TUPLE [BOOLEAN, BOOLEAN]
		do
			profiler_query := pq
			profiler_options := po
			profinfo := pi
			i := 1
				-- Feature name is always shown.
			show_feature_name := True
			i := i + 1

				-- Now assign information from `profiler_options' to BOOLEAN
				-- attributes for speed and ease of use when querying.
			if profiler_options.output_names.valid_index (i) and then profiler_options.output_names.item (i).is_equal (profiler_calls) then
				show_calls := True
				i := i + 1
			end
			if profiler_options.output_names.valid_index (i) and then profiler_options.output_names.item (i).is_equal (profiler_self) then
				show_self := True
				i := i + 1
			end
			if profiler_options.output_names.valid_index (i) and then profiler_options.output_names.item (i).is_equal (profiler_descendants) then
				show_descendents := True
				i := i + 1
			end
			if profiler_options.output_names.valid_index (i) and then profiler_options.output_names.item (i).is_equal (profiler_total) then
				show_total := True
				i := i + 1
			end
			if profiler_options.output_names.valid_index (i) and then profiler_options.output_names.item (i).is_equal (profiler_percentage) then
				show_percentage := True
				i := i + 1
			end

			count_active_subqueries
			if profiler_query.subqueries.count > active_subqueries then
				from
					profiler_query.subqueries.go_i_th (active_subqueries + 1)
					profiler_query.subquery_operators.go_i_th (active_subqueries)
					if profiler_query.subquery_operators.before then
						profiler_query.subquery_operators.forth
					end
				until
					profiler_query.subqueries.after
				loop
					all_subqueries.extend (profiler_query.subqueries.item)
					profiler_query.subqueries.forth
					if not profiler_query.subquery_operators.after then
						all_operators.extend (profiler_query.subquery_operators.item)
						profiler_query.subquery_operators.forth
					end
				end
			end

			update_query_frame
			subquery_text.remove_text
			output_grid.wipe_out
			profile_set := pi.profile_data
			profile_set_count := profile_set.c_profiling_list.count + profile_set.cycle_profiling_list.count + profile_set.eiffel_profiling_list.count

				-- Store the flat profile information.
			create profile_array.make (1, profile_set_count)
			from
				profile_set := pi.profile_data
				profile_set.start
				i := 1
			until
				profile_set.after
			loop
				current_profile_data := profile_set.item
				current_eiffel_profile_data ?= current_profile_data
				if current_eiffel_profile_data /= Void then
					create query_grid_item.make_node (current_profile_data.function.name, current_profile_data, 4)
				else
					create query_grid_item.make_node (current_profile_data.function.name, current_profile_data, 5)
				end
				if current_eiffel_profile_data /= Void then
						-- Now we perform special handling for the row as we must have access to each of the three
						-- feature, class and cluster texts individually.
					query_grid_item.set_cluster_class_feature_text (current_eiffel_profile_data.function.class_c.group.name + full_stop, eiffel_system.class_of_id (current_eiffel_profile_data.function.class_id).name + full_stop, current_eiffel_profile_data.function.displayed_feature_name)
				end
				query_grid_item.set_values (current_profile_data.calls, current_profile_data.self, current_profile_data.descendants, current_profile_data.total, current_profile_data.percentage)
				profile_array.put (query_grid_item, i)
				i := i + 1
				profile_set.forth
			end

				-- Perform a sort to ensure that all data is in order before
				-- building the tree info.
			create equality_tester.make (agent compare_profile_query_grid_rows (?, ?, 1, True))
			create quick_sorter.make (equality_tester)
			quick_sorter.sort (profile_array)

				-- Store the tree profile information needed for the tree mode.
			from
				create cluster_array.make (1, 0)
				create class_array.make (1, 0)
				create feature_array.make (1, 0)
				create c_functions_array.make (1, 0)
				create cyclic_functions_array.make (1, 0)
				create root_nodes_array.make (1, 0)
				i := 1
				cluster_lower := 1
				class_lower := 1
				class_upper := 1
				cluster_upper := 1
				last_cluster_string := ""
				last_class_id := 0
			until
				i > profile_array.count
			loop
				current_eiffel_profile_data ?= (profile_array.item (i)).profile_data
				if current_eiffel_profile_data /= Void then
					function := current_eiffel_profile_data.function
					current_cluster_string := function.class_c.group.name
					current_class_id := function.class_id
					if not last_cluster_string.is_equal (current_cluster_string) then
						if last_cluster /= Void then
							last_cluster.set_upper (cluster_lower - 1)
						end
						create query_grid_item.make_parent (cluster_lower, cluster_lower, current_cluster_string, current_eiffel_profile_data, 3)
						cluster_array.force (query_grid_item, cluster_array.upper + 1)
						last_cluster := query_grid_item
					end
					if last_class_id /= current_class_id then
						if last_class /= Void then
							last_class.set_upper (class_lower - 1)
						end
						create query_grid_item.make_parent (class_lower, class_lower, eiffel_system.class_of_id (function.class_id).name, current_eiffel_profile_data, 2)
						class_array.force (query_grid_item, class_array.upper + 1)
						cluster_lower := cluster_lower + 1
						last_class := query_grid_item

					end
					create query_grid_item.make_node (function.displayed_feature_name, current_eiffel_profile_data, 1)
					query_grid_item.set_values (current_eiffel_profile_data.calls, current_eiffel_profile_data.self, current_eiffel_profile_data.descendants, current_eiffel_profile_data.total, current_eiffel_profile_data.percentage)
					feature_array.force (query_grid_item, feature_array.upper + 1)

						-- Now update totals for classes and clusters.
					if last_class /= Void then
						last_class.increase_values (current_eiffel_profile_data.calls, current_eiffel_profile_data.self, current_eiffel_profile_data.descendants, current_eiffel_profile_data.total, current_eiffel_profile_data.percentage)
					end

					last_cluster_string := current_cluster_string
					last_class_id := current_class_id
					class_lower := class_lower + 1
				else
					current_profile_data := (profile_array.item (i)).profile_data
					current_c_profile_data ?= current_profile_data
					if current_c_profile_data /= Void then
						create query_grid_item.make_node (current_c_profile_data.function.name, current_c_profile_data, 5)
						query_grid_item.set_values (current_c_profile_data.calls, current_c_profile_data.self, current_c_profile_data.descendants, current_c_profile_data.total, current_c_profile_data.percentage)
						c_functions_array.force (query_grid_item, c_functions_array.upper + 1)
					else
						current_cycle_profile_data ?= current_profile_data
						check
							unsupported_type: current_cycle_profile_data = Void
						end
						create query_grid_item.make_node (current_cycle_profile_data.function.name, current_cycle_profile_data, 5)
						query_grid_item.set_values (current_cycle_profile_data.calls, current_cycle_profile_data.self, current_cycle_profile_data.descendants, current_cycle_profile_data.total, current_cycle_profile_data.percentage)
						cyclic_functions_array.force (query_grid_item, cyclic_functions_array.upper + 1)
					end

				end
				i := i + 1
			end

				-- The loop does not handle the upper of the final items, so
				-- set them explicitly here.
			if not cluster_array.is_empty then
				query_grid_item := cluster_array.item (cluster_array.upper)
				query_grid_item.set_upper (class_array.upper)
			end
			if not class_array.is_empty then
				query_grid_item := class_array.item (class_array.upper)
				query_grid_item.set_upper (feature_array.upper)
			end

					-- Now build the root nodes for Eiffel queries.
			if feature_array.count >= 1 then
				create query_grid_item.make_node (Profiler_eiffel_features, Void, 5)
				query_grid_item.set_display_agent (agent build_eiffel_functions)
				root_nodes_array.force (query_grid_item, root_nodes_array.upper + 1)
			end

				-- Now sum cluster totals.
			from
				i := 1
			until
				i > cluster_array.count
			loop
				last_cluster := cluster_array [i]
				j := last_cluster.child_node_lower_index
				k := last_cluster.child_node_upper_index
				from
					l := j
				until
					l > k
				loop
					last_class := class_array [l]
					last_cluster.increase_values (last_class.calls, last_class.self, last_class.descendents, last_class.total, last_class.percentage)
					l := l + 1
				end
				query_grid_item.increase_values (last_cluster.calls, last_cluster.self, last_cluster.descendents, last_cluster.total, last_cluster.percentage)
				i := i + 1
			end

			if c_functions_array.count >= 1 then
				create query_grid_item.make_node (profiler_c_functions, Void, 5)
				query_grid_item.set_display_agent (agent build_c_functions)
				root_nodes_array.force (query_grid_item, root_nodes_array.upper + 1)

					-- Now Sum c_function totals.
				from
					i := 1
				until
					i > c_functions_array.count
				loop
					row := c_functions_array [i]
					query_grid_item.increase_values (row.calls, row.self, row.descendents, row.total, row.percentage)
					i := i + 1
				end
			end
			if cyclic_functions_array.count >= 1 then
				create query_grid_item.make_node (profiler_cyclic_functions, Void, 5)
				query_grid_item.set_display_agent (agent build_cyclic_functions)
				root_nodes_array.force (query_grid_item, root_nodes_array.upper + 1)
					-- Now Sum cyclic totals.
				from
					i := 1
				until
					i > cyclic_functions_array.count
				loop
					row := cyclic_functions_array [i]
					query_grid_item.increase_values (row.calls, row.self, row.descendents, row.total, row.percentage)
					i := i + 1
				end
			end

			create displayed_column_indexes.make (1, 6)
				-- Build the column headers
				-- Note that "Function" is always displayed.
			output_grid.insert_new_column (1)
			displayed_column_indexes.put (1, 1)
			output_grid.column (1).set_title ("Function")
			output_grid.column (1).header_item.pointer_button_press_actions.force_extend (agent sort_column (1))
			output_grid.column (1).header_item.pointer_double_press_actions.force_extend (agent resize_column (1))
			create sorted_tuple
			sorted_tuple.put_boolean (True, 1)
			sorted_tuple.put_boolean (True, 2)
			output_grid.column (1).set_data (sorted_tuple)

			if show_calls then
				i := output_grid.column_count + 1
				output_grid.insert_new_column (i)
				output_grid.column (i).set_title ("Calls")
				output_grid.column (i).header_item.pointer_button_press_actions.force_extend (agent sort_column (2))
				displayed_column_indexes.put (i, 2)
				output_grid.column (i).header_item.pointer_double_press_actions.force_extend (agent resize_column (i))
				create sorted_tuple
				sorted_tuple.put_boolean (True, 1)
				sorted_tuple.put_boolean (True, 2)
				output_grid.column (i).set_data (sorted_tuple)
			end
			if show_self then
				i := output_grid.column_count + 1
				output_grid.insert_new_column (i)
				output_grid.column (i).set_title ("Self")
				output_grid.column (i).header_item.pointer_button_press_actions.force_extend (agent sort_column (3))
				displayed_column_indexes.put (i, 3)
				output_grid.column (i).header_item.pointer_double_press_actions.force_extend (agent resize_column (i))
				create sorted_tuple
				sorted_tuple.put_boolean (True, 1)
				sorted_tuple.put_boolean (True, 2)
				output_grid.column (i).set_data (sorted_tuple)
			end
			if show_descendents then
				i := output_grid.column_count + 1
				output_grid.insert_new_column (i)
				output_grid.column (i).set_title ("Descendants")
				output_grid.column (i).header_item.pointer_button_press_actions.force_extend (agent sort_column (4))
				displayed_column_indexes.put (i, 4)
				output_grid.column (i).header_item.pointer_double_press_actions.force_extend (agent resize_column (i))
				create sorted_tuple
				sorted_tuple.put_boolean (True, 1)
				sorted_tuple.put_boolean (True, 2)
				output_grid.column (i).set_data (sorted_tuple)
			end
			if show_total then
				i := output_grid.column_count + 1
				output_grid.insert_new_column (i)
				output_grid.column (i).set_title ("Total")
				output_grid.column (i).header_item.pointer_button_press_actions.force_extend (agent sort_column (5))
				displayed_column_indexes.put (i, 5)
				output_grid.column (i).header_item.pointer_double_press_actions.force_extend (agent resize_column (i))
				create sorted_tuple
				sorted_tuple.put_boolean (True, 1)
				sorted_tuple.put_boolean (True, 2)
				output_grid.column (i).set_data (sorted_tuple)
			end
			if show_percentage then
				i := output_grid.column_count + 1
				output_grid.insert_new_column (i)
				output_grid.column (i).set_title ("Percentage")
				output_grid.column (i).header_item.pointer_button_press_actions.force_extend (agent sort_column (6))
				displayed_column_indexes.put (i, 6)
				output_grid.column (i).header_item.pointer_double_press_actions.force_extend (agent resize_column (i))
				create sorted_tuple
				sorted_tuple.put_boolean (True, 1)
				sorted_tuple.put_boolean (True, 2)
				output_grid.column (i).set_data (sorted_tuple)
			end

			rebuild_grid
		end

feature {NONE} -- Implementation

	displayed_column_indexes: ARRAY [INTEGER]
		-- Mapping of logical column index (1-6) to
		-- physical column index as displayed in `Current'.
		-- If a column is not shown, its entry is zero.

	profile_array: ARRAY [EB_PROFILE_QUERY_GRID_ROW]
		-- All grid rows used in the flat list mode.

	cluster_array: ARRAY [EB_PROFILE_QUERY_GRID_ROW]
	class_array: ARRAY [EB_PROFILE_QUERY_GRID_ROW]
	feature_array: ARRAY [EB_PROFILE_QUERY_GRID_ROW]
	c_functions_array: ARRAY [EB_PROFILE_QUERY_GRID_ROW]
	cyclic_functions_array: ARRAY [EB_PROFILE_QUERY_GRID_ROW]
		-- Arrays to hold all grid rows used in the tree structure
		-- mode. Grouped accordingly.

	root_nodes_array: ARRAY [EB_PROFILE_QUERY_GRID_ROW]
		-- All root nodes to be shown in `output_grid'.
		-- Eiffel, C or Cyclic nodes. Only used in the
		-- tree structure mode.

	calls, self, descendants, total, percentage: REAL
	cluster_calls, cluster_self, cluster_descendants, cluster_total, cluster_percentage: REAL
	class_calls, class_self, class_descendants, class_total, class_percentage: REAL
		-- Attributes to hold information totals during building of the structured tree mode.
		-- They are not defined as locals within `rebuild_grid' as this permits functions to
		-- be implemented which deal with them, thereby reducing repeated code.

	show_feature_name, show_calls, show_self, show_descendents, show_total, show_percentage: BOOLEAN
		-- Attributes to hold which columns of data are to be displayed. These
		-- are set from `profiler_options.output_names' so they can be quickly queried.

	fill_grid_row (query_grid_row: EB_PROFILE_QUERY_GRID_ROW; row_index: INTEGER) is
			-- Fill `output_grid' row `row_index' with data from `query_grid_row'.
		require
			query_grid_row_not_void: query_grid_row /= Void
			valid_row_index: row_index >= 1 and row_index <= output_grid.row_count + 1
		local
			i: INTEGER
			feature_grid_item: EV_GRID_DRAWABLE_ITEM
			calls_grid_item, self_grid_item, descendents_grid_item, total_grid_item, percentage_grid_item: EV_GRID_LABEL_ITEM
		do
				-- Create grid items to be associated with `query_grid_row' if not already created.
			if query_grid_row.feature_grid_item = Void then
				create feature_grid_item.make_with_expose_action_agent (agent draw_grid_item (?, query_grid_row))
				if show_calls then
					create calls_grid_item.make_with_text (query_grid_row.calls.out)
				end
				if show_self then
					create self_grid_item.make_with_text (query_grid_row.self.out)
				end
				if show_descendents then
					create descendents_grid_item.make_with_text (query_grid_row.descendents.out)
				end
				if show_total then
					create total_grid_item.make_with_text (query_grid_row.total.out)
				end
				if show_percentage then
					create percentage_grid_item.make_with_text (query_grid_row.percentage.out)
				end
				query_grid_row.set_grid_items (feature_grid_item, calls_grid_item, self_grid_item, descendents_grid_item, total_grid_item, percentage_grid_item)
			end

			output_grid.set_item (1, row_index, query_grid_row.feature_grid_item)
			i := 2
			if show_calls then
				output_grid.set_item (i, row_index, query_grid_row.calls_grid_item)
				i := i + 1
			end
			if show_self then
				output_grid.set_item (i, row_index, query_grid_row.self_grid_item)
				i := i + 1
			end
			if show_descendents then
				output_grid.set_item (i, row_index, query_grid_row.descendents_grid_item)
				i := i + 1
			end
			if show_total then
				output_grid.set_item (i, row_index, query_grid_row.total_grid_item)
				i := i + 1
			end
			if show_percentage then
				output_grid.set_item (i, row_index, query_grid_row.percentage_grid_item)
				i := i + 1
			end

				-- Connect the `query_grid_row' and `output_grid.row' so
				-- once may be accessed from the other.
			output_grid.row (row_index).set_data (query_grid_row)
			query_grid_row.set_row (output_grid.row (row_index))
		end

	rebuild_grid is
			-- Perform a complete rebuild of `output_grid' based on current settings.
		local
			i: INTEGER
			query_grid_row: EB_PROFILE_QUERY_GRID_ROW
		do
				-- Remove all existing rows. We do not wish to call `wipe_out'
				-- as we do not want to loose the columns.
			if output_grid.row_count > 0 then
				output_grid.remove_rows (1, output_grid.row_count)
			end
			if not tree_structure_enabled then
				output_grid.disable_tree
				from
					i := 1
				until
					i > profile_array.count
				loop
					query_grid_row := profile_array.item (i)
					fill_grid_row (query_grid_row, i)
					i := i + 1
				end
			else
				output_grid.enable_tree
				from
					i := 1
				until
					i > root_nodes_array.count
				loop
					(root_nodes_array.item (i)).display_agent.call ([root_nodes_array.item (i)])
					i := i + 1
				end
			end

				-- Now update the expanded state of all rows contained.
				-- Only if tree structure enabled.		
			if tree_structure_enabled then
				from
					i := output_grid.row_count
				until
					i < 1
				loop
					query_grid_row ?= output_grid.row (i).data
					if query_grid_row.is_expanded then
						query_grid_row.row.expand
					end
					i := i - 1
				end
			end
		end

	build_eiffel_functions (query_grid_row: EB_PROFILE_QUERY_GRID_ROW) is
			-- Build all Eiffel functions into `output_grid' as child rows
			-- of `query_grid_row'.
		require
			query_grid_row_not_void: query_grid_row /= Void
		local
			cluster_index, class_index, feature_index: INTEGER
			cluster_query_grid_row, class_query_grid_row, feature_query_grid_row: EB_PROFILE_QUERY_GRID_ROW
			class_lower, class_upper, cluster_lower, cluster_upper: INTEGER
			cluster_row_index, class_row_index, feature_row_index: INTEGER
			cluster_node_index: INTEGER
		do
			if cluster_array.count >= 1 then
				cluster_node_index := output_grid.row_count + 1
				fill_grid_row (query_grid_row, cluster_node_index)
				from
					cluster_index := 1
				until
					cluster_index > cluster_array.count
				loop
					cluster_query_grid_row := cluster_array [cluster_index]
					cluster_lower := cluster_query_grid_row.child_node_lower_index
					cluster_upper := cluster_query_grid_row.child_node_upper_index
					cluster_row_index := output_grid.row_count + 1
					fill_grid_row (cluster_query_grid_row, cluster_row_index)
					output_grid.row (cluster_node_index).add_subrow (output_grid.row (cluster_row_index))
					from
						class_index := cluster_lower
					until
						class_index > cluster_upper
					loop
						class_query_grid_row := class_array [class_index]
						class_lower := class_query_grid_row.child_node_lower_index
						class_upper := class_query_grid_row.child_node_upper_index
						class_row_index := output_grid.row_count + 1
						fill_grid_row (class_query_grid_row, class_row_index)
						output_grid.row (cluster_row_index).add_subrow (output_grid.row (class_row_index))
						from
							feature_index := class_lower
						until
							feature_index > class_upper
						loop
							feature_query_grid_row ?= feature_array [feature_index]
							feature_row_index := output_grid.row_count + 1
							fill_grid_row (feature_query_grid_row, feature_row_index)
							output_grid.row (class_row_index).add_subrow (output_grid.row (feature_row_index))
							feature_index := feature_index + 1
						end
						class_index := class_index + 1
					end
					cluster_index := cluster_index + 1
				end
			end
		end

	build_c_functions (query_grid_row: EB_PROFILE_QUERY_GRID_ROW) is
			-- Build all c functions into `output_grid' as child rows
			-- of `query_grid_row'.
		require
			query_grid_row_not_void: query_grid_row /= Void
		local
			i, k, c_node_index: INTEGER
			c_function_query_grid_row: EB_PROFILE_QUERY_GRID_ROW
		do
			if c_functions_array.count >= 1 then
				c_node_index := output_grid.row_count + 1
				fill_grid_row (query_grid_row, c_node_index)
				from
					i := 1
				until
					i > c_functions_array.count
				loop
					c_function_query_grid_row := c_functions_array [i]
					k := output_grid.row_count + 1
					fill_grid_row (c_function_query_grid_row, k)
					output_grid.row (c_node_index).add_subrow (output_grid.row (k))
					i := i + 1
				end
			end
		end

	build_cyclic_functions (query_grid_row: EB_PROFILE_QUERY_GRID_ROW) is
			-- Build all cyclic functions into `output_grid' as child rows
			-- of `query_grid_row'.
		require
			query_grid_row_not_void: query_grid_row /= Void
		local
			i, k, cyclic_node_index: INTEGER
			cyclic_function_query_grid_row: EB_PROFILE_QUERY_GRID_ROW
		do
			if cyclic_functions_array.count >= 1 then
				cyclic_node_index := output_grid.row_count + 1
				fill_grid_row (query_grid_row, cyclic_node_index)
				from
					i := 1
				until
					i > cyclic_functions_array.count
				loop
					cyclic_function_query_grid_row := cyclic_functions_array [i]
					k := output_grid.row_count + 1
					fill_grid_row (cyclic_function_query_grid_row, k)
					output_grid.row (cyclic_node_index).add_subrow (output_grid.row (k))
					i := i + 1
				end
			end
		end

	draw_grid_item (drawable: EV_DRAWABLE; query_grid_row: EB_PROFILE_QUERY_GRID_ROW) is
			-- Draw feature grid item of `query_grid_row' into `drawable'.
		require
			drawable_not_void: drawable /= Void
			query_grid_row_not_void: query_grid_row /= Void
		local
			offset: INTEGER
			font: EV_FONT
			row_selected, focused: BOOLEAN
			adjusted_column_width: INTEGER
		do
			row_selected := query_grid_row.row.is_selected
			focused := output_grid.has_focus
			if row_selected then
				if focused then
					drawable.set_foreground_color (output_grid.focused_selection_color)
				else
					drawable.set_foreground_color (output_grid.non_focused_selection_color)
				end
			else
				drawable.set_foreground_color (white)
			end
				-- Firstly fill the background area of the grid. We respect the
				-- selected state of the row by drawing in the correct selection color
				-- if selected.
			drawable.fill_rectangle (0, 0, drawable.width, drawable.height)

				-- Calculate the width of the first column less the current horizontal indent
				-- of the item being drawn. This is required to draw the ellipsing correctly.
			adjusted_column_width := output_grid.column (1).width - query_grid_row.row.item (1).horizontal_indent
			font := drawing_font
			drawable.set_font (drawing_font)
			if query_grid_row.type = 1 then
				if row_selected and has_focus then
					drawable.set_foreground_color (white)
				elseif query_grid_row.is_feature_renamed then
					drawable.set_foreground_color (black)
				else
					drawable.set_foreground_color (feature_text_color)
				end
				drawable.draw_ellipsed_text_top_left (left_border, 1, query_grid_row.text, adjusted_column_width - left_border)
			elseif query_grid_row.type = 2 then
				if row_selected and has_focus then
					drawable.set_foreground_color (white)
				else
					drawable.set_foreground_color (class_text_color)
				end
				drawable.draw_ellipsed_text_top_left (left_border, 1, query_grid_row.text, adjusted_column_width - left_border)
			elseif query_grid_row.type = 3 then
				if row_selected and has_focus then
					drawable.set_foreground_color (white)
				else
					drawable.set_foreground_color (cluster_text_color)
				end
				drawable.draw_ellipsed_text_top_left (left_border, 1, query_grid_row.text, adjusted_column_width - left_border)
			elseif query_grid_row.type = 4 then
				if row_selected and has_focus then
					drawable.set_foreground_color (white)
				else
					drawable.set_foreground_color (cluster_text_color)
				end
				offset := left_border
				drawable.draw_ellipsed_text_top_left (offset, 1, query_grid_row.cluster_text, adjusted_column_width - offset)
				offset := offset + query_grid_row.cluster_text_width
				if row_selected and has_focus then
					drawable.set_foreground_color (white)
				else
					drawable.set_foreground_color (class_text_color)
				end
				drawable.draw_ellipsed_text_top_left (offset, 1, query_grid_row.class_text, adjusted_column_width - offset)
				offset := offset + query_grid_row.class_text_width
				if row_selected and has_focus then
					drawable.set_foreground_color (white)
				elseif query_grid_row.is_feature_renamed then
					drawable.set_foreground_color (black)
				else
					drawable.set_foreground_color (feature_text_color)
				end
				drawable.draw_ellipsed_text_top_left (offset, 1, query_grid_row.feature_text, adjusted_column_width - offset)
			elseif query_grid_row.type = 5 then
				if row_selected and has_focus then
					drawable.set_foreground_color (white)
				else
					drawable.set_foreground_color (black)
				end
				drawable.draw_ellipsed_text_top_left (left_border, 1, query_grid_row.text, adjusted_column_width - left_border)
			end
		end

	left_border: INTEGER is 3
		-- Pixel position from left edge of first item in row
		-- where the text of the item begins.

	last_sorted_column_agent: FUNCTION [ANY, TUPLE [EB_PROFILE_QUERY_GRID_ROW, EB_PROFILE_QUERY_GRID_ROW], BOOLEAN]
		-- The last agent used to perform a full sort on `output_grid'. We need access to
		-- this for implementing sorts within sorts.

	last_equal_column_agent: FUNCTION [ANY, TUPLE [EB_PROFILE_QUERY_GRID_ROW, EB_PROFILE_QUERY_GRID_ROW], BOOLEAN]
		-- An agent used to determine if two profile query grid rows are equal based on the same
		-- seach criteria as `last_sorted_column_agent'. We need access to
		-- this for implementing sorts within sorts.

	sort_within_last: BOOLEAN
		-- Should the current sort be performed within the last sort?

	tree_structure_enabled: BOOLEAN
		-- Is `output_grid' to display its contents in
		-- a nested tree structure?

	tree_node_state_toggled is
			-- The tree structured enabled button has been toggled
			-- so updated display in `output_grid' to reflect this.
		do
			tree_structure_enabled := tree_nodes_enabled_button.is_selected
			sort_column (1)
		end

	sort_column (column_index: INTEGER) is
			-- Sort logical column `column_index'.
		require
			valid_column_index: column_index >= 1 and column_index <= 6
		local
			ascending: BOOLEAN
			sorted_tuple: TUPLE [BOOLEAN, BOOLEAN]
		do
			if output_grid.header.pointed_divider_index = 0 then

					-- Should sorting be performed within the last sort?
				sort_within_last := ev_application.ctrl_pressed


				sorted_tuple ?= output_grid.column (displayed_column_indexes.item (column_index)).data
				check
					sorted_tuple_not_void: sorted_tuple /= Void
				end
				if not ev_application.ctrl_pressed then
						-- Determine the direction for the sort.
					ascending := sorted_tuple.boolean_item (1)

						-- Now store the new direction for the column state.
					sorted_tuple.put_boolean (not ascending, 1)
				else
					ascending := sorted_tuple.boolean_item (2)
					sorted_tuple.put_boolean (not ascending, 2)
				end


					-- Now perform actual sort on data.
				if tree_structure_enabled then
					sort_tree_structure (column_index, ascending)
				else
					sort_flat_structure (column_index, ascending)
				end

				rebuild_grid

				if not ev_application.ctrl_pressed then
					last_equal_column_agent := agent profile_equal (?, ?, column_index)
					last_sorted_column_agent := agent compare_profile_query_grid_rows (?, ?, column_index, ascending)
				end
			end
		end

	sort_flat_structure (column_index: INTEGER; ascending: BOOLEAN) is
			-- Perform sorting within flat structure for column `column_index' with
			-- direction based on `ascending'.
		require
			flat_mode_enabled: not tree_structure_enabled
			valid_column_index: column_index >= 1 and column_index <= 1
		local
			quick_sorter: DS_ARRAY_QUICK_SORTER [EB_PROFILE_QUERY_GRID_ROW]
			equality_tester: AGENT_BASED_EQUALITY_TESTER [EB_PROFILE_QUERY_GRID_ROW]
		do
			create equality_tester.make (agent compare_profile_query_grid_rows (?, ?, column_index, ascending))
			create quick_sorter.make (equality_tester)
			quick_sorter.sort (profile_array)
		end

	sort_tree_structure (column_index: INTEGER; ascending: BOOLEAN) is
			-- Perform sorting within tree structure for column `column_index' with
			-- direction based on `ascending'.
		require
			tree_structure_enabled: tree_structure_enabled
			valid_column_index: column_index >= 1 and column_index <= 1
		local
			quick_sorter: DS_ARRAY_QUICK_SORTER [EB_PROFILE_QUERY_GRID_ROW]
			equality_tester: AGENT_BASED_EQUALITY_TESTER [EB_PROFILE_QUERY_GRID_ROW]
			i: INTEGER
		do
			create equality_tester.make (agent compare_profile_query_grid_rows (?, ?, column_index, ascending))
			create quick_sorter.make (equality_tester)
			quick_sorter.sort (cluster_array)
			from
				i := 1
			until
				i > cluster_array.upper
			loop
				quick_sorter.subsort (class_array, (cluster_array.item (i)).child_node_lower_index, (cluster_array.item (i)).child_node_upper_index)
				i := i + 1
			end
			from
				i := 1
			until
				i > class_array.upper
			loop
				quick_sorter.subsort (feature_array, (class_array.item (i)).child_node_lower_index, (class_array.item (i)).child_node_upper_index)
				i := i + 1
			end
			quick_sorter.sort (root_nodes_array)
		end

	compare_profile_query_grid_rows (query_grid_row1, query_grid_row2: EB_PROFILE_QUERY_GRID_ROW; column_index: INTEGER; ascending: BOOLEAN): BOOLEAN is
			-- Is `query_grid_row1' less than `query_grid_row2' with search criteria based on logical column `column_index' and direction
			-- `ascending'.
		require
			query_grid_row1_not_void: query_grid_row1 /= Void
			query_grid_row2_not_void: query_grid_row2 /= Void
			valid_column_index: column_index >= 1 and column_index <= 6
		local
			last_equal: BOOLEAN
		do
			last_equal := True
			if sort_within_last then
				last_equal_column_agent.call ([query_grid_row1, query_grid_row2, column_index])
				last_equal := last_equal_column_agent.last_result
			end
			if last_equal then
				inspect
					column_index
				when 1 then
					if ascending then
						Result := query_grid_row1.text < query_grid_row2.text
					else
						Result := query_grid_row1.text > query_grid_row2.text
					end
				when 2 then
					if ascending then
						Result := query_grid_row1.calls < query_grid_row2.calls
					else
						Result := query_grid_row1.calls > query_grid_row2.calls
					end
				when 3 then
					if ascending then
						Result := query_grid_row1.self < query_grid_row2.self
					else
						Result := query_grid_row1.self > query_grid_row2.self
					end
				when 4 then
					if ascending then
						Result := query_grid_row1.descendents < query_grid_row2.descendents
					else
						Result := query_grid_row1.descendents > query_grid_row2.descendents
					end
				when 5 then
					if ascending then
						Result := query_grid_row1.total < query_grid_row2.total
					else
						Result := query_grid_row1.total > query_grid_row2.total
					end
				when 6 then
					if ascending then
						Result := query_grid_row1.percentage < query_grid_row2.percentage
					else
						Result := query_grid_row1.percentage > query_grid_row2.percentage
					end
				else
					check
						invalid_column: False
					end
				end
			else
				sort_within_last := False
				last_sorted_column_agent.call ([query_grid_row1, query_grid_row2])
				Result := last_sorted_column_agent.last_result
				sort_within_last := True
			end
		end

	resize_column (a_column: INTEGER) is
			-- Resize column `a_column' in `output_grid' to required width to display
			-- its contents if the mouse pointer is currently over a column divider.
		require
			valid_column: a_column >= 1 and a_column <= output_grid.row_count
		local
			pointed_index: INTEGER
			grid_row: EV_GRID_ROW
			query_grid_row: EB_PROFILE_QUERY_GRID_ROW
			required_width: INTEGER
			i: INTEGER
		do
			pointed_index := output_grid.header.pointed_divider_index
				-- If we are not currently pointing to a column divider then do nothing.
			if pointed_index /= 0 then
				if pointed_index > 1 then
					required_width := output_grid.column (a_column).required_width_of_item_span (1, output_grid.row_count)
				else
					-- In this case we are the first column so we must compute the width
					-- ourselves as we use drawable items.
					from
						i := 1
					until
						i > output_grid.row_count
					loop
						grid_row := output_grid.row (i)
						query_grid_row ?= grid_row.data
						if query_grid_row.type = 4 then
								-- If the row type is 4, then we must add the widths of all three
								-- components comprising the text.
							required_width := required_width.max (query_grid_row.cluster_text_width + query_grid_row.class_text_width + query_grid_row.feature_text_width + (left_border * 2))
						else
								-- Although in this mode we only have a single text, we are in the tree mode so
								-- we also add on the indent of the first item.
							required_width := required_width.max (query_grid_row.text_width + (left_border * 2) + grid_row.item (1).horizontal_indent)
						end

							-- We now ignore all rows that are not expanded.
						if grid_row.subrow_count > 0 and not grid_row.is_expanded then
							i := i + grid_row.subrow_count_recursive
						end
						i := i + 1
					end
				end
				output_grid.column (a_column).set_width (required_width)
			end
		end

	profile_equal (query_grid_row1, query_grid_row2: EB_PROFILE_QUERY_GRID_ROW; column_index: INTEGER): BOOLEAN is
			-- Are `query_grid_row1' and `query_grid_row2' considered equal for property defined by `column_index'?
		require
			profile_data_not_void: query_grid_row1 /= Void and query_grid_row2 /= Void
			valid_column_index: column_index >= 1 and column_index <= 6
		do
			inspect column_index
			when 1 then
				Result := query_grid_row1.text.is_equal (query_grid_row2.text)
			when 2 then
				Result := query_grid_row1.calls = query_grid_row2.calls
			when 3 then
				Result := query_grid_row1.self = query_grid_row2.self
			when 4 then
				Result := query_grid_row1.descendents = query_grid_row2.descendents
			when 5 then
				Result := query_grid_row1.total = query_grid_row2.total
			when 6 then
				Result := query_grid_row1.percentage = query_grid_row2.percentage
			else
				check
					invalid_column: False
				end
			end
		end

	retrieve_pebble (an_item: EV_GRID_ITEM): STONE is
			-- Retrieve a pebble from `an_item' if it represents
			-- a pickable object. May return an instance of
			-- CLUSTER_STONE, CLASS_STONE, FEATURE_STONE or Void.
		require
			an_item_not_void: an_item /= Void
		local
			query_grid_row: EB_PROFILE_QUERY_GRID_ROW
			eiffel_profile_data: EIFFEL_PROFILE_DATA
			e_feature: E_FEATURE
			total_offset: INTEGER
		do
			if an_item /= Void then
				query_grid_row ?= an_item.data
				if query_grid_row /= Void then
					if query_grid_row.type = 1 then
						if last_x > left_border and last_x < query_grid_row.text_width + left_border then
							eiffel_profile_data ?= query_grid_row.profile_data
							check
								only_eiffel_data_pickable: eiffel_profile_data /= Void
							end
							e_feature := eiffel_profile_data.function.e_feature
							if e_feature /= Void then
								create {FEATURE_STONE} Result.make (e_feature)
							end
						end
					elseif query_grid_row.type = 2 then
						if last_x > left_border and last_x < query_grid_row.text_width + left_border then
							eiffel_profile_data ?= query_grid_row.profile_data
							check
								only_eiffel_data_pickable: eiffel_profile_data /= Void
							end
							create {CLASSC_STONE} Result.make (eiffel_profile_data.function.class_c)
						end
					elseif query_grid_row.type = 3 then
						if last_x > left_border and last_x < query_grid_row.text_width + left_border then
							eiffel_profile_data ?= query_grid_row.profile_data
							check
								only_eiffel_data_pickable: eiffel_profile_data /= Void
							end
							create {CLUSTER_STONE} Result.make (eiffel_profile_data.function.class_c.group)
						end
					elseif query_grid_row.type = 4 then
						if last_x > left_border then
							-- We ensure that no pick is performed from within the border at the
							-- left edge of the item.

							total_offset := left_border + query_grid_row.cluster_text_width
							if last_x < total_offset then
								eiffel_profile_data ?= query_grid_row.profile_data
								check
									only_eiffel_data_pickable: eiffel_profile_data /= Void
								end
								create {CLUSTER_STONE} Result.make (eiffel_profile_data.function.class_c.group)
							else
								total_offset := total_offset + query_grid_row.class_text_width
								if last_x < total_offset then
									eiffel_profile_data ?= query_grid_row.profile_data
									check
										only_eiffel_data_pickable: eiffel_profile_data /= Void
									end
									create {CLASSC_STONE} Result.make (eiffel_profile_data.function.class_c)
								else
									total_offset := total_offset + query_grid_row.feature_text_width
									if last_x < total_offset then
										eiffel_profile_data ?= query_grid_row.profile_data
										check
											only_eiffel_data_pickable: eiffel_profile_data /= Void
										end
										e_feature := eiffel_profile_data.function.e_feature
										if e_feature /= Void then
											create {FEATURE_STONE} Result.make (e_feature)
										end
									end
								end
							end
						end
					end
				end
			end
		end

	key_pressed (a_key: EV_KEY) is
			-- Respond to `a_key' being pressed in `output_grid'.
		require
			a_key_not_void: a_key /= Void
		local
			i: INTEGER
			j: INTEGER
			current_row: EV_GRID_ROW
			clipboard_text: STRING
		do
			if a_key.code = key_a and then ev_application.ctrl_pressed then
					-- Select all rows in `output_grid'.
				from
					i := 1
				until
					i > output_grid.row_count
				loop
					current_row := output_grid.row (i)
					current_row.enable_select
					if current_row.subrow_count > 0 and then not current_row.is_expanded then
						i := i + current_row.subrow_count_recursive
					end
					i := i + 1
				end
			elseif a_key.code = key_c and then ev_application.ctrl_pressed then
					-- Copy selected rows to clipboard.
				clipboard_text := ""
				from
					j := 1
				until
					j > output_grid.row_count
				loop
					current_row := output_grid.row (j)
					if current_row.is_selected then
						append_row_to_string (current_row, clipboard_text)
					end
					j := j + 1
				end
				if not clipboard_text.is_empty then
					ev_application.clipboard.set_text (clipboard_text)
				end
			elseif a_key.code = key_page_up then
				scroll_output_grid ( - lines_to_move_in_per_page_scrolling)
			elseif a_key.code = key_page_down then
				scroll_output_grid (lines_to_move_in_per_page_scrolling)
			end
		end

	lines_to_move_in_per_page_scrolling: INTEGER is
			-- Number of lines to be moved in per page scrolling mode.
		do
			Result := output_grid.last_visible_row.index - output_grid.first_visible_row.index - preferences.editor_data.scrolling_common_line_count
		end

	mouse_wheel_received (a_delta: INTEGER) is
			-- Respond to movement of mouse wheel by `delta' on `output_grid'.
		local
			lines_to_move: INTEGER
		do
			if preferences.editor_data.mouse_wheel_scroll_full_page then
				lines_to_move := lines_to_move_in_per_page_scrolling
				if a_delta > 0 then
					lines_to_move := 0 - lines_to_move
				end
			else
				lines_to_move := - a_delta * preferences.editor_data.mouse_wheel_scroll_size
			end
			scroll_output_grid (lines_to_move)
		end

	scroll_output_grid (line_count: INTEGER) is
			-- Scroll `output_grid' by `line_count' lines,
			-- restricted to maximum positions permitted by grid.
		do
			output_grid.set_virtual_position (output_grid.virtual_x_position,
				(output_grid.virtual_y_position + (output_grid.row_height * line_count)).min (output_grid.maximum_virtual_y_position).max (0))
		end

	append_row_to_string (a_row: EV_GRID_ROW; a_string: STRING) is
			-- Append output version of `a_row' to `string'.
		require
			a_row_not_void: a_row /= Void
			a_string_not_void: a_string /= Void
		local
			i: INTEGER
			label_item: EV_GRID_LABEL_ITEM
			query_grid_row: EB_PROFILE_QUERY_GRID_ROW
		do
			from
				i := 1
			until
				i > a_row.count
			loop
				label_item ?= a_row.item (i)
				if label_item /= Void then
					a_string.append (label_item.text)
				else
					query_grid_row ?= a_row.data
					a_string.append (full_feature_path (query_grid_row))
				end
				if i < a_row.count then
					a_string.append (tab)
				else
					a_string.append (new_line)
				end
				i := i + 1
			end
		end

	full_feature_path (query_grid_row: EB_PROFILE_QUERY_GRID_ROW): STRING is
			-- `Result' is expanded version of the the name a associated
			-- with `query_grid_row'. For Eiffel features, this is the full cluster,
			-- class and feature name.
		require
			query_grid_row_not_void: query_grid_row /= Void
		local
			eiffel_profile_data: EIFFEL_PROFILE_DATA
			function: EIFFEL_FUNCTION
		do
			Result := ""
			if query_grid_row.type = 4 then
				Result.append (query_grid_row.cluster_text)
				Result.append (query_grid_row.class_text)
				Result.append (query_grid_row.feature_text)
			else
				eiffel_profile_data ?= query_grid_row.profile_data
				if eiffel_profile_data /= Void then
					function := eiffel_profile_data.function
					if query_grid_row.type = 1 then
						Result.append (function.class_c.group.name)
						Result.append (full_stop)
						Result.append (function.class_c.name)
						Result.append (full_stop)
						Result.append (function.feature_name)
					elseif query_grid_row.type = 2 then
						Result.append (function.class_c.group.name)
						Result.append (full_stop)
						Result.append (function.class_c.name)
					elseif query_grid_row.type = 3 then
						Result.append (function.class_c.group.name)
					end
				else
					Result.append (query_grid_row.text)
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	item_pressed (an_x, a_y, a_button: INTEGER; an_item: EV_GRID_ITEM) is
			-- Respond to a press of button `a_button' at virtual position `an_x', `a_y'
			-- within `output_grid'.
		local
			menu: EV_MENU
			menu_item: EV_MENU_ITEM
			grid_row: EV_GRID_ROW
			l_indent: INTEGER
			spacing: INTEGER
			rows: ARRAYED_LIST [INTEGER]
		do
			if a_button = 3 and tree_structure_enabled then
					-- We must now display a context menu for expanding or collapsing rows,
					-- but only if the mouse pointer is above the tree node.
				rows := output_grid.visible_row_indexes
				grid_row := output_grid.row (rows.i_th ((a_y // output_grid.row_height) + 1))
				l_indent := grid_row.item (1).horizontal_indent
				spacing := output_grid.tree_node_spacing
				if an_x < l_indent - (spacing * 2) and an_x > l_indent - (spacing * 2) - output_grid.expand_node_pixmap.width then
					create menu
					create menu_item.make_with_text (profiler_expand_all)
					menu_item.select_actions.extend (agent expand_all (grid_row))
					menu.extend (menu_item)
					create menu_item.make_with_text (profiler_collapse_all)
					menu_item.select_actions.extend (agent collapse_all (grid_row))
					menu.extend (menu_item)
					menu.show
				end
			end
		end

	expand_all (a_row: EV_GRID_ROW) is
			-- Expand `a_row' and all subrows recursively.
		require
			a_row_not_void: a_row /= Void
		local
			i: INTEGER
			l_subrow: EV_GRID_ROW
		do
			a_row.expand
			from
				i := 1
			until
				i > a_row.subrow_count
			loop
				l_subrow := a_row.subrow (i)
				if l_subrow.subrow_count > 0 then
					l_subrow.expand
					expand_all (l_subrow)
				end
				i := i + 1
			end
		ensure
			row_expanded: a_row.is_expanded
			--subrows_expanded_recursively
		end

	collapse_all (a_row: EV_GRID_ROW) is
			-- Collapse `a_row' and all subrows recursively.
		require
			a_row_not_void: a_row /= Void
		local
			i: INTEGER
			l_subrow: EV_GRID_ROW
		do
			a_row.collapse
			from
				i := 1
			until
				i > a_row.subrow_count
			loop
				l_subrow := a_row.subrow (i)
				if l_subrow.subrow_count > 0 then
					l_subrow.collapse
					collapse_all (l_subrow)
				end
				i := i + 1
			end
		ensure
			row_not_expanded: not a_row.is_expanded
			--subrows_not_expanded_recursively
		end

	drawing_font: EV_FONT is
			-- Font used for drawing in `output_grid'.
		once
			Result := (create {EV_LABEL}).font
		end

	record_mouse_relative_to_item (an_x, a_y: INTEGER; grid_item: EV_GRID_ITEM) is
			-- Store the last position of the mouse relative to an item.
		local
			query_grid_row: EB_PROFILE_QUERY_GRID_ROW
		do
			if grid_item /= Void then
				last_x := an_x - grid_item.virtual_x_position
				last_y := a_y - grid_item.virtual_y_position

				if grid_item.column.index = 1 then
					query_grid_row ?= grid_item.row.data
					check
						data_pointed_to_query_grid_row: query_grid_row /= Void
					end
					output_grid.set_tooltip (full_feature_path (query_grid_row))
				else
					output_grid.remove_tooltip
				end
			else
				output_grid.remove_tooltip
			end
		end

	row_expanded (a_row: EV_GRID_ROW) is
			-- Row `a_row' has been expanded so update
			-- the associated `query_grid_row' to reflect this.
		require
			a_row_not_void: a_row /= Void
		local
			query_grid_row: EB_PROFILE_QUERY_GRID_ROW
		do
			query_grid_row ?= a_row.data
			check
				query_grid_row_not_void: query_grid_row /= Void
			end
			query_grid_row.set_is_expanded (True)
		end

	row_collapsed (a_row: EV_GRID_ROW) is
			-- Row `a_row' has been collapsed so update
			-- the associated `query_grid_row' to reflect this.
		require
			a_row_not_void: a_row /= Void
		local
			query_grid_row: EB_PROFILE_QUERY_GRID_ROW
		do
			query_grid_row ?= a_row.data
			check
				query_grid_row_not_void: query_grid_row /= Void
			end
			query_grid_row.set_is_expanded (False)
		end


	last_x, last_y: INTEGER
		-- Last x and y position relative to an item within `output_grid'.


feature -- Update

	update_graphical_resources is
			-- Update the graphical resources.
		do
			output_grid.wipe_out
			run_query_cmd.execute
		end

	update_query_frame is
			-- Refresh active and inactive subquery frames.
		local
			i : INTEGER
			scrollable_subquery: EB_SUBQUERY_ITEM
			op: STRING
		do
			active_query_window.wipe_out
			inactive_subqueries_window.wipe_out
			if all_subqueries.count > 0 then
				all_subqueries.start
				create scrollable_subquery.make_first (all_subqueries.item.image)
				if all_subqueries.item.is_active then
					active_query_window.extend (scrollable_subquery)
				else
					inactive_subqueries_window.extend (scrollable_subquery)
				end
				if all_operators.count > 0 then
					from
						all_subqueries.forth
						all_operators.start
						i := 2
					until
						all_subqueries.after or else all_operators.after
					loop
						if all_subqueries.item.is_active then
							if active_query_window.count = 0 then
								op := ""
							else
								op := all_operators.item.actual_operator
							end
							create scrollable_subquery.make_normal (op, all_subqueries.item.image, i)
							active_query_window.extend (scrollable_subquery)
						else
							create scrollable_subquery.make_normal (all_operators.item.actual_operator, all_subqueries.item.image, i)
							inactive_subqueries_window.extend (scrollable_subquery)
						end
						all_subqueries.forth
						all_operators.forth
						i := i + 1
					end
				end
			end
		end

	update_profiler_query is
			-- Refresh `profiler_query' according to changes made on subquery list
		do
			profiler_query.set_subqueries (all_subqueries)
			profiler_query.set_subquery_operators (all_operators)
		end

feature {NONE} -- Attributes

	output_grid: EV_GRID
			-- Widget in which all output is displayed.

	active_subqueries: INTEGER
			-- Number of active subqueries in all_subqueries

	tree_nodes_enabled_button: EV_CHECK_BUTTON

feature {EB_CHANGE_OPERATOR_CMD} -- Attributes

	active_query_window: EV_MULTI_COLUMN_LIST
			--  Scrollable list of active subqueries

	inactive_subqueries_window: EV_MULTI_COLUMN_LIST
			-- Scrollable list if inactive queries

feature {EB_ADD_SUBQUERY_CMD, EB_CHANGE_OPERATOR_CMD} -- Attributes

	subquery_text: EV_TEXT_FIELD
			-- Text field for eventual subqueries

	all_subqueries: LINKED_LIST[SUBQUERY]
			-- All the subqueries typed

	all_operators: LINKED_LIST[SUBQUERY_OPERATOR]
			-- All the subquery operators typed

feature {EB_RUN_QUERY_CMD} -- Attributes

	profiler_query: PROFILER_QUERY
			-- Query from which `profinfo' is the result

	profiler_options: PROFILER_OPTIONS
			-- Options used to generate `profinfo'

	profinfo: PROFILE_INFORMATION
			-- Set of information about profiled system, generated
			-- with help of `profiler_query' and `profiler_options'

feature {EB_CLOSE_QUERY_WINDOW_CMD} -- User Interface

	close is
			-- Close Current and update `parent'
		do
				-- Remove agents added to preferences for color handling.
			preferences.editor_data.feature_text_color_preference.change_actions.prune_all (colors_changed_agent)
			preferences.editor_data.cluster_text_color_preference.change_actions.prune_all (colors_changed_agent)
			preferences.editor_data.class_text_color_preference.change_actions.prune_alL (colors_changed_agent)

			destroy
		end

feature {EB_ADD_SUBQUERY_CMD} -- Access

	subquery: STRING is
			-- Text typed in the subquery window
		do
			Result := subquery_text.text
		end

feature -- Commands

	run_query_cmd: EB_RUN_QUERY_CMD
			-- Command to run a subquery from Current

	save_result_cmd: EB_SAVE_RESULT_CMD
			-- Command to save the result of currently displayed query

feature {NONE} -- Implementation

	feature_text_color, class_text_color, cluster_text_color: EV_COLOR
		-- Colors retreived from the preferences. They must be set each time
		-- that the window is displayed or the preferences change, and are not onces as a user
		-- may change the colors.

	colors_changed_agent: PROCEDURE [ANY, TUPLE []]
		-- Agent connected to the color change events from EiffelStudio.

	count_active_subqueries is
			-- Number of active subqueries
		do
			from
				all_subqueries.start
				active_subqueries := 0
			until
				all_subqueries.after
			loop
				if all_subqueries.item.is_active then
					active_subqueries := active_subqueries + 1
				end
				all_subqueries.forth
			end
		end

	inactivate is
			-- Copy all the selected subqueries from `active_query_window'
			-- into `inactive_subqueries_window', inactivate the corresponding subqueries
			-- and operators in `all_subqueries' and `all_operators'
		local
			selected_subqueries: DYNAMIC_LIST  [EV_MULTI_COLUMN_LIST_ROW]
			selected_subquery: EB_SUBQUERY_ITEM
			i: INTEGER
		do
			selected_subqueries := active_query_window.selected_items
			from
				selected_subqueries.start
			until
				selected_subqueries.after
			loop
				selected_subquery ?= selected_subqueries.item
				i := selected_subquery.number
					--| inactivate the subquery in 'all_subqueries'
				all_subqueries.go_i_th (i)
				all_subqueries.item.inactivate
					--| inactivate the operator in 'all_subquery_operators'
				if i > 1 then
					all_operators.go_i_th (i-1)
					all_operators.item.inactivate
				end
				selected_subqueries.forth
			end
			if active_query_window.count > 0 then
				selected_subquery ?= active_query_window.first
				i := selected_subquery.number
				if i > 1 then
					all_operators.go_i_th (i-1)
					all_operators.item.inactivate
				end
			end
			profiler_query.set_subqueries ( all_subqueries )
			profiler_query.set_subquery_operators ( all_operators )
			update_query_frame
		end

	reactivate is
			-- Copy all the selected subqueries from `inactive_subqueries_window'
			-- into `active_query_window', activate the corresponding subqueries
			-- and operators in `all_subqueries' and `all_operators'
		local
			selected_subqueries: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			selected_subquery: EB_SUBQUERY_ITEM
			i, smallest_active: INTEGER
			is_window_empty: BOOLEAN
				-- is `active_subquery_window' empty?
		do
			if inactive_subqueries_window.count > 0 then
				selected_subqueries := inactive_subqueries_window.selected_items
				is_window_empty := (active_query_window.count = 0)
				if not is_window_empty then
					selected_subquery ?= active_query_window.first
					smallest_active := selected_subquery.number
				end
				from
					selected_subqueries.start
				until
					selected_subqueries.after
				loop
					selected_subquery ?= selected_subqueries.item

					i := selected_subquery.number
						--| inactivate the subquery in 'all_subqueries'
					all_subqueries.go_i_th (i)
					all_subqueries.item.activate
						--| inactivate the operator in 'all_subquery_operators'
					if is_window_empty then
						smallest_active := i
					elseif i < smallest_active then
						all_operators.go_i_th (smallest_active - 1)
						all_operators.item.activate
						smallest_active := i
					else
						all_operators.go_i_th (i - 1)
						all_operators.item.activate
					end
					selected_subqueries.forth
				end
				profiler_query.set_subqueries ( all_subqueries )
				profiler_query.set_subquery_operators ( all_operators )
				update_query_frame
			end
		end

feature {NONE} -- execution

	add_subquery (string_arg: STRING) is
			-- Add subquery to list of subqueries.
			-- Subquery operator is given by `string_arg'.
		local
			parser: EB_QUERY_PARSER
			txt: STRING
			operator: SUBQUERY_OPERATOR
			error_dialog: EV_WARNING_DIALOG
		do
			txt := subquery
			if txt /= Void and then not txt.is_empty then
				clear_values
				create parser
				if parser.parse (txt, Current) then
					all_subqueries.append (subqueries)
					create operator.make (string_arg)
					all_operators.extend (operator)
					all_operators.append (subquery_operators)
					update_query_frame
					subquery_text.remove_text
				else
					create error_dialog.make_with_text (Warning_messages.w_Profiler_bad_query)
					error_dialog.show_modal_to_window (Current)
				end
			end
		end

	change_operator (string_arg: STRING) is
			-- Change selected subqueries
			-- operators according to `string_arg'.
		local
			selected_subqueries: DYNAMIC_LIST  [EV_MULTI_COLUMN_LIST_ROW]
			selected_subquery: EB_SUBQUERY_ITEM
		do
			if active_query_window.count > 0 then
				from
					selected_subqueries := active_query_window.selected_items
					selected_subqueries.start
				until
					selected_subqueries.after
				loop
					selected_subquery ?= selected_subqueries.item
					check
						valid_entry: selected_subquery /= Void
					end
					if selected_subquery.number > 1 then
						all_operators.go_i_th (selected_subquery.number - 1)
						all_operators.item.change_operator (string_arg)
					end
					selected_subqueries.forth
				end
			end

			if inactive_subqueries_window.count > 0 then
				from
					selected_subqueries := inactive_subqueries_window.selected_items
					selected_subqueries.start
				until
					selected_subqueries.after
				loop
					selected_subquery ?= selected_subqueries.item
					check
						valid_entry: selected_subquery /= Void
					end
					if selected_subquery.number > 1 then
						all_operators.go_i_th (selected_subquery.number - 1)
						all_operators.item.change_operator (string_arg)
					end
					selected_subqueries.forth
				end
			end

			update_query_frame
		end

feature {NONE} -- Implementation

	handle_color_change is
			-- Respond to a color change occurring from the preferences.
		do
			cluster_text_color := preferences.editor_data.cluster_text_color
			class_text_color :=  preferences.editor_data.class_text_color
			feature_text_color := preferences.editor_data.feature_text_color
				-- Now redraw the contents of `output_grid'.
			output_grid.redraw
		end

	tab: STRING is "%T"

	new_line: STRING is "%N"

	full_stop: STRING is "."

	black: EV_COLOR is
			-- Once access to black EV_COLOR.
		once
			Result := (create {EV_STOCK_COLORS}).black
		end

	gray: EV_COLOR is
			-- Once access to gray EV_COLOR.
		once
			Result := (create {EV_STOCK_COLORS}).gray
		end

	white: EV_COLOR is
			-- Once access to white EV_COLOR.
		once
			Result := (create {EV_STOCK_COLORS}).white
		end

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

end -- class EB_PROFILE_QUERY_WINDOW
