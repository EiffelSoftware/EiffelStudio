note
	description: "[
		{XEL_SERVLET_CLASS_ELEMENT}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_SERVLET_CLASS_ELEMENT

inherit
	XEL_CLASS_ELEMENT

create
	make_with_constants

feature -- Initialization

	make_with_constants (a_name: STRING; a_const_class: XEL_CONSTANTS_CLASS_ELEMENT)
			--
		do
			make (a_name)
			create make_feature.make (make_signature)
			create set_all_booleans.make (set_all_booleans_signature)
			create handle_form_internal.make (handle_form_internal_signature)
			create render_html_page.make_with_const_class (render_html_page_signature, a_const_class)
			create clean_up_after_render.make (clean_up_after_render_signature)
			create fill_bean.make (fill_bean_signature)
			
			add_feature (make_feature)
			add_feature (set_all_booleans)
			add_feature (handle_form_internal)
			add_feature (render_html_page)
			add_feature (clean_up_after_render)
			add_feature (fill_bean)
				--Ensure that the result is always True if nothing else checked!
			fill_bean.append_expression_to_start ("Result := True")
		end

feature -- Access

	make_feature: XEL_DEBUG_FEATURE_ELEMENT
			-- The constructor feature

	set_all_booleans: XEL_DEBUG_FEATURE_ELEMENT
			-- The feature where all the variables are set

	clean_up_after_render: XEL_DEBUG_FEATURE_ELEMENT
			-- The feature which is executed after everything has been rendered

	render_html_page: XEL_RENDER_FEATURE_ELEMENT
			-- The feature in where the page is rendered

	handle_form_internal: XEL_DEBUG_FEATURE_ELEMENT
			-- The feature where the form is handled

	fill_bean: XEL_DEBUG_FEATURE_ELEMENT
			-- The feature is validated and wrapped

	set_debug_information (a_debug_info: STRING)
			-- Sets the debug information
		require
			a_debug_info_attached: attached a_debug_info
		do
			from
				features.start
			until
				features.after
			loop
				if attached {XEL_DEBUG_FEATURE_ELEMENT} features.item as l_feature then
					l_feature.set_debug_information (a_debug_info)
				end
				features.forth
			end
		end

feature {NONE} -- Constants

	make_signature: STRING = "make"
	set_all_booleans_signature: STRING = "set_all_booleans (request: XH_REQUEST; response: XH_RESPONSE)"
	clean_up_after_render_signature: STRING = "clean_up_after_render (request: XH_REQUEST; response: XH_RESPONSE)"
	render_html_page_signature: STRING = "render_html_page (request: XH_REQUEST; response: XH_RESPONSE)"
	handle_form_bean_signature: STRING = "handle_form_bean (a_request: XH_REQUEST; a_response: XH_RESPONSE; a_real_bean: ANY)"
	handle_form_internal_signature: STRING = "handle_form_internal (a_request: XH_REQUEST; a_response: XH_RESPONSE)"
	fill_bean_signature: STRING = "fill_bean (a_request: XH_REQUEST): BOOLEAN"

feature -- Constants

	Constants_class_name: STRING = "G_SERVLET_CONSTANTS"


feature -- If you delete this line you'll get a syntax error

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
