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
		end

feature {NONE} -- Access

	children: LIST [XTAG_TAG_SERIALIZER]
			-- All the children tags of the tag

	render: STRING
			-- String representation of boolean (either call or constant) for
			-- rendering

feature -- Access

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

	generate_children (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature: XEL_FEATURE_ELEMENT; variable_table: TABLE [STRING, STRING])
		do
			from
				children.start
			until
				children.after
			loop
				children.item.generate (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature, variable_table)
				children.forth
			end
		end

	generate (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature: XEL_FEATURE_ELEMENT; variable_table: TABLE [STRING, STRING])
			-- `a_prerender_get_feature': This feature is executed before the render feature in case of a get request
			-- `a_prerender_post_feature': Like `a_prerender_get_feature' but on a post request
			-- `a_render_feature': This feature is executed after a_prerender_post/get_feature and renders the page
			-- `a_afterrender_feature': This feature is executed in the end, after rendering the page
		do
			if not render.is_empty then
				a_render_feature.append_expression ("if " + render + " then")
				internal_generate (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature, variable_table)
				a_render_feature.append_expression ("end")
			else
				internal_generate (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature, variable_table)
			end
		end

	internal_generate (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature: XEL_FEATURE_ELEMENT; variable_table: TABLE [STRING, STRING])
			--
		deferred
		end

	write_string_to_result (a_text: STRING; a_feature: XEL_FEATURE_ELEMENT)
			--
		do
			a_feature.append_expression (Response_variable + ".append(%"[%N" + a_text + "%N]%")")
		end

	add_controller_call (feature_name: STRING; a_feature: XEL_FEATURE_ELEMENT)
			--
		do
			a_feature.append_expression (Controller_variable + "." + feature_name)
		end

	append_debug_info (a_feature: XEL_FEATURE_ELEMENT)
			-- Appends debug information to the feature
		do
			a_feature.append_comment (debug_information)
		end

feature {XTAG_TAG_SERIALIZER} -- Constants

		Response_variable: STRING = "response"
		Request_variable: STRING = "request"
		Controller_variable: STRING = "controller"
		Response_variable_append: STRING = "response.append"

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
