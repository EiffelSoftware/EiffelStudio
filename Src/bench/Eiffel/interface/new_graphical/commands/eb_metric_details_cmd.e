indexing
	description: "Command to display detailed metric calculation%N%
				%for subclusters of current."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_DETAILS_CMD

inherit
	EB_METRIC_COMMAND
		redefine
			new_toolbar_item
		end

	EB_CONSTANTS

	SHARED_WORKBENCH

	EB_METRIC_SCOPE_INFO

create
	make

feature -- Initialization

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			current_button := Result
		end

	execute is
			-- Show details for sub element of selected scope for last calculated measure.
		do
			on_details_click
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_view_measure_plus
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			if tool.details_hidden then
				Result := "Show details for requested metric"
			else
				Result := "Hide details for requested metric"
			end
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Details metrics"
		end

	name: STRING is "details"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature -- Level in hierarchy

	depth_of_cluster (a_cluster: CLUSTER_I): INTEGER is
			-- Number of cluster levels in `a_cluster' hierarchy.
		require
			existing_clster: a_cluster /= Void
		local
			depth: INTEGER
		do
			if a_cluster.sub_clusters.is_empty then
				Result := 0
			else
				from
					a_cluster.sub_clusters.start
				until
					a_cluster.sub_clusters.after
				loop
					depth := 1 + depth_of_cluster (a_cluster.sub_clusters.item)
					if depth > Result then
						Result := depth
					end
					a_cluster.sub_clusters.forth
				end
			end
		end

	depth_of_system: INTEGER is
			-- Number of cluster levels in system hierarchy.
		require
			system_set: universe /= Void
		local
			depth: INTEGER
		do
			from
				universe.clusters.start
			until
				universe.clusters.after
			loop
				depth := depth_of_cluster (universe.clusters.item)
				if depth > Result then
					Result := depth
				end
				universe.clusters.forth
			end
		end

feature -- Detailed column list

	multi_column_list_for_details: EV_MULTI_COLUMN_LIST 
			-- Column list to display details of a metric result.

	title_array_for_details (cluster_depth: INTEGER): ARRAY [STRING] is
			-- `multi_column_list_for_details' titles.
		require
			existing_tool: tool /= Void
			effective_metric: metric /= Void			
		local
			array_depth, i: INTEGER
		do
			if metric.min_scope >= Cluster_scope then
				array_depth := cluster_depth + 2
			else
				array_depth := cluster_depth + 4
			end
			create Result.make (1, array_depth)
			Result.put ("Name", 1)
			from
				i := 2
			until
				i = cluster_depth + 3
			loop
				Result.put ("Subcluster", i)
				i := i + 1
			end
			if equal (metric.name, interface_names.metric_classes) then
				Result.put ("Compiled classes", array_depth)
			elseif equal (metric.name, interface_names.metric_clusters) then
				Result.put ("Clusters", array_depth)
			else
				Result.put ("Class name", array_depth - 2)
				Result.put ("Metric", array_depth - 1)
				Result.put ("Result", array_depth)
			end
		ensure
			min_titles: Result.count >= 2
		end

	show_details_of_cluster (a_cluster: CLUSTER_I; depth, starting_index, index_column_insert: INTEGER) is
			-- Build a column list to display details of a metric for a picked and dropped cluster.
			-- `depth' is `a_cluster' depth in terms of sub-clusters.
			-- `starting_index' is the line we start to insert details of `a_cluster'. Indeed, there
			-- are possibly other clusters that have been detailed before `a_cluster' and we should not overwrite them.
			-- `index_column_insert' is the index of column we start detailing. 
		require
			calculation: tool.is_calculation_done
			effective_cluster: a_cluster /= Void
			positive_indexes: depth >= 0 and starting_index >= 0 and index_column_insert >= 0
			correct_column_insert: index_column_insert >= 1 and index_column_insert < multi_column_list_for_details.column_count
		local
			insert_index, current_depth, column_insert: INTEGER
			sub_clusters: ARRAYED_LIST [CLUSTER_I]
			a_class_scope: EB_METRIC_SCOPE
			a_percentage: BOOLEAN
		do
				-- `scope' is either system or cluster.
				-- For each cluster, details are given per class, which means that
				-- local scope is class.
			a_class_scope := tool.scope (interface_names.metric_this_class)
				-- Insert rows starting from `insert_index'.
			insert_index := starting_index
				-- Insert subclusters starting from column `column_insert'.
			column_insert := index_column_insert

				-- Adjust size of the detailed multi_column_list.
			if metric.min_scope >= Cluster_scope then
				current_depth := depth + 2
			else
				current_depth := depth + 4
			end

			a_percentage := metric.percentage
			detailed_line_of_cluster (a_cluster, current_depth, column_insert, a_percentage)

				-- Build rows for sub clusters of `a_cluster'.
			insert_index := insert_index + 1
			if not a_cluster.sub_clusters.is_empty then
				sub_clusters := a_cluster.sub_clusters
				column_insert := column_insert + 1
				from
					sub_clusters.start
				until
					sub_clusters.after
				loop
					show_details_of_cluster (sub_clusters.item, depth, insert_index, column_insert)
					sub_clusters.forth
				end
			end
			insert_index := detailed_lines_of_classes_in_cluster (a_cluster, depth, current_depth, insert_index, a_class_scope, a_percentage)
		ensure
			details_displayed: multi_column_list_for_details.count > 0
		end

	detailed_line_of_cluster (a_cluster: CLUSTER_I; current_depth, column_insert: INTEGER; a_percentage: BOOLEAN) is
			-- Build detailed row for `a_cluster'
		require
			effective_cluster: a_cluster /= Void
			positive_indexes: current_depth >= 0 and column_insert >= 0
			correct_column_insert: column_insert >= 1 and column_insert < multi_column_list_for_details.column_count
		local
			mean: DOUBLE
			row_array: ARRAY [STRING]
			row:  EV_MULTI_COLUMN_LIST_ROW
			a_cluster_scope: EB_METRIC_SCOPE
			i: INTEGER
		do
				-- Build row for current cluster with its name and mean over classes.
			mean := calculate_mean (a_cluster)
			create row_array.make (1, current_depth)
			from
				i := 1
			until
				i = column_insert
			loop
				row_array.put (" ", i)
				i := i + 1
			end
			row_array.put (a_cluster.cluster_name, column_insert)
			from
				i := column_insert + 1
			until
				i = current_depth
			loop
				row_array.put ("--------------------", i)
				i := i + 1
			end

			if metric.min_scope >= Cluster_scope then
				a_cluster_scope := tool.scope (interface_names.metric_this_cluster)
				a_cluster_scope.set_cluster_i (a_cluster)
				row_array.put (tool.fix_decimals_and_percentage (metric.value (a_cluster_scope), a_percentage), current_depth)
			else
				if mean >= 0 then
					row_array.put ("Average: " + tool.fix_decimals_and_percentage (mean, a_percentage), current_depth)
				else
						-- Not in system.
					row_array.put (" ", current_depth)
				end
			end
			create row
			row.fill (row_array)
			multi_column_list_for_details.extend (row)
		ensure
			add_line: multi_column_list_for_details.count = old multi_column_list_for_details. count + 1
		end

	detailed_lines_of_classes_in_cluster (a_cluster: CLUSTER_I; depth, current_depth, insert_index: INTEGER; a_class_scope: EB_METRIC_SCOPE; a_percentage: BOOLEAN): INTEGER is
			-- Build detailed row for classes included in `a_cluster'
		require
			effective_cluster: a_cluster /= Void
			positive_indexes: depth >= 0 and current_depth >= 0 and insert_index >= 0
			effective_class_scope: a_class_scope /= Void and then a_class_scope.index = Class_scope
--									and then a_class_scope.class_c /= Void
		local
			classes_in_cluster: HASH_TABLE [CLASS_I, STRING]
			x_pos, y_pos, i, progress_value: INTEGER
			row_array: ARRAY [STRING]
			row:  EV_MULTI_COLUMN_LIST_ROW
			a_cursor: CURSOR
			displayed_result: DOUBLE
		do
				-- Build rows for classes of `a_cluster' if needed.
			if not a_cluster.classes.is_empty
			  and (metric.min_scope < Cluster_scope
			  or equal (tool.selected_metric, interface_names.metric_classes)) then

				classes_in_cluster := a_cluster.classes

				x_pos := tool.development_window.window.x_position + 100
				y_pos := tool.development_window.window.y_position + 100
				tool.progress_dialog.set_message ("Retrieving details of cluster: " + a_cluster.cluster_name)
				tool.progress_dialog.set_entity (interface_names.d_Compilation_class)
				tool.progress_dialog.set_position (x_pos, y_pos)
				tool.progress_dialog.start (classes_in_cluster.count)
				tool.progress_dialog.set_value (0)

				from
					classes_in_cluster.start
				until
					classes_in_cluster.after
				loop
					if classes_in_cluster.item_for_iteration.compiled_class /= Void then
						tool.progress_dialog.set_current_entity (classes_in_cluster.item_for_iteration.name_in_upper)
						create row_array.make (1, current_depth)
							from
								i := 1
							until
								i = depth + 3
							loop
								row_array.put (" ", i)
								i := i + 1
							end
						row_array.put (classes_in_cluster.item_for_iteration.compiled_class.name_in_upper, depth + 2)
						if not equal (tool.selected_metric, interface_names.metric_classes) then
							row_array.put (tool.selected_metric, current_depth - 1)
							a_cursor := classes_in_cluster.cursor
								-- When metric is composite, we have to update `scope' since
								-- used in `value' in EB_METRIC_MEASURE
							a_class_scope.set_class_c (classes_in_cluster.item_for_iteration.compiled_class)
							displayed_result := metric.value (a_class_scope)
							row_array.put (tool.fix_decimals_and_percentage (displayed_result, a_percentage), current_depth)
							classes_in_cluster.go_to (a_cursor)
						end
						create row
						row.fill (row_array)
						multi_column_list_for_details.extend (row)
						progress_value := progress_value + 1
						tool.progress_dialog.set_value (progress_value)
					end
					classes_in_cluster.forth
					Result := insert_index + classes_in_cluster.count
				end
			end
		end

	calculate_mean (a_cluster: CLUSTER_I): DOUBLE is
			-- Calculate mean of `metric' (evaluated for `a_cluster') over number of classes
			-- in `a_cluster'.
		require
			effective_tool: tool /= Void
			effective_cluster: a_cluster /= Void
		local
			number_classes: INTEGER
			a_cluster_scope: EB_METRIC_SCOPE
			functionality: EB_METRIC_BASIC_FUNCTIONALITIES
		do
			create functionality
			a_cluster_scope := tool.scope (interface_names.metric_this_cluster)
			a_cluster_scope.set_cluster_i (a_cluster)
			number_classes := functionality.number_of_classes_in_cluster (a_cluster_scope).truncated_to_integer
			if number_classes > 0 then
					-- Update cluster_i since changes in `number_of_classes_in_cluster'.
				a_cluster_scope.set_cluster_i (a_cluster)
				Result := metric.value (a_cluster_scope) / number_classes
			else
				Result := -1
			end
		end

	show_details_of_system (depth: INTEGER) is
			-- Build a column list to display details of a metric for this system.
		require
			positive_depth: depth >= 0
		local
			index: INTEGER
		do
			from
				universe.clusters.start
			until
				universe.clusters.after
			loop
				if universe.clusters.item.parent_cluster = Void then
					show_details_of_cluster (universe.clusters.item, depth, index, 1)
					index := multi_column_list_for_details.count
				end
				universe.clusters.forth
			end
		end

	metric: EB_METRIC
		-- metric details apply to.

	on_details_click is
			-- Show details for calculated metric.
		require
			exixting_tool: tool /= Void
		local
			depth: INTEGER
			selected_cluster: CLUSTER_I
			retried: BOOLEAN
		do
			if not retried then
				if tool.details_hidden then
						-- Change details_button's pixmap.
					current_button.set_pixmap (Pixmaps.Icon_view_measure_minus @ 1)
						-- Disable all buttons.
					disable_all_components
						-- Hide unuseful ojects.
					tool.text_area.hide
					tool.sep.hide
					tool.multi_column_list.hide
						-- Create a multi_column_list for displaying details.
					create multi_column_list_for_details
						-- Display a progress dialog while waiting for details calculation.
					tool.progress_dialog.set_value (1)
	
						-- Retrieve metric object.
					metric := tool.metric (tool.selected_metric)
					check metric /= Void end
			
					if equal (tool.selected_scope, interface_names.metric_this_cluster) then
						selected_cluster := tool.selected_cluster
						depth := depth_of_cluster (selected_cluster)
					elseif equal (tool.selected_scope, interface_names.metric_this_system) then
						depth := depth_of_system
					end
					multi_column_list_for_details.set_column_titles (title_array_for_details (depth))
					tool.widget.extend (multi_column_list_for_details)
					tool.development_window.window.set_pointer_style (tool.development_window.Wait_cursor)
					if equal (tool.selected_scope, interface_names.metric_this_cluster) then
						show_details_of_cluster (selected_cluster, depth, 0, 1)
					elseif equal (tool.selected_scope, interface_names.metric_this_system) then
						show_details_of_system (depth)
					end
					multi_column_list_for_details.align_text_right (multi_column_list_for_details.column_count)
					tool.development_window.window.set_pointer_style (tool.development_window.Standard_cursor)
					tool.resize_column_list_to_content (multi_column_list_for_details)
					tool.set_details_hidden (False)
					tool.progress_dialog.set_message ("Calculating requested metric(s)...")
					tool.progress_dialog.set_entity (interface_names.d_Compilation_class)
					tool.progress_dialog.hide
					tool.details.enable_sensitive
					tool.details_cmd_in_menu.enable_sensitive
				else
					current_button.set_pixmap (Pixmaps.Icon_view_measure_plus @ 1)
					tool.widget.prune (multi_column_list_for_details)
					tool.text_area.show
					tool.sep.show
					tool.multi_column_list.show
					enable_all_components
					tool.set_details_hidden (True)
				end
				current_button.set_tooltip (tooltip)
			end
		rescue
			retried := True
			tool.progress_dialog.set_message ("Calculating requested metric(s)...")
			tool.progress_dialog.set_entity (interface_names.d_Compilation_class)
			tool.progress_dialog.hide
			tool.progress_dialog.enable_cancel
			tool.details.enable_sensitive
			tool.details_cmd_in_menu.enable_sensitive
			tool.set_details_hidden (False)
			tool.development_window.window.set_pointer_style (tool.development_window.Standard_cursor)
			retry				
		end

	disable_all_components is
			-- Disable buttons and menu items during details calculation.
		do
			tool.details.disable_sensitive
			tool.new_metric.disable_sensitive
			tool.calculate.disable_sensitive
			tool.add.disable_sensitive
			tool.delete.disable_sensitive
			tool.manage.disable_sensitive
			tool.archive.disable_sensitive

			tool.details_cmd_in_menu.disable_sensitive
			tool.new_metric_cmd_in_menu.disable_sensitive
			tool.calculate_cmd_in_menu.disable_sensitive
			tool.add_cmd_in_menu.disable_sensitive
			tool.delete_cmd_in_menu.disable_sensitive
			tool.manage_cmd_in_menu.disable_sensitive
			tool.archive_cmd_in_menu.disable_sensitive

			tool.name.disable_sensitive
			tool.scope_combobox.disable_sensitive
			tool.metric_field.disable_sensitive
			tool.metric_button.disable_sensitive
			tool.unit_field.disable_sensitive
		end

	enable_all_components is
			-- Enable buttons and menu items after details calculation.
		do
			if not tool.add.added then
				tool.add.enable_sensitive
				tool.add_cmd_in_menu.enable_sensitive
			end

			tool.new_metric.enable_sensitive
			tool.calculate.enable_sensitive
			tool.delete.enable_sensitive
			tool.manage.enable_sensitive
			tool.archive.enable_sensitive

			tool.new_metric_cmd_in_menu.enable_sensitive
			tool.calculate_cmd_in_menu.enable_sensitive
			tool.delete_cmd_in_menu.enable_sensitive
			tool.manage_cmd_in_menu.enable_sensitive
			tool.archive_cmd_in_menu.enable_sensitive

			tool.name.enable_sensitive
			tool.scope_combobox.enable_sensitive
			tool.metric_field.enable_sensitive
			tool.metric_button.enable_sensitive
			tool.unit_field.enable_sensitive
		end

	current_button: EB_COMMAND_TOOL_BAR_BUTTON

end -- class EB_METRIC_DETAILS_CMD
