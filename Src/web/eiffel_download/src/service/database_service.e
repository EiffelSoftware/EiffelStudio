note
	description: "Summary description for {DATABASE_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_SERVICE

inherit
	DATA_SERVICE

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialize

	make (a_connection: DATABASE_CONNECTION)
			-- Create the API service
		require
			is_connected: a_connection.is_connected
		do
			connection := a_connection
			create data_provider.make (a_connection)
			create login_provider.make (a_connection)
		end

feature -- Access


	is_membership (a_email: READABLE_STRING_8) : BOOLEAN
			-- Is email `a_email' already associated to a Membership user?
		do
			Result := attached login_provider.user_from_email (a_email)
		end

	is_contact (a_email: READABLE_STRING_8) : BOOLEAN
			-- Is email `a_email' already associated to a Contact user?
		do
			Result := attached login_provider.contact_from_email (a_email)
		end

	is_download_active (a_token: READABLE_STRING_GENERAL): BOOLEAN
			-- Is download active for token `a_token'?
		local
			l_result: INTEGER
		do
			l_result := data_provider.download_expiration_token_age (a_token)
			log.write_information (generator + ".is_download_active with token: " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_token) + " with result : " + l_result.out )

			if attached data_provider.last_error as l_error then
				log.write_critical (generator + ".is_download_active: Error message" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_error.error_message))
			end

			if
				l_result >= 0 and then
		        l_result <= 30
		    then
		    	Result := True
		    end

		    -- Same code using SQL Queries instead of SP
		    -- l_result := data_provider.download_expiration_token_age_2 (a_token)
			-- log.write_information (generator + ".is_download_active with token using the SQL version: " + a_token + " with result : " + l_result.out )

		end

feature -- Status Report

	is_available: BOOLEAN
			-- Is the current service available?
			-- If False, the database could be down or it's restaring.
		do
			Result := connection.is_connected
		end

feature -- Basic Operations

	retrieve_download_details (a_token: READABLE_STRING_GENERAL): detachable DOWNLOAD_INFORMATION
			-- Retrieve download details as tuple with email and platform for a given token `a_token', if any.
		do
			log.write_debug (generator + ".retrieve_download_details with token:" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_token))
				-- TUPLE [email: READABLE_STRING_8; platform: READABLE_STRING_8; username: READABLE_STRING_32; org_name: READABLE_STRING_32; phone: READABLE_STRING_8; org_email: READABLE_STRING_8]
			if
				attached {TUPLE [email: READABLE_STRING_8; platform: READABLE_STRING_8; username: READABLE_STRING_32; org_name: READABLE_STRING_32; phone: READABLE_STRING_8; org_email: READABLE_STRING_8; date: DATE_TIME; company: READABLE_STRING_32; first_name: READABLE_STRING_32; last_name: READABLE_STRING_32]} data_provider.retrieve_download_details (a_token) as l_tuple
			then
				create Result
				Result.set_email (l_tuple.email)
				Result.set_platform (l_tuple.platform)
				Result.set_user (l_tuple.username)
				Result.set_phone (l_tuple.phone)
				Result.set_organization (l_tuple.org_name)
				Result.set_organization_email (l_tuple.org_email)
				Result.set_email_date (l_tuple.date)
				Result.set_company (l_tuple.company)
				Result.set_first_name (l_tuple.first_name)
				Result.set_last_name (l_tuple.last_name)
			elseif
				attached {TUPLE [email: READABLE_STRING_8; platform: READABLE_STRING_8; username: READABLE_STRING_32; date: DATE_TIME; company: READABLE_STRING_32; first_name: READABLE_STRING_32; last_name: READABLE_STRING_32]} data_provider.retrieve_temporary_download_details (a_token)  as l_tuple
			then
				create Result	-- Add download interaction to contact with email `a_email', product `a_product', platform `a_platform'
				-- file `a_file_name', token `a_token'.

				Result.set_email (l_tuple.email)
				Result.set_platform (l_tuple.platform)
				Result.set_user (l_tuple.username)
				Result.set_email_date (l_tuple.date)
				Result.set_company (l_tuple.company)
				Result.set_first_name (l_tuple.first_name)
				Result.set_last_name (l_tuple.last_name)
			end
		end

	add_download_interaction_membership (a_email, a_product, a_platform: READABLE_STRING_8; a_file_name, a_token: READABLE_STRING_32)
				-- Add download interaction to membership with email `a_email', product `a_product', platform `a_platform'
				-- file `a_file_name', token `a_token'.
		do
			if attached login_provider.user_from_email (a_email) as l_data then
				 data_provider.add_download_interaction (l_data.user_name, a_product, a_platform, a_file_name)
			end
		end

	add_download_interaction_contact (a_email, a_product, a_platform: READABLE_STRING_8; a_file_name, a_token: READABLE_STRING_32)
				-- Add download interaction to contact with email `a_email', product `a_product', platform `a_platform'
				-- file `a_file_name', token `a_token'.
 		do
			if attached login_provider.contact_from_email (a_email) then
				 data_provider.add_download_interaction_contact (a_email, a_product, a_platform, a_file_name)
			end
		end

	initialize_download (a_token: READABLE_STRING_32; a_form: DOWNLOAD_FORM)
			-- Initialize product download.
		do
			data_provider.initialize_download (a_form.email, a_token, a_form.platform, a_form.company, a_form.first_name, a_form.last_name)
		end

	add_temporary_contact (a_first_name, a_last_name: READABLE_STRING_32; a_email: READABLE_STRING_8; a_newsletter: INTEGER)
			-- A a new contact temporary with first_name, last_name and email.
		do
			data_provider.add_contacts_temporary (a_first_name, a_last_name, a_email, a_newsletter)
		end

	validate_contact (a_email: READABLE_STRING_8)
			-- A a new contact from a temporary contact
		do
			data_provider.add_temporary_contacts_to_contacts (a_email)
		end

	register_newsletter (a_email: READABLE_STRING_8)
			-- Register a contact with email `a_email' to the newsletter.
		do
			data_provider.register_newsletter (a_email)
		end

feature {NONE} -- Database Providers

	data_provider: REPORT_DATA_PROVIDER
			-- Report Data provider.

	login_provider: LOGIN_DATA_PROVIDER
			-- Login data provider.

	connection: DATABASE_CONNECTION
			-- Current database connection.
end
