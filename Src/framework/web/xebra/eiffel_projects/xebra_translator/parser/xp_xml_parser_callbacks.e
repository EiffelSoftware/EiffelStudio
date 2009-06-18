note
	description: "[
		Generates a tree of XB_TAGs
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_XML_PARSER_CALLBACKS

inherit
	XM_CALLBACKS
	ERROR_SHARED_MULTI_ERROR_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_parser: XM_PARSER; a_path: FILE_NAME)
			-- {Create XB_XML_PARSER_CALLBACKS}.
		require
			a_parser_attached: attached a_parser
			a_path_attached: attached a_path
			a_path_is_valid: not a_path.is_empty
		do
			parser := a_parser
			path := a_path.twin
			create root_tag.make ("xeb", "container", "XTAG_XEB_CONTAINER_TAG", current_debug_information)
			create tag_stack.make (10)
			create state_html.make (Current)
			create state_tag.make (Current)
			create state_general.make (Current)
			state := state_general
			controller_class := ""
		ensure
			parser_attached: attached parser
			path_attached: attached path
			controller_class_attached: attached controller_class
			state_attached: attached state
			state_tag_attached: attached state_tag
			state_html_attached: attached state_html
			root_tag_attached: attached root_tag
			tag_stack_attached: attached tag_stack
			tag_stack_is_empty: tag_stack.is_empty
		end

feature -- Access

	parser: XM_PARSER
			-- The parser which uses Current

	path: FILE_NAME
			-- The path of the file to which is being read

	is_template: BOOLEAN assign set_is_template
			-- Defines if a xeb file is a template (i.e. has unimplemented regions)

	controller_class: STRING
			-- The class of the handling controller

	state: XP_CALLBACK_STATE
			-- The current state of the parser

	state_tag: XP_TAG_CALLBACK_STATE
			-- The instance for the state = tag

	state_html: XP_HTML_CALLBACK_STATE
			-- The instance for the state = html

	state_general: XP_GENERAL_CALLBACK_STATE
			-- The instance for the state= html and tags

	root_tag: XP_TAG_ELEMENT
			-- Represents the root of the XB_TAG tree

	tag_stack: ARRAYED_STACK [XP_TAG_ELEMENT]
			-- The stack is used to generate the tree

	registry: XP_SERVLET_GG_REGISTRY
			-- Registry

	put_registry (a_registry: XP_SERVLET_GG_REGISTRY)
			-- Adds a taglib to the parser
		require
			a_registry_attached: a_registry /= Void
		do
			registry := a_registry
			registry.put_tag_lib (Configuration_tag, generate_configuration_taglib)
		ensure
			registry_set: a_registry = registry
		end

	put_class_name (a_class_name: STRING)
			-- Puts the class name
		require
			a_class_name_attached: a_class_name /= Void
		do
			controller_class := a_class_name
		ensure
			controller_class_set: a_class_name = controller_class
		end

feature -- Status setting

	set_is_template (a_is_template: BOOLEAN)
			-- Sets whether Current is a temlate or not
		do
			is_template := a_is_template
		ensure
			is_template_set: is_template = a_is_template
		end

feature -- Document

	on_start
			-- Called when parsing starts.
		do
			tag_stack.wipe_out
			tag_stack.put (root_tag)
			state := state_general
		ensure then
			only_root_on_stack: tag_stack.count = 1
		end

	on_finish
			-- Called when parsing finished.
		do
			state.on_finish
			if tag_stack.count > 1 then
				error_manager.add_error (create {XERROR_PARSE}.make
				(["Unmatched tag in " + path + ": " + tag_stack.item.id]), False)
			elseif tag_stack.count < 1 then
				error_manager.add_error (create {XERROR_PARSE}.make
				(["Missing end tagin " + path ]), False)
			end
		end

	on_xml_declaration (a_version: STRING; an_encoding: STRING; a_standalone: BOOLEAN)
			-- XML declaration.		
		do
		end

feature -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			error_manager.add_error (create {XERROR_PARSE}.make
				([a_message + current_debug_information + "%N in '" + path + "'%N"]), false)
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- Processing instruction.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			error_manager.add_error (create {XERROR_PARSE}.make
				(["INSTRUCTIONS not yet implemented"]), False)
		end

	on_comment (a_content: STRING)
			-- Processing a comment.
			-- Atomic: single comment produces single event
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
		end

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- Start of start tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		local
			l_prefix: STRING
			l_local_part: STRING
			l_namespace: STRING
		do
			if attached a_prefix then
				l_prefix := a_prefix
			else
				l_prefix := ""
			end

			if attached a_local_part then
				l_local_part := a_local_part
			else
				l_local_part := ""
			end

		    if attached a_namespace then
				l_namespace := a_namespace
			else
				l_namespace := ""
			end

			state.on_start_tag (l_namespace, l_prefix, l_local_part)
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- Start of attribute.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		local
			l_namespace: STRING
			l_prefix: STRING
			l_local_part: STRING
			l_value: STRING
		do
			if attached a_namespace then
				l_namespace := a_namespace
			else
				l_namespace := ""
			end
			if attached a_prefix then
				l_prefix := a_prefix
			else
				l_prefix := ""
			end
			if attached a_local_part then
				l_local_part := a_local_part
			else
				l_local_part := ""
			end
			if attached a_value then
				l_value := a_value
			else
				l_value := ""
			end

			state.on_attribute (l_namespace, l_prefix, l_local_part, l_value)
		end

	on_start_tag_finish
			-- End of start tag.
		do
			state.on_start_tag_finish
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- End tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		local
			l_prefix: STRING
			l_local_part: STRING
			l_namespace: STRING
		do
			if attached a_prefix then
				l_prefix := a_prefix
			else
				l_prefix := ""
			end

			if attached a_local_part then
				l_local_part := a_local_part
			else
				l_local_part := ""
			end

			if attached a_namespace then
				l_namespace := a_namespace
			else
				l_namespace := ""
			end

			state.on_end_tag (l_namespace, l_prefix, l_local_part)
		end

feature -- Content

	on_content (a_content: STRING)
			-- Text content.
			-- NOT atomic: two on_content events may follow each other
			-- without a markup event in between.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			state.on_content (a_content)
		ensure then
			stack_does_not_change: tag_stack.count = old tag_stack.count
		end

feature {XP_CALLBACK_STATE} -- Implementation

	get_tag_lib (id: STRING): XTL_TAG_LIBRARY
			-- Returns tag library with the name `id'
		require
			id_is_valid: not id.is_empty
			tag_lib_available: registry.contains_tag_lib (id)
		do
			Result := registry.retrieve_taglib (id)
		ensure
			result_attached: attached Result
		end

	current_debug_information: STRING
			-- Queries the parser for row and column
		require
			parser_position_attached: attached parser.position
		do
			Result := "line: " + parser.position.row.out
					+ " column: " + parser.position.column.out + " path: " + path
		ensure
			result_attached: attached Result
			result_not_empty: not result.is_empty
		end

	set_state_html
			-- Sets the state to the html object
		do
			state := state_html
		ensure
			state_set: state = state_html
		end

	set_state_tag
			-- Sets the state to the tag object
		do
			state := state_tag
		ensure
			state_set: state = state_tag
		end

	generate_configuration_taglib: XTL_TAG_LIBRARY
			-- Generates the tablig with the page configurations
		do
			--create {XTL_PAGE_CONF_TAG_LIB} Result.make_with_arguments (Configuration_tag, Current)
		ensure
			result_attached: attached Result
		end

	fail
			-- Stops the parsing
		do
			state := create {XP_EMPTY_CALLBACK_STATE}.make (Current)
			tag_stack.wipe_out
			create root_tag.make_empty
		end

feature -- Constants

	Configuration_tag: STRING = "page"

invariant
		parser_attached: attached parser
		path_attached: attached path
		controller_class_attached: attached controller_class
		state_attached: attached state
		state_tag_attached: attached state_tag
		state_html_attached: attached state_html
		root_tag_attached: attached root_tag
		tag_stack_attached: attached tag_stack

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
