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

feature -- Status report

	has_error: BOOLEAN
			-- Does parsing contain error?

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

feature -- Callbacks

	on_error (a_message: STRING) is
			-- Event producer detected an error.
		do
			set_parse_error_message (a_message, Void)
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
					set_parse_error_message (metric_names.err_invalid_tag_position (a_local_part), Void)
				else
					current_tag.extend (l_tag)
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
						set_parse_error_message (metric_names.err_invalid_attribute (a_local_part), Void)
					end
				end
			end
		end

feature{NONE} -- Implementation

	set_error (an_error: EB_METRIC_ERROR) is
			-- Set `an_error'.
		require
			an_error_ok: an_error /= Void
		do
			has_error := True
			last_error := an_error
		end

	set_parse_error_message (a_message: STRING_GENERAL; a_location: STRING_GENERAL) is
			-- We have a parse error with a message.
		require
			a_message_attached: a_message /= Void
		local
			l_error: EB_METRIC_ERROR
		do
			create l_error.make (a_message)
			l_error.set_location (a_location)
			has_error := True
			last_error := l_error
		end

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

--	all_transition_tag:

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

	check_uuid_validity (a_uuid_str: STRING_GENERAL; a_location: STRING_GENERAL) is
			-- Check validity of `a_uuid_str'.
			-- `a_location' is where `a_uuid_str' appears.
		require
			a_location_attached: a_location /= Void
		do
			last_valid_uuid := Void
			if a_uuid_str = Void then
				set_parse_error_message (metric_names.err_uuid_missing, a_location)
			else
				if not shared_uuid.is_valid_uuid (a_uuid_str.as_string_8) then
					set_parse_error_message (metric_names.err_uuid_invalid (a_uuid_str), a_location)
				else
					create last_valid_uuid.make_from_string (a_uuid_str.as_string_8)
				end
			end
		end

	last_valid_uuid: UUID
			-- Last valid UUID generated by `check_uuid_validity'.
			-- If no UUID has been checked or the last checked UUID is invalid,
			-- this will be Void

feature{NONE} -- Status report

	is_domain_item_type_valid (a_scope: STRING): BOOLEAN is
			-- Is `a_scope' a valid domain item type?
		require
			a_scope_attached: a_scope /= Void
		do
			Result := domain_item_type_table.has (a_scope)
		end

feature{NONE} -- Implementation

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

invariant
		factory_attached: factory /= Void

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
