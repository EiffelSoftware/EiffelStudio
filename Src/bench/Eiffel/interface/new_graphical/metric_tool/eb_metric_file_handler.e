indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_FILE_HANDLER

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	SHARED_XML_ROUTINES
	
	EB_METRIC_SCOPE_INFO
	
	EB_CONSTANTS

create
	make
	
feature -- Initialization

	make (tl: EB_METRIC_TOOL; fm: EB_METRIC_FILE_MANAGER) is
			-- Initialize attributes `Current' is pointing on.
		require
			existing_tool: tl /= Void
			existing_manager: fm /= Void
		do
			tool := tl
			file_manager := fm
		end

feature -- Access

	tool: EB_METRIC_TOOL
			-- Metric tool `Current' is pointing on.
	
	file_manager: EB_METRIC_FILE_MANAGER
			-- Manager that handles `metric_file' for saving new metrics and measures. 

	plus: STRING is " + "
		-- Operator +.
		
	minus: STRING is " - "
		-- Operator -.
		
	multiply: STRING is " * "
		-- Operator *.
		
	divide: STRING is " / "
		-- Operator /.
	
	parser_problems: BOOLEAN
		-- Has `metric_file' syntax errors?

feature -- Loading files

	load_files is
			-- Load file containing previous defined metrics and recorded measures.
		local
			retried: BOOLEAN
			error_dialog: EB_INFORMATION_DIALOG
		do		
			if not retried and not tool.is_file_loaded and tool.System /= Void then
				file_manager.create_metric_file (file_manager.metric_file_name)
				if file_manager.metric_file.exists then
					if file_manager.metric_file.is_closed then
						file_manager.metric_file.open_read_write
					end
					if file_manager.metric_file.readable then
						retrieve_metric (file_manager.metric_file, tool.metrics, tool.user_metrics_xml_list)
						retrieve_recorded_measures (file_manager.metric_file)
						if parser_problems then
							create error_dialog.make_with_text ("File: " + file_manager.metric_file_name + "%Nhas syntax error or missing information"
																+ "File will be overriden when saving is requested.")
							error_dialog.show_modal_to_window (tool.development_window.window)
						end
					end
				end
				if not file_manager.metric_file.is_closed then
					file_manager.metric_file.close
				end
				tool.set_name_index (tool.initialize_name_index)
				tool.name.set_text ("Result" + tool.name_index.out)
				tool.set_file_loaded (True)
				if tool.multi_column_list.is_empty then
					tool.adjust_columns_size
				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to read file:%N"
								+ file_manager.metric_file_name )
			error_dialog.show_modal_to_window (tool.development_window.window)
			retry
		end

feature -- Metrics loading

	retrieve_metric (f: PLAIN_TEXT_FILE; metric_list: LINKED_LIST [EB_METRIC]; xml_list: LINKED_LIST [XML_ELEMENT]) is
			-- Retrieve recorded metric definitions from `file_manager.metric_file'.
			-- Store metric objects in `metric_list' and their XML definition in `xml_list'.
		local
			s, metric_name, metric_unit, scope_num, scope_den, type, parent_name: STRING
			parser: XML_TREE_PARSER
			metric_element, node, definition, scope_element: XML_ELEMENT
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			min_scope, i: INTEGER
			composite_metric: EB_METRIC_COMPOSITE
			derived_metric: EB_METRIC_DERIVED
			tree: EB_METRIC_VALUE
			bf: EB_METRIC_BASIC_FUNCTIONALITIES
			agent_array: ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]]
			is_derived, is_linear, is_metric_ratio, is_scope_ratio,
			retried, info_missing, percentage, op, self: BOOLEAN
			error_dialog:EB_INFORMATION_DIALOG
		do
			if not retried then
				tool.set_min_scope_available (tool.scope (interface_names.metric_this_system).index)
				create parser.make
				f.start
				f.read_stream (f.count)
				s := f.last_string
				parser.parse_string (s)
				parser.set_end_of_file
				if parser.is_correct then
					metric_element := element_by_name (parser.root_element, "METRIC_DEFINITIONS")
					a_cursor := metric_element.new_cursor

					from
						a_cursor.start
						i := 1
					until
						a_cursor.after
					loop
						node ?= a_cursor.item
						if node /= Void then
							info_missing := (not node.attributes.has ("Name") or else node.attributes.item ("Name").value.is_empty) or
											(not node.attributes.has ("Unit") or else node.attributes.item ("Unit").value.is_empty) or
											(not node.attributes.has ("Type") or else node.attributes.item ("Type").value.is_empty) or
											(not node.attributes.has ("Min_scope") or else node.attributes.item ("Min_scope").value.is_empty) or
											(not node.has (element_by_name (node, "DEFINITION"))
											or else (element_by_name (node, "DEFINITION")).is_empty)

							if not info_missing then
								metric_name := node.attributes.item ("Name").value
								metric_unit := node.attributes.item ("Unit").value
								type := node.attributes.item ("Type").value
								is_derived := equal ("Derived", type)
								is_linear := equal ("Linear", type)
								is_metric_ratio := equal ("MRatio", type)
								is_scope_ratio := equal ("SRatio", type)
								min_scope := corresponding_scope_index (node.attributes.item ("Min_scope").value)
								definition := element_by_name (node, "DEFINITION")
								if is_derived then
									create bf
									agent_array := build_agent_array (definition, bf)
									parent_name := xml_string (definition, "Raw_metric")
									op := xml_boolean (definition, "And")
									self := xml_boolean (definition, "Self")
								else
									tree := build_operator (definition, is_linear, is_metric_ratio, is_scope_ratio, True)
								end
								if tree /= Void or agent_array /= Void then
									if tree /= Void and not is_derived then
										create composite_metric.make (metric_name, metric_unit, tree, tool, min_scope)
										composite_metric.set_linear (is_linear)
										composite_metric.set_metric_ratio (is_metric_ratio)
										composite_metric.set_scope_ratio (is_scope_ratio)
										if is_metric_ratio or is_scope_ratio then
											percentage := node.attributes.item ("Percentage").value.to_boolean
											composite_metric.set_percentage (percentage)
										end
										if is_scope_ratio then
											scope_element ?= definition.item (2)
											scope_num := content_of_node (scope_element)
											composite_metric.set_scope_num (tool.scope (scope_num))
											scope_element ?= definition.item (3)
											scope_den := content_of_node (scope_element)
											composite_metric.set_scope_den (tool.scope (scope_den))
										end
										if metric_list /= tool.metrics or else tool.metric (composite_metric.name) = Void then
											metric_list.extend (composite_metric)
											xml_list.extend (node)
										end
									elseif is_derived and agent_array /= Void then
										create derived_metric.make (metric_name, metric_unit, parent_name, tool, min_scope, agent_array, op, self, bf)
										if metric_list /= tool.metrics or else tool.metric (derived_metric.name) = Void then
											metric_list.extend (derived_metric)
											xml_list.extend (node)
										end
									end

									if metric_list = tool.metrics and then file_manager.observer_list.count = 1 then
										-- If this observer is the first one which retrieves composite metrics,
										-- it must initialize new_metrics_header.
										-- When another observer reads the file, it needn't add previous composite metric.
										-- (New composite metrics will be update when defined in the future.)
										file_manager.add_metric (node, i)
										i := i + 1
									end

								end
							end
						end
						a_cursor.forth
					end
				elseif not parser.is_correct or info_missing or tree = Void then
					parser_problems := not parser.is_correct or info_missing or tree = Void
--				if not parser.is_correct or info_missing or tree = Void then
--					create error_dialog.make_with_text ("File: " + file_manager.metric_file_name + "%Nhas syntax error or missing information")
--					error_dialog.show_modal_to_window (tool.development_window.window)
				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to read file:%N"
								+ file_manager.metric_file_name )
			error_dialog.show_modal_to_window (tool.development_window.window)
			retry
		end

feature -- Metric operators

	build_operator (a_metric_definition: XML_ELEMENT; linear, metric_ratio, scope_ratio, success: BOOLEAN): EB_METRIC_VALUE is
			-- Translate `a_metric_definition' to a polish syntax and return tool to allow metric calculation.
			-- Called on defining new metric or on retrieveing saved-in-file metric.
		local
			stack: LINKED_STACK [EB_METRIC_VALUE]
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			node: XML_ELEMENT
			node_item: STRING
			parameter: DOUBLE
			met_constant: EB_METRIC_CONSTANT
			met_measure: EB_METRIC_MEASURE
			met_operator: EB_METRIC_OPERATOR
			value1, value2: EB_METRIC_VALUE
			error_dialog: EB_INFORMATION_DIALOG
		do
			create stack.make
			a_cursor := a_metric_definition.new_cursor
			if success then
				if not scope_ratio then
					from
						a_cursor.start
					until
						a_cursor.after
					loop
						node ?= a_cursor.item
						if node /= Void then
							if node.name.is_equal ("PARAMETER") then
								node_item := content_of_node (node)
								parameter := node_item.to_double
								create met_constant.make (parameter)
								stack.put (met_constant)
							end
							if node.name.is_equal ("METRIC") then
								node_item := content_of_node (node)		
								create met_measure.make (node_item, tool)
								stack.put (met_measure)
							end
							if node.name.is_equal ("OPERATOR") then
								node_item := content_of_node (node)
								value1 := stack.item
								stack.remove
								value2 := stack.item
								stack.remove
								if equal (node_item, plus) then
									create {EB_METRIC_OPERATOR_PLUS} met_operator.make (value1, value2)
								elseif equal (node_item, minus) then
									create {EB_METRIC_OPERATOR_MINUS} met_operator.make (value1, value2)
								elseif equal (node_item, multiply) then
									create {EB_METRIC_OPERATOR_MULTIPLY} met_operator.make (value1, value2)
								elseif equal (node_item, divide) then
									create {EB_METRIC_OPERATOR_DIVIDE} met_operator.make (value1, value2)
								end
								stack.put (met_operator)
							end
						end
						a_cursor.forth
					end
				else
					node_item := xml_string (a_metric_definition, "METRIC")
					create met_measure.make (node_item, tool)
					stack.put (met_measure)
				end
				Result := stack.item
			else
				create error_dialog.make_with_text ("Error in metric definition, see file:%N"
						+ file_manager.metric_file_name )
				error_dialog.show_modal_to_window (tool.development_window.window)
			end
		ensure
			value_not_void: success implies Result /= Void
		end

	content_of_node (node: XML_ELEMENT): STRING is
			-- Return content of `node'.
		local
			cd: XML_CHARACTER_DATA
		do
			if node /= Void then
				if not node.is_empty then
					cd ?= node.first
					if cd /= Void then
						Result := cd.string
						valid_tags_read
					end
				end
			end
		end

	build_agent_array (a_definition: XML_ELEMENT; bf: EB_METRIC_BASIC_FUNCTIONALITIES): ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]] is
			-- Return array containing agent for criteria evaluation for derived metrics.
		require
			valid_definition: a_definition /= Void
			function_pointer_not_void: bf /= Void
		local
			raw_metric_name: STRING
		do
			raw_metric_name := xml_string (a_definition, "Raw_metric")
			if equal (raw_metric_name, interface_names.metric_classes) then
				Result := agent_array_for_classes (a_definition, bf)
			elseif equal (raw_metric_name, interface_names.metric_dependents) then
				Result := agent_array_for_dependents (a_definition, bf)
			elseif equal (raw_metric_name, interface_names.metric_features) then
				Result := agent_array_for_features (a_definition, bf)
			end
		ensure
			agent_built: Result /= Void
		end

	agent_array_for_classes (a_definition: XML_ELEMENT; bf: EB_METRIC_BASIC_FUNCTIONALITIES): ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]] is
			-- Return array containing agent for criteria evaluation for derived metrics
			-- when parent raw metric is "classes".
		require
			valid_definition: a_definition /= Void
			function_pointer_not_void: bf /= Void
		local
			bool: BOOLEAN
		do
			create Result.make (1, 3)
			if element_by_name (a_definition, "Deferred_class") /= Void then
				bool := xml_boolean (a_definition, "Deferred_class")
				if bool then
					Result.put (bf~is_class_deferred, 1)
				else
					Result.put (bf~is_class_effective, 1)
				end
			end
			if element_by_name (a_definition, "Invariant") /= Void then
				bool := xml_boolean (a_definition, "Invariant")
				if bool then
					Result.put (bf~is_class_invariant_equipped, 2)
				else
					Result.put (bf~is_class_invariant_equipped_less, 2)
				end
			end
			if element_by_name (a_definition, "Obsolete") /= Void then
				bool := xml_boolean (a_definition, "Obsolete")
				if bool then
					Result.put (bf~is_class_obsolete, 3)
				else
					Result.put (bf~is_class_not_obsolete, 3)
				end
			end
		ensure
			agent_built: Result /= Void
		end

	agent_array_for_dependents (a_definition: XML_ELEMENT; bf: EB_METRIC_BASIC_FUNCTIONALITIES): ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]] is
			-- Return array containing agent for criteria evaluation for derived metrics
			-- when parent raw metric is "dependents".
		require
			valid_definition: a_definition /= Void
			function_pointer_not_void: bf /= Void
		local
			bool: BOOLEAN
		do
			create Result.make (1, 4)
			if element_by_name (a_definition, "D_or_i_clients") /= Void then
				bool := xml_boolean (a_definition, "D_or_i_clients")
				if bool then
					Result.put (bf~is_class_direct_client, 1)
				else
					Result.put (bf~is_class_client, 1)
				end
			end
			if element_by_name (a_definition, "D_or_i_suppliers") /= Void then
				bool := xml_boolean (a_definition, "D_or_i_suppliers")
				if bool then
					Result.put (bf~is_class_direct_supplier, 2)
				else
					Result.put (bf~is_class_supplier, 2)
				end
			end
			if element_by_name (a_definition, "D_or_i_heirs") /= Void then
				bool := xml_boolean (a_definition, "D_or_i_heirs")
				if bool then
					Result.put (bf~is_class_direct_heir, 3)
				else
					Result.put (bf~is_class_heir, 3)
				end
			end
			if element_by_name (a_definition, "D_or_i_parents") /= Void then
				bool := xml_boolean (a_definition, "D_or_i_parents")
				if bool then
					Result.put (bf~is_class_direct_parent, 4)
				else
					Result.put (bf~is_class_parent, 4)
				end
			end
		ensure
			agent_built: Result /= Void
		end

	agent_array_for_features (a_definition: XML_ELEMENT; bf: EB_METRIC_BASIC_FUNCTIONALITIES): ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]] is
			-- Return array containing agent for criteria evaluation for derived metrics
			-- when parent raw metric is "features".
		require
			valid_definition: a_definition /= Void
			function_pointer_not_void: bf /= Void
		local
			bool: BOOLEAN
		do
			create Result.make (1, 7)
			if element_by_name (a_definition, "Attr_or_rout") /= Void then
				bool := xml_boolean (a_definition, "Attr_or_rout")
				if bool then
					Result.put (bf~is_feature_attribute, 1)
				else
					Result.put (bf~is_feature_routine, 1)
				end
			end
			if element_by_name (a_definition, "Quer_or_comm") /= Void then
				bool := xml_boolean (a_definition, "Quer_or_comm")
				if bool then
					Result.put (bf~is_feature_querie, 2)
				else
					Result.put (bf~is_feature_command, 2)
				end
			end
			if element_by_name (a_definition, "Function") /= Void then
				bool := xml_boolean (a_definition, "Function")
				if bool then
					Result.put (bf~is_feature_function, 2)
				else
					Result.put (bf~is_feature_not_function, 2)
				end
			end
			if element_by_name (a_definition, "Deferred_feat") /= Void then
				bool := xml_boolean (a_definition, "Deferred_feat")
				if bool then
					Result.put (bf~is_feature_deferred, 3)
				else
					Result.put (bf~is_feature_effective, 3)
				end
			end
			if element_by_name (a_definition, "Exported") /= Void then
				bool := xml_boolean (a_definition, "Exported")
				if bool then
					Result.put (bf~is_feature_exported, 4)
				else
					Result.put (bf~is_feature_not_exported, 4)
				end
			end
			if element_by_name (a_definition, "Inherited") /= Void then
				bool := xml_boolean (a_definition, "Inherited")
				if bool then
					Result.put (bf~is_feature_inherited, 5)
				else
					Result.put (bf~is_feature_not_inherited, 5)
				end
			end
			if element_by_name (a_definition, "Pre_equi") /= Void then
				bool := xml_boolean (a_definition, "Pre_equi")
				if bool then
					Result.put (bf~is_feature_precondition_equipped, 6)
				else
					Result.put (bf~is_feature_precondition_equipped_less, 6)
				end
			end
			if element_by_name (a_definition, "Post_equi") /= Void then
				bool := xml_boolean (a_definition, "Post_equi")
				if bool then
					Result.put (bf~is_feature_postcondition_equipped, 7)
				else
					Result.put (bf~is_feature_postcondition_equipped_less, 7)
				end
			end
		ensure
			agent_built: Result /= Void
		end

	corresponding_scope_index (str: STRING): INTEGER is
			-- Return index of scope of name `str'.
		require
			valid_scope: str /= Void and then not str.is_empty
		do
			if equal (str, "Feature_scope") then
				Result := Feature_scope
			elseif equal (str, "Class_scope") then
				Result := Class_scope
			elseif equal (str, "Cluster_scope") then
				Result := Cluster_scope
			elseif equal (str, "System_scope") then
				Result := System_scope
			end
		ensure
			correct_range: Result >= Feature_scope and Result <= System_scope
		end

feature -- Measures

	retrieve_recorded_measures (f: PLAIN_TEXT_FILE) is
			-- Retrieve recorded measures from `file_manager.metric_file'.
		local
			s: STRING
			parser: XML_TREE_PARSER
			metric_element, node: XML_ELEMENT
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			row_array: ARRAY [STRING]
			row: EV_MULTI_COLUMN_LIST_ROW
			retried, info_missing, a_percentage: BOOLEAN
			a_metric: EB_METRIC
			a_composite_metric: EB_METRIC_COMPOSITE
			a_result: DOUBLE
			error_dialog:EB_INFORMATION_DIALOG
		do
			if not retried then
				create parser.make
				f.start
				f.read_stream (f.count)
				s := f.last_string
				parser.parse_string (s)
				parser.set_end_of_file
				if parser.is_correct then
					metric_element := element_by_name (parser.root_element, "RECORDED_MEASURES")
					a_cursor := metric_element.new_cursor
					from
						a_cursor.start
					until
						a_cursor.after
					loop
						create row_array.make (1, 6)
						node ?= a_cursor.item
						if node /= Void then
							info_missing := (not node.has (element_by_name (node, "MEASURE_NAME"))
											 or else (element_by_name (node, "MEASURE_NAME")).is_empty) or
											 (not node.has (element_by_name (node, "SCOPE_TYPE"))
											 or else (element_by_name (node, "SCOPE_TYPE")).is_empty) or
											 (not node.has (element_by_name (node, "SCOPE_NAME"))
											 or else (element_by_name (node, "SCOPE_NAME")).is_empty) or
											 (not node.has (element_by_name (node, "METRIC"))
											 or else (element_by_name (node, "METRIC")).is_empty) or
											 (not node.has (element_by_name (node, "RESULT"))
											 or else (element_by_name (node, "RESULT")).is_empty)
							if not info_missing then
								row_array.put (xml_string (node,"MEASURE_NAME"), 1)
								row_array.put (xml_string (node,"SCOPE_TYPE"), 2)
								row_array.put (xml_string (node,"SCOPE_NAME"), 3)
								row_array.put (xml_string (node,"METRIC"), 4)
								a_metric := tool.metric (xml_string (node,"METRIC"))
								a_percentage := a_metric.percentage
								a_result := xml_double (node,"RESULT")
								row_array.put (tool.fix_decimals_and_percentage (a_result, a_percentage), 5)
								tool.scope (interface_names.metric_this_system).set_system_i (tool.System)
								a_composite_metric ?= a_metric
								row_array.put (" - ", 6)
								if not row_array.is_empty then
									create row
									row.fill (row_array)
										-- `recorded_measures_manager' needs a DOUBLE value.
									row.put_i_th ((xml_double (node,"RESULT")).out, 5)

										-- Each observer updates measure_header. To avoid redunduncies, other observers must
										-- not update measure_header just if they are alone.
									if not tool.is_file_loaded and then file_manager.observer_list.count = 1 then
										file_manager.add_row (row, node.attributes.item ("STATUS").value)
									end

									if node.attributes.item ("STATUS").value.is_equal ("old") then
										row.set_pixmap (Pixmaps.Icon_red_cross)
									else
										row.set_pixmap (Pixmaps.Icon_green_tick)
									end
										-- `multi_column_list' needn't a DOUBLE value.
									row.put_i_th (tool.fix_decimals_and_percentage (xml_double (node,"RESULT"), a_percentage), 5)
									tool.multi_column_list.extend (row)
								end
							else
							end
						end
						a_cursor.forth
					end
					tool.progress_dialog.hide
				elseif not parser.is_correct or info_missing then
					parser_problems := not parser.is_correct or info_missing
--				if not parser.is_correct or info_missing then
--					create error_dialog.make_with_text ("File: " + file_manager.metric_file_name + "%Nhas syntax error or missing information.")
--					error_dialog.show_modal_to_window (tool.development_window.window)
				end
				if tool.multi_column_list.is_empty then
					tool.adjust_columns_size
				else
					tool.resize_column_list_to_content (tool.multi_column_list)
				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to read file:%N"
								+ file_manager.metric_file_name )
			error_dialog.show_modal_to_window (tool.development_window.window)
			tool.progress_dialog.hide
			retry
		end

end -- class EB_METRIC_FILE_HANDLER
