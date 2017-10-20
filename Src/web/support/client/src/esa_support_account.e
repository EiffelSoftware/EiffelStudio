note
	description:  "[
		Communicates with the support site to access the user account
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SUPPORT_ACCOUNT

inherit
	ESA_SUPPORT_LOGIN

create
	make

feature -- Basic operations

	account_details: detachable ESA_ACCOUNT
			-- Return user account details.
			-- Note: A login must be performed before attempting to get the user account details.
		require
			is_support_accessible: is_support_accessible
			is_logged_in: is_logged_in
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := retrieve_account_details
			end
		rescue
			is_bad_request := True
			retried := True
			retry
		end

feature -- Access

	user_account_uri: detachable STRING_8
			-- Report form URI.
		do
			Result := retrieve_url ("account_information", "Account")
		end

feature {NONE} -- Implementation

	retrieve_account_details: detachable ESA_ACCOUNT
		local
			l_account_uri: STRING_GENERAL
		do
			l_account_uri := user_account_uri
			if l_account_uri /= Void then
				Result := do_get (l_account_uri)
			end
		end


	do_get (a_target_url: STRING_GENERAL): detachable ESA_ACCOUNT
	 		-- Get request to retrive the user account.
	 	require
			is_support_accessible: is_support_accessible
	 		a_target_url_attached: a_target_url /= Void
	 		not_a_target_url_is_empty: not a_target_url.is_empty
	 	local
			l_resp: ESA_SUPPORT_RESPONSE
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do

			create ctx.make
			if attached last_username as u and then attached last_password as p then
				if attached basic_auth (u, p) as l_auth then
					ctx.add_header ("Authorization", l_auth)
				end
			end

			l_resp := get (a_target_url, ctx)
			if l_resp.status /= 200 then
				(create {EXCEPTIONS}).raise ("Connection error: HTTP Status " + l_resp.status.out)
			else
				if attached l_resp.collection as l_col then
					if
						attached {CJ_TEMPLATE} l_col.template as l_template and then
						attached {ARRAYED_LIST [CJ_DATA]} l_template.data as l_data
					then
						create Result
						across l_data as ic loop
							if
								ic.item.name.same_string ("first_name") and then
								attached ic.item.value as l_value
							then
								Result.set_first_name (l_value)
							elseif
								ic.item.name.same_string ("last_name") and then
								attached ic.item.value as l_value
							then
								Result.set_last_name (l_value)
							elseif
								ic.item.name.same_string ("user_email") and then
								attached ic.item.value as l_value
							then
								Result.set_email (l_value)
							elseif
								ic.item.name.same_string ("country") and then
								attached ic.item.value as l_value
							then
								Result.set_country (l_value)
							elseif
								ic.item.name.same_string ("user_region") and then
								attached ic.item.value as l_value
							then
								Result.set_region (l_value)
							elseif
								ic.item.name.same_string ("user_position") and then
								attached ic.item.value as l_value
							then
								Result.set_position (l_value)
							elseif
								ic.item.name.same_string ("user_city") and then
								attached ic.item.value as l_value
							then
								Result.set_city (l_value)
							elseif
								ic.item.name.same_string ("user_address") and then
								attached ic.item.value as l_value
							then
								Result.set_address (l_value)
							elseif
								ic.item.name.same_string ("user_post_code") and then
								attached ic.item.value as l_value
							then
								Result.set_postal_code (l_value)
							elseif
								ic.item.name.same_string ("user_phone") and then
								attached ic.item.value as l_value
							then
								Result.set_telephone (l_value)
							elseif
								ic.item.name.same_string ("user_fax") and then
								attached ic.item.value as l_value
							then
								Result.set_fax (l_value)
							end
						end
					end
				end
			end
		end
end
