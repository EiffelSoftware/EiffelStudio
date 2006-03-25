indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	retrieve_metric (f: PLAIN_TEXT_FILE; metric_list: ARRAYED_LIST [EB_METRIC]; xml_list: ARRAYED_LIST [XM_ELEMENT]) is
			-- Retrieve recorded metric definitions from `file_manager.metric_file'.
			-- Store metric objects in `metric_list' and their XML definition in `xml_list'.
		local
			metric_name, metric_unit, scope_num, scope_den, type, parent_name: STRING
			l_deserialized_document: XM_DOCUMENT
			metric_element, node, definition, scope_element: XM_ELEMENT
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			min_scope, i: INTEGER
			composite_metric: EB_METRIC_COMPOSITE
			derived_metric: EB_METRIC_DERIVED
			tree: EB_METRIC_VALUE
			bf: EB_METRIC_BASIC_FUNCTIONALITIES
			agent_array: ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]]
			is_derived, is_linear, is_metric_ratio, is_scope_ratio,
			retried, info_missing, percentage, op, self: BOOLEAN
		do
			if not retried then
				tool.set_min_scope_available (tool.scope (interface_names.metric_this_system).index)
				l_deserialized_document := Xml_routines.deserialize_document (f.name)
				if l_deserialized_document /= Void then
					metric_element := Xml_routines.element_by_name (l_deserialized_document.root_element, "METRIC_DEFINITIONS")
					a_cursor := metric_element.new_cursor
					from
						a_cursor.start
						i := 1
					until
						a_cursor.after
					loop
						node ?= a_cursor.item
						a_cursor.forth
						if node /= Void then
							info_missing :=
								(not node.has_attribute_by_name ("Name") or else node.attribute_by_name ("Name").value.is_empty) or
								(not node.has_attribute_by_name ("Unit") or else node.attribute_by_name ("Unit").value.is_empty) or
								(not node.has_attribute_by_name ("Type") or else node.attribute_by_name ("Type").value.is_empty) or
								(not node.has_attribute_by_name ("Min_scope") or else node.attribute_by_name ("Min_scope").value.is_empty) or
								(not node.has (Xml_routines.element_by_name (node, "DEFINITION"))
								or else (Xml_routines.element_by_name (node, "DEFINITION")).is_empty)

							if not info_missing then
								metric_name := node.attribute_by_name ("Name").value
								metric_unit := node.attribute_by_name ("Unit").value
								type := node.attribute_by_name ("Type").value
								min_scope := corresponding_scope_index (node.attribute_by_name ("Min_scope").value)
								is_derived := equal ("Derived", type)
								is_linear := equal ("Linear", type)
								is_metric_ratio := equal ("MRatio", type)
								is_scope_ratio := equal ("SRatio", type)
								definition := Xml_routines.element_by_name (node, "DEFINITION")
								if is_derived then
									create bf
									agent_array := build_agent_array (definition, bf)
									parent_name := Xml_routines.xml_string (definition, "Raw_metric")
									op := Xml_routines.xml_boolean (definition, "And")
									self := Xml_routines.xml_boolean (definition, "Self")
								else
									tree := build_operator (definition, is_linear, is_metric_ratio, is_scope_ratio, True)
								end
								if tree /= Void or agent_array /= Void then
									if tree /= Void and not is_derived then
										create composite_metric.make (metric_name, metric_unit, tree, min_scope)
										composite_metric.set_linear (is_linear)
										composite_metric.set_metric_ratio (is_metric_ratio)
										composite_metric.set_scope_ratio (is_scope_ratio)
										if is_metric_ratio or is_scope_ratio then
											percentage := node.attribute_by_name ("Percentage").value.to_boolean
											composite_metric.set_percentage (percentage)
										end
										if is_scope_ratio then
											scope_element ?= definition.item (2)
											scope_num := scope_element.text
											composite_metric.set_scope_num (tool.scope (scope_num))
											scope_element ?= definition.item (3)
											scope_den := scope_element.text
											composite_metric.set_scope_den (tool.scope (scope_den))
										end
										if metric_list /= tool.metrics or else tool.metric (composite_metric.name) = Void then
											metric_list.extend (composite_metric)
											xml_list.extend (node)
										end
									elseif is_derived and agent_array /= Void then
										create derived_metric.make (metric_name, metric_unit, parent_name, min_scope, agent_array, op, self, bf)
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
					end
				elseif info_missing or tree = Void then
					parser_problems := info_missing or tree = Void
--				if not parser.is_correct or info_missing or tree = Void then
--					create error_dialog.make_with_text ("File: " + file_manager.metric_file_name + "%Nhas syntax error or missing information")
--					error_dialog.show_modal_to_window (tool.development_window.window)
				end
			end
		rescue
			retried := True
			Xml_routines.display_warning_message_relative (
					"Unable to read file:%N" + file_manager.metric_file_name,
					tool.development_window.window)
			retry
		end

feature -- Metric operators

	build_operator (a_metric_definition: XM_ELEMENT; linear, metric_ratio, scope_ratio, success: BOOLEAN): EB_METRIC_VALUE is
			-- Translate `a_metric_definition' to a polish syntax and return tool to allow metric calculation.
			-- Called on defining new metric or on retrieveing saved-in-file metric.
		local
			stack: LINKED_STACK [EB_METRIC_VALUE]
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			node: XM_ELEMENT
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
								parameter := node.text.to_double
								create met_constant.make (parameter)
								stack.put (met_constant)
							elseif node.name.is_equal ("METRIC") then
								create met_measure.make (node.text, tool)
								stack.put (met_measure)
							elseif node.name.is_equal ("OPERATOR") then
								node_item := node.text
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
					node_item := Xml_routines.xml_string (a_metric_definition, "METRIC")
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

	build_agent_array (a_definition: XM_ELEMENT; bf: EB_METRIC_BASIC_FUNCTIONALITIES): ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]] is
			-- Return array containing agent for criteria evaluation for derived metrics.
		require
			valid_definition: a_definition /= Void
			function_pointer_not_void: bf /= Void
		local
			raw_metric_name: STRING
		do
			raw_metric_name := Xml_routines.xml_string (a_definition, "Raw_metric")
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

	agent_array_for_classes (a_definition: XM_ELEMENT; bf: EB_METRIC_BASIC_FUNCTIONALITIES): ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]] is
			-- Return array containing agent for criteria evaluation for derived metrics
			-- when parent raw metric is "classes".
		require
			valid_definition: a_definition /= Void
			function_pointer_not_void: bf /= Void
		local
			bool: BOOLEAN
		do
			create Result.make (1, 3)
			if Xml_routines.element_by_name (a_definition, "Deferred_class") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Deferred_class")
				if bool then
					Result.put (agent bf.is_class_deferred, 1)
				else
					Result.put (agent bf.is_class_effective, 1)
				end
			end
			if Xml_routines.element_by_name (a_definition, "Invariant") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Invariant")
				if bool then
					Result.put (agent bf.is_class_invariant_equipped, 2)
				else
					Result.put (agent bf.is_class_invariant_equipped_less, 2)
				end
			end
			if Xml_routines.element_by_name (a_definition, "Obsolete") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Obsolete")
				if bool then
					Result.put (agent bf.is_class_obsolete, 3)
				else
					Result.put (agent bf.is_class_not_obsolete, 3)
				end
			end
		ensure
			agent_built: Result /= Void
		end

	agent_array_for_dependents (a_definition: XM_ELEMENT; bf: EB_METRIC_BASIC_FUNCTIONALITIES): ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]] is
			-- Return array containing agent for criteria evaluation for derived metrics
			-- when parent raw metric is "dependents".
		require
			valid_definition: a_definition /= Void
			function_pointer_not_void: bf /= Void
		local
			bool: BOOLEAN
		do
			create Result.make (1, 4)
			if Xml_routines.element_by_name (a_definition, "D_or_i_clients") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "D_or_i_clients")
				if bool then
					Result.put (agent bf.is_class_direct_client, 1)
				else
					Result.put (agent bf.is_class_client, 1)
				end
			end
			if Xml_routines.element_by_name (a_definition, "D_or_i_suppliers") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "D_or_i_suppliers")
				if bool then
					Result.put (agent bf.is_class_direct_supplier, 2)
				else
					Result.put (agent bf.is_class_supplier, 2)
				end
			end
			if Xml_routines.element_by_name (a_definition, "D_or_i_heirs") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "D_or_i_heirs")
				if bool then
					Result.put (agent bf.is_class_direct_heir, 3)
				else
					Result.put (agent bf.is_class_heir, 3)
				end
			end
			if Xml_routines.element_by_name (a_definition, "D_or_i_parents") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "D_or_i_parents")
				if bool then
					Result.put (agent bf.is_class_direct_parent, 4)
				else
					Result.put (agent bf.is_class_parent, 4)
				end
			end
		ensure
			agent_built: Result /= Void
		end

	agent_array_for_features (a_definition: XM_ELEMENT; bf: EB_METRIC_BASIC_FUNCTIONALITIES): ARRAY [FUNCTION [ANY, TUPLE [EB_METRIC_SCOPE], BOOLEAN]] is
			-- Return array containing agent for criteria evaluation for derived metrics
			-- when parent raw metric is "features".
		require
			valid_definition: a_definition /= Void
			function_pointer_not_void: bf /= Void
		local
			bool: BOOLEAN
		do
			create Result.make (1, 7)
			if Xml_routines.element_by_name (a_definition, "Attr_or_rout") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Attr_or_rout")
				if bool then
					Result.put (agent bf.is_feature_attribute, 1)
				else
					Result.put (agent bf.is_feature_routine, 1)
				end
			end
			if Xml_routines.element_by_name (a_definition, "Quer_or_comm") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Quer_or_comm")
				if bool then
					Result.put (agent bf.is_feature_querie, 2)
				else
					Result.put (agent bf.is_feature_command, 2)
				end
			end
			if Xml_routines.element_by_name (a_definition, "Function") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Function")
				if bool then
					Result.put (agent bf.is_feature_function, 2)
				else
					Result.put (agent bf.is_feature_not_function, 2)
				end
			end
			if Xml_routines.element_by_name (a_definition, "Deferred_feat") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Deferred_feat")
				if bool then
					Result.put (agent bf.is_feature_deferred, 3)
				else
					Result.put (agent bf.is_feature_effective, 3)
				end
			end
			if Xml_routines.element_by_name (a_definition, "Exported") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Exported")
				if bool then
					Result.put (agent bf.is_feature_exported, 4)
				else
					Result.put (agent bf.is_feature_not_exported, 4)
				end
			end
			if Xml_routines.element_by_name (a_definition, "Inherited") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Inherited")
				if bool then
					Result.put (agent bf.is_feature_inherited, 5)
				else
					Result.put (agent bf.is_feature_not_inherited, 5)
				end
			end
			if Xml_routines.element_by_name (a_definition, "Pre_equi") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Pre_equi")
				if bool then
					Result.put (agent bf.is_feature_precondition_equipped, 6)
				else
					Result.put (agent bf.is_feature_precondition_equipped_less, 6)
				end
			end
			if Xml_routines.element_by_name (a_definition, "Post_equi") /= Void then
				bool := Xml_routines.xml_boolean (a_definition, "Post_equi")
				if bool then
					Result.put (agent bf.is_feature_postcondition_equipped, 7)
				else
					Result.put (agent bf.is_feature_postcondition_equipped_less, 7)
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
			l_deserialized_document: XM_DOCUMENT
			metric_element, node: XM_ELEMENT
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			row_array: ARRAY [STRING_32]
			row: EV_MULTI_COLUMN_LIST_ROW
			retried, info_missing, a_percentage: BOOLEAN
			a_metric: EB_METRIC
			a_composite_metric: EB_METRIC_COMPOSITE
			a_result: DOUBLE
		do
			if not retried then
				l_deserialized_document := Xml_routines.deserialize_document (f.name)
				if l_deserialized_document /= Void then
					metric_element := Xml_routines.element_by_name (l_deserialized_document.root_element, "RECORDED_MEASURES")
					a_cursor := metric_element.new_cursor
					from
						a_cursor.start
					until
						a_cursor.after
					loop
						create row_array.make (1, 6)
						node ?= a_cursor.item
						if node /= Void then
							info_missing := (not node.has (Xml_routines.element_by_name (node, "MEASURE_NAME"))
											 or else (Xml_routines.element_by_name (node, "MEASURE_NAME")).is_empty) or
											 (not node.has (Xml_routines.element_by_name (node, "SCOPE_TYPE"))
											 or else (Xml_routines.element_by_name (node, "SCOPE_TYPE")).is_empty) or
											 (not node.has (Xml_routines.element_by_name (node, "SCOPE_NAME"))
											 or else (Xml_routines.element_by_name (node, "SCOPE_NAME")).is_empty) or
											 (not node.has (Xml_routines.element_by_name (node, "METRIC"))
											 or else (Xml_routines.element_by_name (node, "METRIC")).is_empty) or
											 (not node.has (Xml_routines.element_by_name (node, "RESULT"))
											 or else (Xml_routines.element_by_name (node, "RESULT")).is_empty)
							if not info_missing then
								row_array.put (Xml_routines.xml_string (node,"MEASURE_NAME"), 1)
								row_array.put (Xml_routines.xml_string (node,"SCOPE_TYPE"), 2)
								row_array.put (Xml_routines.xml_string (node,"SCOPE_NAME"), 3)
								row_array.put (Xml_routines.xml_string (node,"METRIC"), 4)
								a_metric := tool.metric (Xml_routines.xml_string (node,"METRIC"))
								a_percentage := a_metric.percentage
								a_result := Xml_routines.xml_double (node,"RESULT")
								row_array.put (tool.fix_decimals_and_percentage (a_result, a_percentage), 5)
								tool.scope (interface_names.metric_this_system).set_system_i (tool.System)
								a_composite_metric ?= a_metric
								row_array.put (" - ", 6)
								if not row_array.is_empty then
									create row
									row.fill (row_array)
										-- `recorded_measures_manager' needs a DOUBLE value.
									row.put_i_th ((Xml_routines.xml_double (node, "RESULT")).out, 5)

										-- Each observer updates measure_header. To avoid redunduncies, other observers must
										-- not update measure_header just if they are alone.
									if not tool.is_file_loaded and then file_manager.observer_list.count = 1 then
										if node.has_attribute_by_name ("STATUS") then
											file_manager.add_row (row, node.attribute_by_name ("STATUS").value)
										end
									end
									if node.has_attribute_by_name ("STATUS") then
										if node.attribute_by_name ("STATUS").value.is_equal ("old") then
											row.set_pixmap (Pixmaps.Icon_red_cross)
										else
											row.set_pixmap (Pixmaps.Icon_green_tick)
										end
									end

										-- `multi_column_list' needn't a DOUBLE value.
									row.put_i_th (tool.fix_decimals_and_percentage (Xml_routines.xml_double (node, "RESULT"), a_percentage), 5)
									tool.multi_column_list.extend (row)
								end
							else
							end
						end
						a_cursor.forth
					end
					tool.progress_dialog.hide
				elseif info_missing then
					parser_problems := info_missing
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
			Xml_routines.display_warning_message_relative (
					"Unable to read file:%N" + file_manager.metric_file_name,
					tool.development_window.window)
			tool.progress_dialog.hide
			retry
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_METRIC_FILE_HANDLER
