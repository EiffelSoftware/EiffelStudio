indexing
	description: "[
		A parser callbacks implementation for processing XML documents using a state-machine.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	XM_STATE_LOAD_CALLBACKS

inherit
	XM_CALLBACKS_NULL
		rename
			make as make_callbacks,
			on_error as on_report_xml_error
		export
			{NONE}
				on_attribute,
				on_comment,
				on_content,
				on_end_tag,
				on_finish,
				on_report_xml_error,
				on_processing_instruction,
				on_start,
				on_start_tag,
				on_start_tag_finish,
				on_xml_declaration
		redefine
			on_start,
			on_start_tag,
			on_start_tag_finish,
			on_attribute,
			on_content,
			on_end_tag,
			on_report_xml_error
		end

feature {NONE} -- Initialization

	make (a_parser: !like xml_parser)
			-- Initializes callbacks using an existing XML parser.
			-- Note: Initialization will set the parser's callbacks to Current.
			--
			-- `a_parser': An XML parser Current is used with.
		do
			create current_transition_stack.make_default
			create current_attributes_stack.make_default
			create current_content_stack.make_default

			a_parser.set_callbacks (Current)
			xml_parser := a_parser

			make_callbacks
		ensure
			xml_parser_set: xml_parser = a_parser
			xml_parser_callbacks_set: xml_parser.callbacks = Current
		end

feature -- Access

	xml_parser: !XM_EIFFEL_PARSER
			-- The XML parser used to in conjuntion with Current

	last_error_message: !STRING_32
			-- Last error message
		require
			has_error: has_error
		do
			if {l_msg: !like last_error_message} internal_last_error_message then
				Result := l_msg
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Access

	current_transition_stack: !DS_LINKED_STACK [NATURAL_8]
			-- Stack of transitional XML element tags

	current_attributes_stack: !DS_LINKED_STACK [!DS_HASH_TABLE [!STRING_32, NATURAL_8]]
			-- Current attributes

	current_content_stack: !DS_LINKED_STACK [!STRING_32]
			-- Current text content

	frozen current_state: NATURAL_8
			-- Current state
		require
			not_current_transition_stack_is_empty: not current_transition_stack.is_empty
		do
			Result := current_transition_stack.item
		end

	frozen current_attributes: !DS_HASH_TABLE [!STRING_32, NATURAL_8]
			-- Current attributes
		require
			not_current_attributes_stack_is_empty: not current_attributes_stack.is_empty
		do
			Result := current_attributes_stack.item
		end

	frozen current_content: !STRING_32
			-- Current content
		require
			not_current_content_stack_is_empty: not current_content_stack.is_empty
		do
			if not is_perserving_whitespace then
				Result := prune_whitespace (current_content_stack.item)
			else
				Result := current_content_stack.item.twin.as_attached
			end
		end

feature -- Status report

	has_error: BOOLEAN
			-- Indicates if Current has an error
		do
			Result := internal_last_error_message /= Void
		end

feature {NONE} -- Status report

	is_strict: BOOLEAN
			-- Is call back strict about checking well formed XML?
			-- If not, empty attributes, duplicates attribute, etc. fall through.
		deferred
		end

	is_perserving_whitespace: BOOLEAN assign set_is_perserving_whitespace
			-- Indicates if leading/trailing whitespace should be preserved for content text.
			-- Note: This is currently only applicable when using `current_content'

feature -- Status setting

	set_is_perserving_whitespace (a_preserve: like is_perserving_whitespace)
			-- Sets evalation of text content whitespace preservation.
			-- See `is_perserving_whitespace' for more information.
			--
			-- `a_preserve': True to retain the whitespace; False otherwise.
		do
			is_perserving_whitespace := a_preserve
		ensure
			is_perserving_whitespace_set: is_perserving_whitespace = a_preserve
		end

feature {NONE} -- Basic operations

	reset
			-- Resets internal state, ready for the next parse
		do
			current_transition_stack.wipe_out
			current_attributes_stack.wipe_out
			current_content_stack.wipe_out

				-- Required for the xml declaration processing instruction
			current_attributes_stack.put (create {DS_HASH_TABLE [!STRING_32, NATURAL_8]}.make_default)

			internal_last_error_message := Void
		ensure
			current_transition_stack_is_empty: current_transition_stack.is_empty
			current_attributes_stack_is_empty: current_attributes_stack.count = 1
			current_content_stack_is_empty: current_content_stack.is_empty
			not_has_error: not has_error
			internal_last_error_message_detached: internal_last_error_message = Void
		end

feature {NONE} -- Process

	process_tag_state (a_state: NATURAL_8)
			-- Called to process a tag's state.
			--| Note: At this point the state transition stack (`current_transistion_stack') contains the current state.
			--|       The attribute table (`current_attributes') will also have been populated.
			--
			-- `a_state': A state id matching a tag state described in `tag_state_transitions'
		require
			current_state_ensured: current_state = a_state
		deferred
		ensure
			current_state_unchanged: current_state = old current_state
		end

	process_end_tag_state (a_state: NATURAL_8)
			-- Called to process a tag's end state.
			--| Note: At this point the state transition stack (`current_transistion_stack') contains the current state.
			--|       The attribute table (`current_attributes') will also have been populated.
			--
			-- `a_state': A state id matching a tag state described in `tag_state_transitions'
		require
			current_state_ensured: current_state = a_state
		deferred
		ensure
			current_state_unchanged: current_state = old current_state
		end

feature {NONE} -- Query

	is_named (a_element_name: STRING; a_name: STRING): BOOLEAN
			-- Determines if an element has a specific name.
			--
			-- `a_element': The XML element to check the name of.
			-- `a_name': The expected tag name of the specified element.
			-- `Result': True if the element has the expected name, False otherwise.
		require
			a_element_name_attached: a_element_name /= Void
			not_a_element_name_is_empty: not a_element_name.is_empty
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			Result := a_element_name.is_case_insensitive_equal (a_name)
		end

	is_xml_attribute (a_name: STRING): BOOLEAN
			-- Determines if a XML element attribute name is a well known XML attribute name.
			--
			-- `a_name': The attribute name.
			-- `Result': True if the attribute name is a well known name; False otherwise.
		do
			Result := a_name.is_case_insensitive_equal (xmlns_tag) or else
					a_name.is_case_insensitive_equal (xsi_tag) or else
					a_name.is_case_insensitive_equal (schema_location_tag)
		end

feature -- Actions

	frozen error_reported_actions: !ACTION_SEQUENCE [TUPLE [msg: !STRING_32; line: NATURAL; index: NATURAL]]
			-- Actions used to recieve notification of an error
			--
			-- 'msg': Message and cause of the error.
			-- 'line': Offending one-based line index of the error.
			-- 'index': Offending one-base character index, on the line, of the error.
			--          Will be zero if the line is empty.
		do
			if {l_actions: like error_reported_actions} internal_error_reported_actions then
				Result := l_actions
			else
				create Result
				internal_error_reported_actions := Result
			end
		ensure
			result_consistent: Result = error_reported_actions
		end

	frozen warning_reported_actions: !ACTION_SEQUENCE [TUPLE [msg: !STRING_32; line: NATURAL; index: NATURAL]]
			-- Actions used to recieve notification of an warning
			--
			-- 'msg': Message and cause of the warning.
			-- 'line': Offending one-based line index of the warning.
			-- 'index': Offending one-base character index, on the line, of the warning.
			--          Will be zero if the line is empty.		
		do
			if {l_actions: like warning_reported_actions} internal_warning_reported_actions then
				Result := l_actions
			else
				create Result
				internal_warning_reported_actions := Result
			end
		ensure
			result_consistent: Result = warning_reported_actions
		end

feature {NONE} -- Action handlers

	on_start
			-- <Precursor>
		do
			reset
		end

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>
		local
			l_name: STRING
			l_tag_transitions: like tag_state_transitions
			l_transitions: DS_HASH_TABLE [NATURAL_8, STRING]
			l_current_transition_stack: like current_transition_stack
			l_next_state: NATURAL_8
		do
			if not has_error then
					-- Extend the attribute stack
				current_attributes_stack.put (create {DS_HASH_TABLE [!STRING_32, NATURAL_8]}.make_default)

					-- Set new state
				l_next_state := t_none

				l_name := a_local_part.as_lower

	--				-- check version
	--			check_version (a_namespace)

					-- Check if it is a valid tag state transition
				l_tag_transitions := tag_state_transitions
				l_current_transition_stack := current_transition_stack
				if l_current_transition_stack.is_empty then
						-- Fetches the inital transition from a start point.
					l_transitions := l_tag_transitions.item (t_none)
				else
						-- Retrieve the next valid state transitions.
					l_transitions := l_tag_transitions.item (l_current_transition_stack.item)
				end

				if l_transitions /= Void and then l_transitions.has (l_name) then
						-- Valid state
					l_next_state := l_transitions.item (l_name)
				end

				if l_next_state = t_none then
						-- Parse error
					on_report_xml_error ("Unexpected tag '" + a_local_part + "'!")
				else
						-- Set next transition.
					l_current_transition_stack.force (l_next_state)
				end
			end
		end

	on_start_tag_finish
			-- <Precursor>
		do
			if not has_error then
				check not_current_transition_stack_is_empty: not current_transition_stack.is_empty end
				process_tag_state (current_transition_stack.item)

				current_content_stack.force (create {!STRING_32}.make_empty)
			end
		ensure then
			current_transition_stack_stack_unchanged: current_transition_stack.count = old current_transition_stack.count
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>
		local
			l_name: STRING
			l_cur_attributes: like current_attributes
			l_attribute_states: like attribute_states
			l_attributes: ?DS_HASH_TABLE [NATURAL_8, STRING]
			l_tag_state: NATURAL_8
			l_state: NATURAL_8
		do
			if not has_error then
				check not_current_transition_stack_is_empty: not current_transition_stack.is_empty end

					-- Only process if there is no error
				if not is_xml_attribute (a_local_part) then
					l_name := a_local_part.as_lower

						-- Check if the attribute is valid for the current state
					l_tag_state := current_transition_stack.item
					l_attribute_states := attribute_states
					if l_attribute_states.has (l_tag_state) then
						l_attributes := l_attribute_states.item (l_tag_state)
						if l_attributes /= Void and then l_attributes.has (l_name) then
							l_state := l_attributes.item (l_name)
						end
					end

					if l_state /= 0 then
						l_cur_attributes := current_attributes
						if l_cur_attributes.has (l_state) and is_strict then
								-- Duplication error
							on_report_xml_error ("Attribute '" + a_local_part + "' appears more than once!")
						else
							if not a_value.is_empty then
									-- Add value to the attributes table.
								l_cur_attributes.force (unescape_text (a_value), l_state)
							else
								if is_strict then
										-- Empty value error
									on_report_xml_error ("Attribute '" + a_local_part + "' is empty!")
								elseif l_cur_attributes.has (l_state) then
										-- Remove empty attribute value (non-strict operation) because the last occurance is empty.
									l_cur_attributes.remove (l_state)
										-- Empty value warning
									on_report_xml_warning ("Attribute '" + a_local_part + "' is empty.")
								end
							end
						end
					elseif is_strict then
							-- Unreconginized attribute error
						on_report_xml_error ("Unexpected attribute '" + a_local_part + "'!")
					end
				end
			end
		end

	on_content (a_content: STRING) is
			-- <Precursor>
		do
			if not has_error then
				check not_current_content_stack_is_empty: not current_content_stack.is_empty end

				if a_content /= Void and then {l_content: !STRING_32} a_content.as_string_32 then
					current_content_stack.item.append (l_content)
				end
			end
		end

	on_end_tag (a_namespace, a_prefix, a_local_part: STRING)
			-- <Precursor>
		local
			l_name: STRING
			l_tag_transitions: like tag_state_transitions
			l_transitions: DS_HASH_TABLE [NATURAL_8, STRING]
			l_current_transition_stack: like current_transition_stack
			l_current_state: like current_state
			l_next_state: NATURAL_8
		do
			if not has_error then
					-- Set new state
				l_next_state := t_none

				l_name := a_local_part.as_lower

					-- Check if it is a valid tag state transition
				l_tag_transitions := tag_state_transitions
				l_current_transition_stack := current_transition_stack
				check not_l_current_transition_stack_is_empty: not l_current_transition_stack.is_empty end

					-- Retrieve the next valid state transitions.
				l_current_transition_stack.remove
				if not l_current_transition_stack.is_empty then
					l_current_state := current_state
				else
					l_current_state := t_none
				end
				if l_tag_transitions.has (l_current_state) then
					l_transitions := l_tag_transitions.item (l_current_state)
					if l_transitions /= Void and then l_transitions.has (l_name) then
						l_next_state := l_transitions.item (l_name)
						if l_next_state /= t_none then
							l_current_transition_stack.force (l_next_state)
							process_end_tag_state (l_next_state)
							l_current_transition_stack.remove
						end
					end
				end

					-- Remove content
				current_attributes_stack.remove
				current_content_stack.remove
			end
		end

	on_report_xml_error (a_message: STRING)
			-- Reports an XML error.
			--
			-- `a_message': The XML error to report.
		do
			if a_message /= Void and then {l_message: !STRING_32} a_message.as_string_32 then
				internal_last_error_message := l_message
				on_error (l_message, xml_parser.line.to_natural_32, xml_parser.column.to_natural_32)
			else
				internal_last_error_message := "Unknown error!"
			end
		end

	on_report_xml_warning (a_message: STRING)
			-- Reports an XML warning.
			--
			-- `a_message': The XML warning to report.
		do
			if a_message /= Void and then {l_message: !STRING_32} a_message.as_string_32 then
				on_warning (l_message, xml_parser.line.to_natural_32, xml_parser.column.to_natural_32)
			end
		end

feature {NONE} -- Reporting

	on_error (a_msg: !STRING_32; a_line: NATURAL; a_index: NATURAL)
			-- Reports an error.
			--
			-- `a_msg': Message and cause of the error.
			-- `a_line': Offending one-based line index of the error.
			-- `a_index': Offending one-base character index, on the line, of the error.
			--            Will be zero if the line is empty.
		require
			not_a_msg_is_empty: not a_msg.is_empty
			a_line_positive: a_line >= 1
			a_index_non_negative: a_index >= 0
		do
			if internal_error_reported_actions /= Void then
				internal_error_reported_actions.call ([a_msg, a_line, a_index])
			end
			if is_strict then
				xml_parser.abort
			end
		ensure
			has_error: has_error
		end

	on_warning (a_msg: !STRING_32; a_line: NATURAL; a_index: NATURAL)
			-- Reports a warning.
			--
			-- `a_msg': Message and cause of the warning.
			-- `a_line': Offending one-based line index of the warning.
			-- `a_index': Offending one-base character index, on the line, of the error.
			--            Will be zero if the line is empty.
		require
			not_a_msg_is_empty: not a_msg.is_empty
			a_line_positive: a_line >= 1
			a_index_non_negative: a_index >= 0
		do
			if internal_warning_reported_actions /= Void then
				internal_warning_reported_actions.call ([a_msg, a_line, a_index])
			end
		end

feature {NONE} -- Conversion

	boolean_attribute (a_name: STRING; a_token: NATURAL_8; a_default: BOOLEAN): BOOLEAN
			-- Converts an attribute value to a Boolean.
			--
			-- `a_name': The name of the attribute or element.
			-- `a_token': The attribute token.
			-- `a_default': A default value, in the case the supplied value cannot be converted.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_attributes: !like current_attributes
			l_value: like prune_whitespace
		do
			Result := a_default

			l_attributes := current_attributes
			if l_attributes.has (a_token) then
				l_value := l_attributes.item (a_token)
				if l_value /= Void then
					l_value.left_adjust
					l_value.right_adjust
					if l_value.is_boolean then
						Result := l_value.to_boolean
					elseif v_bool_one.is_equal (l_value) or else v_bool_yes.is_case_insensitive_equal (l_value) then
						Result := True
					elseif v_bool_zero.is_equal (l_value) or else v_bool_no.is_case_insensitive_equal (l_value) then
						Result := False
					else
							-- Invalid Boolean value.
						on_report_xml_error ("Invalid Boolean value '" + l_value + "' for entity '" + a_name + "!")
					end
				end
			end
		end

	integer_attribute (a_name: STRING; a_token: NATURAL_8; a_default: INTEGER_32): INTEGER_32
			-- Converts an attribute value to a Boolean.
			--
			-- `a_name': The name of the attribute or element.
			-- `a_token': The attribute token.
			-- `a_default': A default value, in the case the supplied value cannot be converted.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_attributes: !like current_attributes
			l_value: like prune_whitespace
		do
			Result := a_default

			l_attributes := current_attributes
			if l_attributes.has (a_token) then
				l_value := l_attributes.item (a_token)
				if l_value /= Void then
					l_value.left_adjust
					l_value.right_adjust
					if l_value.is_integer_32 then
						Result := l_value.to_integer_32
					else
							-- Invalid Integer value.
						on_report_xml_error ("Invalid Integer value '" + l_value + "' for entity '" + a_name + "!")
					end
				end
			end
		end

	to_boolean (a_name: STRING; a_value: !STRING_32; a_default: BOOLEAN): BOOLEAN
			-- Converts a value to a Boolean.
			--
			-- `a_name': The name of the attribute or element.
			-- `a_value': Value to convert to a Boolean.
			-- `a_default': A default value, in the case the supplied value cannot be converted.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			not_a_value_is_empty: not a_value.is_empty
		local
			l_value: like prune_whitespace
		do
			l_value := prune_whitespace (a_value)
			if l_value.is_boolean then
				Result := l_value.to_boolean
			elseif v_bool_one.is_equal (l_value) or else v_bool_yes.is_case_insensitive_equal (l_value) then
				Result := True
			elseif v_bool_zero.is_equal (l_value) or else v_bool_no.is_case_insensitive_equal (l_value) then
				Result := False
			else
				Result := a_default

					-- Invalid Boolean value.
				on_report_xml_error ("Invalid Boolean value '" + a_value + "' for entity '" + a_name + "!")
			end
		end

	to_integer (a_name: STRING; a_value: !STRING_32; a_default: INTEGER_32): INTEGER_32
			-- Converts a value to a Integer.
			--
			-- `a_name': The name of the attribute or element.
			-- `a_value': Value to convert to a Integer.
			-- `a_default': A default value, in the case the supplied value cannot be converted.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			not_a_value_is_empty: not a_value.is_empty
		local
			l_value: like prune_whitespace
		do
			l_value := prune_whitespace (a_value)
			if l_value.is_integer_32 then
				Result := l_value.to_integer_32
			else
				Result := a_default

					-- Invalid Boolean value.
				on_report_xml_error ("Invalid Integer value '" + a_value + "' for entity '" + a_name + "!")
			end
		end

feature {NONE} -- Formatting

	unescape_text (a_text: ?STRING): !STRING_32
			-- Unescapes XML text.
			--
			-- `a_text':
			-- `Result':
		require
			a_text_attached: a_text /= Void
		local
			l_mapping: DS_HASH_TABLE_CURSOR [!STRING_32, !STRING_32]
		do
			create Result.make_from_string (a_text)
			l_mapping := escaped_character_mapping.new_cursor
			from l_mapping.start until l_mapping.after loop
				Result.replace_substring_all (l_mapping.key, l_mapping.item)
				l_mapping.forth
			end
		ensure
			not_result_is_empty: not old a_text.is_empty implies not Result.is_empty
		end

	prune_whitespace (a_value: !STRING_32): !STRING_32
			-- Prunes all leading a trailing whitespace from `a_value' and returns the result.
			--
			-- `a_value': THe source value to remove leading and trailing whitespace from.
		local
			l_count, i: INTEGER
		do
			Result := a_value.twin

				-- Find leading non-whitespace.
			from
				i := 1
				l_count := Result.count
			until
				i > l_count or else not Result.item (i).is_space
			loop
				i := i + 1
			end

			if i > 1 then
					-- Remove leading whitespace
				if i < l_count then
					Result.keep_tail (Result.count - (i - 1))
				else
						-- Content is all whitespace
					Result.wipe_out
				end
			end

				-- Find trailing non-whitespace
			from
				l_count := Result.count
				i := l_count
			until
				i = 0 or else not Result.item (i).is_space
			loop
				i := i - 1
			end

			if i > 0 then
					-- Remove trailing whitespace
				check i_positive: i > 0 end
				Result.keep_head (i)
			end
		end

	frozen escaped_character_mapping: !DS_HASH_TABLE [!STRING_32, !STRING_32]
			-- Character mappings, given a escape string.
		once
			create Result.make (5)
			Result.put (("%"").as_string_32.as_attached, ("&quote;").as_string_32.as_attached)
			Result.put (("%'").as_string_32.as_attached, ("&apos;").as_string_32.as_attached)
			Result.put (("&").as_string_32.as_attached, ("&amp;").as_string_32.as_attached)
			Result.put (("<").as_string_32.as_attached, ("&lt;").as_string_32.as_attached)
			Result.put ((">").as_string_32.as_attached, ("&gt;").as_string_32.as_attached)
		end

feature {NONE} -- State transistions

	tag_state_transitions: !DS_HASH_TABLE [!DS_HASH_TABLE [NATURAL_8, STRING], NATURAL_8]
			-- Mapping of possible tag state transitions from `current_tag' with the tag name to the new state.
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	attribute_states: !DS_HASH_TABLE [!DS_HASH_TABLE [NATURAL_8, STRING], NATURAL_8]
			-- Mapping of possible attributes of tags.
		deferred
		end

feature {NONE} -- Internal implementation cache

	internal_last_error_message: STRING_32
			-- Cached version of `last_error_message'
			-- Note: Do not use directly!

	internal_error_reported_actions: ACTION_SEQUENCE [TUPLE [msg: !STRING_32; line: NATURAL; index: NATURAL]]
			-- Cached version of `error_reported_actions'
			-- Note: Do not use directly!

	internal_warning_reported_actions: ACTION_SEQUENCE [TUPLE [msg: !STRING_32; line: NATURAL; index: NATURAL]]
			-- Cached version of `warning_reported_actions'
			-- Note: Do not use directly!

feature {NONE} -- Tag states

	t_none: NATURAL_8          = 0x00

feature {NONE} -- Attribute names

	xmlns_tag: STRING = "xmlns"
	xsi_tag: STRING = "xsi"
	schema_location_tag: STRING = "schemalocation"

feature {NONE} -- Attribute values

	v_bool_one: STRING = "1"
	v_bool_yes: STRING = "yes"

	v_bool_zero: STRING = "0"
	v_bool_no: STRING = "no"

invariant
	xml_parser_callbacks_is_current: xml_parser.callbacks = Current

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
