note
	description: "[
		This class provides basic functionality for all xebra tags.
		Its serialization is deferred and must me implemented from the
		Descendants.
		The 'render'-attribute is a hard-coded attribute. It expects
		a controller feature which returns a {BOOLEAN}. If it returns 
		True the children are rendered, otherwise it will skip that
		part.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XTAG_TAG_SERIALIZER

inherit
	XU_STRING_MANIPULATION

feature -- Initialization

	make_base
			-- Initialization of variables
			-- Call this constructor, if you inherit
		do
			create {ARRAYED_LIST [XTAG_TAG_SERIALIZER]} children.make (3)
			create render.make ("")
			current_controller_id := ""
			tag_id := ""
		ensure
			children_attached: attached children
			render_attached: attached render
			current_controller_id_attached: attached current_controller_id
			tag_id_attached: attached tag_id
		end

feature {XTAG_TAG_SERIALIZER} -- Access

	children: LIST [XTAG_TAG_SERIALIZER]
			-- All the children tags of the tag

	render: XTAG_TAG_ARGUMENT
			-- String representation of boolean (either call or constant) for
			-- rendering

feature -- Access

	tag_id: STRING assign set_tag_id
			-- The tag id

	set_tag_id (a_tag_id: STRING)
			-- Sets the tag id.
		do
			tag_id := a_tag_id
		end

	current_controller_id: STRING assign set_controller_id
			-- The uid of the controller which should be used by this tag

	debug_information: STRING assign set_debug_information
		-- Row and column of original xeb file

	add_to_body (a_child: XTAG_TAG_SERIALIZER)
			-- Adds a TAG to the body.
		require
			a_child_attached: attached a_child
		do
			children.extend (a_child)
		ensure
			child_has_been_added: children.count = old children.count + 1
		end

feature -- Status setting

	set_controller_id (a_id: STRING)
		require
			a_id_valid: attached a_id and not a_id.is_empty
		do
			current_controller_id := a_id
		ensure
			current_controller_id_set: current_controller_id = a_id
		end

	set_debug_information (a_debug_information: STRING)
			-- Sets the debug information
		require
			a_debug_information_valid: attached a_debug_information and not a_debug_information.is_empty
		do
			debug_information := a_debug_information
		ensure
			debug_info_set: debug_information = a_debug_information
		end

feature -- Basic implementation

	put_attribute (id: STRING; a_attribute: STRING)
			-- Adds an attribute to the tag
		require
			id_attached: attached id
			a_attribute_attached: attached a_attribute
			id_is_not_empty: not id.is_empty
		do
			if id.is_equal (Render_attribute_name) then
				create render.make (a_attribute)
			else
				internal_put_attribute (id, create {XTAG_TAG_ARGUMENT}.make (a_attribute))
			end
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- Adds an attribute to the tag
		require
			a_id_valid: attached a_id and not a_id.is_empty
		deferred
		end

	generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- Wrapps around the internal_generate feature to add debug information and handle the "render" option
		require
			a_servlet_class_attached: attached a_servlet_class
			a_variable_table_attached: attached a_variable_table
		do
				-- Generate debug information for a feature respectively
			if generates_make then
				append_debug_info (a_servlet_class.make_feature)
			end
			if generates_booleans then
				append_debug_info (a_servlet_class.set_all_booleans)
			end
			if generates_clean_up then
				append_debug_info (a_servlet_class.clean_up_after_render)
			end
			if generates_render then
				append_debug_info (a_servlet_class.render_html_page)
			end

				-- If the render option is set, overwrite definition of tag
			if not render.value (current_controller_id).is_empty then
				append_debug_info (a_servlet_class.make_feature)
				append_debug_info (a_servlet_class.set_all_booleans)
				append_debug_info (a_servlet_class.clean_up_after_render)
				append_debug_info (a_servlet_class.render_html_page)

				a_servlet_class.set_all_booleans.append_expression ("render_conditions [%""+"%"] := " + render.plain_value (current_controller_id))

				a_servlet_class.clean_up_after_render.append_expression ("if attached render_conditions [" + "%"%"" + "] and then render_conditions [" + "%"%"" + "] then")
				a_servlet_class.render_html_page.append_expression ("if attached render_conditions [" + "%"%"" + "] and then render_conditions [" + "%"%"" + "] then")
				internal_generate (a_servlet_class, a_variable_table)
				
				a_servlet_class.clean_up_after_render.append_expression ("end")
				a_servlet_class.render_html_page.append_expression ("end")
			else
				internal_generate (a_servlet_class, a_variable_table)
			end
		end

	generate_children (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- Generates all the children
		require
			a_servlet_class_attached: attached a_servlet_class
			a_variable_table_attached: attached a_variable_table
		do
			from
				children.start
			until
				children.after
			loop
				children.item.generate (a_servlet_class, a_variable_table)
				children.forth
			end
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			--
		require
			a_servlet_class_attached: attached a_servlet_class
			a_variable_table_attached: attached a_variable_table
			current_controller_id_set: attached current_controller_id and not current_controller_id.is_empty
		deferred
		ensure
			all_variables_removed: old a_variable_table.count = a_variable_table.count
		end

feature -- Debug configuration

	generates_wrap: BOOLEAN
			-- Does the tag write statements in the wrap_form_to_internal feature?
		do
			Result := False
		end

	generates_booleans: BOOLEAN
			-- Does the tag write statements in the set_all_booleans feature?
		do
			Result := False
		end

	generates_clean_up: BOOLEAN
			-- Does the tag write statements in the clean_up_after_render feature?
		do
			Result := False
		end

	generates_render: BOOLEAN
			-- Does the tag write statements in the render_html_page feature?
		do
			Result := False
		end

	generates_make: BOOLEAN
			-- Does the tag write statements in the constructor feature?
		do
			Result := False
		end

feature -- Utilities

	write_string_to_result (a_text: STRING; a_feature: XEL_RENDER_FEATURE_ELEMENT)
			-- Writes an append instruction
		require
			a_text_valid: attached a_text and not a_text.is_empty
			a_feature_attached: attached a_feature
		local
			l_text: STRING
		do
			l_text := a_text.twin
			if l_text.starts_with ("%N") then
				l_text := l_text.substring (2, a_text.count)
			end
			if l_text.ends_with ("%N") then
				l_text := l_text.substring (1, a_text.count-1)
			end
			if not l_text.is_empty then
				if l_text.is_equal ("%%N") then
					a_feature.append_output_text ("%%N")
				else
					a_feature.append_output_text (l_text)
				end

			end
		end

	write_string_to_result_uncashed (a_text: STRING; a_feature: XEL_RENDER_FEATURE_ELEMENT)
			-- Writes an append instruction
		require
			a_text_valid: attached a_text and not a_text.is_empty
			a_feature_attached: attached a_feature
		local
			l_text: STRING
		do
			l_text := a_text.twin
			if l_text.starts_with ("%N") then
				l_text := l_text.substring (2, a_text.count)
			end
			if l_text.ends_with ("%N") then
				l_text := l_text.substring (1, a_text.count-1)
			end
			if not l_text.is_empty then
				if l_text.is_equal ("%%N") then
					a_feature.append_output_text ("%%N")
				else
					a_feature.append_output_expression ("%"" + l_text + "%"")
				end

			end
		end

	add_controller_call (a_feature_name: STRING; a_feature: XEL_FEATURE_ELEMENT)
			-- Adds a call to the controller
		require
			a_feature_name_valid: attached a_feature_name and not a_feature_name.is_empty
			a_feature_attached: attached a_feature
		do
			a_feature.append_expression (current_controller_id + "." + a_feature_name)
		end

	append_debug_info (a_feature: XEL_FEATURE_ELEMENT)
			-- Appends debug information to the feature
		require
			a_feature_attached: attached a_feature
		do
			a_feature.append_comment (debug_information)
		end

	concatenate_with (a_separator: STRING; a_list: LIST [STRING]): STRING
			-- `a_list': List with elements to be concatenated
			-- Concatenates the elements of the list with a separator inbetween ("join")
		require
			a_separator: attached a_separator
			a_separator_not_empty: not a_separator.is_empty
			a_list_attached: attached a_list
			a_list_not_empty: not a_list.is_empty
		local
			l_separator: STRING
		do
			l_separator := " " + a_separator + " "
			from
				a_list.start
				Result := a_list.first
				a_list.forth
			until
				a_list.after
			loop
				Result := Result + l_separator + a_list.item
				a_list.forth
			end
		ensure
			result_attached: attached Result
		end

	get_validation_local (a_validation_table: HASH_TABLE [STRING , STRING]; a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_name: STRING): STRING
			-- `a_validation_table': Holds a mapping between xeb-file names and class locals
			-- `a_servlet_class': The enclosing class
			-- `a_name': The name from the xeb file
			-- Caches a local variable relying on `a_validation_table'
		require
			a_validation_table_attached: attached a_validation_table
			a_servlet_class_attached: attached a_servlet_class
			a_name_valid: attached a_name and not a_name.is_empty
		local
			l_local_name: STRING
		do
			if attached {STRING} a_validation_table [a_name] as var_name then
				Result := var_name
			else
				l_local_name := a_servlet_class.get_unique_identifier
				a_servlet_class.add_variable_by_name_type (l_local_name, "ARRAYED_LIST [STRING]")
				a_servlet_class.make_feature.append_expression ("create " + l_local_name + ".make (10)")
				a_validation_table [a_name] := l_local_name
				Result := l_local_name
			end
		ensure
			result_attached: attached Result
		end

feature {XTAG_TAG_SERIALIZER} -- Constants

		Response_variable: STRING = "response"
		Request_variable: STRING = "request"
		Response_variable_append: STRING = "response.append"
		Response_variable_append_newline: STRING = "response.append_newline"
		Render_attribute_name: STRING = "render"

invariant
	tag_id_attached: attached tag_id

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
