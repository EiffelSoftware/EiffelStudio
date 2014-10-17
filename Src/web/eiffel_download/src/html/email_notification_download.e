note
	description: "Summary description for {EMAIL_NOTIFICATION_DOWNLOAD}."
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL_NOTIFICATION_DOWNLOAD

inherit

	HTML_TEMPLATE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_path: PATH; a_download: DOWNLOAD_INFORMATION)
			-- Initialize `Current'.
		local
			l_url: URL_ENCODER
		do
			create l_url
			set_template_folder (a_path)
			set_template_file_name ("email_notification_download.tpl")
			template.add_value (a_download.product, "product")
			template.add_value (a_download.platform, "platform")
			template.add_value (a_download.filename, "filename")
			template.add_value (a_download.user, "username")
			template.add_value (a_download.company, "company")
			template.add_value (a_download.first_name, "firstname")
			template.add_value (a_download.last_name, "lastname")
			template.add_value (a_download.organization, "organization")
			template.add_value (a_download.email_date_output, "download_email")
			template.add_value (a_download.download_date_output, "download_eiffelstudio")
			template.add_value (a_download.phone, "phone")
			template.add_value (a_download.email, "email")
			template.add_value (a_download.organization_email, "organization_email")
			process
		end

end
