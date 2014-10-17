note
	description: "Download information for a user (Contact or Membership)"
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_INFORMATION

feature -- Access

	download_date: detachable DATE_TIME
			-- `download_date'

	download_date_output: detachable READABLE_STRING_32
			-- Download date representation.			

	email_date: detachable DATE_TIME
			-- `email_date'

	email_date_output: detachable READABLE_STRING_32
			-- Email date representation.		

	organization_email: detachable READABLE_STRING_32
			-- User's `organization_email'.

	email: detachable READABLE_STRING_32
			-- User's `email'.

	phone: detachable READABLE_STRING_32
			-- `phone'

	organization: detachable READABLE_STRING_32
			-- User's `organization'.

	user: detachable READABLE_STRING_32
			-- `user'

	filename: detachable READABLE_STRING_32
			-- Downloaded `filename'

	platform: detachable READABLE_STRING_32
			-- 	Downloaded `platform'.

	product: detachable READABLE_STRING_32
			-- Downloaded `product'.

	company: detachable READABLE_STRING_32
			-- User company.

feature -- Element change

	set_download_date (a_download_date: like download_date)
			-- Assign `download_date' with `a_download_date'.
		do
			download_date := a_download_date
			if a_download_date /= Void then
				download_date_output := a_download_date.formatted_out ("yyyy/[0]mm/[0]dd [0]hh:[0]mi:[0]ss am")
			end
		ensure
			download_date_assigned: download_date = a_download_date
		end

	set_email_date (an_email_date: like email_date)
			-- Assign `email_date' with `an_email_date'.
		do
			email_date := an_email_date
			if an_email_date /= Void then
				email_date_output := an_email_date.formatted_out ("yyyy/[0]mm/[0]dd [0]hh:[0]mi:[0]ss am")
			end
		ensure
			email_date_assigned: email_date = an_email_date
		end

	set_organization_email (an_organization_email: like organization_email)
			-- Assign `organization_email' with `an_organization_email'.
		do
			organization_email := an_organization_email
		ensure
			organization_email_assigned: organization_email = an_organization_email
		end

	set_email (an_email: like email)
			-- Assign `email' with `an_email'.
		do
			email := an_email
		ensure
			email_assigned: email = an_email
		end

	set_phone (a_phone: like phone)
			-- Assign `phone' with `a_phone'.
		do
			phone := a_phone
		ensure
			phone_assigned: phone = a_phone
		end

	set_organization (an_organization: like organization)
			-- Assign `organization' with `an_organization'.
		do
			organization := an_organization
		ensure
			organization_assigned: organization = an_organization
		end

	set_user (an_user: like user)
			-- Assign `user' with `an_user'.
		do
			user := an_user
		ensure
			user_assigned: user = an_user
		end

	set_filename (a_filename: like filename)
			-- Assign `filename' with `a_filename'.
		do
			filename := a_filename
		ensure
			filename_assigned: filename = a_filename
		end

	set_platform (a_platform: like platform)
			-- Assign `platform' with `a_platform'.
		do
			platform := a_platform
		ensure
			platform_assigned: platform = a_platform
		end

	set_product (a_product: like product)
			-- Assign `product' with `a_product'.
		do
			product := a_product
		ensure
			product_assigned: product = a_product
		end

	set_company (a_company: like company)
			-- Assign `company' with `a_company'.
		do
			company := a_company
		ensure
			company_assigned: company = a_company
		end

end
