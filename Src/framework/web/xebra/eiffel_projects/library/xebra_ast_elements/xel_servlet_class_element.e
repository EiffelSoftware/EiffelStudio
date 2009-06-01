note
	description: "[
		{XEL_SERVLET_CLASS_ELEMENT}.
	]"
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
			create make_feature.make ("make")
			add_feature (make_feature)
			create prerender_post_feature.make (Prerender_post_feature_name)
			add_feature (prerender_post_feature)
			create prerender_get_feature.make (Prerender_get_feature_name)
			add_feature (prerender_get_feature)
			create render_feature.make_with_const_class (Render_feature_name, a_const_class)
			add_feature (render_feature)
			create afterrender_feature.make (Afterrender_feature_name)
			add_feature (afterrender_feature)
		end

feature -- Access

	make_feature: XEL_FEATURE_ELEMENT


	render_feature: XEL_RENDER_FEATURE_ELEMENT


	prerender_post_feature: XEL_FEATURE_ELEMENT


	prerender_get_feature: XEL_FEATURE_ELEMENT


	afterrender_feature: XEL_FEATURE_ELEMENT


feature {NONE} -- Constants

	Render_feature_name: STRING = "handle_request (request: XH_REQUEST; response: XH_RESPONSE)"
	Prerender_post_feature_name: STRING = "prehandle_post_request (request: XH_REQUEST; response: XH_RESPONSE)"
	Prerender_get_feature_name: STRING = "prehandle_get_request (request: XH_REQUEST; response: XH_RESPONSE)"
	Afterrender_feature_name: STRING = "afterhandle_request (request: XH_REQUEST; response: XH_RESPONSE)"

feature -- Constants

	Constants_class_name: STRING = "SERVLET_CONSTANTS"


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
