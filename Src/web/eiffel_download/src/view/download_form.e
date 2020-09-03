note
	description: "Object that represent the download form."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_FORM

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create an instance with default values.
		do
			set_first_name ("")
			set_last_name ("")
			set_email ("")
			set_platform ("")
			set_company ("")
			set_title ("")
		end

feature -- Access

	first_name: READABLE_STRING_32
		-- User first name.

	last_name: READABLE_STRING_32
		-- User last name.

	email: IMMUTABLE_STRING_8
		-- User email.

	platform: IMMUTABLE_STRING_8
		-- Selected Platform.

	company: READABLE_STRING_32
		-- User's organization.	

	product: detachable IMMUTABLE_STRING_8
		-- Given EiffelStudio product:
		--  * eiffelstudio_standard (default)
		--  * eiffelstudio_enterprise
		--  * eiffelstudio_branded (not yet handled)

	newsletter: BOOLEAN
		-- Newsletter subscription ?

	title: READABLE_STRING_32
		-- User title :Developer, Project Manager, CIO/CTO, Student, Professor, Other.	

feature -- Change elements

	set_product (a_product: detachable READABLE_STRING_8)
		do
			if a_product = Void then
				product := Void
			else
				create product.make_from_string (a_product)
			end
		end

	set_first_name (a_first_name: READABLE_STRING_32)
			-- Set `first_name' as `a_first_name'.
		do
			first_name := a_first_name
		ensure
			first_name_set: first_name = a_first_name
		end

	set_last_name (a_last_name: READABLE_STRING_32)
			-- Set `last_name' as `a_last_name'.
		do
			last_name := a_last_name
		ensure
			last_name_set: last_name = a_last_name
		end

	set_email (a_email: READABLE_STRING_8)
			-- Set `email' to `a_email'.
		do
			create email.make_from_string (a_email)
		ensure
			email_set: email.same_string (a_email)
		end

	set_platform (a_platform: READABLE_STRING_8)
			-- Set `platform' to `a_platform'
		do
			create platform.make_from_string (a_platform)
		ensure
			platform_set: platform.same_string (a_platform)
		end

	set_newsletter (a_newsletter: BOOLEAN)
			-- Set `newsletter' to `a_newsletter'.
		do
			newsletter := a_newsletter
		ensure
			newsletter_set: newsletter = a_newsletter
		end

	set_company (a_organization: like company)
			-- Set `company' to `a_organization'.
		do
			company := a_organization
		ensure
			organization_set: company = a_organization
		end

	set_title (a_title: like title)
			-- Set `title' to `a_title'.
		do
			title := a_title
		ensure
			title_set: title = a_title
		end

end
