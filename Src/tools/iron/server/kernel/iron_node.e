note
	description: "[
				This represents an iron node (i.e server)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE

inherit
	IRON_NODE_FORWARD_OBSERVER

create
	make

feature {NONE} -- Initialization

	make (db: like database; a_layout: IRON_NODE_LAYOUT)
		do
			database := db
			layout := a_layout
		end

feature -- Access

	is_available: BOOLEAN
		do
			Result := database.is_available
		end

	database: IRON_NODE_DATABASE

	layout: IRON_NODE_LAYOUT

feature -- Query

	versions: detachable ITERABLE [IRON_NODE_VERSION]
		do
			Result := database.versions
		end

	packages (a_lower, a_upper: INTEGER_32): detachable LIST [IRON_NODE_PACKAGE]
		do
			Result := database.packages (a_lower, a_upper)
		end

	version_packages (v: IRON_NODE_VERSION; a_lower, a_upper: INTEGER_32): detachable LIST [IRON_NODE_VERSION_PACKAGE]
		do
			Result := database.version_packages (v, a_lower, a_upper)
		end

feature -- Status report

	is_documentation_available: BOOLEAN
			-- Is static documentation available?
		local
			f: FILE_UTILITIES
		do
			Result := f.directory_path_exists (layout.documentation_path)
		end

feature -- Visitor

	accept (vis: IRON_NODE_VISITOR)
		do
			vis.visit_node (Current)
		end

feature -- Access: api url

	api_base_url: STRING = "/access"

	api_resource (p: READABLE_STRING_8): READABLE_STRING_8
		do
			Result := api_base_url + p
		end

	resource (v: detachable IRON_NODE_VERSION; p: READABLE_STRING_8): READABLE_STRING_8
		do
			if v /= Void then
				Result := api_base_url + "/" + v.value + p
			else
				Result := api_base_url + p
			end
		end

	package_view_resource (p: IRON_NODE_PACKAGE): READABLE_STRING_8
		do
			Result := resource (Void, "/package/" + url_encoder.general_encoded_string (p.id))
		end

	package_version_view_resource (p: IRON_NODE_VERSION_PACKAGE): READABLE_STRING_8
		do
			Result := resource (p.version, "/package/" + url_encoder.general_encoded_string (p.id))
		end

	package_version_archive_resource (p: IRON_NODE_VERSION_PACKAGE): READABLE_STRING_8
		do
			Result := resource (p.version, "/package/" + url_encoder.general_encoded_string (p.id) + "/archive")
		end

	package_version_update_resource (p: IRON_NODE_VERSION_PACKAGE): READABLE_STRING_8
		do
			Result := resource (p.version, "/package/" + url_encoder.general_encoded_string (p.id))
		end

	package_version_create_resource (v: IRON_NODE_VERSION): READABLE_STRING_8
		do
			Result := resource (v, "/package/") -- POST
		end

feature -- Access: cms url

	cms_base_url: STRING = "/repository"

	cms_page (p: READABLE_STRING_8): READABLE_STRING_8
		do
			Result := cms_base_url + p
		end

	html_page (v: detachable IRON_NODE_VERSION; s: READABLE_STRING_8): READABLE_STRING_8
		do
			if v /= Void then
				Result := cms_base_url + "/" + v.value + "/html/" + s
			else
				Result := cms_base_url + "/html/" + s
			end
		end

	page (v: detachable IRON_NODE_VERSION; p: READABLE_STRING_8): READABLE_STRING_8
		do
			if v /= Void then
				Result := cms_base_url + "/" + v.value + p
			else
				Result := cms_base_url + p
			end
		end

	user_page (u: IRON_NODE_USER): READABLE_STRING_8
		do
			Result := cms_base_url + "/user/" + url_encoder.general_encoded_string (u.name)
		end

	account_page (u: detachable IRON_NODE_USER): STRING_8
		do
			Result := cms_base_url + "/account/"
			if u /= Void then
				Result.append (url_encoder.general_encoded_string (u.name) + "/")
			end
		end

	page_redirection (v: detachable IRON_NODE_VERSION): READABLE_STRING_8
		do
			Result := page (Void, "/")
		end

	package_admin_web_page (v: detachable IRON_NODE_VERSION): READABLE_STRING_8
		do
			Result := page (v, "/")
		end

	package_list_web_page: READABLE_STRING_8
		do
			Result := page (Void, "/package/")
		end

	package_version_list_web_page (v: IRON_NODE_VERSION): READABLE_STRING_8
		do
			Result := page (v, "/package/")
		end

	package_version_archive_web_page (p: IRON_NODE_VERSION_PACKAGE): READABLE_STRING_8
		do
			Result := page (p.version, "/package/" + url_encoder.general_encoded_string (p.id) + "/archive")
		end

	package_version_map_web_page (p: IRON_NODE_VERSION_PACKAGE; a_path: detachable READABLE_STRING_32): READABLE_STRING_8
		do
			Result := page (p.version, "/package/" + url_encoder.general_encoded_string (p.id) + "/map")
			if a_path /= Void then
				Result := Result + a_path.to_string_8 -- FIXME
			end
		end

	package_view_web_page (p: IRON_NODE_PACKAGE): READABLE_STRING_8
		do
			Result := page (Void, "/package/" + url_encoder.general_encoded_string (p.id))
		end

	package_version_view_web_page (p: IRON_NODE_VERSION_PACKAGE): READABLE_STRING_8
		do
			Result := page (p.version, "/package/" + url_encoder.general_encoded_string (p.id))
		end

	package_update_page (p: IRON_NODE_PACKAGE): READABLE_STRING_8
		do
			Result := page (Void, "/package/" + url_encoder.general_encoded_string (p.id))
		end

	package_version_update_page (p: IRON_NODE_VERSION_PACKAGE): READABLE_STRING_8
		do
			Result := page (p.version, "/package/" + url_encoder.general_encoded_string (p.id))
		end

	package_edit_web_page (p: IRON_NODE_PACKAGE): READABLE_STRING_8
		do
			Result := page (Void, "/package/" + url_encoder.general_encoded_string (p.id) + "/edit/")
		end

	package_version_edit_web_page (p: IRON_NODE_VERSION_PACKAGE): READABLE_STRING_8
		do
			Result := page (p.version, "/package/" + url_encoder.general_encoded_string (p.id) + "/edit/")
		end

	package_create_web_page: READABLE_STRING_8
		do
			Result := page (Void, "/package/create/")
		end

	package_version_create_web_page (v: IRON_NODE_VERSION): READABLE_STRING_8
		do
			Result := page (v, "/package/create/")
		end

	package_version_create_page (v: IRON_NODE_VERSION): READABLE_STRING_8
		do
			Result := page (v, "/package/") -- POST
		end

feature -- Encoders

	url_encoder: URL_ENCODER
		once
			create Result
		end

	html_encoder: HTML_ENCODER
		once
			create Result
		end


note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
