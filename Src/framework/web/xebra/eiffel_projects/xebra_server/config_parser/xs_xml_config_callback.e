note
	description: "Summary description for {XS_XML_CONFIG_CALLBACK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_XML_CONFIG_CALLBACK

inherit
	XM_CALLBACKS
	ERROR_SHARED_ERROR_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_parser: XM_PARSER; a_path: STRING)
			-- {Create XB_XML_PARSER_CALLBACKS}.
		require
			a_path_is_valid: not a_path.is_empty
		do
			parser := a_parser
			path := a_path
			create webapps.make (1)
			create state_webapp.make (current)
			create state_default.make (current)
		ensure

		end

feature -- Constants


feature -- Access

	parser: XM_PARSER
			-- The parser which uses Current

	path: STRING
			-- The path of the file to which is being read

	webapps: ARRAYED_STACK [XS_WEBAPP]


	state: XS_CALLBACK_STATE
			-- The current state of the parser

	state_webapp: XS_CALLBACK_STATE_WEBAPP
			-- The instance for the state = webapp

	state_default: XS_CALLBACK_STATE_DEFAULT
		-- The instance for the state = default	

	webapps_hash: HASH_TABLE [XS_WEBAPP, STRING]
			-- Converts the sack to a hashtable
			-- Removes the stack!!
		do
			create Result.make (1)
			from

			until
				webapps.is_empty
			loop
				Result.force (webapps.item, webapps.item.name)
				webapps.remove
			end
		end



feature -- Document

	on_start
			-- Called when parsing starts.
		do
			webapps.wipe_out
--			tag_stack.put (root_tag)
--			create {XP_HTML_CALLBACK_STATE} state.make (Current)
--		ensure then
--			only_root_on_stack: tag_stack.count = 1
		end

	on_finish
			-- Called when parsing finished.
		do
			state.on_finish
--		ensure then
--			only_root_on_stack: tag_stack.count = 1
		end

	on_xml_declaration (a_version: STRING; an_encoding: STRING; a_standalone: BOOLEAN)
			-- XML declaration.		
		do
		end

feature -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			error_manager.set_last_error (create {XERROR_PARSE}.make
				([a_message +  "%N in '" + path + "'%N"]), false)
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- Processing instruction.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			error_manager.set_last_error (create {XERROR_PARSE}.make
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
			l_class_name: STRING
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

			if l_local_part.is_equal (state_webapp.tag) then
				set_state_webapp
			else
				set_state_default
			end

			state.on_start_tag (a_namespace, l_prefix, l_local_part)
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

			state.on_end_tag (a_namespace, l_prefix, l_local_part)
		end

feature -- Content

	on_content (a_content: STRING)
			-- Text content.
			-- NOT atomic: two on_content events may follow each other
			-- without a markup event in between.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			state.on_content (a_content)
		end

feature  --

	set_state_webapp
			-- Sets the state to the webapp object
		do
			state := state_webapp
		ensure
			state_set: state = state_webapp
		end

	set_state_default
			-- Sets the state to  default
		do
			state := state_default
		ensure
			state_set: state = state_default
		end



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
