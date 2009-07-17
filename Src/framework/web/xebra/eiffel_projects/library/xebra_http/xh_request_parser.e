note
	description: "[
		Parses request message and generates a request.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_REQUEST_PARSER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Basic Operations

	request (a_request_message: STRING): detachable XH_REQUEST
			-- Returns a XH_REQUEST if the message could be parsed successfully
		require
			not_a_request_message_is_detached_or_empty: a_request_message /= Void and then not a_request_message.is_empty
		local
			l_result: PEG_PARSER_RESULT
		do
			l_result := parser.parse (create {PEG_PARSER_STRING}.make_from_string (a_request_message))
			if l_result.error_messages.count > 0 or l_result.left_to_parse.count > 0 then
				from
					l_result.error_messages.start
				until
					l_result.error_messages.after
				loop
					print (l_result.error_messages.item)
					l_result.error_messages.forth
				end

			else
				if attached {XH_REQUEST} l_result.internal_result.first as l_rec then
					l_rec.set_request_message (a_request_message)
					Result := l_rec
				end
			end
		end


feature {NONE} -- Parser

	parser: PEG_ABSTRACT_PEG
			-- Creates the parser
		local
			the_request,
			header,
			headers_in ,
			headers_out ,
			subprocess_environment_vars ,
			table_entry ,
			key_get,
			key_post,
			key_http ,
			key_space,
			key_hi,
			key_ho,
			key_end,
			key_se,
			key_t_name,
			key_t_value,
			key_arg,
			url,
			item_name,
			arg_name,
			item_value,
			arg_value,
			any,
			key_method,
			args: PEG_ABSTRACT_PEG
			l_parser_result: PEG_PARSER_RESULT
		once
				-- Special
			create {PEG_ANY} any.make
			any.ommit_result

				-- Constants
			key_method := (stringp ({XU_CONSTANTS}.request_method_get) | stringp ({XU_CONSTANTS}.request_method_post)).consumer
			key_method.fixate

			key_http := stringp ({XU_CONSTANTS}.request_http11) | stringp ({XU_CONSTANTS}.request_http10)
			key_http.fixate
			key_space := stringp ({XU_CONSTANTS}.request_space)
			key_hi := stringp ({XU_CONSTANTS}.request_hi)
			key_ho := stringp ({XU_CONSTANTS}.request_ho)
			key_end := stringp ({XU_CONSTANTS}.request_end)
			key_se := stringp ({XU_CONSTANTS}.request_se)
			key_t_name := stringp ({XU_CONSTANTS}.request_t_name)
			key_t_value := stringp ({XU_CONSTANTS}.request_t_value)
			key_arg := stringp ({XU_CONSTANTS}.request_arg)

				-- User fields
			args := (-any).consumer
			url := (-(key_space.negate + any)).consumer
			item_name := (-(key_t_value.negate + any)).consumer
			item_value := (-((key_t_name.negate + key_end.negate) + any)).consumer


				-- Structure
			table_entry := key_t_name + item_name + key_t_value + item_value
			table_entry.set_behaviour (agent build_table_item)
			table_entry.fixate
			headers_in := key_hi + (-table_entry) + key_end
			headers_in.set_behaviour (agent build_table)
			headers_in.fixate
			headers_out := key_ho + (-table_entry) + key_end
			headers_out.set_behaviour (agent build_table)
			headers_out.fixate
			subprocess_environment_vars := key_se + (-table_entry) + key_end
			subprocess_environment_vars.set_behaviour (agent build_table)
			subprocess_environment_vars.fixate

			header :=  key_method + key_space + url + key_space + key_http
			header.fixate

			the_request := header + headers_in + headers_out + subprocess_environment_vars + key_arg + args
			the_request.set_behaviour (agent build_request)
			Result := the_request
		ensure
			result_attached: Result /= Void
		end


	build_request (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a request
			-- REQUEST = method url HEADERS_IN HEADERS_OUT SUBPROCESS_ENVIRONMENT_VARS ARGS
		require
			a_result_attached: attached a_result
		local
			l_request: XH_REQUEST
		do
			Result := a_result
			create l_request.make_empty

			if attached {STRING} a_result.internal_result [1] as l_method then
				l_request.set_method (l_method)
			else
				a_result.put_error_message ("Missing method")
			end

			if attached {STRING} a_result.internal_result [2] as l_target_uri then
				l_request.set_target_uri (l_target_uri)
			else
				a_result.put_error_message ("Missing url")
			end

			if attached {HASH_TABLE [STRING, STRING]} a_result.internal_result [3] as l_headers_in then
				l_request.set_headers_in (l_headers_in)
			else
				a_result.put_error_message ("Missing HEADERS_IN")
			end

			if attached {HASH_TABLE [STRING, STRING]} a_result.internal_result [4] as l_headers_out then
				l_request.set_headers_out (l_headers_out)
			else
				a_result.put_error_message ("Missing HEADERS_OUT")
			end

			if attached {HASH_TABLE [STRING, STRING]} a_result.internal_result [5] as l_subprocess_environment_vars then
				l_request.set_environment_vars (l_subprocess_environment_vars)
			else
				a_result.put_error_message ("Missing SUBPROCESS_ENVIRONMENT_VARS")
			end

			if attached {STRING} Result.internal_result [6] as l_args then
				l_request.set_args (l_args)
			else
				Result.put_error_message ("Missing ARGS")
			end

			Result.replace_result (l_request)
		ensure
			Result_attached: attached Result
		end


	build_table_item (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a name value tuple
			-- TABLE_ENTRY =  item_name  item_value;

		require
			a_result_attached: attached a_result
		local
			l_item: TUPLE [name: STRING; value: STRING]
		do
			Result := a_result
			if attached {STRING} a_result.internal_result [1] as l_name and
				attached {STRING} a_result.internal_result [2] as l_value then
					Result.replace_result ([l_name, l_value])
			end
		ensure
			Result_attached: attached Result
		end

	build_table (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a hash table
			-- TABLE = {TABLE_ENTRIES}
		require
			a_result_attached: attached a_result
		local
			l_table_args: HASH_TABLE [STRING, STRING]
		do
			Result := a_result
			create l_table_args.make (a_result.internal_result.count)
			from
				a_result.internal_result.start
			until
				a_result.internal_result.after
			loop
				if attached {TUPLE [name: STRING; value: STRING]} a_result.internal_result.item as l_arg then
					l_table_args.put (l_arg.value, l_arg.name)
				end
				a_result.internal_result.forth
			end
			Result.replace_result (l_table_args)
		ensure
			Result_attached: attached Result
		end


	stringp (a_string: STRING): PEG_SEQUENCE
			-- Generates a parser which parses `a_string'
		require
			a_string_valid: attached a_string and then not a_string.is_empty
		local
			l_i: INTEGER
		do
			create Result.make
			from
				l_i := 1
			until
				l_i > a_string.count
			loop
				Result := Result + char (a_string [l_i])
				l_i := l_i + 1
			end
			Result.fixate
		ensure
			Result_attached: attached Result
		end

	char (a_char: CHARACTER): PEG_CHARACTER
			-- Generates  Character Parser
		require
			a_char_attached: attached a_char
		do
			create Result.make_with_character (a_char)
			Result.ommit_result
		ensure
			Result_attached: attached Result
		end

end
