note

	description:

		"EWG config file parser"

	copyright: "Copyright (c) 2004, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class EWG_CONFIG_PARSER

inherit

	EWG_CONFIG_ELEMENT_NAMES
		export {NONE} all end

	EWG_CONFIG_WRAPPER_TYPE_NAMES
		export {NONE} all end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	EWG_CONFIG_SHARED_CONSTRUCT_TYPE_NAMES
		export {NONE} all end
	ANY

create

	make

feature {NONE} -- Initialization

	make (an_error_handler: like error_handler)
			-- Create new EWG config file parser.
		require
			an_error_handler_not_void: an_error_handler /= Void
		do
			error_handler := an_error_handler
			create {XM_EIFFEL_PARSER} xml_parser.make
			xml_parser.set_string_mode_mixed
			create tree_pipe.make
			xml_parser.set_callbacks (tree_pipe.start)
			tree_pipe.tree.enable_position_table (xml_parser)
			create xml_validator.make (error_handler)
		ensure
			error_handler_set: error_handler = an_error_handler
		end

feature {ANY} -- Parsing

	parse_file (a_file: KI_CHARACTER_INPUT_STREAM; a_config_system: EWG_CONFIG_SYSTEM)
			-- Parse EWG config file file `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
			a_config_system_not_void: a_config_system /= Void
		local
			a_root_name: STRING
			a_document: XM_DOCUMENT
			a_root_element: XM_ELEMENT
			a_position_table: XM_POSITION_TABLE
		do
			xml_parser.parse_from_stream (a_file)
			if xml_parser.is_correct then
				if not tree_pipe.error.has_error then
					a_document := tree_pipe.document
					a_root_element := a_document.root_element
					a_root_name := a_root_element.name
					a_position_table := tree_pipe.tree.last_position_table
					if attached a_position_table then
						xml_validator.validate_config_system_doc (a_document, a_position_table)
						if not xml_validator.has_error then
							fill_config_system (a_config_system, a_root_element, a_position_table)
						end
					end
						-- TODO check what happens if a_position_table is Void
				else
					error_handler.report_parser_error (tree_pipe.last_error)
				end
			else
				error_handler.report_parser_error (xml_parser.last_error_extended_description)
			end
		end


feature {ANY} -- Access

	error_handler: EWG_ERROR_HANDLER
			-- Error handler

feature {NONE} -- Implementation

	xml_parser: XM_PARSER
			-- XML parser

	tree_pipe: XM_TREE_CALLBACKS_PIPE
			-- Tree generating callbacks

	xml_validator: EWG_CONFIG_VALIDATOR
			-- XML validator

feature {NONE} -- Implementation

	fill_config_system (a_config_system: EWG_CONFIG_SYSTEM; an_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Fill EWG config system `a_config_system' with data found in `an_element'.
		require
			a_config_system_not_void: a_config_system /= Void
			an_element_not_void: an_element /= Void
			is_config_system: STRING_.same_string (an_element.name, config_system_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
		do
			if attached an_element.attribute_by_name (name_attribute_name) as l_name_attribute_name then
				a_config_system.set_name (l_name_attribute_name.value)
			end
			cs := an_element.new_cursor
			from
				cs.start
			until
				cs.after
			loop
				if attached {XM_ELEMENT} cs.item as child then
					if STRING_.same_string (child.name, rule_list_element_name) then
						fill_config_system_with_rule_list (a_config_system, child, a_position_table)
					end
				end
				cs.forth
			end
		end

	fill_config_system_with_rule_list (a_config_system: EWG_CONFIG_SYSTEM; a_rule_list_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Fill EWG config system `a_config_system' with rule data found in `a_rule_list_element'.
		require
			a_config_system_not_void: a_config_system /= Void
			a_rule_list_element_not_void: a_rule_list_element /= Void
			is_rule_list_element: STRING_.same_string (a_rule_list_element.name, rule_list_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
		do
			cs := a_rule_list_element.new_cursor
			from
				cs.start
			until
				cs.after
			loop
				if attached {XM_ELEMENT} cs.item as child then
					if STRING_.same_string (child.name, rule_element_name) then
						add_rule_to_config_system (a_config_system, child, a_position_table)
					end
				end
				cs.forth
			end
		end

	add_rule_to_config_system (a_config_system: EWG_CONFIG_SYSTEM; a_rule_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Create a new rule out of `a_rule_element' and add it to `a_config_system'.
		require
			a_config_system_not_void: a_config_system /= Void
			a_rule_element_not_void: a_rule_element /= Void
			is_rule_element: STRING_.same_string (a_rule_element.name, rule_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			wrapper_clause: EWG_CONFIG_WRAPPER_CLAUSE
			rule: EWG_CONFIG_RULE
		do
			if
				attached a_rule_element.element_by_name (function_element_name) as l_function_excludes and then
				attached l_function_excludes.attribute_by_name (name_attribute_name) as l_name_attribute_name
			then
					-- functions_excludes
				a_config_system.function_excludes.force (l_name_attribute_name.value)
			elseif attached  a_rule_element.element_by_name (function_element_address_name) as l_function_address and then
				attached l_function_address.attribute_by_name (name_attribute_name) as l_name_attribute_name
					-- function address
			then
				a_config_system.function_address.force (l_name_attribute_name.value)
			else
					-- Wrapping clause
				if
					attached a_rule_element.element_by_name (match_element_name) as match_element and then
					attached a_rule_element.element_by_name (wrapper_element_name) as wrapper_element and then
					attached new_matching_clause (a_config_system, match_element, a_position_table) as matching_clause
				then

					if  matching_clause.construct_type_code = construct_type_names.any_code then
						wrapper_clause := new_any_wrapper_clause (a_config_system, wrapper_element, a_position_table)
					elseif matching_clause.construct_type_code = construct_type_names.none_code then
						wrapper_clause := new_none_wrapper_clause (a_config_system, wrapper_element, a_position_table)
					elseif matching_clause.construct_type_code = construct_type_names.struct_code then
						wrapper_clause := new_struct_wrapper_clause (a_config_system, wrapper_element, a_position_table)
					elseif matching_clause.construct_type_code = construct_type_names.union_code then
						wrapper_clause := new_union_wrapper_clause (a_config_system, wrapper_element, a_position_table)
					elseif matching_clause.construct_type_code = construct_type_names.enum_code then
						wrapper_clause := new_enum_wrapper_clause (a_config_system, wrapper_element, a_position_table)
					elseif matching_clause.construct_type_code = construct_type_names.function_code then
						wrapper_clause := new_function_wrapper_clause (a_config_system, wrapper_element, a_position_table)
					elseif matching_clause.construct_type_code = construct_type_names.callback_code then
						wrapper_clause := new_callback_wrapper_clause (a_config_system, wrapper_element, a_position_table)
					elseif matching_clause.construct_type_code = construct_type_names.macro_code then
						wrapper_clause := new_macro_wrapper_clause (a_config_system, wrapper_element, a_position_table)
					else
						check
							dead_end: False
						end
					end
					if attached wrapper_clause then
						create rule.make (matching_clause, wrapper_clause)
						if matching_clause.construct_type_code = construct_type_names.macro_code then
							a_config_system.append_macro_rule (rule)
						else
							a_config_system.append_rule (rule)
						end
					end
				end
			end
		end

	new_matching_clause (a_config_system: EWG_CONFIG_SYSTEM; a_match_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE): EWG_CONFIG_MATCHING_CLAUSE
			-- New matching clause from `a_match_element'
		require
			a_config_system_not_void: a_config_system /= Void
			a_match_element_not_void: a_match_element /= Void
			is_match_element: STRING_.same_string (a_match_element.name, match_element_name)
			a_position_table: a_position_table /= Void
		local
			construct_type_name: STRING
			construct_type_code: INTEGER
		do
			create Result.make
			if
				attached a_match_element.element_by_name (identifier_element_name) as child and then
				attached child.attribute_by_name (name_attribute_name) as l_name_attribute_name
			then
				Result.set_c_identifier_regexp (l_name_attribute_name.value)
			end

			if
				attached a_match_element.element_by_name (header_element_name) as child and then
				attached child.attribute_by_name (name_attribute_name) as l_name_attribute_name
			then
				Result.set_header_file_name_regexp (l_name_attribute_name.value)
			end

			if
				attached a_match_element.element_by_name (type_element_name) as child and then
				attached child.attribute_by_name (name_attribute_name) as l_name_attribute_name
			then
				construct_type_name := l_name_attribute_name.value
				construct_type_code := construct_type_names.construct_type_code_from_name (construct_type_name)
				Result.set_construct_type_code (construct_type_code)
			end

		end

	new_any_wrapper_clause (a_config_system: EWG_CONFIG_SYSTEM; a_wrapper_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE): detachable EWG_CONFIG_WRAPPER_CLAUSE
			-- New wrapper clause from `a_wrapper_element'
		require
			a_config_system_not_void: a_config_system /= Void
			a_wrapper_element_not_void: a_wrapper_element /= Void
			is_wrapper_element: STRING_.same_string (a_wrapper_element.name, wrapper_element_name)
			a_position_table: a_position_table /= Void
		local
			wrapper_type_name: STRING
		do
			if attached a_wrapper_element.attribute_by_name (type_attribute_name) as l_type_attribute_name then
				wrapper_type_name := l_type_attribute_name.value
			else
				wrapper_type_name := default_name
			end

			if STRING_.same_string (wrapper_type_name, default_name) then
				create {EWG_CONFIG_DEFAULT_WRAPPER_CLAUSE} Result.make
			elseif STRING_.same_string (wrapper_type_name, none_name) then
				create {EWG_CONFIG_NONE_WRAPPER_CLAUSE} Result.make
			else
					check
						dead_end: False
					end
			end
		end

	new_none_wrapper_clause (a_config_system: EWG_CONFIG_SYSTEM; a_wrapper_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE): EWG_CONFIG_WRAPPER_CLAUSE
			-- New wrapper clause from `a_wrapper_element'
		require
			a_config_system_not_void: a_config_system /= Void
			a_wrapper_element_not_void: a_wrapper_element /= Void
			is_wrapper_element: STRING_.same_string (a_wrapper_element.name, wrapper_element_name)
			a_position_table: a_position_table /= Void
		do
			create {EWG_CONFIG_NONE_WRAPPER_CLAUSE} Result.make
		end

	new_struct_wrapper_clause (a_config_system: EWG_CONFIG_SYSTEM; a_wrapper_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE): EWG_CONFIG_WRAPPER_CLAUSE
			-- New wrapper clause from `a_wrapper_element'
		require
			a_config_system_not_void: a_config_system /= Void
			a_wrapper_element_not_void: a_wrapper_element /= Void
			is_wrapper_element: STRING_.same_string (a_wrapper_element.name, wrapper_element_name)
			a_position_table: a_position_table /= Void
		do
			create {EWG_CONFIG_STRUCT_WRAPPER_CLAUSE} Result.make
		end

	new_union_wrapper_clause (a_config_system: EWG_CONFIG_SYSTEM; a_wrapper_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE): EWG_CONFIG_WRAPPER_CLAUSE
			-- New wrapper clause from `a_wrapper_element'
		require
			a_config_system_not_void: a_config_system /= Void
			a_wrapper_element_not_void: a_wrapper_element /= Void
			is_wrapper_element: STRING_.same_string (a_wrapper_element.name, wrapper_element_name)
			a_position_table: a_position_table /= Void
		do
			create {EWG_CONFIG_UNION_WRAPPER_CLAUSE} Result.make
		end

	new_enum_wrapper_clause (a_config_system: EWG_CONFIG_SYSTEM; a_wrapper_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE): EWG_CONFIG_WRAPPER_CLAUSE
			-- New wrapper clause from `a_wrapper_element'
		require
			a_config_system_not_void: a_config_system /= Void
			a_wrapper_element_not_void: a_wrapper_element /= Void
			is_wrapper_element: STRING_.same_string (a_wrapper_element.name, wrapper_element_name)
			a_position_table: a_position_table /= Void
		do
			create {EWG_CONFIG_ENUM_WRAPPER_CLAUSE} Result.make
		end

	new_function_wrapper_clause (a_config_system: EWG_CONFIG_SYSTEM; a_wrapper_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE): EWG_CONFIG_FUNCTION_WRAPPER_CLAUSE
			-- New wrapper clause from `a_wrapper_element'
		require
			a_config_system_not_void: a_config_system /= Void
			a_wrapper_element_not_void: a_wrapper_element /= Void
			is_wrapper_element: STRING_.same_string (a_wrapper_element.name, wrapper_element_name)
			a_position_table: a_position_table /= Void
		local
			class_name: STRING
		do
			create Result.make
			if
				attached a_wrapper_element.element_by_name (class_name_element_name) as class_name_element and then
				attached class_name_element.attribute_by_name (name_attribute_name) as l_name_attribute_name
			then
				class_name := l_name_attribute_name.value
				Result.set_class_name (class_name)
			end
		end

	new_callback_wrapper_clause (a_config_system: EWG_CONFIG_SYSTEM; a_wrapper_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE): EWG_CONFIG_CALLBACK_WRAPPER_CLAUSE
			-- New wrapper clause from `a_wrapper_element'
		require
			a_config_system_not_void: a_config_system /= Void
			a_wrapper_element_not_void: a_wrapper_element /= Void
			is_wrapper_element: STRING_.same_string (a_wrapper_element.name, wrapper_element_name)
			a_position_table: a_position_table /= Void
		do
			create Result.make
			if
				attached a_wrapper_element.element_by_name (callbacks_per_type_element_name) as callbacks_per_type_element and then
				attached callbacks_per_type_element.attribute_by_name (value_attribute_name) as l_value_attribute_name
			then
				if l_value_attribute_name.value.is_integer and then
					l_value_attribute_name.value.to_integer > 0
				then
					Result.set_callbacks_per_type (l_value_attribute_name.value.to_integer)
				end
			end
		end

	new_macro_wrapper_clause (a_config_system: EWG_CONFIG_SYSTEM; a_wrapper_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE): WRAPC_CONFIG_MACRO_WRAPPER_CLAUSE
			-- New wrapper clause from `a_wrapper_element'
		require
			a_config_system_not_void: a_config_system /= Void
			a_wrapper_element_not_void: a_wrapper_element /= Void
			is_wrapper_element: STRING_.same_string (a_wrapper_element.name, wrapper_element_name)
			a_position_table: a_position_table /= Void
		local
			class_name: STRING
		do
			create Result.make
			if
				attached a_wrapper_element.element_by_name (class_name_element_name) as class_name_element and then
				attached class_name_element.attribute_by_name (name_attribute_name) as l_name_attribute_name
			then
				class_name := l_name_attribute_name.value
				Result.set_class_name (class_name)
			end
		end


invariant

	xml_parser_not_void: xml_parser /= Void
	tree_pipe_not_void: tree_pipe /= Void
	position_table_enabled: tree_pipe.tree.is_position_table_enabled
	xml_validator_not_void: xml_validator /= Void
	error_handler_not_void: error_handler /= Void

end
