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

	make (db: like database; a_basedir: detachable PATH)
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

	basedir: detachable PATH
			-- Basedir if any

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


end
