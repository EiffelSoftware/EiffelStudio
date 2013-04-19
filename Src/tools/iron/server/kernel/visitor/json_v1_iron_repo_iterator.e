note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	JSON_V1_IRON_REPO_ITERATOR

inherit
	IRON_REPO_ITERATOR
		redefine
			visit_package,
			visit_package_iterable
		end

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; a_iron: like iron; v: like version)
			-- Initialize `Current'.
		do
			iron := a_iron
			request := req
			version := v
		end

	iron: IRON_REPO

	request: WSF_REQUEST

	version: IRON_REPO_VERSION

	content_type_version: IMMUTABLE_STRING_8
		do
			create Result.make_from_string ("1.0")
		end

	content_type: IMMUTABLE_STRING_8
		local
			s: STRING
		do
			s := "application/json+iron-v"
			s.append (content_type_version)
			create Result.make_from_string (s)
		end

feature -- Access	

	last_json_value: detachable JSON_VALUE

	package_to_json (p: detachable IRON_REPO_PACKAGE): STRING_8
		local
			j: like last_json_value
			jo: JSON_OBJECT
			js: JSON_STRING
		do
			last_json_value := Void
			if p /= Void then
				visit_package (p)
				j := last_json_value
			else
				create {JSON_NULL} j
			end
			create jo.make
			js := content_type_version
			jo.put (js, "_version")
			if j /= Void then
				jo.put (j, "package")
			end
			Result := jo.representation
		end

	packages_to_json (it: detachable ITERABLE [IRON_REPO_PACKAGE]): STRING
		local
			j: like last_json_value
			jo: JSON_OBJECT
			js: JSON_STRING
		do
			last_json_value := Void
			if it /= Void then
				visit_package_iterable (it)
				j := last_json_value
			else
				create {JSON_ARRAY} j.make_array
			end
			create jo.make
			js := content_type_version
			jo.put (js, "_version")
			if j /= Void then
				jo.put (j, "packages")
			end
			Result := jo.representation
		end

feature -- Visit

	visit_package (p: IRON_REPO_PACKAGE)
		local
			js: JSON_STRING
--			l_size: INTEGER
			j_object: JSON_OBJECT
			j_array: JSON_ARRAY
		do
			create j_object.make
			js := p.id
			j_object.put (js, "id")
			if attached p.name as l_name then
				js := l_name
				j_object.put (js, "name")
				if attached p.archive_path as l_archive_path then
					js := request.absolute_script_url (iron.package_archive_web_page (version, p))
					j_object.put (js, "archive")
					debug
						js := l_archive_path.name
						j_object.put (js, "archive_path")
					end
					js := p.archive_file_size.out + " octects"
					j_object.put (js, "archive_size")
					if attached p.archive_last_modified as dt then
						js := date_as_string (dt)
						j_object.put (js, "archive_date")
					end
				end
				if attached p.description as l_description then
					js := l_description
					j_object.put (js, "description")
				end
			end
			if attached iron.database.path_associated_with_package (version, p) as l_paths then
				create j_array.make_array
				across
					l_paths as c
				loop
					js := c.item
					j_array.add (js)
				end
				j_object.put (j_array, "paths")
			end
			last_json_value := j_object
		end

	visit_package_iterable (it: ITERABLE [IRON_REPO_PACKAGE])
		local
			j_array: JSON_ARRAY
		do
			create j_array.make_array
			across
				it as c
			loop
				last_json_value := Void
				visit_package (c.item)
				if attached last_json_value as v then
					j_array.add (v)
				end
			end
			last_json_value := j_array
		end

feature {NONE} -- Implementation

	size_as_string (s: INTEGER): STRING_8
		do
			Result := s.out + " octets"
		end

	date_as_string (dt: DATE_TIME): READABLE_STRING_8
		do
			Result :=(create {HTTP_DATE}.make_from_date_time (dt)).rfc1123_string
		end

	url_encoder: URL_ENCODER
		once
			create Result
		end

end
