note
	description: "Summary description for {WSF_FILE_SYSTEM_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FILE_SYSTEM_HANDLER

inherit
	WSF_STARTS_WITH_HANDLER
		rename
			execute as execute_starts_with
		end

	WSF_SELF_DOCUMENTED_HANDLER

create
	make,
	make_hidden

feature {NONE} -- Initialization

	make (d: like document_root)
		require
			valid_d: (d /= Void and then not d.is_empty) implies not d.ends_with (operating_environment.directory_separator.out)
		local
			e: EXECUTION_ENVIRONMENT
		do
			if d.is_empty then
				create e
				document_root := e.current_working_directory
			else
				document_root := d
			end
		ensure
			not document_root.is_empty and then not document_root.ends_with (operating_environment.directory_separator.out)
		end

	make_hidden (d: like document_root)
		require
			valid_d: (d /= Void and then not d.is_empty) implies not d.ends_with (operating_environment.directory_separator.out)
		do
			make (d)
			is_hidden := True
		ensure
			hidden: is_hidden
		end

	is_hidden: BOOLEAN
			-- Current mapped handler should be hidden from self documentation		

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- <Precursor>
		do
			create Result.make (m)
			Result.set_is_hidden (is_hidden)
			Result.add_description ("File service")
		end

feature -- Access		

	document_root: STRING
	max_age: INTEGER

	index_disabled: BOOLEAN
			-- Index disabled?

	directory_index: detachable ARRAY [READABLE_STRING_8]
			-- File serve if a directory index is requested

	not_found_handler: detachable PROCEDURE [ANY, TUPLE [uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE]]

	access_denied_handler: detachable PROCEDURE [ANY, TUPLE [uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE]]

feature -- Element change

	enable_index
		do
			index_disabled := False
		end

	disable_index
		do
			index_disabled := True
		end

	set_max_age (a_seconds: like max_age)
		do
			max_age := a_seconds
		end

	set_directory_index (idx: like directory_index)
			-- Set `directory_index' as `idx'
		do
			if idx = Void or else idx.is_empty then
				directory_index := Void
			else
				directory_index := idx
			end
		end

	set_not_found_handler (h: like not_found_handler)
			-- Set `not_found_handler' to `h'
		do
			not_found_handler := h
		end

	set_access_denied_handler (h: like access_denied_handler)
			-- Set `access_denied_handler' to `h'	
		do
			access_denied_handler := h
		end

feature -- Execution

	execute (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			p: STRING
		do
			p := req.path_info
			if p.starts_with (a_start_path) then
				p.remove_head (a_start_path.count)
			else
				check starts_with_base: False end
			end
			process_uri (p, req, res)
		end

	execute_starts_with (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			execute (a_start_path,req, res)
		end

	process_uri (uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: RAW_FILE
			fn: READABLE_STRING_8
		do
			fn := resource_filename (uri)
			create f.make (fn)
			if f.exists then
				if f.is_readable then
					if f.is_directory then
						if index_disabled then
							process_directory_index_disabled (uri, req, res)
						else
							process_index (req.request_uri, fn, req, res)
						end
					else
						process_file (f, req, res)
					end
				else
					process_access_denied (uri, req, res)
				end
			else
				process_not_found (uri, req, res)
			end
		end

	process_index (a_uri: READABLE_STRING_8; dn: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: HTTP_HEADER
			uri, s: STRING_8
			d: DIRECTORY
			l_files: LIST [STRING_8]
		do
			create d.make_open_read (dn)
			if attached directory_index_file (d) as f then
				process_file (f, req, res)
			else
				uri := a_uri
				if not uri.is_empty and then uri [uri.count] /= '/'  then
					uri.append_character ('/')
				end
				s := "[
					<html>
						<head>
							<title>Index for folder: $URI</title>
						</head>
						<body>
							<h1>Index for $URI</h1>
							<ul>
					]"
				s.replace_substring_all ("$URI", uri)

				from
					l_files := d.linear_representation
					l_files.start
				until
					l_files.after
				loop
					s.append ("<li><a href=%"" + uri + l_files.item_for_iteration + "%">" + l_files.item_for_iteration + "</a></li>%N")
					l_files.forth
				end
				s.append ("[
							</ul>
						</body>
					</html>
					]"
				)

				create h.make
				h.put_content_type_text_html
				res.set_status_code ({HTTP_STATUS_CODE}.ok)
				h.put_content_length (s.count)
				res.put_header_text (h.string)
				if not req.request_method.same_string ({HTTP_REQUEST_METHODS}.method_head) then
					res.put_string (s)
				end
				res.flush
			end
			d.close
		end

	process_file (f: FILE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			ext: READABLE_STRING_8
			ct: detachable READABLE_STRING_8
			fres: WSF_FILE_RESPONSE
			dt: DATE_TIME
		do
			ext := extension (f.name)
			ct := extension_mime_mapping.mime_type (ext)
			if ct = Void then
				ct := {HTTP_MIME_TYPES}.application_force_download
			end
			if
				attached req.meta_string_variable ("HTTP_IF_MODIFIED_SINCE") as s_if_modified_since and then
				attached http_date_format_to_date (s_if_modified_since) as l_if_modified_since_date and then
				attached file_date (f) as f_date and then
				f_date <= l_if_modified_since_date
			then
				process_not_modified (f_date, req, res)
			else
				create fres.make_with_content_type (ct, f.name)
				fres.set_status_code ({HTTP_STATUS_CODE}.ok)

				-- cache control
				create dt.make_now_utc
				fres.header.put_cache_control ("private, max-age=" + max_age.out)
				fres.header.put_utc_date (dt)
				if max_age > 0 then
					dt := dt.twin
					dt.second_add (max_age)
				end
				fres.header.put_expires_date (dt)

				fres.set_answer_head_request_method (req.request_method.same_string ({HTTP_REQUEST_METHODS}.method_head))
				res.send (fres)
			end
		end

	process_not_modified (a_utc_date: detachable DATE_TIME; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: HTTP_HEADER
			dt: DATE_TIME
		do
			create dt.make_now_utc
			create h.make
			h.put_cache_control ("private, max-age=" + max_age.out)
			h.put_utc_date (dt)
			if max_age > 0 then
				dt := dt.twin
				dt.second_add (max_age)
			end
			h.put_expires_date (dt)

			if a_utc_date /= Void then
				h.put_last_modified (a_utc_date)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.not_modified)
			res.put_header_text (h.string)
			res.flush
		end

	process_not_found (uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: HTTP_HEADER
			s: STRING_8
		do
			if attached not_found_handler as hdl then
				hdl.call ([uri, req, res])
			else
				create h.make
				h.put_content_type_text_plain
				create s.make_empty
				s.append ("Resource %"" + uri + "%" not found%N")
				res.set_status_code ({HTTP_STATUS_CODE}.not_found)
				h.put_content_length (s.count)
				res.put_header_text (h.string)
				res.put_string (s)
				res.flush
			end
		end

	process_access_denied (uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: HTTP_HEADER
			s: STRING_8
		do
			if attached access_denied_handler as hdl then
				hdl.call ([uri, req, res])
			else
				create h.make
				h.put_content_type_text_plain
				create s.make_empty
				s.append ("Resource %"" + uri + "%": Access denied%N")
				res.set_status_code ({HTTP_STATUS_CODE}.forbidden)
				h.put_content_length (s.count)
				res.put_header_text (h.string)
				res.put_string (s)
				res.flush
			end
		end

	process_directory_index_disabled (uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: HTTP_HEADER
			s: STRING_8
		do
			if attached access_denied_handler as hdl then
				hdl.call ([uri, req, res])
			else
				create h.make
				h.put_content_type_text_plain
				create s.make_empty
				s.append ("Directory index: Access denied%N")
				res.set_status_code ({HTTP_STATUS_CODE}.forbidden)
				h.put_content_length (s.count)
				res.put_header_text (h.string)
				res.put_string (s)
				res.flush
			end
		end

feature {NONE} -- Implementation

	directory_index_file (d: DIRECTORY): detachable FILE
		local
			f: detachable RAW_FILE
			fn: FILE_NAME
		do
			if attached directory_index as default_index then
				across
					default_index as c
				until
					Result /= Void
				loop
					if d.has_entry (c.item) then
						create fn.make_from_string (d.name)
						fn.set_file_name (c.item)
						if f = Void then
							create f.make (fn.string)
						else
							f.make (fn.string)
						end
						if f.exists and then f.is_readable then
							Result := f
						end
					end
				end
			end
		end

	resource_filename (uri: READABLE_STRING_8): READABLE_STRING_8
		do
			Result := real_filename (document_root + operating_environment.directory_separator.out + real_filename (uri))
		end

	dirname (uri: READABLE_STRING_8): READABLE_STRING_8
		local
			p: INTEGER
		do
			p := uri.last_index_of ('/', uri.count)
			if p > 0 then
				Result := uri.substring (1, p - 1)
			else
				create {STRING_8} Result.make_empty
			end
		end

	filename (uri: READABLE_STRING_8): READABLE_STRING_8
		local
			p: INTEGER
		do
			p := uri.last_index_of ('/', uri.count)
			if p > 0 then
				Result := uri.substring (p + 1, uri.count)
			else
				Result := uri.twin
			end
		end

	extension (uri: READABLE_STRING_8): READABLE_STRING_8
		local
			p: INTEGER
		do
			p := uri.last_index_of ('.', uri.count)
			if p > 0 then
				Result := uri.substring (p + 1, uri.count)
			else
				create {STRING_8} Result.make_empty
			end
		end

	real_filename (fn: STRING): STRING
			-- Real filename from url-path `fn'
			--| Find a better design for this piece of code
			--| Eventually in a spec/$ISE_PLATFORM/ specific cluster
		do
			if fn.is_empty then
				Result := fn
			else
				if {PLATFORM}.is_windows then
					create Result.make_from_string (fn)
					Result.replace_substring_all ("/", "\")
					if Result [Result.count] = '\' then
						Result.remove_tail (1)
					end
				else
					Result := fn
					if Result [Result.count] = '/' then
						Result.remove_tail (1)
					end
				end
			end
		end

feature {NONE} -- Implementation

	node_exists (p: READABLE_STRING_8): BOOLEAN
		local
			f: RAW_FILE
		do
			create f.make (p)
			Result := f.exists
		end

	extension_mime_mapping: HTTP_FILE_EXTENSION_MIME_MAPPING
		local
			f: RAW_FILE
		once
			create f.make ("mime.types")
			if f.exists and then f.is_readable then
				create Result.make_from_file (f.name)
			else
				create Result.make_default
			end
		end

feature {NONE} -- implementation: date time

	file_date (f: FILE): DATE_TIME
		do
			Result := timestamp_to_date (f.date)
		end

	http_date_format_to_date (s: READABLE_STRING_8): detachable DATE_TIME
			-- String representation of `dt' using the RFC 1123
			--       HTTP-date    = rfc1123-date | rfc850-date | asctime-date
			--       rfc1123-date = wkday "," SP date1 SP time SP "GMT"
			--       rfc850-date  = weekday "," SP date2 SP time SP "GMT"
			--       asctime-date = wkday SP date3 SP time SP 4DIGIT
			--       date1        = 2DIGIT SP month SP 4DIGIT
			--                      ; day month year (e.g., 02 Jun 1982)
			--       date2        = 2DIGIT "-" month "-" 2DIGIT
			--                      ; day-month-year (e.g., 02-Jun-82)
			--       date3        = month SP ( 2DIGIT | ( SP 1DIGIT ))
			--                      ; month day (e.g., Jun  2)
			--       time         = 2DIGIT ":" 2DIGIT ":" 2DIGIT
			--                      ; 00:00:00 - 23:59:59
			--       wkday        = "Mon" | "Tue" | "Wed"
			--                    | "Thu" | "Fri" | "Sat" | "Sun"
			--       weekday      = "Monday" | "Tuesday" | "Wednesday"
			--                    | "Thursday" | "Friday" | "Saturday" | "Sunday"
			--       month        = "Jan" | "Feb" | "Mar" | "Apr"
			--                    | "May" | "Jun" | "Jul" | "Aug"
			--                    | "Sep" | "Oct" | "Nov" | "Dec"
			--| Sun, 06 Nov 1994 08:49:37 GMT  ; RFC 822, updated by RFC 1123
			--| Sunday, 06-Nov-94 08:49:37 GMT ; RFC 850, obsoleted by RFC 1036
			--| Sun Nov  6 08:49:37 1994       ; ANSI C's asctime() format
			--| 			
			--| "ddd, [0]dd mmm yyyy [0]hh:[0]mi:[0]ss.ff2"
			--| ex: "WED, 30 JAN 2013 21:34:33 "
		note
			EIS: "name=RFC2616", "protocol=URI", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html"
		local
			d: HTTP_DATE
		do
			create d.make_from_string (s)
			if not d.has_error then
				Result := d.date_time
			end
		end

	timestamp_to_date (n: INTEGER): DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_timestamp (n)
			Result := d.date_time
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
