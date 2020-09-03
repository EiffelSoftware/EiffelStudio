note
	description: "Summary description for {DATA_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DATA_SERVICE

feature -- Access

	is_membership (a_email: READABLE_STRING_8) : BOOLEAN
			-- Is email `a_email' already associated to a Membership user?
		deferred
		end

	is_contact (a_email: READABLE_STRING_8) : BOOLEAN
			-- Is email `a_email' already associated to a Contact user?
		deferred
		end

	is_new_contact (a_email: READABLE_STRING_8) : BOOLEAN
			-- Email `a_email' does not exist in the database.
		do
			Result := not ( is_membership (a_email) or is_contact (a_email) )
		end

	is_download_active (a_token: READABLE_STRING_GENERAL): BOOLEAN
			-- Is download active for token `a_token'?
		deferred
		end

feature -- Status Report

	is_available: BOOLEAN
			-- Is the current service available?
			-- If False, the database could be down or it's restaring.
		deferred
		end

feature -- Basic Operations

	retrieve_download_details (a_token: READABLE_STRING_GENERAL): detachable DOWNLOAD_INFORMATION
			-- Retrieve download details as tuple with email and platform for a given token `a_token', if any.
		deferred
		end

	add_download_interaction_membership (a_email, a_product, a_platform: READABLE_STRING_8; a_file_name, a_token: READABLE_STRING_32)
				-- Add download interaction to membership with email `a_email', product `a_product', platform `a_platform'
				-- file `a_file_name', token `a_token'.
		deferred
		end

	add_download_interaction_contact (a_email, a_product, a_platform: READABLE_STRING_8; a_file_name, a_token: READABLE_STRING_32)
				-- Add download interaction to contact with email `a_email', product `a_product', platform `a_platform'
				-- file `a_file_name', token `a_token'.
 		deferred
		end

	initialize_download (a_token: READABLE_STRING_32; a_form: DOWNLOAD_FORM)
			-- Initialize product download.
		deferred
		end

	add_temporary_contact (a_first_name, a_last_name: READABLE_STRING_32; a_email: READABLE_STRING_8; a_newsletter: INTEGER)
			-- A a new contact temporary with first_name, last_name and email.
		deferred
		end

	validate_contact (a_email: READABLE_STRING_8)
			-- A a new contact from a temporary contact
		deferred
		end

	register_newsletter (a_email: READABLE_STRING_8)
			-- Register a contact with email `a_email' to the newsletter.
		deferred
		end

end
