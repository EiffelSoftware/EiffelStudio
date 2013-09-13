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
		do
			timeout := 5
			connect_timeout := 1
			max_redirects := 5
			set_basic_auth_type
		end

	initialize
		deferred
		end

feature -- Basic operation

	url (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): STRING_8
			-- Url computed from Current and `ctx' data.
		local
			s: STRING_8
			url_encoder: URL_ENCODER
		do
			Result := base_url + a_path
			if ctx /= Void then
				create s.make_empty
				create url_encoder
				across
					ctx.query_parameters as q
				loop
					if not s.is_empty then
						s.append_character ('&')
					end
					s.append (url_encoder.encoded_string (q.key))
					s.append_character ('=')
					s.append (url_encoder.encoded_string (q.item))
				end
				if not s.is_empty then
					Result.append_character ('?')
					Result.append (s)
				end
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
		deferred
		end

	head (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- Response for HEAD request based on Current, `a_path' and `ctx'.
		deferred
		end

	post (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Response for POST request based on Current, `a_path' and `ctx'
			-- with input `data'	
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
		deferred
		end

	patch_file (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Response for PATCH request based on Current, `a_path' and `ctx'
			-- with uploaded data file `fn'	
		deferred
		end

	put (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Response for PUT request based on Current, `a_path' and `ctx'
			-- with input `data'	
		deferred
		end

	put_file (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Response for PUT request based on Current, `a_path' and `ctx'
			-- with uploaded file `fn'	
		deferred
		end

	delete (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- Response for DELETE request based on Current, `a_path' and `ctx'
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
			-- HTTP transaction timeout in seconds. Defaults to 5 seconds.

	connect_timeout: INTEGER
			-- HTTP connection timeout in seconds. Defaults to 1 second.

	max_redirects: INTEGER
    		-- Maximum number of times to follow redirects.
			-- Set to 0 to disable and -1 to follow all redirects. Defaults to 5.

	ignore_content_length: BOOLEAN
			-- Does this session ignore Content-Size headers?

	buffer_size: NATURAL
			-- Set the buffer size for request. This option will
			-- only be set if buffer_size is positive

	default_response_charset: detachable READABLE_STRING_8
			-- Default encoding of responses. Used if no charset is provided by the host.

	is_insecure: BOOLEAN
			-- Allow connections to SSL sites without certs

	proxy: detachable TUPLE [host: READABLE_STRING_8; port: INTEGER]
			-- Proxy information [`host' and `port']

feature -- Access

	base_url: READABLE_STRING_8
			-- Base URL for any request created by Current session.

	headers: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- Headers common to any request created by Current session.

feature -- Authentication

	auth_type: STRING
    		-- Set the authentication type for the request.
			-- Types: "basic", "digest", "any"

	auth_type_id: INTEGER
			-- See {HTTP_CLIENT_CONSTANTS}.Auth_type_*

	username,
	password: detachable READABLE_STRING_32

	credentials: detachable READABLE_STRING_32


feature -- Status setting

	set_is_debug (b: BOOLEAN)
		do
			is_debug := b
		end

feature -- Element change

	set_base_url (u: like base_url)
		do
			base_url := u
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

	set_credentials (u: like username; p: like password)
		do
			username := u
			password := p
			if u /= Void and p /= Void then
				credentials := u + ":" + p
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

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
