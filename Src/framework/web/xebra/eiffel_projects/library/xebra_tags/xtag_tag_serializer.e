note
	description: "Summary description for {TAG_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XTAG_TAG_SERIALIZER

feature -- Initialization

	make_base
			-- Initialization of variables
			-- Call this constructor, if you inherit
		do
			create {ARRAYED_LIST [XTAG_TAG_SERIALIZER]} children.make (3)
			render := ""
			current_controller_id := ""
		end

feature {NONE} -- Access

	children: LIST [XTAG_TAG_SERIALIZER]
			-- All the children tags of the tag

	render: STRING
			-- String representation of boolean (either call or constant) for
			-- rendering

feature -- Access

	current_controller_id: STRING

	debug_information: STRING assign set_debug_information
			-- Row and column of original xeb file

	add_to_body (a_child: XTAG_TAG_SERIALIZER)
			-- Adds a TAG to the body.
		do
			children.extend (a_child)
		ensure
			child_has_been_added: children.count = old children.count + 1
		end

	put_attribute (id: STRING; a_attribute: STRING)
			-- Adds an attribute to the tag
		require
			id_is_not_empty: not id.is_empty
		do
			if id.is_equal ("render") then
				render := a_attribute
			else
				internal_put_attribute (id, a_attribute)
			end
		end

	internal_put_attribute (id: STRING; a_attribute: STRING)
			-- Adds an attribute to the tag
		deferred
		end

	set_debug_information (a_debug_information: STRING)
			-- Sets the debug information
		do
			debug_information := a_debug_information
		end

feature -- Implementation

	generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: TABLE [STRING, STRING]; controller_identifier: STRING)
			-- TODO
		do
			current_controller_id := controller_identifier
			append_debug_info (a_servlet_class.render_feature)
			append_debug_info (a_servlet_class.prerender_get_feature)
			append_debug_info (a_servlet_class.prerender_post_feature)
			append_debug_info (a_servlet_class.afterrender_feature)
			if not render.is_empty then
				a_servlet_class.render_feature.append_expression ("if " + render + " then")
				internal_generate (a_servlet_class, variable_table)
				a_servlet_class.render_feature.append_expression ("end")
			else
				internal_generate (a_servlet_class, variable_table)
			end
		end

	generate_children (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: TABLE [STRING, STRING])
			-- TODO
		do
			from
				children.start
			until
				children.after
			loop
				children.item.generate (a_servlet_class, variable_table, current_controller_id)
				children.forth
			end
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: TABLE [STRING, STRING])
			--
		deferred
		end

	write_string_to_result (a_text: STRING; a_feature: XEL_FEATURE_ELEMENT)
			--
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
			if must_be_escaped (l_text) then
				a_feature.append_expression (Response_variable_append + "(%"[%N" + l_text + "%N]%")")
			else
				a_feature.append_expression (Response_variable_append + "(%"" + l_text + "%")")
			end
		end

	must_be_escaped (a_text: STRING): BOOLEAN
			-- Checks, if there are characters which have to be escaped
		do
			Result := a_text.has_substring ("%"") or a_text.has_substring ("%%") or a_text.has_substring ("%N")
		end

	add_controller_call (feature_name: STRING; a_feature: XEL_FEATURE_ELEMENT)
			--
		do
			a_feature.append_expression (current_controller_id + "." + feature_name)
		end

	append_debug_info (a_feature: XEL_FEATURE_ELEMENT)
			-- Appends debug information to the feature
		do
			a_feature.append_comment (debug_information)
		end

feature {XTAG_TAG_SERIALIZER} -- Constants

		Response_variable: STRING = "response"
		Request_variable: STRING = "request"
		Response_variable_append: STRING = "response.append"
		Response_variable_append_newline: STRING = "response.append_newline"

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
