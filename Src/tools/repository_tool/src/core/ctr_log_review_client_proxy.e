note
	description: "Summary description for {CTR_LOG_REVIEW_CLIENT_PROXY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_LOG_REVIEW_CLIENT_PROXY

create
	make

feature {NONE} -- Initialization

	make (a_repo: like repository)
		do
			repository := a_repo
			if
				attached a_repo.review_variables as l_review_vars and then
				attached l_review_vars.item ("domain") as l_domain and then
				attached l_review_vars.item ("apikey") as l_apikey and then
				attached l_review_vars.item ("endpoint") as l_endpoint
			then
				create xmlrpc_client.make (l_domain, l_apikey, l_endpoint, False)
			else
				create xmlrpc_client.make ("", "", "", False)
			end
		end

	xmlrpc_client: XMLRPC_CLIENT

feature -- Basic operation

	is_connected: BOOLEAN

	connect
		do
			if not is_connected then
				reset
				xmlrpc_client.connect
				if attached {XRPC_FAULT_RESPONSE} xmlrpc_client.last_answer as l_fault then
					last_error_message := l_fault.message
					last_error := err_connection_trouble
				end
				is_connected := True
			end
		end

	disconnect
		do
			if is_connected then
				reset
				is_connected := False
			end
		end

	reset
		do
			last_error := 0
			last_error_message := Void
			is_connected := False
		end

	login
		local
			l_user: detachable XRPC_VALUE
		do
			xmlrpc_client.user_login (username, password)
			if xmlrpc_client.last_answer_is_fault then
				last_error := err_invalid_account
			else
				if attached xmlrpc_client.last_answer as rep then
					if attached {XRPC_STRUCT} rep.value as l_struct then
						l_user := l_struct.item ("user")
					end
				end
				if l_user = Void then
					last_error := err_invalid_account
				end
			end
		end

	logout
		do
			if is_connected then
				xmlrpc_client.user_logout
			end
		end

	submit (a_log: REPOSITORY_LOG; a_review: REPOSITORY_LOG_REVIEW)
		local
			i: INTEGER
			e: detachable REPOSITORY_LOG_REVIEW_ENTRY
			r: STRING
			l_user_name: like username
			l_struct: XRPC_STRUCT
			l_data: ARRAY [XRPC_VALUE]
		do
			l_user_name := username

			create r.make_empty
			r.append_string (a_log.id)
			r.append_character ('[')
			r.append_string (l_user_name)
			r.append_character (']')
			if
				attached a_review.user_local_entries (l_user_name, Void) as l_entries
			then
				create r.make (25)
				create l_data.make_filled (create {XRPC_DEFAULT_VALUE}, 1, l_entries.count)
				i := 1
				across
					l_entries as c
				loop
					e := c.item
					create l_struct.make
					l_struct.put (create {XRPC_STRING}.make (e.status), "status")
					r.append_character ('(')
					r.append_string (e.status)
					if attached e.comment as l_comment then
						r.append_character (':')
						r.append_string (l_comment)
						l_struct.put (create {XRPC_STRING}.make (l_comment), "comment")
					end
					r.append_character (')')
					r.append_character (' ')
					l_data.put (l_struct, i)
					i := i + 1
				end

				connect
				if not last_error_occurred then
					login
					if not last_error_occurred then
	--					xmlrpc_client.remote_call ("ise.ctr.log", <<a_log.id>>)
						xmlrpc_client.remote_call ("ise.ctr.post_review", <<a_log.id, l_user_name, l_data>>)
						if xmlrpc_client.last_answer_is_fault then
							last_error := err_trouble_during_remote_call
							if attached xmlrpc_client.last_fault_response as l_fault then
								last_error_message := l_fault.message
							end
						elseif attached xmlrpc_client.last_answer as rep then
							if attached {XRPC_STRING} rep.value as rep_s then
								print (rep_s.item)
							else
								print (rep.value.out)
							end
						end
					end
					logout
					disconnect
				end
				if not last_error_occurred then
					across
						l_entries as c
					loop
						e := c.item
						e.set_is_remote (True)
					end
				end
			end
--			last_error := err_connection_trouble
		end

feature -- Status report

	last_error: NATURAL_8

	last_error_message: detachable STRING

	last_error_occurred: BOOLEAN
		do
			Result := last_error > 0
				or last_error_message /= Void
				or xmlrpc_client.last_answer_is_fault
		end

	last_error_to_string: STRING
		do
			create Result.make_from_string (error_message (last_error))
			if attached last_error_message as m then
				Result.append_character (' ')
				Result.append_character ('(')
				Result.append_string (m)
				Result.append_character (')')
			end
		end

	error_message (a_error: like last_error): STRING
		do
			inspect a_error
			when err_invalid_account then
				Result := "Invalid account for " + username
			when err_connection_trouble then
				Result := "Trouble during connection"
			when err_trouble_during_remote_call then
				Result := "Trouble during remote call"
			else
				Result := "Error [" + a_error.out + "] occurred"
			end
		end

feature -- Access

	repository: REPOSITORY

	username: STRING
		do
			if attached repository.review_username as l_username then
				Result := l_username
			else
				Result := "anonymous"
			end
		end

	password: STRING
		do
			if attached repository.review_password as l_password then
				Result := l_password
			else
				Result := ""
			end
		end

feature -- Constants

	err_invalid_account: like last_error = 1
	err_connection_trouble: like last_error = 2
	err_trouble_during_remote_call: like last_error = 3

end
