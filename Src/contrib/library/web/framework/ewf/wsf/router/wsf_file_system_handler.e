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

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER
		rename
			percent_encoder as url_encoder
		export
			{NONE} all
		end

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make_with_path,
	make_hidden_with_path,
	make,
	make_hidden

feature {NONE} -- Initialization

	make_with_path (d: like document_root)
		do
			max_age := -1
			if d.is_empty then
				document_root := execution_environment.current_working_path
			else
				document_root := d
			end
		ensure
			not document_root.is_empty
		end

	make_hidden_with_path (d: like document_root)
		do
			make_with_path (d)
			is_hidden := True
		ensure
			hidden: is_hidden
		end

	make (d: READABLE_STRING_GENERAL)
		do
			make_with_path (create {PATH}.make_from_string (d))
		end

	make_hidden (d: READABLE_STRING_GENERAL)
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

	document_root: PATH

	max_age: INTEGER
			-- Max age, initialized at -1 by default.	

	index_disabled: BOOLEAN
			-- Index disabled?

	index_ignores_function: detachable FUNCTION [PATH, BOOLEAN]
			-- Function to evaluate if a path is ignored or not during autoindex.
			-- If `index_ignores' is Void and `index_ignores_function' is Void, use default ignore rules.

	directory_index: detachable ARRAY [READABLE_STRING_8]
			-- File serve if a directory index is requested.

	not_found_handler: detachable PROCEDURE [TUPLE [uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE]]

	access_denied_handler: detachable PROCEDURE [TUPLE [uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE]]

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

	set_default_index_ignores
			-- Use default auto index ignores behavior.
		do
			index_ignores_function := Void
		end

	set_index_ignores_function (fct: attached like index_ignores_function)
			-- Use `fct' to compute auto index ignores behavior.
		do
			index_ignores_function := fct
		end

feature -- Status report

	ignoring_index_entry (p: PATH): BOOLEAN
			-- Ignoring path `p' for auto index?
		local
			e: detachable PATH
			n: READABLE_STRING_32
		do
			if attached index_ignores_function as fct then
				Result := fct.item ([p])
			else
				-- default
				e := p.entry
				if e = Void then
					e := p
				end
				if e.is_parent_symbol then
				elseif e.is_current_symbol then
					Result := True
				else
					n := e.name
					Result := n.starts_with ({STRING_32} ".")
						or n.ends_with ({STRING_32} "~")
						or n.ends_with ({STRING_32} ".swp")
				end
			end
		end

feature -- Execution

	execute (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			p: STRING_32
		do
			create p.make_from_string (req.path_info)
			if p.starts_with_general (a_start_path) then
				p.remove_head (a_start_path.count)
			else
				check starts_with_base: False end
			end
			process_uri (p, req, res)
		end

	execute_starts_with (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			execute (a_start_path, req, res)
		end

	process_uri (uri: READABLE_STRING_32; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: RAW_FILE
			fn: like resource_filename
		do
			fn := resource_filename (uri)
			create f.make_with_path (fn)
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

	process_index (a_uri: READABLE_STRING_8; dn: PATH; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: HTTP_HEADER
			uri, s: STRING_8
			d: DIRECTORY
			l_files: LIST [PATH]
			p: PATH
			n: READABLE_STRING_32
			httpdate: HTTP_DATE
			pf: RAW_FILE
			l_is_dir: BOOLEAN
		do
			create d.make_with_path (dn)
			d.open_read
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
							<title>Index of $URI</title>
							<style>
								td { padding-left: 10px;}
							</style>
						</head>
						<body>
							<h1>Index of $URI</h1>
							<table>
							<tr><th/><th>Name</th><th>Last modified</th><th>Size</th></tr>
							<tr><th colspan="4"><hr></th></tr>
					]"
				s.replace_substring_all ("$URI", uri)

				from
					l_files := d.entries
					l_files.start
				until
					l_files.after
				loop
					p := l_files.item
					if ignoring_index_entry (p) then

					else
						n := p.name
						create pf.make_with_path (dn.extended_path (p))
						if pf.exists and then pf.is_directory then
							l_is_dir := True
						else
							l_is_dir := False
						end

						s.append ("<tr><td>")
						if l_is_dir then
							s.append ("[dir]")
						else
							s.append ("&nbsp;")
						end
						s.append ("</td>")
						s.append ("<td><a href=%"" + uri)
						url_encoder.append_percent_encoded_string_to (n, s)
						s.append ("%">")
						if p.is_parent_symbol then
							s.append ("[Parent Directory] ..")
						else
							s.append (html_encoder.encoded_string (n))
						end
						if l_is_dir then
							s.append ("/")
						end

						s.append ("</td>")
						s.append ("<td>")
						if pf.exists then
							create httpdate.make_from_date_time (file_date (pf))
							httpdate.append_to_rfc1123_string (s)
						end
						s.append ("</td>")
						s.append ("<td>")
						if not l_is_dir and pf.exists then
							s.append_integer (file_size (pf))
						end
						s.append ("</td>")
						s.append ("</tr>")
					end
					l_files.forth
				end
				s.append ("[
							<tr><th colspan="4"><hr></th></tr>				
							</table>
						</body>
					</html>
					]"
				)

				create h.make
				h.put_content_type_text_html
				res.set_status_code ({HTTP_STATUS_CODE}.ok)
				h.put_content_length (s.count)
				res.put_header_lines (h)
				if not req.request_method.same_string ({HTTP_REQUEST_METHODS}.method_head) then
					res.put_string (s)
				end
				res.flush
			end
			d.close
		end

	process_file (f: FILE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if
				attached req.meta_string_variable ("HTTP_IF_MODIFIED_SINCE") as s_if_modified_since and then
				attached http_date_format_to_date (s_if_modified_since) as l_if_modified_since_date and then
				attached file_date (f) as f_date and then
				f_date <= l_if_modified_since_date
			then
				process_not_modified (f_date, req, res)
			else
				process_transfert (f, req, res)
			end
		end

	process_transfert (f: FILE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			ext: READABLE_STRING_32
			ct: detachable READABLE_STRING_8
			fres: WSF_FILE_RESPONSE
			dt: DATE_TIME
		do
			ext := extension (f.path.name)
			ct := extension_mime_mapping.mime_type (ext)
			if ct = Void then
				ct := {HTTP_MIME_TYPES}.application_force_download
			end
			create fres.make_with_content_type (ct, f.path.name)
			fres.set_status_code ({HTTP_STATUS_CODE}.ok)

				-- cache control
			create dt.make_now_utc
			fres.header.put_utc_date (dt)
			if max_age >= 0 then
				fres.set_max_age (max_age)
				if max_age > 0 then
					dt := dt.twin
					dt.second_add (max_age)
				end
				fres.set_expires_date (dt)
			end

			fres.set_answer_head_request_method (req.request_method.same_string ({HTTP_REQUEST_METHODS}.method_head))
			res.send (fres)
		end

	process_not_modified (a_utc_date: detachable DATE_TIME; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: HTTP_HEADER
			dt: DATE_TIME
		do
			create dt.make_now_utc
			create h.make
			h.put_utc_date (dt)
			if max_age >= 0 then
				h.put_cache_control ("max-age=" + max_age.out)
				if max_age > 0 then
					dt := dt.twin
					dt.second_add (max_age)
				end
				h.put_expires_date (dt)
			end
			if a_utc_date /= Void then
				h.put_last_modified (a_utc_date)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.not_modified)
			res.put_header_lines (h)
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
				res.put_header_lines (h)
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
				res.put_header_lines (h)
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
				res.put_header_lines (h)
				res.put_string (s)
				res.flush
			end
		end

feature {NONE} -- Implementation

	directory_index_file (d: DIRECTORY): detachable FILE
		local
			f: detachable RAW_FILE
			fn: PATH
		do
			if attached directory_index as default_index then
				across
					default_index as c
				until
					Result /= Void
				loop
					if d.has_entry (c.item) then
						fn := d.path.extended (c.item)
						if f = Void then
							create f.make_with_path (fn)
						else
							f.make_with_path (fn)
						end
						if f.exists and then f.is_readable then
							Result := f
						end
					end
				end
			end
		end

	resource_filename (uri: READABLE_STRING_32): PATH
		local
			s: like uri_path_to_filename
		do
			Result := document_root
			s := uri_path_to_filename (uri)
			if not s.is_empty then
				Result := Result.extended (s)
			end
		end

	dirname (uri: READABLE_STRING_32): READABLE_STRING_32
		local
			p: INTEGER
		do
			p := uri.last_index_of ({CHARACTER_32} '/', uri.count)
			if p > 0 then
				Result := uri.substring (1, p - 1)
			else
				create {STRING_32} Result.make_empty
			end
		end

	filename (uri: READABLE_STRING_32): READABLE_STRING_32
		local
			p: INTEGER
		do
			p := uri.last_index_of ({CHARACTER_32} '/', uri.count)
			if p > 0 then
				Result := uri.substring (p + 1, uri.count)
			else
				Result := uri.twin
			end
		end

	extension (uri: READABLE_STRING_32): READABLE_STRING_32
		local
			p: INTEGER
		do
			p := uri.last_index_of ({CHARACTER_32} '.', uri.count)
			if p > 0 then
				Result := uri.substring (p + 1, uri.count)
			else
				create {STRING_32} Result.make_empty
			end
		end

	uri_path_to_filename (fn: READABLE_STRING_32): STRING_32
			-- Real filename from url-path `fn'
			--| Find a better design for this piece of code
			--| Eventually in a spec/$ISE_PLATFORM/ specific cluster
		local
			n: INTEGER
		do
			n := fn.count
			create Result.make_from_string (fn)
			if n > 0 and then Result.item (Result.count) = {CHARACTER_32} '/' then
				Result.remove_tail (1)
				n := n - 1
			end
			if n > 0 and then Result.item (1) = {CHARACTER_32} '/' then
				Result.remove_head (1)
				n := n - 1
			end

			if n > 0 then
				if {PLATFORM}.is_windows then
					Result.replace_substring_all ({STRING_32} "/", {STRING_32} "\")
				end
			end
		end

feature {NONE} -- Implementation

	extension_mime_mapping: HTTP_FILE_EXTENSION_MIME_MAPPING
		local
			f: RAW_FILE
		once
			create f.make_with_name ("mime.types")
			if f.exists and then f.is_readable then
				create Result.make_from_file (f.path.name)
			else
				create Result.make_default
			end
		end

feature {NONE} -- implementation: date time

	file_size (f: FILE): INTEGER
		do
			Result := f.count
		end

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
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
