note
	description: "Summary description for {XH_REQUEST_BUILDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XH_REQUEST_BUILDER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Access

feature -- Basic operations

	create_goto_request (a_url: STRING; a_previous_request: XH_REQUEST): XH_REQUEST
			-- Creates a goto request
		require
			not_a_url_is_detached_or_empty: a_url /= Void and then not a_url.is_empty
			a_previous_request_attached: a_previous_request /= Void
		local
			l_parser: XH_REQUEST_PARSER
			l_temp: STRING
		do
			create Result.make_empty
			create l_parser.make

			l_temp := a_previous_request.method + " " + a_url + " " + a_previous_request.request_message.split (' ').i_th (3)
			if attached {XH_REQUEST} l_parser.request (l_temp) as l_rec then
				Result := l_rec
			end
		ensure
			result_attached: Result /= Void
		end



--		make_goto_request (a_uri: STRING; a_previous_request: XH_REQUEST)
--			-- Replaces the uri in the previous request and
--		require
--			not_a_uri_is_detached_or_empty: a_uri /= Void and then not a_uri.is_empty
--			a_previous_request_has_headers_in: a_previous_request /= Void and then a_previous_request.request_message.has_substring (Key_headers_in)
--		local
--			l_i: INTEGER
--		do
--			make_empty
--			l_i := a_previous_request.request_message.substring_index (Key_headers_in, 1)
--			make_from_message ("GET " + escape_bad_chars (a_uri) + " HTTP/1.1"
--					 + a_previous_request.request_message.substring (l_i, a_previous_request.request_message.count))
--		ensure
--			the_request_attached: the_request /= Void
--			target_uri_attached: target_uri /= Void
--			request_message_attached: request_message /= Void
--			arguments_attached: arguments /= Void
--			cookies_attached: cookies/= Void
--			environment_vars_attached: environment_vars /= Void
--			arguments_attached: arguments /= Void
--	--		content_type_attached: content_type /= Void
--		end


end
