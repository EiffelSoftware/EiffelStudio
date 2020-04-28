note

	description:

		"EWG config file validator"

	copyright: "Copyright (c) 2004, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class EWG_CONFIG_VALIDATOR

inherit

	EWG_CONFIG_ELEMENT_NAMES
		export {NONE} all end

	EWG_CONFIG_SHARED_WRAPPER_TYPE_NAMES
		export {NONE} all end

	EWG_CONFIG_SHARED_CONSTRUCT_TYPE_NAMES
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end
	ANY

create

	make

feature {NONE} -- Initialization

	make (an_error_handler: like error_handler)
			-- Create new EWG config file validator.
		require
			an_error_handler_not_void: an_error_handler /= Void
		do
			error_handler := an_error_handler
		ensure
			error_handler_set: error_handler = an_error_handler
		end

feature {ANY} -- Status report

	has_error: BOOLEAN
			-- Has an error been detected during the
			-- last validation procress?

feature {ANY} -- Access

	error_handler: EWG_ERROR_HANDLER
			-- Error handler

feature {ANY} -- Validation

	validate_config_system_doc (a_doc: XM_DOCUMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_doc' is a valid XML EWG config system.
			-- Set `has_error' to `True' if not.
		require
			a_doc_not_void: a_doc /= Void
			a_position_table_not_void: a_position_table /= Void
		do
			has_error := False
			if STRING_.same_string (a_doc.root_element.name, config_system_element_name) then
				validate_config_system (a_doc.root_element, a_position_table)
			else
				has_error := True
				error_handler.report_wrong_config_root_element_error (config_system_element_name, a_position_table.item (a_doc.root_element))
			end
		end

feature {NONE} -- Validation

	validate_config_system (a_config_system: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_config_system' is a valid EWG config "ewg_config" element.
			-- Set `has_error' to `True' if not.
		require
			a_config_system_not_void: a_config_system /= Void
			a_config_system_is_config_system: STRING_.same_string (a_config_system.name, config_system_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
		do
			cs := a_config_system.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				elseif STRING_.same_string (child.name, rule_list_element_name) then
					-- OK.
					validate_rule_list (child, a_position_table)
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_config_system, child, a_position_table.item (child))
				end
				cs.forth
			end
		end

	validate_rule_list (a_rule_list: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_rule_list' is a valid EWG config "rule_list" element.
			-- Set `has_error' to `True' if not.
		require
			a_rule_list_not_void: a_rule_list /= Void
			a_rule_list_is_rule_list: STRING_.same_string (a_rule_list.name, rule_list_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
		do
			cs := a_rule_list.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				elseif STRING_.same_string (child.name, rule_element_name) then
					-- OK.
					validate_rule (child, a_position_table)
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_rule_list, child, a_position_table.item (child))
				end
				cs.forth
			end
		end

	validate_rule (a_rule: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_rule' is a valid EWG config "rule" element.
			-- Set `has_error' to `True' if not.
		require
			a_rule_not_void: a_rule /= Void
			a_rule_is_rule: STRING_.same_string (a_rule.name, rule_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
			match_clause_parsed: BOOLEAN
			construct_type_name: STRING
			construct_type_code: INTEGER
		do
			cs := a_rule.new_cursor
			cs.start
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				elseif STRING_.same_string (child.name, match_element_name) then
					-- OK.
					validate_match (child, a_position_table)
					match_clause_parsed := True
					if attached child.element_by_name (type_element_name) as type and then
						attached type.attribute_by_name (name_attribute_name) as l_construct_type_name
					then
						construct_type_name := l_construct_type_name.value
						construct_type_code := construct_type_names.construct_type_code_from_name (construct_type_name)
					else
						construct_type_code := construct_type_names.any_code
					end
				elseif STRING_.same_string (child.name, wrapper_element_name) then
					if not match_clause_parsed then
						error_handler.report_unexpected_element_error (match_element_name, child, a_position_table.item (child))
					else
						-- OK.
						validate_wrapper (child, a_position_table, construct_type_code)
					end
				elseif STRING_.same_string (child.name, function_element_name) then
					validate_function (child, a_position_table)
				elseif STRING_.same_string (child.name, function_element_address_name) then
					validate_function_address (child, a_position_table)
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_rule, child, a_position_table.item (child))
				end
				cs.forth
			end
		end

	validate_match (a_match: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_match' is a valid EWG config "match" element.
			-- Set `has_error' to `True' if not.
		require
			a_match_not_void: a_match /= Void
			a_match_is_rule: STRING_.same_string (a_match.name, match_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
		do
			cs := a_match.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				elseif STRING_.same_string (child.name, header_element_name) then
					-- OK.
					validate_header (child, a_position_table)
				elseif STRING_.same_string (child.name, identifier_element_name) then
					-- OK.
					validate_identifier (child, a_position_table)
				elseif STRING_.same_string (child.name, type_element_name) then
					-- OK.
					validate_match_type (child, a_position_table)
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_match, child, a_position_table.item (child))
				end
				cs.forth
			end
		end

	validate_function (a_function: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_function' is a valid EWG config "function" element.
			-- Set `has_error' to `True' if not.
		require
			a_function_not_void: a_function /= Void
			a_function_is_rule: STRING_.same_string (a_function.name, function_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
		do
			if not a_function.has_attribute_by_name (name_attribute_name) then
				has_error := True
				error_handler.report_missing_config_attribute_error (a_function, name_attribute_name, a_position_table.item (a_function))
			else
--				create regexp.make
--				regexp.compile (a_identifier.attribute_by_name (name_attribute_name).value)
--				if not regexp.is_compiled then
--					error_handler.report_illegal_regular_expression_in_attribute (a_identifier,
--																									  name_attribute_name,
--																									  a_position_table.item (a_identifier),
--																									  regexp.error_message,
--																									  regexp.error_position)
--				end
			end

			cs := a_function.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_function, child, a_position_table.item (child))
				end
				cs.forth
			end


		end

	validate_function_address (a_function_address: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_function_address' is a valid EWG config "function_address" element.
			-- Set `has_error' to `True' if not.
		require
			a_function_address_not_void: a_function_address /= Void
			a_function_address_is_rule: STRING_.same_string (a_function_address.name, function_element_address_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
			regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			if not a_function_address.has_attribute_by_name (name_attribute_name) then
				has_error := True
				error_handler.report_missing_config_attribute_error (a_function_address, name_attribute_name, a_position_table.item (a_function_address))
			else
--				create regexp.make
--				regexp.compile (a_identifier.attribute_by_name (name_attribute_name).value)
--				if not regexp.is_compiled then
--					error_handler.report_illegal_regular_expression_in_attribute (a_identifier,
--																									  name_attribute_name,
--																									  a_position_table.item (a_identifier),
--																									  regexp.error_message,
--																									  regexp.error_position)
--				end
			end

			cs := a_function_address.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_function_address, child, a_position_table.item (child))
				end
				cs.forth
			end
		end


	validate_wrapper (a_wrapper: XM_ELEMENT; a_position_table: XM_POSITION_TABLE; a_construct_type_code: INTEGER)
			-- Check whether `a_wrapper' is a valid EWG config "wrapper" element.
			-- Set `has_error' to `True' if not.
		require
			a_wrapper_not_void: a_wrapper /= Void
			a_wrapper_is_rule: STRING_.same_string (a_wrapper.name, wrapper_element_name)
			a_position_table_not_void: a_position_table /= Void
			valid_construct_type_code: construct_type_names.is_valid_construct_type_code (a_construct_type_code)
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
		do
			if attached a_wrapper.attribute_by_name (type_attribute_name) as l_type_attribute_name then
				if
					not wrapper_type_names.is_valid_wrapper_type_name (l_type_attribute_name.value)
				then
					has_error := True
					error_handler.report_unknown_config_wrapper_type_error (a_wrapper, a_position_table.item (a_wrapper))
				end
			end

			if attached a_wrapper.attribute_by_name (type_attribute_name) as  l_type_attribute_name then
				if
					not wrapper_type_names.is_valid_wrapper_type_name (l_type_attribute_name.value)
				then
					has_error := True
					error_handler.report_unknown_config_wrapper_type_error (a_wrapper, a_position_table.item (a_wrapper))
				end
			else
				has_error := True
				error_handler.report_missing_config_attribute_error (a_wrapper, type_attribute_name, a_position_table.item (a_wrapper))
			end

			cs := a_wrapper.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				else
					if
						STRING_.same_string (child.name, class_name_element_name) and (
						a_construct_type_code = construct_type_names.function_code	or
						a_construct_type_code = construct_type_names.macro_code)
					then
						-- OK
							validate_class_name (child, a_position_table)
					elseif 	STRING_.same_string (child.name, callbacks_per_type_element_name) and
						a_construct_type_code = construct_type_names.callback_code
					then
						-- OK
							validate_callbacks_per_type (child, a_position_table)
					else
						has_error := True
						error_handler.report_unknown_config_element_error (a_wrapper, child, a_position_table.item (child))
					end
				end
				cs.forth
			end
		end

	validate_header (a_header: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_header' is a valid EWG config "header" element.
			-- Set `has_error' to `True' if not.
		require
			a_header_not_void: a_header /= Void
			a_header_is_rule: STRING_.same_string (a_header.name, header_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
			regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			if attached a_header.attribute_by_name (name_attribute_name) as l_name_attribute_name then
				create regexp.make
				regexp.compile (l_name_attribute_name.value)
				if not regexp.is_compiled then
					error_handler.report_illegal_regular_expression_in_attribute (a_header,
																									  name_attribute_name,
																									  a_position_table.item (a_header),
																									  regexp.error_message,
																									  regexp.error_position)
				end
			else
				has_error := True
				error_handler.report_missing_config_attribute_error (a_header, name_attribute_name, a_position_table.item (a_header))
			end

			cs := a_header.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_header, child, a_position_table.item (child))
				end
				cs.forth
			end
		end

	validate_identifier (a_identifier: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_identifier' is a valid EWG config "identifier" element.
			-- Set `has_error' to `True' if not.
		require
			a_identifier_not_void: a_identifier /= Void
			a_identifier_is_rule: STRING_.same_string (a_identifier.name, identifier_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
			regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			if attached a_identifier.attribute_by_name (name_attribute_name) as l_name_attribute_name then
				create regexp.make
				regexp.compile (l_name_attribute_name.value)
				if not regexp.is_compiled then
					error_handler.report_illegal_regular_expression_in_attribute (a_identifier,
																									  name_attribute_name,
																									  a_position_table.item (a_identifier),
																									  regexp.error_message,
																									  regexp.error_position)
				end
			else
				has_error := True
				error_handler.report_missing_config_attribute_error (a_identifier, name_attribute_name, a_position_table.item (a_identifier))
			end

			cs := a_identifier.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_identifier, child, a_position_table.item (child))
				end
				cs.forth
			end
		end

	validate_match_type (a_type: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_type' is a valid EWG config "type" element.
			-- Set `has_error' to `True' if not.
		require
			a_type_not_void: a_type /= Void
			a_type_is_rule: STRING_.same_string (a_type.name, type_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
			name: STRING
		do

			if attached a_type.attribute_by_name (name_attribute_name) as l_name_attribute_name  then
				name := l_name_attribute_name.value
				if
					not construct_type_names.is_valid_construct_type_name (name)
				then
					has_error := True
					error_handler.report_unknown_config_construct_type_error (a_type, a_position_table.item (a_type))
				end
			else
				has_error := True
				error_handler.report_missing_config_attribute_error (a_type, name_attribute_name, a_position_table.item (a_type))
			end

			cs := a_type.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_type, child, a_position_table.item (child))
				end
				cs.forth
			end
		end

	validate_class_name (a_class_name: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_class_name' is a valid EWG config "class_name" element.
			-- Set `has_error' to `True' if not.
		require
			a_class_name_not_void: a_class_name /= Void
			a_class_name_is_class_name: STRING_.same_string (a_class_name.name, class_name_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
			name: STRING
		do
			if attached a_class_name.attribute_by_name (name_attribute_name) as l_name_attribute_name then
				name := l_name_attribute_name.value
				if
					name.count = 0
				then
					has_error := True
					error_handler.report_invalid_class_name_error (a_class_name, a_position_table.item (a_class_name))
				end
			else
				has_error := True
				error_handler.report_missing_config_attribute_error (a_class_name, name_attribute_name, a_position_table.item (a_class_name))
			end

			cs := a_class_name.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_class_name, child, a_position_table.item (child))
				end
				cs.forth
			end
		end


	validate_callbacks_per_type (a_callback: XM_ELEMENT; a_position_table: XM_POSITION_TABLE)
			-- Check whether `a_callback' is a valid EWG config "callbacks_per_type" element.
			-- Set `has_error' to `True' if not.
		require
			a_class_name_not_void: a_callback /= Void
			a_class_name_is_class_name: STRING_.same_string (a_callback.name, callbacks_per_type_element_name)
			a_position_table_not_void: a_position_table /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
			value: STRING
		do
			if attached a_callback.attribute_by_name (value_attribute_name) as l_value_attribute_name then
				value := l_value_attribute_name.value
				if
					not value.is_natural
				then
					has_error := True
					error_handler.report_invalid_class_name_error (a_callback, a_position_table.item (a_callback))
				end
			else
				has_error := True
				error_handler.report_missing_config_attribute_error (a_callback, value_attribute_name, a_position_table.item (a_callback))
			end

			cs := a_callback.new_cursor
			from cs.start until cs.after loop
				child ?= cs.item
				if child = Void then
					-- Not an element. Ignore.
				else
					has_error := True
					error_handler.report_unknown_config_element_error (a_callback, child, a_position_table.item (child))
				end
				cs.forth
			end
		end

invariant

	error_handler_not_void: error_handler /= Void

end
