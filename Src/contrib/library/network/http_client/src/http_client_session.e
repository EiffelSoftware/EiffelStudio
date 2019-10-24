note
	description : "[
				HTTP_CLIENT_SESSION represents a session
				and is used to call get, post, .... request
				with predefined settings such as 
					base_url
					specific common headers
					timeout and so on ...
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTP_CLIENT_SESSION

inherit
	ANY

	HTTP_CLIENT_CONSTANTS
		rename
			auth_type_id as auth_type_id_from_string
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_base_url: READABLE_STRING_8)
			-- Initialize `Current'.
		do
			set_defaults
			create headers.make (3)

			base_url := a_base_url
			initialize
		end

	set_defaults
			-- Set default settings.
		do
			timeout := 0 --| never timeout
			connect_timeout := 0 --| never timeout
			max_redirects := 5
			set_basic_auth_type
		end

	initialize
		deferred
		end

feature -- Basic operation

	close
			-- Close session.
			--| useful to disconnect persistent connection.
		do
		end

feature -- Access

	url (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): STRING_8
			-- Url computed from Current and `ctx' data.
		do
			if is_absolute_url (a_path) then
					-- Is Absolute url
				Result := a_path
			else
				Result := base_url + a_path
			end
			if ctx /= Void then
				ctx.append_query_parameters_to_url (Result)
			end
		end

	is_absolute_url (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `s` represent an absolute url?
		local
			i, pos: INTEGER
			sch: READABLE_STRING_GENERAL
		do
			pos := s.substring_index ("://", 1)
			if pos > 0 then
				sch := s.head (pos - 1)
				if not sch.is_whitespace then
					from
						i := 1
						Result := True
					until
						not Result or i > sch.count
					loop
						Result := sch[i].is_alpha_numeric
						i := i + 1
					end
				end
			end
		end

feature {NONE} -- Access: verbose

	verbose_mode: INTEGER
			-- Internal verbose mode.	

	verbose_header_sent_mode: INTEGER = 1 		--| 0001
	verbose_header_received_mode: INTEGER = 2 	--| 0010
	verbose_debug_mode: INTEGER = 4 			--| 0100

feature -- Access: verbose

	is_header_sent_verbose: BOOLEAN
		do
			Result := verbose_mode & verbose_header_sent_mode = verbose_header_sent_mode
		end

	is_header_received_verbose: BOOLEAN
		do
			Result := verbose_mode & verbose_header_received_mode = verbose_header_received_mode
		end

	is_debug_verbose: BOOLEAN
		do
			Result := verbose_mode & verbose_debug_mode = verbose_debug_mode
		end

feature -- Element change: verbose

	set_header_sent_verbose (b: BOOLEAN)
		do
			if b then
				verbose_mode := verbose_mode | verbose_header_sent_mode
			else
				verbose_mode := verbose_mode & verbose_header_sent_mode.bit_not
			end
		end

	set_header_received_verbose (b: BOOLEAN)
		do
			if b then
				verbose_mode := verbose_mode | verbose_header_received_mode
			else
				verbose_mode := verbose_mode & verbose_header_received_mode.bit_not
			end
		end

	set_debug_verbose (b: BOOLEAN)
		do
			if b then
				verbose_mode := verbose_mode | verbose_debug_mode
			else
				verbose_mode := verbose_mode & verbose_debug_mode.bit_not
			end
		end

feature -- Custom		

	custom (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- Response for `a_method' request based on Current, `a_path' and `ctx'.	
		deferred
		end

feature -- Helper		

	get (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- Response for GET request based on Current, `a_path' and `ctx'.
		require
			is_available: is_available
		deferred
		end

	head (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- Response for HEAD request based on Current, `a_path' and `ctx'.
		require
			is_available: is_available
		deferred
		end

	post (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Response for POST request based on Current, `a_path' and `ctx'
			-- with input `data'	
		require
			is_available: is_available
		deferred
		end

	post_file (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Response for POST request based on Current, `a_path' and `ctx'
			-- with uploaded data file `fn'	
		deferred
		end

	patch (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Response for PATCH request based on Current, `a_path' and `ctx'
			-- with input `data'	
		require
			is_available: is_available
		deferred
		end

	patch_file (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Response for PATCH request based on Current, `a_path' and `ctx'
			-- with uploaded data file `fn'	
		require
			is_available: is_available
		deferred
		end

	put (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Response for PUT request based on Current, `a_path' and `ctx'
			-- with input `data'	
		require
			is_available: is_available
		deferred
		end

	put_file (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Response for PUT request based on Current, `a_path' and `ctx'
			-- with uploaded file `fn'	
		require
			is_available: is_available
		deferred
		end

	delete (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- Response for DELETE request based on Current, `a_path' and `ctx'
		require
			is_available: is_available
		deferred
		end

feature -- Status report

	is_debug: BOOLEAN
			-- Produce debug output

	is_available: BOOLEAN
			-- Is interface usable?
		deferred
		end

feature -- Settings

	timeout: INTEGER
			-- HTTP transaction timeout in seconds.
			-- Defaults to 0 second  i.e never timeout.

	connect_timeout: INTEGER
			-- HTTP connection timeout in seconds.
			-- Defaults to 0 second i.e never timeout.

	max_redirects: INTEGER
    		-- Maximum number of times to follow redirects.
			-- Set to 0 to disable and -1 to follow all redirects. Defaults to 5.

	ignore_content_length: BOOLEAN
			-- Does this session ignore Content-Size headers?

	buffer_size: NATURAL assign set_buffer_size
			-- Set the buffer size for request. This option will
			-- only be set if buffer_size > 0.

	chunk_size: NATURAL assign set_chunk_size
			-- Set the chunk size for request, when "Transfer-Encoding: chunked".
			-- This option will only be set if chunk_size > 0.

	default_response_charset: detachable READABLE_STRING_8
			-- Default encoding of responses. Used if no charset is provided by the host.

	is_insecure: BOOLEAN
			-- Allow connections to SSL sites without certs

	proxy: detachable TUPLE [host: READABLE_STRING_8; port: INTEGER]
			-- Proxy information [`host' and `port']

	secure_config: detachable HTTP_CLIENT_SECURE_CONFIG
			-- http client secure configuration.
			--| HTTPS usage with client certificates.

feature -- Access

	base_url: READABLE_STRING_8
			-- Base URL for any request created by Current session.

	headers: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- Headers common to any request created by Current session.

	cookie: detachable READABLE_STRING_8
			-- Cookie for the current base_url

feature -- Authentication

	auth_type: STRING
    		-- Set the authentication type for the request.
			-- Types: "basic", "digest", "any"

	auth_type_id: INTEGER
			-- See {HTTP_CLIENT_CONSTANTS}.Auth_type_*

	username: detachable READABLE_STRING_32
			-- Associated optional username value.

	password: detachable READABLE_STRING_32
			-- Associated optional password value.

	credentials: detachable READABLE_STRING_32
			-- Associated optional credentials value.
			-- Computed as `username':`password'.

	ciphers_setting: detachable READABLE_STRING_8
			-- SSL cipher preference lists
			-- examples: DEFAULT, ALL, TLSv1
			-- check https://www.openssl.org/docs/man1.1.0/apps/ciphers.html
			-- Warning: At the moment only used for LIB_CURL_HTTP_CLIENT
			--			Net implementation set all the ciphers using the OpenSSL at
			--			initialization time.

feature -- Status setting

	set_is_debug (b: BOOLEAN)
		do
			is_debug := b
		end

feature -- Element change

	set_base_url (u: like base_url)
		do
			base_url := u
			cookie := Void
		end

	set_cookie (a_cookie: detachable READABLE_STRING_8)
		do
			cookie := a_cookie
		end

	set_timeout (n_seconds: like timeout)
		do
			timeout := n_seconds
		end

	set_connect_timeout (n: like connect_timeout)
		do
			connect_timeout := n
		end

	set_user_agent (v: READABLE_STRING_8)
		do
			add_header ("User-Agent", v)
		end

	set_is_insecure (b: BOOLEAN)
		do
			is_insecure := b
		end

	add_header (k: READABLE_STRING_8; v: READABLE_STRING_8)
		do
			headers.force (v, k)
		end

	remove_header (k: READABLE_STRING_8)
		do
			headers.prune (k)
		end

	set_credentials (u,p: detachable READABLE_STRING_GENERAL)
		local
			s: STRING_32
		do
			if u = Void then
				username := Void
			else
				create {STRING_32} username.make_from_string_general (u)
			end
			if p = Void then
				password := Void
			else
				create {STRING_32} password.make_from_string_general (p)
			end
			if u /= Void and p /= Void then
				create s.make (u.count + 1 + p.count)
				s.append_string_general (u)
				s.append_character (':')
				s.append_string_general (p)
				credentials := s
			else
				credentials := Void
			end
		end

	set_auth_type (s: READABLE_STRING_8)
		do
			auth_type := s
			auth_type_id := auth_type_id_from_string (s)
		end

	set_basic_auth_type
		do
			auth_type := "basic"
			auth_type_id := Auth_type_basic
		end

	set_digest_auth_type
		do
			auth_type := "digest"
			auth_type_id := Auth_type_digest
		end

	set_any_auth_type
		do
			auth_type := "any"
			auth_type_id := Auth_type_any
		end

	set_anysafe_auth_type
		do
			auth_type := "anysafe"
			auth_type_id := Auth_type_anysafe
		end

	set_max_redirects (n: like max_redirects)
		do
			max_redirects := n
		end

	set_proxy (a_host: detachable READABLE_STRING_8; a_port: INTEGER)
		do
			if a_host = Void then
				proxy := Void
			else
				proxy := [a_host, a_port]
			end
		end

	set_buffer_size (a_size: like buffer_size)
		do
			buffer_size := a_size
		end

	set_chunk_size (a_size: like chunk_size)
		do
			chunk_size := a_size
		end

	set_ciphers_setting (a_ciphers_setting: READABLE_STRING_8)
			-- Set 'ciphers_setting' with 'a_ciphers_setting'.
		do
			create {STRING_8} ciphers_setting.make_from_string (a_ciphers_setting)
		ensure
			ciphers_setting_set: attached ciphers_setting as c_setting and then c_setting.same_string (a_ciphers_setting)
		end


	set_secure_config (a_config: like secure_config)
			-- Set 'secure_config' with 'a_config'.
		do
			secure_config := a_config
		ensure
			secure_config_set: secure_config = a_config
		end

note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
