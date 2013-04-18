note
	description: "Summary description for {FETCH_PACKAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FETCH_PACKAGE_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_REPO_HANDLER
		rename
			set_iron as make
		end

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				handle_fetch_package (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_fetch_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_RESPONSE_MESSAGE
--			md: WSF_DOWNLOAD_RESPONSE
			md: WSF_FORCE_DOWNLOAD_RESPONSE
--			md: WSF_FILE_RESPONSE
			s: STRING_32
			u: FILE_UTILITIES
		do
			if
				attached {WSF_STRING} req.path_parameter ("domain") as l_domain and then
				attached {WSF_TABLE} req.path_parameter ("vars") as l_vars
			then
				create s.make_from_string (l_domain.value)
				across
					l_vars as c
				loop
					if attached {WSF_STRING} c.item as v then
						s.append_character ('/')
						s.append (v.value)
					end
				end
				if attached iron.database.package_by_path (iron_version (req), s) as l_package then
					if
						attached l_package.archive_path as l_archive_path and then
						u.file_path_exists (l_archive_path)
					then
						create md.make (l_archive_path.utf_8_name)
						md.set_no_cache
						m := md
					else
						create {WSF_NOT_FOUND_RESPONSE} m.make (req)
					end
				else
					create {WSF_NOT_FOUND_RESPONSE} m.make (req)
				end
			else
				create {WSF_NOT_FOUND_RESPONSE} m.make (req)
			end
			res.send (m)

--			create ja.make_array

--			if attached iron.database.packages (1, 0) as lst then
--				across
--					lst as c
--				loop
--					create jo.make
--					if attached c.item.name as l_name then
--						js := l_name
--						jo.put (js, "name")
--					end
--					if attached c.item.description as l_description then
--						js := l_description
--						jo.put (js, "description")
--					end
--					if attached c.item.archive_path as l_archive_path then
--						js := l_archive_path.name
--						jo.put (js, "download")
--					end
--					if not jo.is_empty then
--						ja.add (jo)
--					end
--				end
--			end


--			create h.make
--			h.put_content_type_application_json

--			s := "{ %"packages%": "
--			s.append (ja.representation)
--			s.append ("}")

--			h.put_content_length (s.count)
--			res.put_header_lines (h)
--			res.put_string (s)
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("Download archive associated with package containing current request uri.")
		end

end
