note
	description: "Summary description for {EMAIL_DOWNLOAD_OPTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL_DOWNLOAD_OPTIONS

inherit

	HTML_TEMPLATE

	SHARED_TEMPLATE_CONTEXT

create
	make, make_resources

feature {NONE} --Initialization

	make (a_path: PATH; a_host: READABLE_STRING_GENERAL; a_form: DOWNLOAD_FORM; a_token: READABLE_STRING_32; a_download_service: DOWNLOAD_SERVICE)
			-- Initialize `Current'.
		local
			l_url: URL_ENCODER
		do
			create l_url
			set_template_folder (a_path)
			set_template_file_name ("email_download_options.tpl")
			template.add_value (a_host, "host")
			template.add_value (l_url.encoded_string (a_token), "token")
			template.add_value (a_form.platform, "platform")
			if
				attached a_download_service.first_product as l_product and then
				attached l_product.number as l_number
			then
				template.add_value (l_number, "number")
			end

			if
				attached a_download_service.first_product as l_product
			then
				template.add_value (l_product.sub_directory, "directory")
				template.add_value (selected_platform (l_product.downloads, a_form.platform), "selected_platform")
			end
			process
		end


	make_resources (a_path: PATH)
			-- Initialize `Current'.
		do
			set_template_folder (a_path)
			set_template_file_name ("email_video_resources.tpl")
			process
		end


	selected_platform (a_downloads: detachable LIST [DOWNLOAD_PRODUCT_OPTIONS]; a_platform: READABLE_STRING_8): detachable DOWNLOAD_PRODUCT_OPTIONS
		local
			l_found: BOOLEAN
		do
			if
				attached a_downloads
			then
				from
					a_downloads.start
				until
					a_downloads.after or l_found
				loop
					if
						attached a_downloads.item.platform as p and then
						a_platform.same_string (p)
					then
						Result := a_downloads.item
					end
					a_downloads.forth
				end
			end
		end

end
