note
	description: "[
			Server request context of the httpd request
			
			It includes CGI interface and a few extra values that are usually valuable
			    meta_variable (a_name: READABLE_STRING_GENERAL): detachable WSF_STRING
			    meta_string_variable (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			    
			In addition it provides
				
				query_parameter (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
				form_parameter (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
				cookie (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
				...
				
			And also has
				execution_variable (a_name: READABLE_STRING_GENERAL): detachable ANY
					--| to keep value attached to the request
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_REQUEST

inherit
	DEBUG_OUTPUT

create {WSF_TO_WGI_SERVICE}
	make_from_wgi

convert
	make_from_wgi ({WGI_REQUEST})

feature {NONE} -- Initialization

	make_from_wgi (r: WGI_REQUEST)
		local
			tb: like meta_variables_table
		do
			wgi_request := r

			create string_equality_tester
			if attached r.meta_variables as l_vars then
				create tb.make_with_key_tester (l_vars.count, string_equality_tester)
				across
					l_vars as c
				loop
					tb.force (new_string_value (c.key, c.item), c.key)
				end
			else
				create tb.make_with_key_tester (0, string_equality_tester)
			end
			meta_variables_table := tb
			meta_variables := tb
			create error_handler.make
			create uploaded_files_table.make_with_key_tester (0, string_equality_tester)
			set_raw_input_data_recorded (False)
			create {IMMUTABLE_STRING_32} empty_string.make_empty

			create execution_variables_table.make_with_key_tester (0, string_equality_tester)
			execution_variables_table.compare_objects

			initialize
			analyze
		ensure
			wgi_request_set: wgi_request = r
			request_method_set: request_method.same_string (r.request_method)
		end

	initialize
			-- Specific initialization
		local
			s8: detachable READABLE_STRING_8
			req: WGI_REQUEST
		do
			init_mime_handlers
			req := wgi_request

			--| Content-Length
			if attached content_length as s and then s.is_natural_64 then
				content_length_value := s.to_natural_64
			else
				content_length_value := 0
			end

			-- Content-Type
			s8 := req.content_type
			if s8 /= Void then
				create content_type.make_from_string (s8)
			else
				content_type := Void
			end

			--| Request Methods
			request_method := req.request_method

			--| PATH_INFO
			path_info := raw_url_encoder.decoded_string (req.path_info)

			--| PATH_TRANSLATED
			s8 := req.path_translated
			if s8 /= Void then
				path_translated := raw_url_encoder.decoded_string (s8)
			end

				--| Here one can set its own environment entries if needed
			if meta_variable ({WSF_META_NAMES}.request_time) = Void then
				set_meta_string_variable ({WSF_META_NAMES}.request_time, date_time_utilities.unix_time_stamp (Void).out)
			end
		end

	wgi_request: WGI_REQUEST

feature -- Destroy

	destroy
			-- Destroy the object when request is completed
		do
				-- Removed uploaded files
			across
				-- Do not use `uploaded_files' directly
				-- just to avoid processing input data if not yet done
				uploaded_files_table as c
			loop
				delete_uploaded_file (c.item)
			end
		end

feature -- Status report

	debug_output: STRING_8
		do
			create Result.make_from_string (request_method + " " + request_uri)
		end

feature -- Setting

	raw_input_data_recorded: BOOLEAN assign set_raw_input_data_recorded
			-- Record RAW Input datas into `raw_input_data'
			-- otherwise just forget about it
			-- Default: False
			--| warning: you might keep in memory big amount of memory ...

feature -- Raw input data

	raw_input_data: detachable IMMUTABLE_STRING_8
			-- Raw input data is `raw_input_data_recorded' is True

	set_raw_input_data (d: READABLE_STRING_8)
		do
			if attached {IMMUTABLE_STRING_8} d as imm then
				raw_input_data := d
			else
				create raw_input_data.make_from_string (d)
			end
		end

feature -- Raw header data

	raw_header_data: like meta_string_variable
			-- Raw header data if available.
		do
			Result := meta_string_variable ("RAW_HEADER_DATA")
		ensure
			is_valid_as_string_8: Result /= Void implies Result.is_valid_as_string_8
		end

feature -- Error handling

	has_error: BOOLEAN
		do
			Result := error_handler.has_error
		end

	error_handler: ERROR_HANDLER
			-- Error handler
			-- By default initialized to new handler	

feature -- Access: Input

	input: WGI_INPUT_STREAM
			-- Server input channel
		do
			Result := wgi_request.input
		end

	is_chunked_input: BOOLEAN
			-- Is request using chunked transfer-encoding?	
			-- If True, the Content-Length has no meaning
		do
			Result := wgi_request.is_chunked_input
		end

	read_input_data_into (buf: STRING)
			-- retrieve the content from the `input' stream into `s'
			-- warning: if the input data has already been retrieved
			--          you might not get anything
		local
			l_input: WGI_INPUT_STREAM
			n: INTEGER
		do
			if raw_input_data_recorded and then attached raw_input_data as d then
				buf.copy (d)
			else
				l_input := input
				if is_chunked_input then
					from
						n := 8_192
					until
						n = 0 or l_input.end_of_input
					loop
						l_input.append_to_string (buf, n)
						if l_input.last_appended_count < n then
							n := 0
						end
					end
				else
					n := content_length_value.as_integer_32
					if n > 0 then
						l_input.append_to_string (buf, n)
						n := l_input.last_appended_count
						check n = content_length_value.as_integer_32 end
					end
				end
				if raw_input_data_recorded then
					set_raw_input_data (buf)
				end
			end
		end

	read_input_data_into_file (a_file: FILE)
			-- retrieve the content from the `input' stream into `s'
			-- warning: if the input data has already been retrieved
			--          you might not get anything
		require
			a_file_is_open_write: a_file.is_open_write
		local
			s: STRING
			l_input: WGI_INPUT_STREAM
			l_raw_data: detachable STRING_8
			n: INTEGER
		do
			if raw_input_data_recorded and then attached raw_input_data as d then
				a_file.put_string (d)
			else
				if raw_input_data_recorded then
					create l_raw_data.make_empty
				end
				l_input := input
				from
					n := 8_192
					create s.make (n)
				until
					n = 0 or l_input.end_of_input
				loop
					l_input.append_to_string (s, n)
					a_file.put_string (s)
					if l_raw_data /= Void then
						l_raw_data.append (s)
					end
					s.wipe_out
					if l_input.last_appended_count < n then
						n := 0
					end
				end
				if l_raw_data /= Void then
					set_raw_input_data (l_raw_data)
				end
			end
		end

feature -- Helper

	is_request_method (m: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `m' the Current request_method?
		do
			Result := request_method.is_case_insensitive_equal (m.as_string_8)
		end

	is_post_request_method: BOOLEAN
			-- Is Current a POST request method?
		do
			Result := request_method.is_case_insensitive_equal ({HTTP_REQUEST_METHODS}.method_post)
		end

	is_get_request_method: BOOLEAN
			-- Is Current a GET request method?
		do
			Result := request_method.is_case_insensitive_equal ({HTTP_REQUEST_METHODS}.method_get)
		end

	is_content_type_accepted (a_content_type: READABLE_STRING_GENERAL): BOOLEAN
			-- Does client accepts content_type for the response?
			--| Based on header "Accept:" that can be for instance
			--| 	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
		local
			i, j: INTEGER
		do
			if attached http_accept as l_accept then
				i := l_accept.substring_index (a_content_type, 1)
				if i > 0 then
					-- contains the text, now check if this is the exact text
					if
						i = 1	-- At the beginning of text
						or else l_accept[i-1].is_space -- preceded by space
						or else l_accept[i-1] = ',' -- preceded by other mime type
					then
						j := i + a_content_type.count
						if l_accept.valid_index (j) then
							Result := l_accept[j] = ',' -- followed by other mime type
										or else l_accept[j] = ';' -- followed by quality  ;q=...
										or else l_accept[j].is_space -- followed by space
						else -- end of text
							Result := True
						end
					end
				end
				Result := l_accept.has_substring (a_content_type)
			end
		end

feature -- Eiffel WGI access

	wgi_version: READABLE_STRING_8
			-- Eiffel WGI version
			--| example: "1.0"
		do
			Result := wgi_request.wgi_version
		end

	wgi_implementation: READABLE_STRING_8
			-- Information about Eiffel WGI implementation
			--| example: "Eiffel Web Framework 1.0"
		do
			Result := wgi_request.wgi_implementation
		end

	wgi_connector: WGI_CONNECTOR
			-- Associated Eiffel WGI connector
		do
			Result := wgi_request.wgi_connector
		end

feature {WSF_REQUEST_EXPORTER} -- Override value		

	set_request_method (a_request_method: like request_method)
			-- Set `request_method' to `a_request_method'
			-- note: this is mainly to have smart handling of HEAD request
		do
			request_method := a_request_method
		end

feature {NONE} -- Access: global variable

	items_table: HASH_TABLE_EX [WSF_VALUE, READABLE_STRING_GENERAL]
			-- Table containing all the various variables
			-- Warning: this is computed each time, if you change the content of other containers
			-- this won't update this Result's content, unless you query it again
		do
			create Result.make_with_key_tester (20, string_equality_tester)

			if attached path_parameters as l_path_parameters then
				across
					l_path_parameters as c
				loop
					Result.force (c.item, c.item.name)
				end
			end

			across
				query_parameters as c
			loop
				Result.force (c.item, c.item.name)
			end

			across
				form_parameters as c
			loop
				Result.force (c.item, c.item.name)
			end
		end

feature -- Access: global variables	

	items: ITERABLE [WSF_VALUE]
		do
			Result := items_table
		end

	item (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Variable named `a_name' from any of the variables container
			-- and following a specific order: form_, query_ and path_ parameters
			--| Cookie are not included due to security reason.
		do
			Result := form_parameter (a_name)
			if Result = Void then
				Result := query_parameter (a_name)
				if Result = Void then
					Result := path_parameter (a_name)
				end
			end
		end

	string_item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			if attached {WSF_STRING} item (a_name) as val then
				Result := val.value
			else
				check is_string_value: False end
			end
		end

	string_array_item (a_name: READABLE_STRING_GENERAL): detachable ARRAY [READABLE_STRING_32]
			-- Array of string values for path parameter `a_name' if relevant.
		do
			if attached {WSF_TABLE} item (a_name) as tb then
				Result := tb.as_array_of_string
			else
				Result := string_array_item_for (a_name, agent item)
			end
		end

	string_array_item_for (a_name: READABLE_STRING_GENERAL; a_item_fct: FUNCTION [ANY, TUPLE [READABLE_STRING_GENERAL], detachable WSF_VALUE]): detachable ARRAY [READABLE_STRING_32]
			-- Array of string values for query parameter `a_name' if relevant.
		local
			i: INTEGER
			n: INTEGER
		do
			from
				i := 1
				n := 1
				create Result.make_filled ("", 1, 5)
			until
				i = 0
			loop
				if attached {WSF_STRING} a_item_fct.item ([a_name + "[" + i.out + "]"]) as v then
					Result.force (v.value, n)
					n := n + 1
					i := i + 1
				else
					i := 0 -- Exit
				end
			end
			Result.keep_head (n - 1)
		end

	table_item (a_name: READABLE_STRING_GENERAL; f: detachable FUNCTION [ANY, TUPLE [READABLE_STRING_GENERAL], detachable WSF_VALUE]): detachable WSF_VALUE
			-- Return value associated with table for flat name `a_name'.
			-- Use function `f' to get the item, this could be agent of `form_parameter' or `query_parameter', ...
			--     By default, this uses `items'
			-- For instance "foo[bar]" will return item "bar" from table item "foo" if it exists.
			-- Note: we could add this flexible behavior directly to `query_parameter' and related ..
		local
			p,q: INTEGER
			n,k: READABLE_STRING_GENERAL
			v: like table_item
			val: detachable WSF_VALUE
		do
			if f /= Void then
				Result := f.item ([a_name])
			else
				Result := item (a_name)
			end
			if Result = Void then
				p := a_name.index_of_code (91, 1) -- 91 '['
				if p > 0 then
					q := a_name.index_of_code (93, p + 1) -- 93 ']'
					if q > p then
						n := a_name.substring (1, p - 1)
						k := a_name.substring (p + 1, q - 1)

						if f /= Void then
							val := f.item ([n])
						else
							val := item (n)
						end
						if attached {WSF_TABLE} val as tb then
							v := tb.value (k)
							if q = a_name.count then
								Result := v
							else
							end
						end
					end
				end
			end
		end

feature -- Helpers: global variables

	items_as_string_items: ITERABLE [TUPLE [name: READABLE_STRING_32; value: detachable READABLE_STRING_32]]
			-- `items' as strings items
			-- i.e: flatten any table or related into multiple string items
		local
			res: ARRAYED_LIST [TUPLE [name: READABLE_STRING_32; value: detachable READABLE_STRING_32]]
		do
			if attached items_table as tb then
				create res.make (tb.count)
				across
					tb as c
				loop
					append_value_as_string_items_to (c.item, res)
				end
			else
				create res.make (0)
			end
			Result := res
		end

	append_value_as_string_items_to (v: WSF_VALUE; a_target: LIST [TUPLE [name: READABLE_STRING_32; value: detachable READABLE_STRING_32]])
			-- Append value `v' to `a_target' as multiple string items
		do
			if attached {WSF_STRING} v as s then
				a_target.force ([s.name, s.value])
			elseif attached {ITERABLE [WSF_VALUE]} v as lst then
				across
					lst as c
				loop
					append_value_as_string_items_to (c.item, a_target)
				end
			else
				a_target.force ([v.name, v.string_representation])
			end
		end

feature -- Execution variables

	has_execution_variable (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Has execution variable related to `a_name'?
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			Result := execution_variables_table.has (a_name)
		end

	execution_variable (a_name: READABLE_STRING_GENERAL): detachable ANY
			-- Execution variable related to `a_name'
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			Result := execution_variables_table.item (a_name)
		end

	set_execution_variable (a_name: READABLE_STRING_GENERAL; a_value: detachable ANY)
		do
			execution_variables_table.force (a_value, a_name)
		ensure
			param_set: execution_variable (a_name) = a_value
		end

	unset_execution_variable (a_name: READABLE_STRING_GENERAL)
		do
			execution_variables_table.remove (a_name)
		ensure
			param_unset: execution_variable (a_name) = Void
		end

feature {NONE} -- Execution variables: implementation

	execution_variables_table: HASH_TABLE_EX [detachable ANY, READABLE_STRING_GENERAL]

feature -- Access: CGI Meta variables

	meta_variable (a_name: READABLE_STRING_GENERAL): detachable WSF_STRING
			-- CGI Meta variable related to `a_name'
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			Result := meta_variables_table.item (a_name)
		end

	meta_string_variable (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- CGI meta variable related to `a_name'
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			if attached meta_variable (a_name) as val then
				Result := val.value
			end
		end

	meta_variables: ITERABLE [WSF_STRING]
			-- CGI meta variables values

	meta_string_variable_or_default (a_name: READABLE_STRING_GENERAL; a_default: READABLE_STRING_32; use_default_when_empty: BOOLEAN): READABLE_STRING_32
			-- Value for meta parameter `a_name'
			-- If not found, return `a_default'
		require
			a_name_not_empty: a_name /= Void and then not a_name.is_empty
		do
			if attached meta_variable (a_name) as val then
				Result := val.value
				if use_default_when_empty and then Result.is_empty then
					Result := a_default
				end
			else
				Result := a_default
			end
		end

	set_meta_string_variable (a_name: READABLE_STRING_8; a_value: READABLE_STRING_32)
			-- Set meta variable `a_name' and `a_value'
			--| `a_name' is READABLE_STRING_8 on purpose.
		do
			meta_variables_table.force (new_string_value (a_name, a_value), a_name)
		ensure
			param_set: attached {WSF_STRING} meta_variable (a_name) as val and then val.url_encoded_value.same_string (a_value)
		end

	unset_meta_variable (a_name: READABLE_STRING_GENERAL)
		do
			meta_variables_table.remove (a_name)
		ensure
			param_unset: meta_variable (a_name) = Void
		end

feature {NONE} -- Access: CGI meta parameters

	meta_variables_table: HASH_TABLE_EX [WSF_STRING, READABLE_STRING_GENERAL]
			-- CGI Environment parameters		

feature -- Access: CGI meta parameters - 1.1			

	auth_type: detachable READABLE_STRING_8
			-- This variable is specific to requests made via the "http"
			-- scheme.
			--
			-- If the Script-URI required access authentication for external
			-- access, then the server MUST set the value of this variable
			-- from the 'auth-scheme' token in the wgi_request's "Authorization"
			-- header field. Otherwise it is set to NULL.
			--
			--  AUTH_TYPE   = "" | auth-scheme
			--  auth-scheme = "Basic" | "Digest" | token
			--
			-- HTTP access authentication schemes are described in section 11
			-- of the HTTP/1.1 specification [8]. The auth-scheme is not
			-- case-sensitive.
			--
			-- Servers MUST provide this metavariable to scripts if the
			-- wgi_request header included an "Authorization" field that was
			-- authenticated.
		do
			Result := wgi_request.auth_type
		end

	content_length: detachable READABLE_STRING_8
			-- This metavariable is set to the size of the message-body
			-- entity attached to the wgi_request, if any, in decimal number of
			-- octets. If no data are attached, then this metavariable is
			-- either NULL or not defined. The syntax is the same as for the
			-- HTTP "Content-Length" header field (section 14.14, HTTP/1.1
			-- specification [8]).
			--
			--  CONTENT_LENGTH = "" | 1*digit
			--
			-- Servers MUST provide this metavariable to scripts if the
			-- wgi_request was accompanied by a message-body entity.
		do
			Result := wgi_request.content_length
		end

	content_length_value: NATURAL_64
			-- Integer value related to `content_length"

	content_type: detachable HTTP_CONTENT_TYPE
			-- If the wgi_request includes a message-body, CONTENT_TYPE is set to
			-- the Internet Media Type [9] of the attached entity if the type
			-- was provided via a "Content-type" field in the wgi_request header,
			-- or if the server can determine it in the absence of a supplied
			-- "Content-type" field. The syntax is the same as for the HTTP
			-- "Content-Type" header field.
			--
			--  CONTENT_TYPE = "" | media-type
			--  media-type   = type "/" subtype *( ";" parameter)
			--  type         = token
			--  subtype      = token
			--  parameter    = attribute "=" value
			--  attribute    = token
			--  value        = token | quoted-string
			--
			-- The type, subtype, and parameter attribute names are not
			-- case-sensitive. Parameter values MAY be case sensitive. Media
			-- types and their use in HTTP are described in section 3.7 of
			-- the HTTP/1.1 specification [8].
			--
			-- Example:
			--
			--  application/x-www-form-urlencoded
			--
			-- There is no default value for this variable. If and only if it
			-- is unset, then the script MAY attempt to determine the media
			-- type from the data received. If the type remains unknown, then
			-- the script MAY choose to either assume a content-type of
			-- application/octet-stream or reject the wgi_request with a 415
			-- ("Unsupported Media Type") error. See section 7.2.1.3 for more
			-- information about returning error status values.
			--
			-- Servers MUST provide this metavariable to scripts if a
			-- "Content-Type" field was present in the original wgi_request
			-- header. If the server receives a wgi_request with an attached
			-- entity but no "Content-Type" header field, it MAY attempt to
			-- determine the correct datatype, or it MAY omit this
			-- metavariable when communicating the wgi_request information to the
			-- script.

	gateway_interface: READABLE_STRING_8
			-- This metavariable is set to the dialect of CGI being used by
			-- the server to communicate with the script. Syntax:
			--
			--  GATEWAY_INTERFACE = "CGI" "/" major "." minor
			--  major             = 1*digit
			--  minor             = 1*digit
			--
			-- Note that the major and minor numbers are treated as separate
			-- integers and hence each may be more than a single digit. Thus
			-- CGI/2.4 is a lower version than CGI/2.13 which in turn is
			-- lower than CGI/12.3. Leading zeros in either the major or the
			-- minor number MUST be ignored by scripts and SHOULD NOT be
			-- generated by servers.
			--
			-- This document defines the 1.1 version of the CGI interface
			-- ("CGI/1.1").
			--
			-- Servers MUST provide this metavariable to scripts.
			--
			-- The version of the CGI specification to which this server
			-- complies.  Syntax:
			--
			--  GATEWAY_INTERFACE =  "CGI" "/" 1*digit "." 1*digit
			--
			-- Note that the major and minor numbers are treated as separate
			-- integers and that each may be incremented higher than a single
			-- digit.  Thus CGI/2.4 is a lower version than CGI/2.13 which in
			-- turn is lower than CGI/12.3. Leading zeros must be ignored by
			-- scripts and should never be generated by servers.
		do
			Result := wgi_request.gateway_interface
		end

	path_info: READABLE_STRING_32
			-- The PATH_INFO metavariable specifies a path to be interpreted
			-- by the CGI script. It identifies the resource or sub-resource
			-- to be returned by the CGI script, and it is derived from the
			-- portion of the URI path following the script name but
			-- preceding any query data. The syntax and semantics are similar
			-- to a decoded HTTP URL 'path' token (defined in RFC 2396 [4]),
			-- with the exception that a PATH_INFO of "/" represents a single
			-- void path segment.
			--
			--  PATH_INFO = "" | ( "/" path )
			--  path      = segment *( "/" segment )
			--  segment   = *pchar
			--  pchar     = <any CHAR except "/">
			--
			-- The PATH_INFO string is the trailing part of the <path>
			-- component of the Script-URI (see section 3.2) that follows the
			-- SCRIPT_NAME portion of the path.
			--
			-- Servers MAY impose their own restrictions and limitations on
			-- what values they will accept for PATH_INFO, and MAY reject or
			-- edit any values they consider objectionable before passing
			-- them to the script.
			--
			-- Servers MUST make this URI component available to CGI scripts.
			-- The PATH_INFO value is case-sensitive, and the server MUST
			-- preserve the case of the PATH_INFO element of the URI when
			-- making it available to scripts.

	path_translated: detachable READABLE_STRING_32
			-- PATH_TRANSLATED is derived by taking any path-info component
			-- of the wgi_request URI (see section 6.1.6), decoding it (see
			-- section 3.1), parsing it as a URI in its own right, and
			-- performing any virtual-to-physical translation appropriate to
			-- map it onto the server's document repository structure. If the
			-- wgi_request URI includes no path-info component, the
			-- PATH_TRANSLATED metavariable SHOULD NOT be defined.
			--
			--
			--  PATH_TRANSLATED = *CHAR
			--
			-- For a wgi_request such as the following:
			--
			--  http://somehost.com/cgi-bin/somescript/this%2eis%2epath%2einfo
			--
			-- the PATH_INFO component would be decoded, and the result
			-- parsed as though it were a wgi_request for the following:
			--
			--  http://somehost.com/this.is.the.path.info
			--
			-- This would then be translated to a location in the server's
			-- document repository, perhaps a filesystem path something like
			-- this:
			--
			--  /usr/local/www/htdocs/this.is.the.path.info
			--
			-- The result of the translation is the value of PATH_TRANSLATED.
			--
			-- The value of PATH_TRANSLATED may or may not map to a valid
			-- repository location. Servers MUST preserve the case of the
			-- path-info segment if and only if the underlying repository
			-- supports case-sensitive names. If the repository is only
			-- case-aware, case-preserving, or case-blind with regard to
			-- document names, servers are not required to preserve the case
			-- of the original segment through the translation.
			--
			-- The translation algorithm the server uses to derive
			-- PATH_TRANSLATED is implementation defined; CGI scripts which
			-- use this variable may suffer limited portability.
			--
			-- Servers SHOULD provide this metavariable to scripts if and
			-- only if the wgi_request URI includes a path-info component.

	query_string: READABLE_STRING_8
			-- A URL-encoded string; the <query> part of the Script-URI. (See
			-- section 3.2.)
			--
			--  QUERY_STRING = query-string
			--  query-string = *uric

			-- The URL syntax for a query string is described in section 3 of
			-- RFC 2396 [4].
			--
			-- Servers MUST supply this value to scripts. The QUERY_STRING
			-- value is case-sensitive. If the Script-URI does not include a
			-- query component, the QUERY_STRING metavariable MUST be defined
			-- as an empty string ("").
		do
			Result := wgi_request.query_string
		end

	remote_addr: READABLE_STRING_8
			-- The IP address of the client sending the wgi_request to the
			-- server. This is not necessarily that of the user agent (such
			-- as if the wgi_request came through a proxy).
			--
			--  REMOTE_ADDR  = hostnumber
			--  hostnumber   = ipv4-address | ipv6-address

			-- The definitions of ipv4-address and ipv6-address are provided
			-- in Appendix B of RFC 2373 [13].
			--
			-- Servers MUST supply this value to scripts.
		do
			Result := wgi_request.remote_addr
		end

	remote_host: detachable READABLE_STRING_8
			-- The fully qualified domain name of the client sending the
			-- wgi_request to the server, if available, otherwise NULL. (See
			-- section 6.1.9.) Fully qualified domain names take the form as
			-- described in section 3.5 of RFC 1034 [10] and section 2.1 of
			-- RFC 1123 [5]. Domain names are not case sensitive.
			--
			-- Servers SHOULD provide this information to scripts.
		do
			Result := wgi_request.remote_host
		end

	remote_ident: detachable READABLE_STRING_8
			-- The identity information reported about the connection by a
			-- RFC 1413 [11] wgi_request to the remote agent, if available.
			-- Servers MAY choose not to support this feature, or not to
			-- wgi_request the data for efficiency reasons.
			--
			--  REMOTE_IDENT = *CHAR
			--
			-- The data returned may be used for authentication purposes, but
			-- the level of trust reposed in them should be minimal.
			--
			-- Servers MAY supply this information to scripts if the RFC1413
			-- [11] lookup is performed.
		do
			Result := wgi_request.remote_ident
		end

	remote_user: detachable READABLE_STRING_8
			-- If the wgi_request required authentication using the "Basic"
			-- mechanism (i.e., the AUTH_TYPE metavariable is set to
			-- "Basic"), then the value of the REMOTE_USER metavariable is
			-- set to the user-ID supplied. In all other cases the value of
			-- this metavariable is undefined.
			--
			--  REMOTE_USER = *OCTET
			--
			-- This variable is specific to requests made via the HTTP
			-- protocol.
			--
			-- Servers SHOULD provide this metavariable to scripts.
		do
			Result := wgi_request.remote_user
		end

	request_method: READABLE_STRING_8
			-- The REQUEST_METHOD metavariable is set to the method with
			-- which the wgi_request was made, as described in section 5.1.1 of
			-- the HTTP/1.0 specification [3] and section 5.1.1 of the
			-- HTTP/1.1 specification [8].
			--
			--  REQUEST_METHOD   = http-method
			--  http-method      = "GET" | "HEAD" | "POST" | "PUT" | "DELETE"
			--                     | "OPTIONS" | "TRACE" | extension-method
			--  extension-method = token
			--
			-- The method is case sensitive. CGI/1.1 servers MAY choose to
			-- process some methods directly rather than passing them to
			-- scripts.
			--
			-- This variable is specific to requests made with HTTP.
			--
			-- Servers MUST provide this metavariable to scripts.

	script_name: READABLE_STRING_8
			-- The SCRIPT_NAME metavariable is set to a URL path that could
			-- identify the CGI script (rather than the script's output). The
			-- syntax and semantics are identical to a decoded HTTP URL
			-- 'path' token (see RFC 2396 [4]).
			--
			--  SCRIPT_NAME = "" | ( "/" [ path ] )
			--
			-- The SCRIPT_NAME string is some leading part of the <path>
			-- component of the Script-URI derived in some implementation
			-- defined manner. No PATH_INFO or QUERY_STRING segments (see
			-- sections 6.1.6 and 6.1.8) are included in the SCRIPT_NAME
			-- value.
			--
			-- Servers MUST provide this metavariable to scripts.
		do
			Result := wgi_request.script_name
		end

	server_name: READABLE_STRING_8
			-- The SERVER_NAME metavariable is set to the name of the server,
			-- as derived from the <host> part of the Script-URI (see section
			-- 3.2).
			--
			--  SERVER_NAME = hostname | hostnumber
			--
			-- Servers MUST provide this metavariable to scripts.
		do
			Result := wgi_request.server_name
		end

	server_port: INTEGER
			-- The SERVER_PORT metavariable is set to the port on which the
			-- wgi_request was received, as used in the <port> part of the
			-- Script-URI.
			--
			--  SERVER_PORT = 1*digit
			--
			-- If the <port> portion of the script-URI is blank, the actual
			-- port number upon which the wgi_request was received MUST be
			-- supplied.
			--
			-- Servers MUST provide this metavariable to scripts.
		do
			Result := wgi_request.server_port
		end

	server_protocol: READABLE_STRING_8
			-- The SERVER_PROTOCOL metavariable is set to the name and
			-- revision of the information protocol with which the wgi_request
			-- arrived. This is not necessarily the same as the protocol
			-- version used by the server in its response to the client.
			--
			--  SERVER_PROTOCOL   = HTTP-Version | extension-version
			--                      | extension-token
			--  HTTP-Version      = "HTTP" "/" 1*digit "." 1*digit
			--  extension-version = protocol "/" 1*digit "." 1*digit
			--  protocol          = 1*( alpha | digit | "+" | "-" | "." )
			--  extension-token   = token
			--
			-- 'protocol' is a version of the <scheme> part of the
			-- Script-URI, but is not identical to it. For example, the
			-- scheme of a wgi_request may be "https" while the protocol remains
			-- "http". The protocol is not case sensitive, but by convention,
			-- 'protocol' is in upper case.
			--
			-- A well-known extension token value is "INCLUDED", which
			-- signals that the current document is being included as part of
			-- a composite document, rather than being the direct target of
			-- the client wgi_request.
			--
			-- Servers MUST provide this metavariable to scripts.
		do
			Result := wgi_request.server_protocol
		end

	server_software: READABLE_STRING_8
			-- The SERVER_SOFTWARE metavariable is set to the name and
			-- version of the information server software answering the
			-- wgi_request (and running the gateway).
			--
			--  SERVER_SOFTWARE = 1*product
			--  product         = token [ "/" product-version ]
			--  product-version = token

			-- Servers MUST provide this metavariable to scripts.
		do
			Result := wgi_request.server_software
		end

feature -- HTTP_*

	http_accept: detachable READABLE_STRING_8
			-- Contents of the Accept: header from the current wgi_request, if there is one.
			-- Example: 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
		do
			Result := wgi_request.http_accept
		end

	http_accept_charset: detachable READABLE_STRING_8
			-- Contents of the Accept-Charset: header from the current wgi_request, if there is one.
			-- Example: 'iso-8859-1,*,utf-8'.
		do
			Result := wgi_request.http_accept_charset
		end

	http_accept_encoding: detachable READABLE_STRING_8
			-- Contents of the Accept-Encoding: header from the current wgi_request, if there is one.
			-- Example: 'gzip'.
		do
			Result := wgi_request.http_accept_encoding
		end

	http_accept_language: detachable READABLE_STRING_8
			-- Contents of the Accept-Language: header from the current wgi_request, if there is one.
			-- Example: 'en'.
		do
			Result := wgi_request.http_accept_language
		end

	http_connection: detachable READABLE_STRING_8
			-- Contents of the Connection: header from the current wgi_request, if there is one.
			-- Example: 'Keep-Alive'.
		do
			Result := wgi_request.http_connection
		end

	http_expect: detachable READABLE_STRING_8
			-- The Expect request-header field is used to indicate that particular server behaviors are required by the client.
			-- Example: '100-continue'.
		do
			Result := wgi_request.http_expect
		end

	http_host: detachable READABLE_STRING_8
			-- Contents of the Host: header from the current wgi_request, if there is one.
		do
			Result := wgi_request.http_host
		end

	http_referer: detachable READABLE_STRING_8
			-- The address of the page (if any) which referred the user agent to the current page.
			-- This is set by the user agent.
			-- Not all user agents will set this, and some provide the ability to modify HTTP_REFERER as a feature.
			-- In short, it cannot really be trusted.
		do
			Result := wgi_request.http_referer
		end

	http_user_agent: detachable READABLE_STRING_8
			-- Contents of the User-Agent: header from the current wgi_request, if there is one.
			-- This is a string denoting the user agent being which is accessing the page.
			-- A typical example is: Mozilla/4.5 [en] (X11; U; Linux 2.2.9 i586).
			-- Among other things, you can use this value to tailor your page's
			-- output to the capabilities of the user agent.
		do
			Result := wgi_request.http_user_agent
		end

	http_authorization: detachable READABLE_STRING_8
			-- Contents of the Authorization: header from the current wgi_request, if there is one.
		do
			Result := wgi_request.http_authorization
		end

	http_transfer_encoding: detachable READABLE_STRING_8
			-- Transfer-Encoding
			-- for instance chunked
		do
			Result := wgi_request.http_transfer_encoding
		end

	http_access_control_request_headers: detachable READABLE_STRING_8
			-- Indicates which headers will be used in the actual request
                        -- as part of the preflight request
		do
			Result := wgi_request.http_access_control_request_headers
		end

	http_if_match: detachable READABLE_STRING_8
			-- Existence check on resource
		do
			Result := wgi_request.http_if_match
		end

feature -- Extra CGI environment variables

	request_uri: READABLE_STRING_8
			-- The URI which was given in order to access this page; for instance, '/index.html'.
		do
			Result := wgi_request.request_uri
		end

	orig_path_info: detachable READABLE_STRING_8
			-- Original version of `path_info' before processed by Current environment
		do
			Result := wgi_request.orig_path_info
		end

	request_time: detachable DATE_TIME
			-- Request time (UTC)
		local
			i: like request_time_stamp
		do
			i := request_time_stamp
			if i > 0 then
				Result := date_time_utilities.unix_time_stamp_to_date_time (i)
			end
		end

	request_time_stamp: INTEGER_64
			-- Request time stamp (UTC)	 (unix time stamp)
		do
			if
				attached {WSF_STRING} meta_variable ({WSF_META_NAMES}.request_time) as t and then
				t.value.is_integer_64
			then
				Result := t.value.to_integer_64
			end
		ensure
			Result = 0 implies meta_variable ({WSF_META_NAMES}.request_time) = Void
		end

feature -- Cookies

	cookies: ITERABLE [WSF_VALUE]
			-- All cookies.
		do
			Result := cookies_table
		end

	cookie (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Field for name `a_name'.
		do
			Result := cookies_table.item (a_name)
		end

feature {NONE} -- Cookies

	cookies_table: HASH_TABLE_EX [WSF_VALUE, READABLE_STRING_GENERAL]
			-- Expanded cookies variable
		local
			i,j,p,n: INTEGER
			l_cookies: like internal_cookies_table
			k,v,s: STRING
		do
			l_cookies := internal_cookies_table
			if l_cookies = Void then
				if attached {WSF_STRING} meta_variable ({WSF_META_NAMES}.http_cookie) as val then
					s := val.value
					create l_cookies.make_with_key_tester (5, string_equality_tester)
					l_cookies.compare_objects
					from
						n := s.count
						p := 1
						i := 1
					until
						p < 1
					loop
						i := s.index_of ('=', p)
						if i > 0 then
							j := s.index_of (';', i)
							if j = 0 then
								j := n + 1
								k := s.substring (p, i - 1)
								v := s.substring (i + 1, n)

								p := 0 -- force termination
							else
								k := s.substring (p, i - 1)
								v := s.substring (i + 1, j - 1)
								p := j + 1
							end
							k.left_adjust
							k.right_adjust
							add_value_to_table (k, v, l_cookies)
						end
					end
				else
					create l_cookies.make_with_key_tester (0, string_equality_tester)
					l_cookies.compare_objects
				end
				internal_cookies_table := l_cookies
			end
			Result := l_cookies
		end

feature -- Path parameters

	path_parameters: detachable ITERABLE [WSF_VALUE]
			-- All path parameters.
			--| Could be Void
		do
			Result := path_parameters_table
		end

	path_parameter (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Path Parameter for name `a_name'.
		do
			if attached path_parameters_table as tb then
				Result := tb.item (a_name)
			end
		end

feature {NONE} -- Query parameters: implementation

	path_parameters_table: detachable HASH_TABLE_EX [WSF_VALUE, READABLE_STRING_GENERAL]
			-- Parameters computed from `path_parameters_source'
			--| most often coming from the associated route from WSF_ROUTER

feature {WSF_REQUEST_PATH_PARAMETERS_SOURCE} -- Path parameters: Element change

	path_parameters_source: detachable WSF_REQUEST_PATH_PARAMETERS_SOURCE
			-- Source of urlencoded path_parameters, or saved computed path parameters as WSF_VALUE.

	set_path_parameters_source (src: like path_parameters_source)
		local
			l_table: detachable like path_parameters_table
			lst: detachable TABLE_ITERABLE [READABLE_STRING_8, READABLE_STRING_8]
			l_count: INTEGER
		do
			path_parameters_source := src
			if src = Void then
				l_table := Void
			else
				l_count := src.path_parameters_count
				if l_count = 0 then
					l_table := Void
				else
					create l_table.make_with_key_tester (l_count, string_equality_tester)
					l_table.compare_objects
					if attached src.path_parameters as tb then
						across
							tb as c
						loop
							l_table.force (c.item, c.item.name)
						end
					else
						lst := src.urlencoded_path_parameters
						across
							lst as c
						loop
							add_value_to_table (c.key, c.item, l_table)
						end
						src.update_path_parameters (l_table)
					end
				end
			end
			path_parameters_table := l_table
		end

feature -- Query parameters

	query_parameters: ITERABLE [WSF_VALUE]
			-- All query parameters
		do
			Result := query_parameters_table
		end

	query_parameter (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Query parameter for name `a_name'.
		do
			Result := query_parameters_table.item (a_name)
		end

feature {NONE} -- Query parameters: implementation

	query_parameters_table: HASH_TABLE_EX [WSF_VALUE, READABLE_STRING_GENERAL]
			-- Parameters extracted from QUERY_STRING	
		local
			vars: like internal_query_parameters_table
			p,e: INTEGER
			rq_uri: like request_uri
			s: detachable STRING
		do
			vars := internal_query_parameters_table
			if vars = Void then
				s := query_string
				if s = Void then
					rq_uri := request_uri
					p := rq_uri.index_of ('?', 1)
					if p > 0 then
						e := rq_uri.index_of ('#', p + 1)
						if e = 0 then
							e := rq_uri.count
						else
							e := e - 1
						end
						s := rq_uri.substring (p+1, e)
					end
				end
				vars := urlencoded_parameters (s)
				vars.compare_objects
				internal_query_parameters_table := vars
			end
			Result := vars
		end

	urlencoded_parameters (a_content: detachable READABLE_STRING_8): HASH_TABLE_EX [WSF_VALUE, READABLE_STRING_GENERAL]
			-- Import `a_content'
		local
			n, p, i, j: INTEGER
			s: READABLE_STRING_8
			l_name, l_value: READABLE_STRING_8
		do
			if a_content = Void then
				create Result.make_with_key_tester (0, string_equality_tester)
			else
				n := a_content.count
				if n = 0 then
					create Result.make_with_key_tester (0, string_equality_tester)
				else
					create Result.make_with_key_tester (3, string_equality_tester) --| 3 = arbitrary value
					from
						p := 1
					until
						p = 0
					loop
						i := a_content.index_of ('&', p)
						if i = 0 then
							s := a_content.substring (p, n)
							p := 0
						else
							s := a_content.substring (p, i - 1)
							p := i + 1
						end
						if not s.is_empty then
							j := s.index_of ('=', 1)
							if j > 0 then
								l_name := s.substring (1, j - 1)
								l_value := s.substring (j + 1, s.count)
								add_value_to_table (l_name, l_value, Result)
							end
						end
					end
				end
			end
		end

feature -- Form fields and related

	form_parameters: ITERABLE [WSF_VALUE]
		do
			Result := form_parameters_table
		end

	form_parameter (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Field for name `a_name'.
		do
			Result := form_parameters_table.item (a_name)
		end

	has_uploaded_file: BOOLEAN
			-- Has any uploaded file?
		do
				-- Be sure, the `form_parameters' are already processed
			get_form_parameters

			Result := not uploaded_files_table.is_empty
		end

	uploaded_files: ITERABLE [WSF_UPLOADED_FILE]
			-- uploaded files values
			--| filename: original path from the user
			--| type: content type
			--| tmp_name: path to temp file that resides on server
			--| tmp_base_name: basename of `tmp_name'
			--| error: if /= 0 , there was an error : TODO ...
			--| size: size of the file given by the http request
		do
				-- Be sure, the `form_parameters' are already processed
			get_form_parameters

				-- return uploaded files table
			Result := uploaded_files_table
		end

feature -- Access: MIME handler

	has_mime_handler (a_content_type: HTTP_CONTENT_TYPE): BOOLEAN
			-- Has a MIME handler registered for `a_content_type'?
		do
			if attached mime_handlers as hdls then
				from
					hdls.start
				until
					hdls.after or Result
				loop
					Result := hdls.item_for_iteration.valid_content_type (a_content_type)
					hdls.forth
				end
			end
		end

	register_mime_handler (a_handler: WSF_MIME_HANDLER)
			-- Register `a_handler' for `a_content_type'
		local
			hdls: like mime_handlers
		do
			hdls := mime_handlers
			if hdls = Void then
				create hdls.make (3)
				hdls.compare_objects
				mime_handlers := hdls
			end
			hdls.force (a_handler)
		end

	mime_handler (a_content_type: HTTP_CONTENT_TYPE): detachable WSF_MIME_HANDLER
			-- Mime handler associated with `a_content_type'
		do
			if attached mime_handlers as hdls then
				from
					hdls.start
				until
					hdls.after or Result /= Void
				loop
					Result := hdls.item_for_iteration
					if not Result.valid_content_type (a_content_type) then
						Result := Void
					end
					hdls.forth
				end
			end
		ensure
			has_mime_handler_implies_attached: has_mime_handler (a_content_type) implies Result /= Void
		end

feature {NONE} -- Implementation: MIME handler

	init_mime_handlers
		do
			register_mime_handler (create {WSF_MULTIPART_FORM_DATA_HANDLER}.make)
			register_mime_handler (create {WSF_APPLICATION_X_WWW_FORM_URLENCODED_HANDLER})
		end

	mime_handlers: detachable ARRAYED_LIST [WSF_MIME_HANDLER]
			-- Table of mime handles

feature {NONE} -- Form fields and related

	uploaded_files_table: HASH_TABLE_EX [WSF_UPLOADED_FILE, READABLE_STRING_GENERAL]

	get_form_parameters
			-- Variables sent by POST, ... request	
		local
			vars: like internal_form_data_parameters_table
			l_raw_data_cell: detachable CELL [detachable STRING_8]
			l_type: like content_type
		do
			vars := internal_form_data_parameters_table
			if vars = Void then
				if not is_chunked_input and content_length_value = 0 then
					create vars.make_with_key_tester (0, string_equality_tester)
					vars.compare_objects
				else
					if raw_input_data_recorded then
						create l_raw_data_cell.put (Void)
					end
					create vars.make_with_key_tester (5, string_equality_tester)
					vars.compare_objects

					l_type := content_type
					if l_type /= Void and then attached mime_handler (l_type) as hdl then
						hdl.handle (l_type, Current, vars, l_raw_data_cell)
					end
					if l_raw_data_cell /= Void and then attached l_raw_data_cell.item as l_raw_data then
						-- What if no mime handler is associated to `l_type' ?
						set_raw_input_data (l_raw_data)
					end
				end
				internal_form_data_parameters_table := vars
			end
		ensure
			internal_form_data_parameters_table /= Void
		end

	form_parameters_table: HASH_TABLE_EX [WSF_VALUE, READABLE_STRING_GENERAL]
			-- Variables sent by POST request	
		local
			vars: like internal_form_data_parameters_table
		do
			get_form_parameters
			vars := internal_form_data_parameters_table
			if vars = Void then
				check form_parameters_already_retrieved: False end
				create vars.make_with_key_tester (0, string_equality_tester)
			end
			Result := vars
		end

feature {NONE} -- Implementation: smart parameter identification		

	add_value_to_table (a_name: READABLE_STRING_8; a_value: READABLE_STRING_8; a_table: HASH_TABLE [WSF_VALUE, READABLE_STRING_GENERAL])
			-- Add urlencoded parameter  `a_name'=`a_value' to `a_table'
			-- following smart computation such as handling the "..[..]" as table
		local
			v: detachable WSF_VALUE
			n, k, r: STRING_8
			k32: STRING_32
			p, q: INTEGER
			tb, ptb: detachable WSF_TABLE
		do
			--| Check if this is a list format such as   choice[]  or choice[a] or even choice[a][] or choice[a][b][c]...
			p := a_name.index_of ('[', 1)
			if p > 0 then
				q := a_name.index_of (']', p + 1)
				if q > p then
					n := a_name.substring (1, p - 1)
					r := a_name.substring (q + 1, a_name.count)
					r.left_adjust; r.right_adjust

					create tb.make (n)
					if a_table.has_key (tb.name) and then attached {WSF_TABLE} a_table.found_item as l_existing_table then
						tb := l_existing_table
					end

					k := a_name.substring (p + 1, q - 1)
					k.left_adjust; k.right_adjust
					if k.is_empty then
						k.append_integer (tb.count + 1)
					end
					v := tb
					create n.make_from_string (n)
					n.append_character ('[')
					n.append (k)
					n.append_character (']')

					from
					until
						r.is_empty
					loop
						ptb := tb
						p := r.index_of ({CHARACTER_8} '[', 1)
						if p > 0 then
							q := r.index_of ({CHARACTER_8} ']', p + 1)
							if q > p then
								k32 := url_encoder.decoded_string (k)
								if attached {WSF_TABLE} ptb.value (k32) as l_tb_value then
									tb := l_tb_value
								else
									create tb.make (n)
									ptb.add_value (tb, k32)
								end

								k := r.substring (p + 1, q - 1)
								r := r.substring (q + 1, r.count)
								r.left_adjust; r.right_adjust
								if k.is_empty then
									k.append_integer (tb.count + 1)
								end
								n.append_character ('[')
								n.append (k)
								n.append_character (']')
							end
						else
							r.wipe_out
							--| Ignore bad value
						end
					end
					tb.add_value (new_string_value (n, a_value), k)
				else
					--| Missing end bracket
				end
			end
			if v = Void then
				v := new_string_value (a_name, a_value)
			end
			if a_table.has_key (v.name) and then attached a_table.found_item as l_existing_value then
				if tb /= Void then
					--| Already done in previous part
				elseif attached {WSF_MULTIPLE_STRING} l_existing_value as l_multi then
					l_multi.add_value (v)
				elseif attached {WSF_TABLE} l_existing_value as l_table then
					-- Keep previous values (most likely we have table[1]=foo, table[2]=bar ..and table=/foo/bar
					-- Anyway for this case, we keep the previous version, and ignore this "conflict"
				else
					a_table.force (create {WSF_MULTIPLE_STRING}.make_with_array (<<l_existing_value, v>>), v.name)
					check replaced: a_table.found and then a_table.found_item ~ l_existing_value end
				end
			else
				a_table.force (v, v.name)
			end
		end

feature -- Uploaded File Handling

	is_uploaded_file (a_filename: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_filename' a file uploaded via HTTP Form
		local
			l_files: like uploaded_files_table
		do
			l_files := uploaded_files_table
			if not l_files.is_empty then
				from
					l_files.start
				until
					l_files.after or Result
				loop
					if attached l_files.item_for_iteration.tmp_name as l_tmp_name and then l_tmp_name.same_string_general (a_filename) then
						Result := True
					end
					l_files.forth
				end
			end
		end

feature -- URL Utility

	server_url: STRING
			-- Server url, as http://example.com:8080
		local
			s: like internal_server_url
			p: like server_port
		do
			s := internal_server_url
			if s = Void then
				if
					server_protocol.count >= 5 and then
					server_protocol.substring (1, 5).is_case_insensitive_equal ("https")
				then
					create s.make_from_string ("https://")
				else
					create s.make_from_string ("http://")
				end
				s.append (server_name)
				p := server_port
				if p > 0 then
					s.append_character (':')
					s.append_integer (p)
				end
			end
			Result := s
		end

	absolute_script_url (a_path: STRING): STRING
			-- Absolute Url for the script if any, extended by `a_path'
		do
			Result := script_url (a_path)
			Result.prepend (server_url)
		end

	script_url (a_path: STRING): STRING
			-- Url relative to script name if any, extended by `a_path'
		local
			l_base_url: like internal_url_base
			i,m,n,spos: INTEGER
			l_rq_uri: like request_uri
		do
			l_base_url := internal_url_base
			if l_base_url = Void then
				if attached script_name as l_script_name then
					l_rq_uri := request_uri
					if l_rq_uri.starts_with (l_script_name) then
						l_base_url := l_script_name
					else
						--| Handle Rewrite url engine, to have clean path
						from
							i := 1
							m := l_rq_uri.count
							n := l_script_name.count
						until
							i > m or i > n or l_rq_uri[i] /= l_script_name[i]
						loop
							if l_rq_uri[i] = '/' then
								spos := i
							end
							i := i + 1
						end
						if i > 1 then
							if l_rq_uri[i-1] = '/' then
								i := i -1
							elseif spos > 0 then
								i := spos
							end
							spos := l_rq_uri.substring_index (path_info, i)
							if spos > 0 then
								l_base_url := l_rq_uri.substring (1, spos - 1)
							else
								l_base_url := l_rq_uri.substring (1, i - 1)
							end
						end
					end
				end
				if l_base_url = Void then
					create l_base_url.make_empty
				end
				internal_url_base := l_base_url
			end
			create Result.make_from_string (l_base_url)
			Result.append (a_path)
		end

feature {NONE} -- Implementation: URL Utility

	internal_server_url: detachable like server_url
			-- Server url

	internal_url_base: detachable STRING
			-- URL base of potential script	

feature -- Element change

	set_raw_input_data_recorded (b: BOOLEAN)
			-- Set `raw_input_data_recorded' to `b'
		do
			raw_input_data_recorded := b
		end

	set_error_handler (ehdl: like error_handler)
			-- Set `error_handler' to `ehdl'
		do
			error_handler := ehdl
		end

feature {WSF_MIME_HANDLER} -- Temporary File handling

	delete_uploaded_file (uf: WSF_UPLOADED_FILE)
			-- Delete file `a_filename'
		require
			uf_valid: uf /= Void
		local
			f: RAW_FILE
		do
			if uploaded_files_table.has_item (uf) then
				if attached uf.tmp_name as fn then
					create f.make (fn)
					if f.exists and then f.is_writable then
						f.delete
					else
						error_handler.add_custom_error (0, "Can not delete uploaded file", "Can not delete file %""+ fn +"%"")
					end
				else
					error_handler.add_custom_error (0, "Can not delete uploaded file", "Can not delete uploaded file %""+ uf.name +"%" Tmp File not found")
				end
			else
				error_handler.add_custom_error (0, "Not an uploaded file", "This file %""+ uf.name +"%" is not an uploaded file.")
			end
		end

	save_uploaded_file (a_up_file: WSF_UPLOADED_FILE; a_content: STRING)
			-- Save uploaded file content to `a_filename'
		local
			bn: STRING
			l_safe_name: STRING
			f: RAW_FILE
			dn: STRING
			fn: FILE_NAME
			d: DIRECTORY
			n: INTEGER
			rescued: BOOLEAN
		do
			if not rescued then
				if attached uploaded_file_path as p then
					dn := p
				else
					-- FIXME: should it be configured somewhere?
					dn := (create {EXECUTION_ENVIRONMENT}).current_working_directory
				end
				create d.make (dn)
				if d.exists and then d.is_writable then
					l_safe_name := a_up_file.safe_filename
					from
						create fn.make_from_string (dn)
						bn := "EWF_tmp-" + l_safe_name
						fn.set_file_name (bn)
						create f.make (fn.string)
						n := 0
					until
						not f.exists
						or else n > 1_000
					loop
						n := n + 1
						fn.make_from_string (dn)
						bn := "EWF_tmp-" + n.out + "-" + l_safe_name
						fn.set_file_name (bn)
						f.make (fn.string)
					end

					if not f.exists or else f.is_writable then
						a_up_file.set_tmp_name (f.name)
						a_up_file.set_tmp_basename (bn)
						f.open_write
						f.put_string (a_content)
						f.close
					else
						a_up_file.set_error (-1)
					end
				else
					error_handler.add_custom_error (0, "Directory not writable", "Can not create file in directory %""+ dn +"%"")
				end
				uploaded_files_table.force (a_up_file, a_up_file.name)
			else
				a_up_file.set_error (-1)
			end
		rescue
			rescued := True
			retry
		end

feature {WSF_REQUEST_EXPORTER} -- Settings

	uploaded_file_path: detachable READABLE_STRING_8
			-- Optional folder path used to store uploaded files

	set_uploaded_file_path (p: like uploaded_file_path)
			-- Set `uploaded_file_path' to `p'.
		require
			path_exists: p /= Void implies (create {DIRECTORY}.make (p)).exists
		do
			uploaded_file_path := p
		end

feature {NONE} -- Internal value

	internal_query_parameters_table: detachable like query_parameters_table
			-- cached value for `query_parameters'

	internal_form_data_parameters_table: detachable like form_parameters_table
			-- cached value for `form_fields'

	internal_cookies_table: detachable like cookies_table
			-- cached value for `cookies'

feature {NONE} -- Implementation

	report_bad_request_error (a_message: detachable STRING)
			-- Report error
		local
			e: WSF_ERROR
		do
			create e.make ({HTTP_STATUS_CODE}.bad_request)
			if a_message /= Void then
				e.set_message (a_message)
			end
			error_handler.add_error (e)
		end

	analyze
			-- Extract relevant meta parameters
		local
			s: detachable READABLE_STRING_8
		do
			s := request_uri
			if s.is_empty then
				report_bad_request_error ("Missing URI")
			end
			if not has_error then
				s := request_method
				if s.is_empty then
					report_bad_request_error ("Missing request method")
				end
			end
			if not has_error then
				s := http_host
				if s = Void or else s.is_empty then
					report_bad_request_error ("Missing host header")
				end
			end
		end

feature {NONE} -- Implementation: utilities	

	string_equality_tester: STRING_EQUALITY_TESTER

	single_slash_starting_string (s: READABLE_STRING_32): STRING_32
			-- Return the string `s' (or twin) with one and only one starting slash
		local
			i, n: INTEGER
		do
			n := s.count
			if n > 1 then
				if s[1] /= '/' then
					create Result.make (1 + n)
					Result.append_character ('/')
					Result.append (s)
				elseif s[2] = '/' then
					--| We need to remove all starting slash, except one
					from
						i := 3
					until
						i > n
					loop
						if s[i] /= '/' then
							n := 0 --| exit loop
						else
							i := i + 1
						end
					end
					n := s.count
					check i >= 2 and i <= n end
					Result := s.substring (i - 1, s.count)
				else
					--| starts with one '/' and only one		
					Result := s
				end
			elseif n = 1 then
				if s[1] = '/' then
					Result := s
				else
					create Result.make (2)
					Result.append_character ('/')
					Result.append (s)
				end
			else --| n = 0
				create Result.make_filled ('/', 1)
			end
		ensure
			one_starting_slash: Result[1] = '/' and (Result.count = 1 or else Result[2] /= '/')
		end

	new_string_value (a_name: READABLE_STRING_8; a_value: READABLE_STRING_8): WSF_STRING
		do
			create Result.make (a_name, a_value)
		end

	empty_string: READABLE_STRING_32
			-- Reusable empty string

	raw_url_encoder: URL_ENCODER
		once
			create {URL_ENCODER} Result
		end

	url_encoder: URL_ENCODER
		once
			create {UTF8_URL_ENCODER} Result
		end

	date_time_utilities: HTTP_DATE_TIME_UTILITIES
			-- Utilities classes related to date and time.
		once
			create Result
		end

invariant
	empty_string_unchanged: empty_string.is_empty
	wgi_request.content_type /= Void implies content_type /= Void

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
