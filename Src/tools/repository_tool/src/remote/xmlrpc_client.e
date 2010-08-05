note
	description: "[
			Summary description for {XMLRPC_CLIENT}.
			cf: http://drupal.org/node/774298
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLRPC_CLIENT

create
	make

feature {NONE} -- Initialization

	make (a_domain: STRING; a_apikey: STRING; a_endpoint: STRING; a_verbose: BOOLEAN)
		do
			domain := a_domain
			apikey := a_apikey
			endpoint := a_endpoint
			verbose := a_verbose
			create session_id.make_empty
			initialize
		end

feature -- Access

	apikey: STRING

	domain: STRING

	endpoint: STRING

	verbose: BOOLEAN

	session_id: STRING

	url: STRING
		do
			Result := domain + endpoint
		end

feature -- Basic operation

	user_login (a_user: STRING; a_password: STRING)
		do
			send ("user.login", <<a_user, a_password>>)
			if not last_answer_is_fault then
				if attached last_answer as rep then
					if attached {XRPC_STRUCT} rep.value as l_struct then
						if attached {XRPC_STRING} l_struct.item ("sessid") as l_sessid_string then
							session_id := l_sessid_string.value
						end
					end
				end
			end
		end

	user_logout
		do
			send ("user.logout", Void)
		end

	close
		do
		end

	remote_call (a_method_name: STRING; a_params: detachable ARRAY [ANY])
		do
			send (a_method_name, a_params)
		end

	connect
		do
			send ("system.connect", Void)
			if attached last_answer as rep then
				if attached {XRPC_STRUCT} rep.value as l_struct then
					if
						l_struct.has_member ("sessid") and then
						attached {XRPC_STRING} l_struct.item ("sessid") as l_sessid_string
					then
						session_id := l_sessid_string.value
					end
				end
			end
		end

feature -- Query

	last_answer: detachable XRPC_RESPONSE

	last_answer_is_fault: BOOLEAN
		do
			if attached {XRPC_FAULT_RESPONSE} last_answer then
				Result := True
			end
		end

	last_fault_response: detachable XRPC_FAULT_RESPONSE
		do
			if attached {XRPC_FAULT_RESPONSE} last_answer as f then
				Result := f
			end
		end

	last_answer_as_string: STRING
		do
			if attached last_answer as l_answer then
				Result := answer_to_string (l_answer)
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Basic operation

	send (a_method_name: STRING; a_params: detachable ARRAY [ANY])
		require
			is_initialized: is_initialized
		local
			i,u: INTEGER
			xproxy: XRPC_PROXY
			protocol_args: ARRAY [ANY]
--			xe: XRPC_RESPONSE_XML_EMITTER
			l_timestamp: INTEGER_64
			l_nonce: like nonce
			l_sha_256: like sha_256
		do
			last_answer := Void
			if is_initialized then
				create xproxy.make (url)
				if a_method_name.same_string ("system.connect") then
					last_answer := xproxy.call (a_method_name, Void)
				else
					l_timestamp := timestamp
					l_nonce := nonce (10)
					l_sha_256 := hmac_sha_256 (apikey, l_timestamp.out + ";" + domain + ";" + l_nonce + ";" + a_method_name)
					if attached session_id as sessid then
						protocol_args := <<l_sha_256, domain, l_timestamp.out, l_nonce, sessid>>
					else
						protocol_args := <<l_sha_256, domain, l_timestamp.out, l_nonce, "">>
					end
					if a_params /= Void then
						u := protocol_args.upper
						protocol_args.conservative_resize_with_default (0, protocol_args.lower, u + a_params.count)
						from
							i := 1
						until
							i > a_params.count
						loop
							protocol_args.put (a_params[i], u + i)
							i := i + 1
						end
					end
					last_answer := xproxy.call (a_method_name, protocol_args)
				end
			end

--			if attached last_answer as rep then
--				create xe.make
--				xe.set_is_pretty_printed (True)
--				rep.visit (xe)
--				print (xe.xml)
--			end
		end

	answer_to_string (a: like last_answer): STRING
		require
			a_attached: a /= Void
		local
			xe: XRPC_RESPONSE_XML_EMITTER
		do
			create xe.make
			xe.set_is_pretty_printed (True)
			a.visit (xe)
			Result := xe.xml
		end

feature {NONE} -- Implementation

	hmac_sha_256 (a_key: STRING; a_message: STRING): STRING
		local
			h: HMAC_SHA256
		do
			create h.make_ascii_key (a_key)
			h.sink_string (a_message)
			h.finish
			Result := h.hmac.out_hex
		end

	sha_256 (s: STRING): STRING
		local
			l_sha_256: SHA256
		do
			create l_sha_256.make
			l_sha_256.sink_string (s)
			if attached l_sha_256.current_out as r then
				Result := r
			else
				Result := ""
			end
		end

	timestamp: INTEGER_64
			-- Current Unix time stamp.	
		do
			Result := ((create {DATE_TIME}.make_now_utc).relative_duration (epoch_datetime)).seconds_count
		end

	epoch_datetime: DATE_TIME
		once
			create Result.make (1970, 01, 01, 0,0,0)
		end

	nonce (n: INTEGER): STRING
			-- Similar to the 'user_password' function Drupal uses.
		local
			l_chars: STRING
			rand: RANDOM
			i, r: INTEGER
		do
			l_chars := "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789"
			from
				i := 1
				create Result.make (n)
				create rand.set_seed ((create {TIME}.make_now).fine_seconds.truncated_to_integer)
			until
				i > n - 1
			loop
				r := 1 + (l_chars.count * (rand.i_th (i) / rand.modulus)).truncated_to_integer
				Result.append_character (l_chars.item (r))
				i := i + 1
			end
			last_nonce_number := 1 + (last_nonce_number + 1 ) \\ l_chars.count
			Result.append_character (l_chars.item (last_nonce_number))
		end

	last_nonce_number: INTEGER

	is_initialized: BOOLEAN

	initialize
		do
			is_initialized := True
		end

end
