indexing
	description: "The callbacks that react on metric xml parsing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_LOAD_METRIC_CALLBACKS

inherit
	XM_CALLBACKS_NULL
		redefine
			on_error,
			on_start_tag,
			on_attribute
		end

	EB_METRIC_XML_CONSTANTS

	EB_METRIC_SHARED

	QL_SHARED_NAMES

feature{NONE} -- Initialization

	initialize is
			-- Initialize.
		do
			create location_stack.make
			create element_stack.make
			create tester_receiver_stack.make
			create value_retriever_stack.make
		end

feature -- Access

	factory: EB_LOAD_METRIC_FACTORY
			-- Factory used to create new nodes when parsing xml definition file

	last_error: EB_METRIC_ERROR
			-- Last error

	current_tag: LINKED_STACK [INTEGER]
			-- The stack of tags we are currently processing

	current_attributes: HASH_TABLE [STRING, INTEGER]
			-- The values of the current attributes	

	first_parsed_node: EB_METRIC_VISITABLE
			-- Last parsed node

	location: STRING_GENERAL is
			-- Location from `location_stack'
		local
			l_location: STRING_32
			l_location_stack: like location_stack
		do
			create l_location.make (100)
			from
				l_location_stack := location_stack.duplicate (location_stack.count)
			until
				l_location_stack.is_empty
			loop
				if not l_location.is_empty then
					l_location.prepend (metric_names.location_connector)
				end
				l_location.prepend (l_location_stack.item)
				l_location_stack.remove
			end
			Result := l_location
		ensure
			result_attached: Result /= Void
		end

	xml_parser: XM_PARSER
			-- XML parser which is using current callback

feature -- Status report

	has_error: BOOLEAN is
			-- Does parsing contain error?
		do
			Result := last_error /= Void
		end

	is_for_whole_file: BOOLEAN
			-- Should the input be considered as a whole XML file instead of just an XML element?
			-- Default: True

feature -- Setting

	clear_last_error is
			-- Clear `last_error'.
		do
			last_error := Void
		ensure
			last_error_is_cleared: last_error = Void and then not has_error
		end

	set_first_parsed_node (a_node: like first_parsed_node) is
			-- Set `first_parsed_node' with `a_node'.
		do
			if a_node = Void then
				first_parsed_node := Void
			elseif first_parsed_node = Void then
				first_parsed_node := a_node
			end
		ensure
			first_parsed_node_set:
				(a_node = Void implies first_parsed_node = Void) and then
				((a_node /= Void and then old first_parsed_node = Void) implies first_parsed_node = a_node) and then
				((a_node /= Void and then old first_parsed_node /= Void) implies first_parsed_node = old first_parsed_node)
		end

	set_is_for_whole_file (b: BOOLEAN) is
			-- Set `is_for_whole_file' with `b'.
		do
			is_for_whole_file := b
		ensure
			is_for_whole_file_set: is_for_whole_file = b
		end

	set_xml_parser (a_parser: like xml_parser) is
			-- Set `xml_parser' with `a_parser'.
		do
			xml_parser := a_parser
		ensure
			xml_parser_set: xml_parser = a_parser
		end

feature -- Callbacks

	on_error (a_message: STRING) is
			-- Event producer detected an error.
		do
			create_last_error (a_message)
		end

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Start of start tag.
		local
			l_trans: HASH_TABLE [INTEGER, STRING]
			l_tag: INTEGER
		do
			if not has_error then
				if current_tag.is_empty then
					if is_for_whole_file then
						current_tag.extend (t_none)
						l_trans := state_transitions_tag.item (current_tag.item)
					else
						l_trans := element_index_table
					end
				else
					l_trans := state_transitions_tag.item (current_tag.item)
				end
				if l_trans /= Void then
					l_tag := l_trans.item (a_local_part)
				end
				if l_tag = 0 then
					create_last_error (metric_names.err_invalid_tag_position (a_local_part))
				else
					current_tag.extend (l_tag)
					element_stack.extend (a_local_part)
				end
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- Start of attribute.
		local
			l_attr: HASH_TABLE [INTEGER, STRING]
			l_attribute: INTEGER
		do
			if not has_error then
				if
					not a_local_part.is_case_insensitive_equal ("xmlns") and
					not	a_local_part.is_case_insensitive_equal ("xsi") and
					not a_local_part.is_case_insensitive_equal ("schemaLocation")
				then
					a_local_part.to_lower

						-- check if the attribute is valid for the current state
					l_attr := tag_attributes.item (current_tag.item)
					if l_attr /= Void then
						l_attribute := l_attr.item (a_local_part)
					end
					if current_attributes = Void then
						create current_attributes.make (1)
					end
					if l_attribute /= 0 and then not current_attributes.has (l_attribute) then
						current_attributes.force (a_value, l_attribute)
					else
						location_stack.extend (metric_names.xml_location (element_stack.item, Void))
						create_last_error (metric_names.err_invalid_attribute (a_local_part))
					end
				end
			end
		end

feature{NONE} -- Implementation

	current_domain: EB_METRIC_DOMAIN
			-- Current domain

	current_domain_item: EB_METRIC_DOMAIN_ITEM
			-- Current domain item

feature{NONE} -- Implementation

	state_transitions_tag: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
			-- Mapping of possible tag state transitions from `current_tag' with the tag name to the new state.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	tag_attributes: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
			-- Mapping of possible attributes of tags.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	element_index_table: HASH_TABLE [INTEGER, STRING] is
			-- Table of indexes of supported elements indexed by element name.
		deferred
		ensure
			result_attached: Result /= Void
		end

	domain_item_type_table: HASH_TABLE [FUNCTION [ANY, TUPLE[STRING], EB_METRIC_DOMAIN_ITEM], STRING] is
			-- Domain item type
		once
			create Result.make (6)
			Result.put (agent factory.new_application_target_item, "target")
			Result.put (agent factory.new_group_item, "group")
			Result.put (agent factory.new_folder_item, "folder")
			Result.put (agent factory.new_class_item, "class")
			Result.put (agent factory.new_feature_item, "feature")
			Result.put (agent factory.new_delayed_item, "delayed")
		ensure
			result_attached: Result /= Void
		end

	check_uuid_validity (a_uuid_str: STRING_GENERAL) is
			-- Check validity of `a_uuid_str'.
			-- `a_location' is where `a_uuid_str' appears.
		do
			last_valid_uuid := Void
			if a_uuid_str = Void then
				create_last_error (metric_names.err_uuid_missing)
			else
				if not shared_uuid.is_valid_uuid (a_uuid_str.as_string_8) then
					create_last_error (metric_names.err_uuid_invalid (a_uuid_str))
				else
					create last_valid_uuid.make_from_string (a_uuid_str.as_string_8)
				end
			end
		end

	last_valid_uuid: UUID
			-- Last valid UUID generated by `check_uuid_validity'.
			-- If no UUID has been checked or the last checked UUID is invalid,
			-- this will be Void

	operator_name_set: DS_HASH_SET [STRING] is
			-- Operator name set
		local
			l_tbl: like operator_name_table
		once
			create Result.make (6)
			Result.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [STRING]}.make (agent (a_str: STRING; b_str: STRING): BOOLEAN do Result := a_str.is_equal (b_str) end))
			l_tbl := operator_name_table
			from
				l_tbl.start
			until
				l_tbl.after
			loop
				Result.force_last (l_tbl.key_for_iteration)
				l_tbl.forth
			end
		ensure
			result_attached: Result /= Void
		end

	domain_receiver_stack: LINKED_STACK [TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_DOMAIN]]; is_called: BOOLEAN]]
			-- Domain receiver stack
			-- `setter' is the setter procedure to set last parsed domain,
			-- `is_called' is a flag to indicate if a domain exists. It's used to detect if a needed domain is missing.

	location_stack: LINKED_STACK [STRING_GENERAL]
			-- Location stack used to provide location information in error message
			-- Every item in this stack represents a location section information

	element_stack: LINKED_STACK [STRING_GENERAL]
			-- Stack of met element name			

	tester_receiver_stack: LINKED_STACK [TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_TESTER]]; is_called: BOOLEAN]]
			-- Tester receiver stack
			-- `setter' is the setter procedure to set last parsed tester.
			-- `is_called' is a flag to indicate if a tester exists. It's used to detect if a needed tester is missing.

	value_retriever_stack: LINKED_STACK [TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_RETRIEVER]]; is_called: BOOLEAN]]
			-- Value retriever stack
			-- `setter' is the setter procedure to set last parsed value retriever.
			-- `is_called' is a flag to indicate if a value retirever exists. It's used to detect if a needed value retriever is missing.	

	current_tester: EB_METRIC_VALUE_TESTER
			-- Current value tester

	current_value_retriever: EB_METRIC_VALUE_RETRIEVER
			-- Current value retriever

	current_metric_value_retriever: EB_METRIC_METRIC_VALUE_RETRIEVER
			-- Current metric value retriever

	current_constant_value_retriever: EB_METRIC_CONSTANT_VALUE_RETRIEVER
			-- Current constant value retriever

	current_tester_item: TUPLE [value_retriever: EB_METRIC_VALUE_RETRIEVER; operator: INTEGER]
			-- Current value tester item

feature{NONE} -- Status report

	is_domain_item_type_valid (a_scope: STRING): BOOLEAN is
			-- Is `a_scope' a valid domain item type?
		require
			a_scope_attached: a_scope /= Void
		do
			Result := domain_item_type_table.has (a_scope)
		end

feature{NONE} -- Implementation


	remove_receiver_from_stack (a_stack: STACK [TUPLE [a_setter: PROCEDURE [ANY, TUPLE [ANY]]; is_called: BOOLEAN]];  a_error_message: STRING_GENERAL) is
			-- Test if last registered receiver from `a_stack' has receivered data
			-- If so, remove that receiver from `a_stack'. If not, fire an error `a_error_message'.
		require
			a_stack_attached: a_stack /= Void
			not_a_stack_is_empty: not a_stack.is_empty
			a_error_message_attached: a_error_message /= Void
		local
			l_item: TUPLE [a_setter: PROCEDURE [ANY, TUPLE [ANY]]; is_called: BOOLEAN]
		do
			l_item := a_stack.item
			if l_item.is_called then
				a_stack.remove
			else
				create_last_error (a_error_message)
			end
		end

	remove_domain_receiver_from_stack is
			-- Test if last registered domain receiver from `domain_receiver_stack' has receivered a
			-- domain. If so, remove that domain receiver. If not, file an error.
		do
			remove_receiver_from_stack (
				domain_receiver_stack,
				metric_names.err_domain_missing
			)
		end

	create_last_error (a_message: STRING_GENERAL) is
			-- Create `last_error' with `a_message'.
		local
			l_position: XM_POSITION
		do
			create last_error.make (a_message)
			last_error.set_location (location)
			if xml_parser /= Void then
				l_position := xml_parser.position
				last_error.set_xml_location ([l_position.column, l_position.row])
			end
		ensure
			has_error: has_error
		end

	extend_location_section (a_element_name: STRING_GENERAL) is
			-- Extend element `a_element_type' with possible element name `a_element_name' in `location_stack'.
		do
			location_stack.extend (metric_names.xml_location (element_stack.item, a_element_name))
		end

	remove_location_section is
			-- Remove top location section from `location_stack'.
		do
			location_stack.remove
		end

	set_current_tester_item (a_item: EB_METRIC_VALUE_RETRIEVER) is
			-- Set `a_item' into `current_tester_item'.
		require
			current_tester_item_attached: current_tester_item /= Void
		do
			current_tester_item.put (a_item, 1)
		end

feature{NONE} -- Process

	process_domain is
			-- Process "domain" definition list node.		
		local
			l_domain_receiver: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_DOMAIN]]; is_called: BOOLEAN]
		do
			if not has_error then
				extend_location_section (Void)
				check not domain_receiver_stack.is_empty end
				l_domain_receiver := domain_receiver_stack.item
				if l_domain_receiver.is_called then
					create_last_error (metric_names.err_too_many_domain)
				end
				create current_domain.make
			end
		end

	process_domain_finish is
			-- Process when a domain node has been parsed.				
		local
			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_DOMAIN]]; is_called: BOOLEAN]
		do
			check not domain_receiver_stack.is_empty end
			l_item := domain_receiver_stack.item
			check l_item.setter /= Void end
			l_item.setter.call ([current_domain])
			l_item.is_called := True
		end

	process_domain_item is
			-- Process "domain_item" definition list node.		
		local
			l_id: STRING
			l_type: STRING
			l_library_target_uuid: STRING
			l_domain_item: EB_METRIC_DOMAIN_ITEM
		do
			if not has_error then
				extend_location_section (Void)
				l_id := current_attributes.item (at_id)
				l_type := current_attributes.item (at_type)
				l_library_target_uuid := current_attributes.item (at_library_target_uuid)
				if l_id = Void then
					create_last_error (metric_names.err_domain_item_id_is_missing)
				end
				if not has_error then
					if l_type = Void then
						create_last_error (metric_names.err_domain_item_type_is_missing)
					else
						l_type.to_lower
						if not is_domain_item_type_valid (l_type) then
							create_last_error (metric_names.err_domain_item_type_invalid (l_type))
						else
							if l_library_target_uuid /= Void then
								if not shared_uuid.is_valid_uuid (l_library_target_uuid) then
									create_last_error (metric_names.err_library_target_uuid_invalid (l_library_target_uuid))
								end
							end
							if not has_error then
								l_domain_item := domain_item_type_table.item (l_type).item ([l_id])
								if l_library_target_uuid /= Void then
									l_domain_item.set_library_target_uuid (l_library_target_uuid)
								end
								current_domain.extend (l_domain_item)
								current_domain_item := l_domain_item
							end
						end
					end
				end
			end
		end

	process_tester is
			-- Process tester.
		local
			l_relation_str: STRING
			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_TESTER]]; is_called: BOOLEAN]
		do
			if not has_error then
				extend_location_section (Void)
				check not tester_receiver_stack.is_empty end
				l_item := tester_receiver_stack.item
				if l_item.is_called then
					create_last_error (metric_names.err_too_many_tester)
				else
					l_relation_str := current_attributes.item (at_relation)
					if l_relation_str = Void then
						create_last_error (metric_names.err_tester_relation_missing)
					else
						create current_tester.make
						if l_relation_str.is_case_insensitive_equal (query_language_names.ql_cri_and) then
							current_tester.enable_anded
						elseif l_relation_str.is_case_insensitive_equal (query_language_names.ql_cri_or) then
							current_tester.enable_ored
						else
							current_tester := Void
							create_last_error (metric_names.err_tester_relation_invalid (l_relation_str))
						end
					end
				end
			end
		end

	process_tester_item is
			-- Process tester item.
		require
			current_tester_attached: current_tester /= Void
		local
			l_operator_name: STRING
			l_operator_name_set: like operator_name_set
			l_operator_id: INTEGER
		do
			if not has_error then
				l_operator_name := current_attributes.item (at_name)
				if l_operator_name = Void then
					create_last_error (metric_names.err_operator_missing)
					extend_location_section (Void)
				else
					extend_location_section (l_operator_name)
					l_operator_name_set := operator_name_set
					if not l_operator_name_set.has (l_operator_name) then
						create_last_error (metric_names.err_operator_invalid (l_operator_name))
					else
						l_operator_id := operator_name_table.item (l_operator_name)
					end
					if not has_error then
						current_tester_item := [Void, l_operator_id]
						value_retriever_stack.extend ([agent set_current_tester_item, False])
					end
				end
			end
		end

	process_constant_value is
			-- Process "constant_value" node.
		local
			l_base_value: STRING
			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_RETRIEVER]]; is_called: BOOLEAN]
		do
			if not has_error then
				extend_location_section (Void)
				check not value_retriever_stack.is_empty end
				l_item := value_retriever_stack.item
				if l_item.is_called then
						-- We already processed a "constant_value" node or a "metric_value" node,
						-- only one should presents in a "tester_item" node, so report an error here.
					create_last_error (metric_names.err_too_many_value_retriever)
				else
					l_base_value := current_attributes.item (at_value)
					if l_base_value /= Void then
						test_non_void_double_attribute (
							l_base_value,
							agent metric_names.err_base_value_invalid
						)
					else
						create_last_error (metric_names.err_base_value_missing)
					end
					if not has_error then
						create current_constant_value_retriever.make (last_tested_double)
						current_value_retriever := current_constant_value_retriever
						current_tester_item.put (current_constant_value_retriever, 1)
					end
				end
			end
		end

	process_metric_value is
			-- Process "metric_value" node.
		local
			l_metric_name: STRING
			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_RETRIEVER]]; is_called: BOOLEAN]
			l_use_external: STRING
			l_boolean_set: BOOLEAN
		do
			if not has_error then
				extend_location_section (Void)
				check not value_retriever_stack.is_empty end
				l_item := value_retriever_stack.item
				if l_item.is_called then
						-- We already processed a "constant_value" node or a "metric_value" node,
						-- only one should presents in a "tester_item" node, so report an error here.
					create_last_error (metric_names.err_too_many_value_retriever)
				else
					l_metric_name := current_attributes.item (at_metric_name)
					if l_metric_name = Void then
						create_last_error (metric_names.err_metric_name_missing)
					end
					if not has_error then
						l_use_external := current_attributes.item (at_use_external_delayed)
						l_boolean_set := test_ommitable_boolean_attribute (
							l_use_external,
							agent metric_names.err_use_external_delayed_invalid (?, n_use_external_delayed)
						)
					end
					if not has_error then
						create current_metric_value_retriever
						current_metric_value_retriever.set_metric_name (l_metric_name)
						if l_boolean_set then
							current_metric_value_retriever.set_is_external_delayed_domain_used (last_tested_boolean)
						end
						current_value_retriever := current_metric_value_retriever
						current_tester_item.put (current_metric_value_retriever, 1)
						domain_receiver_stack.extend ([agent current_metric_value_retriever.set_input_domain, False])
					end
				end
			end
		end

	process_tester_finish is
			-- Process when a tester node has been parsed.
		local
			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_TESTER]]; is_called: BOOLEAN]
		do
			check not tester_receiver_stack.is_empty end
			l_item := tester_receiver_stack.item
			check l_item.setter /= Void end
			l_item.setter.call ([current_tester])
			l_item.is_called := True
		end

	process_value_retriever_finish is
			-- Process when a value retriever has been parsed.
		local
			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_RETRIEVER]]; is_called: BOOLEAN]
		do
			check not value_retriever_stack.is_empty end
			l_item := value_retriever_stack.item
			check l_item.setter /= Void end
			l_item.setter.call ([current_value_retriever])
			l_item.is_called := True
		end

feature -- Value validity testing

	test_ommitable_boolean_attribute (a_boolean_str: STRING; a_error_message_agent: FUNCTION [ANY, TUPLE [STRING_GENERAL], STRING_GENERAL]): BOOLEAN is
			-- Test if `a_boolean_str' represents a valid boolean value. If so, store the boolean value in `last_tested_boolean' and return True
			-- If `a_boolean_str' represents an invalid boolean value, fire an error with error message returned by `a_error_message' and return True.
			-- If `a_boolean_str' is Void, do not set `last_tested_boolean' and return False.			
		require
			a_error_message_agent_attached: a_error_message_agent /= Void
		do
			if a_boolean_str /= Void then
				test_non_void_boolean_attribute (a_boolean_str, a_error_message_agent.item ([a_boolean_str]))
				Result := True
			end
		end

	test_boolean_attribute (a_boolean_str: STRING; a_missing_error_message: STRING_GENERAL; a_invalid_error_message_agent: FUNCTION [ANY, TUPLE [STRING_GENERAL], STRING_GENERAL]) is
			-- Test if `a_boolean_str' represents a valid boolean value. If so, store the boolean value in `last_tested_boolean'.
			-- Otherwise if `a_boolean_str' is Void, fire an error with error message returned by `a_missing_error_message_agent',
			-- if `a_boolean_str' is non-Void but is not a valid boolean, fire an error with error message given by `a_invalid_error_message'.
		require
			a_missing_error_message_attached: a_missing_error_message /= Void
			a_error_message_agent_attached: a_invalid_error_message_agent /= Void
		do
			if a_boolean_str = Void then
				create_last_error (a_missing_error_message)
			else
				test_non_void_boolean_attribute (a_boolean_str, a_invalid_error_message_agent.item ([a_boolean_str]))
			end
		end

	test_non_void_boolean_attribute (a_boolean_str: STRING; a_error_message: STRING_GENERAL) is
			-- Test if `a_boolean_str' represents a valid boolean value. If so, store the boolean value in `last_tested_boolean'.
			-- Otherwise fire an error with error message given by `a_error_message'.
		require
			a_boolean_str_attached: a_boolean_str /= Void
			a_error_message_attached: a_error_message /= Void
		do
			if a_boolean_str.is_boolean then
				last_tested_boolean := a_boolean_str.to_boolean
			else
				create_last_error (a_error_message)
			end
		ensure
			last_tested_boolean_set: a_boolean_str.is_boolean implies last_tested_boolean = a_boolean_str.to_boolean
		end

	last_tested_boolean: BOOLEAN
			-- Last boolean value successfully tested by `test_non_void_boolean_attribute'

	test_non_void_double_attribute (a_double_str: STRING; a_error_message_agent: FUNCTION [ANY, TUPLE [STRING_GENERAL], STRING_GENERAL]) is
			-- Test if `a_double_str' represents a valid double value. If so, store the boolean value in `last_tested_double'.
			-- Otherwise fire an error with error message given by `a_error_message_agent'.
		require
			a_double_str_attached: a_double_str /= Void
			a_error_message_agent_attached: a_error_message_agent /= Void
		do
			if a_double_str.is_double then
				last_tested_double := a_double_str.to_double
			else
				create_last_error (a_error_message_agent.item ([a_double_str]))
			end
		ensure
			last_tested_double_set: a_double_str.is_double implies last_tested_double = a_double_str.to_double
		end

	last_tested_double: DOUBLE
			-- Last double value successfully tested by `test_non_void_double_attribute'

invariant
	factory_attached: factory /= Void
	location_stack_attached: location_stack /= Void
	element_stack_attached: element_stack /= Void
	tester_receiver_stack_attached: tester_receiver_stack /= Void
	value_retriever_stack_attached: value_retriever_stack /= Void

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


end
