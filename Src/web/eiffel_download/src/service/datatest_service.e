note
	description: "Summary description for {DATATEST_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	DATATEST_SERVICE

inherit
	DATA_SERVICE

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialize

	make
			-- Create the API service
		do
		end

feature -- Access


	is_membership (a_email: READABLE_STRING_8) : BOOLEAN
			-- Is email `a_email' already associated to a Membership user?
		do
			Result := False
		end

	is_contact (a_email: READABLE_STRING_8) : BOOLEAN
			-- Is email `a_email' already associated to a Contact user?
		do
			Result := False
		end

	is_download_active (a_token: READABLE_STRING_GENERAL): BOOLEAN
			-- Is download active for token `a_token'?
		local
			l_result: INTEGER
		do
--			l_result := data_provider.download_expiration_token_age (a_token)
			l_result := 10
			if
				l_result >= 0 and then
		        l_result <= 30
		    then
		    	Result := True
		    end
		end

feature -- Status Report

	is_available: BOOLEAN
			-- Is the current service available?
			-- If False, the database could be down or it's restaring.
		do
			Result := True
		end

feature -- Basic Operations

	retrieve_download_details (a_token: READABLE_STRING_GENERAL): detachable DOWNLOAD_INFORMATION
			-- Retrieve download details as tuple with email and platform for a given token `a_token', if any.
		do
			create Result
			Result.set_email ("test@eiffel.com")
			Result.set_platform ("win64")
			Result.set_user ("testdownload")
			Result.set_first_name ("Test")
			Result.set_last_name ("Download")
		end

	add_download_interaction_membership (a_email, a_product, a_platform: READABLE_STRING_8; a_file_name, a_token: READABLE_STRING_32)
				-- Add download interaction to membership with email `a_email', product `a_product', platform `a_platform'
				-- file `a_file_name', token `a_token'.
		do
			-- TODO
		end

	add_download_interaction_contact (a_email, a_product, a_platform: READABLE_STRING_8; a_file_name, a_token: READABLE_STRING_32)
				-- Add download interaction to contact with email `a_email', product `a_product', platform `a_platform'
				-- file `a_file_name', token `a_token'.
 		do
			-- TODO
		end

	initialize_download (a_token: READABLE_STRING_32; a_form: DOWNLOAD_FORM)
			-- Initialize product download.
		do
			-- TODO
		end

	add_temporary_contact (a_first_name, a_last_name: READABLE_STRING_32; a_email: READABLE_STRING_8; a_newsletter: INTEGER)
			-- A a new contact temporary with first_name, last_name and email.
		do
			-- TODO
		end

	validate_contact (a_email: READABLE_STRING_8)
			-- A a new contact from a temporary contact
		do
			-- TODO
		end

	register_newsletter (a_email: READABLE_STRING_8)
			-- Register a contact with email `a_email' to the newsletter.
		do
			-- TODO
		end

end
