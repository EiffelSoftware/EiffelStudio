indexing
	description: "Command to calculate a metric over selected parameters."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CALCULATE_CMD

inherit
	EB_METRIC_COMMAND

	EB_CONSTANTS

	EB_METRIC_SCOPE_INFO

	SHARED_XML_ROUTINES

create
	make

feature -- Initialization

	execute is
			-- Launch metric calculation regarding selected parameters.
		do
			on_calculate_click
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_new_measure
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Calculate metric with selected parameters"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Calculate metrics"
		end

	name: STRING is "calculate"
			-- Name of the command. Used to store the command in the
			-- preferences.


feature -- Displayed messages in text form.

	has_metric (current_metric: EB_METRIC; f: PLAIN_TEXT_FILE): BOOLEAN is
			-- Has `f' metric definition corresponding to `current_metric'?
		require
			f_not_void: f /= Void
			metric_not_void: current_metric /= Void
		local
			defined_metric: EB_METRIC
			archived_metrics: LINKED_LIST [EB_METRIC]
			archived_xml: LINKED_LIST [XML_ELEMENT]
			index_current_metric: INTEGER
			current_formula: STRING
			current_xml: XML_ELEMENT
			defined_formula: STRING
		do
			create archived_metrics.make
			create archived_xml.make
			tool.file_handler.retrieve_metric (f, archived_metrics, archived_xml)

			index_current_metric := tool.metrics.index_of (current_metric, 1)
			current_xml := tool.user_metrics_xml_list.i_th (index_current_metric - tool.nb_basic_metrics)
			current_formula := xml_string (current_xml, "FORMULA")
			from
				archived_xml.start
			until
				archived_xml.after or defined_metric/= Void
			loop
				defined_formula := xml_string (archived_xml.item, "FORMULA")
				if equal (defined_formula, current_formula) then
					Result := True
				end
				archived_xml.forth
			end
		end

	retrieve_archived_measure (current_metric: EB_METRIC; f: PLAIN_TEXT_FILE): STRING is
			-- Retrieve recorded measure of `current_metric' evaluated over `System_scope' if any
			-- from file `f'.
		require
			f_not_void: f /= Void
			metric_not_void: current_metric /= Void
		local
			s, final_result, archive_name: STRING
			parser: XML_TREE_PARSER
			measure_element, node: XML_ELEMENT
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			retried, same_metric: BOOLEAN
			error_dialog:EB_INFORMATION_DIALOG
			basic_metric: EB_METRIC_BASIC
		do
			if not retried then
				f.open_read
				create parser.make
				f.start
				f.read_stream (f.count)
				s := f.last_string
				parser.parse_string (s)
				parser.set_end_of_file
				if parser.is_correct  then
					if tool.archive.archive_syntax (parser.root_element) then
						basic_metric ?= current_metric
						if basic_metric = Void then
							same_metric := has_metric (current_metric, f)
						end
						if (basic_metric /= Void or same_metric) then
							if parser.root_element.attributes.has ("System") then
								archive_name := parser.root_element.attributes.item ("System").value						
							end
							measure_element := element_by_name (parser.root_element, "RECORDED_MEASURES")
							a_cursor := measure_element.new_cursor
							Result := "Metric: " + current_metric.name + "      "
								+ "Scope: Archive"
							from
								a_cursor.start
							until
								a_cursor.after
							loop
								node ?= a_cursor.item
								if node /= Void then
									if equal (node.attributes.item ("Metric").value, current_metric.name) then
										final_result := tool.fix_decimals_and_percentage (node.attributes.item ("Result").value.to_double, current_metric.percentage)
										Result.append (" " + archive_name + ":")
										Result.append (final_result)
									end
								end
								a_cursor.forth
							end
						else
							Result := "Sorry, no measure has been recorded for this metric."
						end
					else
						create error_dialog.make_with_text ("File: " + f.name + "%Nis not an archive file.")
						error_dialog.show_modal_to_window (tool.development_window.window)
					end
				else
					create error_dialog.make_with_text ("File: " + f.name + "%Nhas syntax errors or is not an archive file.")
					error_dialog.show_modal_to_window (tool.development_window.window)
				end
--				if final_result = Void or else final_result.is_empty then
--					Result := "Sorry, no measure has been recorded for this metric."
--				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to read file:%N"
								+ f.name )
			error_dialog.show_modal_to_window (tool.development_window.window)
			retry
		end

	display_result (a_result: DOUBLE; num, den: STRING; percentage: BOOLEAN): STRING is
			-- Display result of metric calculation.
		local
			final_result: STRING
			composite_metric: EB_METRIC_COMPOSITE
		do
			final_result := tool.fix_decimals_and_percentage (a_result, percentage)
			composite_metric ?= tool.metric (tool.selected_metric)
			Result := "Metric: " + tool.selected_metric + "      "
			if composite_metric /= Void and then composite_metric.is_scope_ratio then
				Result.append ("Scope: " + composite_metric.scope_num.name + ": " + num + " / "
							+ composite_metric.scope_den.name + ": " + den + "      ")
			else
				Result.append ("Scope: " + tool.selected_scope + ": " + num + "   ")
			end
			Result.append ("Value:" + final_result)
		end

	wrong_selection: BOOLEAN is
			-- Is there a mismatch between stones and scope_index?
		do
			Result := (tool.feature_stone = Void and scope.index = Feature_scope) or
				(tool.feature_stone = Void and tool.class_stone = Void and scope.index = Class_scope) or
				(tool.feature_stone = Void and tool.class_stone = Void and tool.cluster_stone = Void and scope.index = Cluster_scope)
		end

	fill_text_area (current_metric: EB_METRIC): STRING is
			-- Build a structured text to display metric results.
		require
			not wrong_selection
		local
			selected_feature: E_FEATURE
			selected_class: CLASS_C
			selected_cluster: CLUSTER_I
			selected_system: SYSTEM_I
			metric_result: DOUBLE
			selected_name1, selected_name2: STRING
			metric_composite: EB_METRIC_COMPOSITE
			percentage: BOOLEAN
			scope_num, scope_den: EB_METRIC_SCOPE
		do
			metric_composite ?= current_metric

			if tool.feature_stone /= Void then
				selected_feature := tool.feature_stone.e_feature
			end
			selected_class := tool.selected_class
			selected_cluster := tool.selected_cluster
			selected_system := tool.system

				-- Case when selected class is not in system
			if scope.index = Class_scope and selected_class = Void then
				Result := "Class not compiled"
					-- Result cannot be saved.
				tool.add.set_added (True)
			else
				if metric_composite /= Void and then metric_composite.is_scope_ratio then
						-- Adjust scopes of numerator and denominator.
					scope_num := metric_composite.scope_num
					scope_den := metric_composite.scope_den
						-- `selected_name' is used just to adjust scopes.
						-- It won't be used in `display_result'.
					selected_name1 := select_name_and_adjust_scope (scope_num,
												selected_feature, selected_class, selected_cluster, selected_system)
					selected_name2 := select_name_and_adjust_scope (scope_den,
												selected_feature, selected_class, selected_cluster, selected_system)
					tool.add.set_scope_type (scope_num.name + " / " + scope_den.name)
					tool.add.set_scope_name (selected_name1 + " / " + selected_name2)
				else
					selected_name1 := select_name_and_adjust_scope (scope,
												selected_feature, selected_class, selected_cluster, selected_system)
					selected_name2 := ""
					tool.add.set_scope_type (scope.name)
					tool.add.set_scope_name (clone (selected_name1))
				end
				metric_result := calculate_metric (current_metric, scope)
				percentage := current_metric.percentage
				Result := display_result (metric_result, selected_name1, selected_name2, percentage)
					-- metric_result is useful to fill in multi_column_list on add click.
				tool.set_metric_result (metric_result)
				tool.add.set_added (False)
				tool.add.enable_sensitive
				tool.add_cmd_in_menu.enable_sensitive
			end
		end

	select_name_and_adjust_scope (a_scope: EB_METRIC_SCOPE; feat: E_FEATURE; cla: CLASS_C; clu: CLUSTER_I; sys: SYSTEM_I): STRING is
			-- Pick up name of the dropped stone.
		require
			valid_scope: a_scope /= void
		do
			inspect a_scope.index
			when Feature_scope then
				a_scope.set_e_feature (feat)
				Result := feat.name + " (" + feat.written_class.name_in_upper + ")"

			when Class_scope then
				a_scope.set_class_c (cla)
				Result := clone (cla.name)
				Result.to_upper

			when Cluster_scope then
				a_scope.set_cluster_i (clu)
				Result := clu.cluster_name

			when System_scope then
				a_scope.set_system_i (sys)
				Result := sys.system_name
			end
		ensure
			something_selected: Result /= Void and then not Result.is_empty
		end

	calculate_metric (a_metric: EB_METRIC; a_scope: EB_METRIC_SCOPE): DOUBLE is
			-- Evaluate `a_metric' over `a_scope'.
		require
			a_metric_not_void: a_metric /= Void
			a_scope_not_void: a_scope /= Void
		local
			composite_metric: EB_METRIC_COMPOSITE
			scope_num, scope_den: EB_METRIC_SCOPE
			num_result, den_result: DOUBLE
		do
			composite_metric ?= a_metric
			if composite_metric /= Void and then composite_metric.is_scope_ratio then
				scope_num := clone (composite_metric.scope_num)
				scope_den := clone (composite_metric.scope_den)
				num_result := composite_metric.value (scope_num)
				den_result := composite_metric.value (scope_den)
				if den_result = 0 then
					Result := -123456
				else
					Result := num_result / den_result
				end
			else
				Result := a_metric.value (a_scope)
			end
		end

	handle_details is
			-- Enable details when available, disable otherwise.
		local
			metric: EB_METRIC
			composite_metric: EB_METRIC_COMPOSITE
			bool: BOOLEAN
		do
			metric := tool.metric (tool.selected_metric)
			composite_metric ?= tool.metric (tool.selected_metric)

				-- Disable details when:
				-- scope is feature or class.
				-- metric concerns systems and only systems (compilations...).
				-- metric is composite and mixes classes and other Class_unit metric.
			bool := (scope /= Void and then scope.index < Cluster_scope)
				or (scope /= Void and then scope.index = Archive_scope)
				or (metric /= Void and then metric.min_scope > Cluster_scope)
				or (composite_metric /= Void and then 
					(metric.min_scope = Cluster_scope and equal (metric.unit, interface_names.metric_class_unit)))
				or (composite_metric /= Void and then composite_metric.is_scope_ratio)
				or not tool.is_calculation_done

			if bool then
				tool.details.disable_sensitive
				tool.details_cmd_in_menu.disable_sensitive
			else
				tool.details.enable_sensitive
				tool.details_cmd_in_menu.enable_sensitive
			end
		end

	scope: EB_METRIC_SCOPE
		-- Currently selected_scope.

	on_calculate_click is
			-- Calculte the metric asked and display result in text form.
		local
			str, archive: STRING
			x_pos, y_pos: INTEGER
			metric: EB_METRIC
			retried: BOOLEAN
			error_dialog: EB_INFORMATION_DIALOG
			f: PLAIN_TEXT_FILE
		do
			if not retried then
				x_pos := tool.development_window.window.x_position + 550
				y_pos := tool.development_window.window.y_position + 100
				if tool.workbench.successful then
					disable_all_components
					tool.development_window.window.set_pointer_style (tool.development_window.Wait_cursor)
					tool.set_selected_metric (tool.metric_field.text)
					tool.set_selected_scope (tool.scope_combobox.text)
					scope := tool.scope (tool.selected_scope)
					metric := tool.metric (tool.selected_metric)
					check scope /= Void and metric /= Void end
					if scope.index /= Archive_scope then
						str := fill_text_area (metric)
					else
						archive := tool.archive_for_measure
						if archive /= Void and then not archive.is_empty then
							create f.make (archive)
							if f.exists then
								str := retrieve_archived_measure (metric, f)
									-- Archive result cannot be saved again.
								tool.add.set_added (True)
							else
								create error_dialog.make_with_text ("Error in archive file.%N%
												%No file has been selected or%N%
												%selected file does not exist.")
								error_dialog.set_position (x_pos, y_pos)
								error_dialog.show_modal_to_window (tool.development_window.window)
							end
						end
					end
					if str = Void or str.is_empty then
						tool.text_area.remove_text
					else
						tool.text_area.set_text (str)
					end
					tool.set_calculation_done (True)
					tool.progress_dialog.hide
					handle_details
					tool.development_window.window.set_pointer_style (tool.development_window.Standard_cursor)
					enable_all_components
					if scope.index = Archive_scope or
						equal (str, "Class not compiled") then
						tool.add.disable_sensitive
						tool.add_cmd_in_menu.disable_sensitive
					end
				else
					create error_dialog.make_with_text ("Metric calculation is not available.%N%
												%Compilation either is not finished yet%N%
												%or has not been successful.")
					error_dialog.set_position (x_pos, y_pos)
					error_dialog.show_modal_to_window (tool.development_window.window)
				end
			end
		rescue
			retried := True
			tool.progress_dialog.hide
			tool.progress_dialog.enable_cancel
			enable_all_components
			tool.details.disable_sensitive
			tool.details_cmd_in_menu.disable_sensitive
			tool.development_window.window.set_pointer_style (tool.development_window.Standard_cursor)
			retry
		end

	disable_all_components is
			-- Disable buttons and menu items during calculation.
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
			-- Enable buttons and menu items after calculation
		do
				-- Details are not necessarily enabled after a calculation.
				-- This is handled by `handle_details'.
			handle_details
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

end -- class EB_METRIC_CALCULATE_CMD
