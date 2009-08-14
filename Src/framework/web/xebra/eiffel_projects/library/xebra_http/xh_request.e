note
	description: "[
		The {REQUEST} object contains all data from a user request.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"
class
	XH_REQUEST

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Creates an empty request
		do
			uri := ""
			method := ""
			request_message := ""
			args := ""
			create environment_vars.make (1)
			create headers_out.make (1)
			create headers_in.make (1)
		ensure
			method_attached: method /= Void
			uri_attached: uri /= Void
			request_message_attached: request_message /= Void
			environment_vars_attached: environment_vars /= Void
			cookies_attached: cookies /= Void
			argument_table_attached: argument_table /= Void
		end

feature -- Access

	request_message: STRING
			-- The original request message

	method: STRING
			-- The method of the request, POST or GET

	is_post: BOOLEAN
			-- True if the method is POST
		do
			Result := method.is_equal ({XU_CONSTANTS}.Request_method_post)
		end

	is_get: BOOLEAN
			-- True if the method is GET
		do
			Result := method.is_equal ({XU_CONSTANTS}.Request_method_get)
		end

	uri: STRING
			-- The target uri

	headers_in: HASH_TABLE [STRING, STRING]
			-- Headers_in as provided by the http server

	headers_out: HASH_TABLE [STRING, STRING]
			-- Headers_out as provided by the http server	

	environment_vars: HASH_TABLE [STRING, STRING]
			-- Subprocess environment variables as provided by the http server		

	args: STRING
			-- The post or get arguments (as string)

	argument_table: HASH_TABLE [STRING, STRING]
			-- The arguments (post or get) represented as a table		
		do
			if args_changed then
				internal_argument_table := parse_argument_table
				args_changed := False
			end

			if attached internal_argument_table as l_iat then
				Result := l_iat
			else
				create Result.make (1)
			end
		ensure
			args_not_changed: args_changed = False
			internal_argument_table_attached: internal_argument_table /= Void
			result_attached: Result /= Void
		end

	cookies: HASH_TABLE [XH_COOKIE, STRING]
			-- The cookies (extracted from headers_in)		
		do
			if headers_in_changed then
				internal_cookies := parse_cookies
				headers_in_changed := False
			end

			if attached internal_cookies as l_ic then
				Result := l_ic
			else
				create Result.make (1)
			end
		ensure
			headers_in_not_changed: headers_in_changed = False
			internal_cookies_attached: internal_cookies /= Void
			result_attached: Result /= Void
		end


	is_form_encoded: BOOLEAN
			-- Checks if the headers_in contain 'application/x-www-form-urlencoded'
		do
			Result := False
			if attached {STRING} headers_in [{XU_CONSTANTS}.Request_content_type] as l_ct then
				if l_ct.is_equal ({XU_CONSTANTS}.Request_ct_form) then
					Result := True
				end
			end
		end


feature -- Status setting


	set_target_uri (a_target_uri: like uri)
			-- Sets the target uri.
		require
			not_a_target_uri_is_detached_or_empty: a_target_uri /= Void and then not a_target_uri.is_empty
		do
			uri := a_target_uri
		ensure
			target_uri_set: equal (uri, a_target_uri)
		end

	set_headers_in (a_headers_in: like headers_in)
			-- Sets the headers_in.
		require
			a_headers_attached: a_headers_in /= Void
		do
			headers_in := a_headers_in
			headers_in_changed := True
		ensure
			headers_in_set: equal (headers_in, a_headers_in)
		end

	set_headers_out (a_headers_out: like headers_out)
			-- Sets the headers_out.
		require
			a_headers_attached: a_headers_out /= Void
		do
			headers_out := a_headers_out
		ensure
			headers_out_set: equal (headers_out, a_headers_out)
		end

	set_environment_vars (a_environment_vars: like environment_vars)
			-- Sets the environment_vars.
		require
			a_environment_vars_attached: a_environment_vars /= Void
		do
			environment_vars := a_environment_vars
		ensure
			environment_vars_set: equal (environment_vars, a_environment_vars)
		end

	set_args (a_args: like args)
			-- Sets args. Also unescapes HTML special chars.
		require
			a_args_attached: a_args /= Void
		local
			l_escaper: XU_ESCAPER
		do
			create l_escaper
			args := l_escaper.unescape_html (a_args)
			args_changed := True
		end

	set_method (a_method: like method)
			-- Sets method.
		require
			a_method_attached: a_method /= Void
		do
			method := a_method
		ensure
			method_set: equal (method, a_method)
		end

	set_request_message (a_request_message: like request_message)
			-- Sets request_message.
		require
			a_request_message_attached: a_request_message /= Void
		do
			request_message := a_request_message
		ensure
			request_message_set: equal (request_message, a_request_message)
		end


feature -- Basic Operations

	call_pre_handler (a_form_handler: XH_FORM_HANDLER; a_response: XH_RESPONSE)
			-- Calls the right pre_handler on the servlet
		require
			a_form_handler_attached: a_form_handler /= Void
			a_response_attached: a_response /= Void
		do
			if method.is_equal ({XU_CONSTANTS}.Request_method_post) then
				a_form_handler.handle_form (Current, a_response)
			end
		end

feature {NONE} -- Internal

	headers_in_changed: BOOLEAN
			-- Is set to true whenever headers_in changes		

	internal_cookies: detachable like cookies

	parse_cookies: like cookies
			-- Retrives cookies that are stored in the headers_in table.
		local
			l_parser: XH_REQUEST_COOKIE_PARSER
		do
			create Result.make (1)
				-- Read the cookies
			if attached {STRING} headers_in ["Cookie"] as l_cookies_string then
				create l_parser.make
				if attached {like cookies} l_parser.cookie_table (l_cookies_string) as l_cookies then
					Result := l_cookies
				end

			end
		ensure
			result_attached: Result /= Void
		end

	args_changed: BOOLEAN
		-- Is set to true whenever args changes	

	internal_argument_table: detachable like argument_table

	parse_argument_table: like argument_table
			-- Retrives arguments as table.
		local
			l_parser: XH_REQUEST_ARG_TABLE_PARSER
		do
			create Result.make (1)
			if (method.is_equal ({XU_CONSTANTS}.Request_method_get) or is_form_encoded) and not args.is_empty then
				create l_parser.make
				if attached {like argument_table} l_parser.argument_table (args) as l_arg_table then
					Result := l_arg_table
				end
			end
		ensure
			result_attached: Result /= Void
		end


invariant
		target_uri_attached: uri /= Void
		request_message_attached: request_message /= Void
		environment_vars_attached: environment_vars /= Void
		method_attached: method /= Void
		valid_method: (method /= Void and then not method.is_empty) implies (method.is_equal ({XU_CONSTANTS}.Request_method_get) or method.is_equal ({XU_CONSTANTS}.Request_method_post))
end
