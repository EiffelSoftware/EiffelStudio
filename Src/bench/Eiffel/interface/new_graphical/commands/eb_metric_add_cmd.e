indexing
	description: "Command to save last calculated measure."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ADD_CMD

inherit
	EB_METRIC_COMMAND

	EB_CONSTANTS

create
	make

feature -- Initialization

	execute is
			-- Add and save latest calculated measure.
		do
			on_add_click
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_save_measure
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Add current measure to the list and save it"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Add metrics"
		end

	name: STRING is "add"
			-- Name of the command. Used to store the command in the
			-- preferences.


feature -- Action

	fill_and_save_multi_column_list is
			-- Fill `multi_column_list' with metrics on 'add' click and save measure in file.
		require
			existing_tool: tool /= Void
			calculation_done: tool.is_calculation_done
			name_correct: not name_error
			valid_scope: tool.scope (scope_type) /= Void
			valid_metric: tool.metric (tool.selected_metric) /= Void
		local
			row_array: ARRAY [STRING]
			row: EV_MULTI_COLUMN_LIST_ROW
			a_percentage: BOOLEAN
			a_metric: EB_METRIC
			archive_measure: STRING
		do
			create row_array.make (1, 6)
			row_array.put (tool.name.text, 1)
			row_array.put (scope_type, 2)
			row_array.put (scope_name, 3)
			row_array.put (tool.selected_metric, 4)

			a_metric := tool.metric (tool.selected_metric)
			a_percentage := a_metric.percentage
			row_array.put (tool.metric_result.out, 5)
				-- Fill archive comparison column.
			if tool.default_archive then
				row_array.put ("-", 6)
			else
				archive_measure := tool.archive.retrieve_archived_result (a_metric, tool.archive.archived_file, tool.archive.archived_root_element, tool.archive_mode, tool.metric_result)
				row_array.put (archive_measure, 6)
			end


			create row
			row.fill (row_array)
				-- Create file for saving if not yet created.
			if not tool.file_manager.metric_file.exists then
				tool.file_manager.destroy_file_name
				tool.set_file_loaded (False)
				tool.file_handler.load_files
			end
			check tool.file_manager.metric_file.exists end
			tool.file_manager.add_row (row, "new")
			tool.file_manager.store
			tool.file_manager.measure_notify_all_but (tool)
			row.put_i_th (tool.fix_decimals_and_percentage (tool.metric_result, a_metric.percentage), 5)
			row.set_pixmap (Pixmaps.Icon_green_tick)
			tool.multi_column_list.extend (row)
			tool.resize_column_list_to_content (tool.multi_column_list)
		ensure
			measure_saved: equal (tool.file_manager.measure_header.count , old tool.file_manager.measure_header.count + 1)
		end

	name_error: BOOLEAN is
			-- Has measure name been used for a previously recorded measure?
		require
			existing_tool: tool /= Void
		local
			list: EV_MULTI_COLUMN_LIST
		do
			Result:= tool.name.text = Void or else tool.name.text.is_empty
			if not Result then
				Result := tool.name.text.has ('<') or tool.name.text.has ('>')
			end
			list := tool.multi_column_list
			from
				list.start
			until
				list.after or Result
			loop
				Result := Result or equal (list.item.i_th (1), tool.name.text)
				list.forth
			end
		end

	path_shown: BOOLEAN
		-- Has `tool.file_manager.metric_file' path been shown once at least?

	scope_name: STRING
		-- Name of selected scope in `tool'.

	set_scope_name (str: STRING) is
			-- Assign `str' to `scope_name'.
		require
			correct_name: str /= Void and then not str.is_empty
		do
			scope_name := str
		end

	scope_type: STRING
		-- Type of selected scope in `tool'.

	set_scope_type (str: STRING) is
			-- Assign `str' to `scope_type'.
		require
			correct_type: str /= Void and then not str.is_empty
		do
			scope_type := str
		ensure 
			valid_scope: tool.scope (scope_type) /= Void
		end
	
	added: BOOLEAN
		-- Has calculated result been added?
	
	set_added (bool: BOOLEAN) is
			-- Assign `bool' to `added'.
		do
			added := bool
		end

	on_add_click is
			-- Add calculated metric in `multi_column_list' and save it in file.
		require
			existing_tool: tool /= Void
			Result_not_added: not added
		local
			x_pos, y_pos, local_index: INTEGER
			measure_name: STRING
			error_dialog: EB_INFORMATION_DIALOG
		do
			if tool.is_calculation_done then
				x_pos := tool.development_window.window.x_position + 100
				y_pos := tool.development_window.window.y_position + 100

				if not name_error then
					fill_and_save_multi_column_list
					added := True
					tool.add.disable_sensitive
					tool.add_cmd_in_menu.disable_sensitive
					measure_name := tool.name.text
					if equal (measure_name.substring (1, 6), "Result") then
						local_index := measure_name.substring (7, measure_name.count).to_integer
					end
					tool.set_name_index (local_index.max (tool.name_index) + 1)
					tool.name.set_text ("Result" + tool.name_index.out)
					if not path_shown then
						create error_dialog.make_with_text ("Measures are saved in file:%N" + tool.file_manager.metric_file_name)
						error_dialog.set_position (x_pos, y_pos)
						error_dialog.show_modal_to_window (tool.development_window.window)
						path_shown := True
					end
				else
					create error_dialog.make_with_text ("Metric name already exists or is empty%N%
												%or contains invalid characters (<, >)%N%
												%Please change it before saving.")
					error_dialog.set_position (x_pos, y_pos)
					error_dialog.show_modal_to_window (tool.development_window.window)
				end
			end
		end

end -- class EB_METRIC_ADD_CMD
