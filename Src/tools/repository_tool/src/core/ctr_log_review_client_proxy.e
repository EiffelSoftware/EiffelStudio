note
	description: "Summary description for {CTR_LOG_REVIEW_CLIENT_PROXY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_LOG_REVIEW_CLIENT_PROXY

inherit
	CTR_SHARED_CONSOLE

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
				console_log ("connect " + username + "@[" + repository.location +"]")
				reset
				xmlrpc_client.connect
				if attached {XRPC_FAULT_RESPONSE} xmlrpc_client.last_answer as l_fault then
					console_log_error ("connect [" + repository.location +"]: ERROR")
					last_error_message := l_fault.message
					last_error := err_connection_trouble
				else
					console_log ("connect [" + repository.location +"]: SUCCESS")
				end
				is_connected := True
			end
		end

	disconnect
		do
			console_log ("disconnect [" + repository.location +"]")
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
			console_log ("login " + username + "@[" + repository.location +"]")
			xmlrpc_client.user_login (username, password)
			if xmlrpc_client.last_answer_is_fault then
				last_error := err_invalid_account
				console_log_error ("login " + username + "@[" + repository.location +"]: invalid account")
			else
				if attached xmlrpc_client.last_answer as rep then
					if attached {XRPC_STRUCT} rep.value as l_struct then
						l_user := l_struct.item ("user")
					end
				end
				if l_user = Void then
					last_error := err_invalid_account
				else
					console_log ("login " + username + "@[" + repository.location +"]: SUCCEED")
				end
			end
			if last_error > 0 then
				console_log_error ("login " + username + "@[" + repository.location +"]: FAILED <" + last_error.out + ">")
			end
		end

	logout
		do
			console_log ("logout " + username + "@[" + repository.location +"]")
			if is_connected then
				xmlrpc_client.user_logout
			end
		end

	submit (a_log: REPOSITORY_LOG; a_review: REPOSITORY_LOG_REVIEW)
		do
			post_review (a_log.id, username, a_review)
		end

	post_review (a_rev: STRING; a_user: STRING; a_review: REPOSITORY_LOG_REVIEW)
		local
			i: INTEGER
			e: detachable REPOSITORY_LOG_REVIEW_ENTRY
			r: STRING
			l_struct: XRPC_STRUCT
			l_data: ARRAY [XRPC_VALUE]
		do
			console_log ("submit review [" + repository.location +"]")

			create r.make_empty
			r.append_string (a_rev)
			r.append_character ('[')
			r.append_string (a_user)
			r.append_character (']')
			if
				attached a_review.user_local_entries (a_user, Void) as l_entries
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
	--					xmlrpc_client.remote_call ("ise.ctr.get_log", <<a_rev>>)
						xmlrpc_client.remote_call ("ise.ctr.post_review", <<a_rev, a_user, l_data>>)
						if xmlrpc_client.last_answer_is_fault then
							last_error := err_trouble_during_remote_call
							if attached xmlrpc_client.last_fault_response as l_fault then
								last_error_message := l_fault.message
							end
						elseif attached xmlrpc_client.last_answer as rep then
							if attached {XRPC_STRING} rep.value as rep_s then
								console_log ("Submit response: " + rep_s.item)
							else
								console_log ("Submit response: " + rep.value.out)
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
			if last_error > 0 then
				console_log_error ("submit review [" + repository.location +"]: FAILED")
			end
		end

	get_logs_range: detachable TUPLE [lower_revision, upper_revision: STRING_32]
		do
			console_log ("get_logs_range")

			connect
			if not last_error_occurred then
				login
				if not last_error_occurred then
					xmlrpc_client.remote_call ("ise.ctr.get_logs_range", <<repository.location>>)
					if xmlrpc_client.last_answer_is_fault then
						last_error := err_trouble_during_remote_call
						if attached xmlrpc_client.last_fault_response as l_fault then
							last_error_message := l_fault.message
						end
					elseif attached xmlrpc_client.last_answer as rep then
						if attached {XRPC_STRING} rep.value as rep_s then
							console_log ("get_logs_range response: " + rep_s.item)
						else
							console_log ("get_logs_range response: " + rep.value.out)
							if attached {XRPC_ARRAY} rep.value as l_array then
								if
									l_array.count = 2 and then
									attached {XRPC_STRING} l_array.item (1) as l_lower and then
									attached {XRPC_STRING} l_array.item (2) as l_upper
								then
									Result := [l_lower.value, l_upper.value]
								end
							end
						end
					end
				end
				logout
				disconnect
			end
			if last_error > 0 then
				console_log_error ("get_logs_range [" + repository.location + "]: FAILED")
			end
		end

	get_missing_logs (a_lower, a_upper: STRING): detachable ARRAY [STRING]
		local
			n, i: INTEGER
			l_user_name: like username
		do
			console_log ("get_missing_logs")
			l_user_name := username

			connect
			if not last_error_occurred then
				login
				if not last_error_occurred then
					xmlrpc_client.remote_call ("ise.ctr.get_missing_logs", <<repository.location, a_lower, a_upper>>)
					if xmlrpc_client.last_answer_is_fault then
						last_error := err_trouble_during_remote_call
						if attached xmlrpc_client.last_fault_response as l_fault then
							last_error_message := l_fault.message
						end
					elseif attached xmlrpc_client.last_answer as rep then
						if attached {XRPC_STRING} rep.value as rep_s then
							console_log ("get_missing_logs response: " + rep_s.item)
						else
							console_log ("get_missing_logs response: " + rep.value.out)
							if attached {XRPC_ARRAY} rep.value as l_array then
								from
									n := l_array.count.as_integer_32
									create Result.make_filled ("", 1, n)
									i := 1
								until
									i > n
								loop
									if attached {XRPC_STRING} l_array.item (i.as_natural_32) as s then
										Result.put (s.value, i)
									end
									i := i + 1
								end
							end
						end
					end
				end
				logout
				disconnect
			end
			if last_error > 0 then
				console_log_error ("get_missing_logs [" + repository.location + "]: FAILED")
			end
		end

	get_log (a_rev: STRING): detachable STRING
		do
			console_log ("get_log")

			connect
			if not last_error_occurred then
				login
				if not last_error_occurred then
					xmlrpc_client.remote_call ("ise.ctr.get_log", <<repository.location, a_rev>>)
					if xmlrpc_client.last_answer_is_fault then
						last_error := err_trouble_during_remote_call
						if attached xmlrpc_client.last_fault_response as l_fault then
							last_error_message := l_fault.message
						end
					elseif attached xmlrpc_client.last_answer as rep then
						if attached {XRPC_STRING} rep.value as rep_s then
							console_log ("get_log response: " + rep_s.item)
						else
							console_log ("get_log response: " + rep.value.out)
							if attached {XRPC_STRING} rep.value as s then
								Result := s.value
							end
						end
					end
				end
				logout
				disconnect
			end
			if last_error > 0 then
				console_log_error ("get_log [" + repository.location + "]: FAILED")
			end
		end


	get_review (a_rev: STRING; a_user: detachable STRING): detachable STRING
		do
			console_log ("get_review")

			connect
			if not last_error_occurred then
				login
				if not last_error_occurred then
					if a_user = Void then
						xmlrpc_client.remote_call ("ise.ctr.get_review", <<repository.location, a_rev, create {XRPC_DEFAULT_VALUE}>>)
					else
						xmlrpc_client.remote_call ("ise.ctr.get_review", <<repository.location, a_rev, a_user>>)
					end
					if xmlrpc_client.last_answer_is_fault then
						last_error := err_trouble_during_remote_call
						if attached xmlrpc_client.last_fault_response as l_fault then
							last_error_message := l_fault.message
						end
					elseif attached xmlrpc_client.last_answer as rep then
						if attached {XRPC_STRING} rep.value as rep_s then
							console_log ("get_review response: " + rep_s.item)
						else
							console_log ("get_review response: " + rep.value.out)
							if attached {XRPC_STRING} rep.value as s then
								Result := s.value
							end
						end
					end
				end
				logout
				disconnect
			end
			if last_error > 0 then
				console_log_error ("get_review [" + repository.location + "]: FAILED")
			end
		end

feature -- Status report

	last_error: NATURAL_8

	last_error_message: detachable READABLE_STRING_32

	last_error_occurred: BOOLEAN
		do
			Result := last_error > 0
				or last_error_message /= Void
				or xmlrpc_client.last_answer_is_fault
		end

	last_error_to_string: STRING_32
		do
			create Result.make_from_string (error_message (last_error))
			if attached last_error_message as m then
				Result.append_character (' ')
				Result.append_character ('(')
				Result.append_string (m)
				Result.append_character (')')
			end
		end

	error_message (a_error: like last_error): STRING_32
		do
			inspect a_error
			when err_invalid_account then
				Result := {STRING_32} "Invalid account for " + username
			when err_connection_trouble then
				Result := {STRING_32} "Trouble during connection"
			when err_trouble_during_remote_call then
				Result := {STRING_32} "Trouble during remote call"
			else
				Result := {STRING_32} "Error [" + a_error.out + {STRING_32} "] occurred"
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
