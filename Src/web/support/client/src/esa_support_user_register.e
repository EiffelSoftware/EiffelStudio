note
	description: "[
		Communicates with support site to register a new user.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SUPPORT_USER_REGISTER

inherit
	ESA_SUPPORT_ACCESS

create
	make

feature -- Basic operations

	user_register (a_user: ESA_USER_REGISTER)
			-- Register a new user 'a_user' into support site
			--
			-- `a_user': User details.
		require
			is_support_accessible: is_support_accessible
			a_user_attached: a_user /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				fill_user_register (a_user)
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Basic operations

	fill_user_register (a_user: ESA_USER_REGISTER)
			-- Filling a user form .
		require
			is_support_accessible: is_support_accessible
		local
			l_register_uri: STRING_GENERAL
		do
				-- Uri to create a new user
			l_register_uri := register_uri

				-- Submit
			if l_register_uri /= Void then
				perform_submit (l_register_uri, a_user)
			end
		end

	perform_submit (a_target_url: STRING_GENERAL; a_user: ESA_USER_REGISTER)
			-- Fill template user data and performs the submit to register a new user.
		require
			is_support_accessible: is_support_accessible
			not_void_user: a_user /= Void
			a_target_url_attached: a_target_url /= Void
			not_a_target_url_is_empty: not a_target_url.is_empty
		local
			l_tpl: CJ_TEMPLATE
			l_data: CJ_DATA
			l_resp: ESA_SUPPORT_RESPONSE
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			message := Void
			create l_tpl.make

				-- first name
			create l_data.make_with_name ("first_name")
			if attached a_user.first_name as l_fn then
				l_data.set_value (l_fn)
			end
			l_tpl.add_data (l_data)

				-- last name
			create l_data.make_with_name ("last_name")
			if attached a_user.last_name as l_ln then
				l_data.set_value (l_ln)
			end
			l_tpl.add_data (l_data)

				-- email
			create l_data.make_with_name ("email")
			if attached a_user.email as l_email then
				l_data.set_value (l_email)
			end
			l_tpl.add_data (l_data)

				-- user name
			create l_data.make_with_name ("user_name")
			if attached a_user.user_name as l_uname then
				l_data.set_value (l_uname)
			end
			l_tpl.add_data (l_data)

				-- password
			create l_data.make_with_name ("password")
			if attached a_user.password as l_pwd then
				l_data.set_value (l_pwd)
			end
			l_tpl.add_data (l_data)

				-- check password
			create l_data.make_with_name ("check_password")
			if attached a_user.password as l_cpwd then
				l_data.set_value (l_cpwd)
			end
			l_tpl.add_data (l_data)

				-- question
			create l_data.make_with_name ("question")
			l_data.set_value (a_user.question.out)
			l_tpl.add_data (l_data)

				-- answer
			create l_data.make_with_name ("answer")
			l_data.set_value (a_user.answer)
			l_tpl.add_data (l_data)

			l_resp := create_with_template (a_target_url, l_tpl, ctx)

			if l_resp = Void then
				(create {EXCEPTIONS}).raise ("Connection error: missing URL for the register form.")
			elseif l_resp.status /= 200 then
				if
					attached l_resp.collection as l_col and then
					attached l_col.error as l_error
				then
					if attached l_error.message as l_message then
						(create {EXCEPTIONS}).raise ({STRING_32} "Connection error: HTTP Status " + l_resp.status.out.to_string_32 + {STRING_32} " " + l_message)
					else
						(create {EXCEPTIONS}).raise ("Connection error: HTTP Status " + l_resp.status.out)
					end
				else
					(create {EXCEPTIONS}).raise ("Connection error: HTTP Status " + l_resp.status.out)
				end
			else
				if attached l_resp.collection as l_col then
					if attached {ARRAYED_LIST [CJ_ITEM]} l_col.items as l_items and then
					   not l_items.is_empty and then l_items.count = 1
					then
						 -- TODO: Improve code.
						check one_item: l_items.count = 1 end
						if attached l_items.first as l_first_item then
							next_action := l_first_item.href
						else
							next_action := Void
						end
						if attached l_items.first.data as l_first_data then
							check one_item_data: l_first_data.count = 1 end
							if not l_first_data.is_empty and then attached l_first_data.first.value as l_value then
								message := l_value
							end
						else
							check has_item: False end
						end
					end
				end
			end
		end

feature -- Access

	next_action: detachable STRING_8
			-- URI of the last response with next action to do.

	message: detachable STRING_GENERAL
			-- Message to execute the next action.

feature -- Access

	register_uri: detachable STRING_8
			-- Report form URI.
		do
			Result := retrieve_url ("register", "Register")
		end

end
