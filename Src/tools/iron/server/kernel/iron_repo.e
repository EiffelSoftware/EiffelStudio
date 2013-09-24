note
	description: "Summary description for {IRON_REPO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO

create
	make

feature {NONE} -- Initialization

	make (db: like database; a_basedir: PATH)
		do
			database := db
			basedir := a_basedir
		end

feature -- Access

	is_available: BOOLEAN
		do
			Result := database.is_available
		end

	database: IRON_REPO_DATABASE

	basedir: PATH
			-- Base directory for iron system

feature {NONE} -- Observers

	observers: detachable ARRAYED_LIST [IRON_REPO_OBSERVER]

feature -- Observers	

	notify_user_updated (u: IRON_REPO_USER; flag_is_new: BOOLEAN)
		do
			if attached observers as lst then
				across
					lst as c
				loop
					c.item.on_user_updated (u, flag_is_new)
				end
			end
		end

	notify_package_updated (p: IRON_REPO_PACKAGE; flag_is_new: BOOLEAN)
		do
			if attached observers as lst then
				across
					lst as c
				loop
					c.item.on_package_updated (p, flag_is_new)
				end
			end
		end

feature -- Observers

	register_observer (o: IRON_REPO_OBSERVER)
		local
			obs: like observers
		do
			obs := observers
			if obs = Void then
				create obs.make (1)
				observers := obs
			end
			obs.force (o)
		end

	unregister_observer (o: IRON_REPO_OBSERVER)
		local
			obs: like observers
		do
			obs := observers
			if obs /= Void then
				obs.prune_all (o)
				if obs.is_empty then
					observers := Void
				end
			end
		end

feature -- Access: url

	html_page (v: detachable IRON_REPO_VERSION; s: READABLE_STRING_8): READABLE_STRING_8
		do
			if v /= Void then
				Result := "/access/" + v.value + "/html/" + s
			else
				Result := "/access/html/" + s
			end
		end

	page (v: detachable IRON_REPO_VERSION; p: READABLE_STRING_8): READABLE_STRING_8
		do
			if v /= Void then
				Result := "/access/" + v.value + p
			else
				Result := "/access" + p
			end
		end

	user_page (u: IRON_REPO_USER): READABLE_STRING_8
		do
			Result := "/access/user/" + url_encoder.general_encoded_string (u.name)
		end

	account_page (u: detachable IRON_REPO_USER): STRING_8
		do
			Result := "/access/account/"
			if u /= Void then
				Result.append (url_encoder.general_encoded_string (u.name) + "/")
			end
		end

	page_redirection (v: detachable IRON_REPO_VERSION): READABLE_STRING_8
		do
			Result := page (Void, "/")
		end

	package_admin_web_page (v: detachable IRON_REPO_VERSION): READABLE_STRING_8
		do
			Result := page (v, "/")
		end

	package_list_web_page (v: IRON_REPO_VERSION): READABLE_STRING_8
		do
			Result := page (v, "/package/")
		end

	package_archive_web_page (v: IRON_REPO_VERSION; p: IRON_REPO_PACKAGE): READABLE_STRING_8
		do
			Result := page (v, "/package/" + url_encoder.general_encoded_string (p.id) + "/archive")
		end

	package_map_web_page (v: IRON_REPO_VERSION; p: IRON_REPO_PACKAGE; a_path: detachable READABLE_STRING_32): READABLE_STRING_8
		do
			Result := page (v, "/package/" + url_encoder.general_encoded_string (p.id) + "/map")
			if a_path /= Void then
				Result := Result + a_path.to_string_8 -- FIXME
			end
		end

	package_view_web_page (v: IRON_REPO_VERSION; p: IRON_REPO_PACKAGE): READABLE_STRING_8
		do
			Result := page (v, "/package/" + url_encoder.general_encoded_string (p.id))
		end

	package_update_page (v: IRON_REPO_VERSION; p: IRON_REPO_PACKAGE): READABLE_STRING_8
		do
			Result := page (v, "/package/" + url_encoder.general_encoded_string (p.id))
		end

	package_edit_web_page (v: IRON_REPO_VERSION; p: IRON_REPO_PACKAGE): READABLE_STRING_8
		do
			Result := page (v, "/package/" + url_encoder.general_encoded_string (p.id) + "/edit/")
		end

	package_create_web_page (v: IRON_REPO_VERSION): READABLE_STRING_8
		do
			Result := page (v, "/package/create/")
		end

	package_create_page (v: IRON_REPO_VERSION): READABLE_STRING_8
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
