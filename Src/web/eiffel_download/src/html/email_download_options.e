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
	make

feature {NONE} --Initialization

	make (a_path: PATH; a_host: READABLE_STRING_GENERAL; a_form: DOWNLOAD_FORM; a_token: READABLE_STRING_32; a_download: detachable DOWNLOAD_OPTIONS)
			-- Initialize `Current'.
		local
			l_url: URL_ENCODER
		do
			create l_url
			set_template_folder (a_path)
			set_template_file_name ("email_download_options.tpl")
			template.add_value (a_host, "host")
			template.add_value (l_url.encoded_string (a_token), "token")
			template.add_value (selected_platform (a_download,a_form.platform), "selected_platform")
			template.add_value (l_url.encoded_string (a_form.email), "email")
			template.add_value (a_form.platform, "platform")
			if attached a_download as l_download and then
			   attached l_download.mirrors as l_mirrors
			then
				template.add_value (l_mirrors.at (1) ,"mirror")
			end
			if
				attached a_download and then
				attached a_download.product as l_product
			then
				template.add_value (l_product.name, "name")
				template.add_value (l_product.number, "number")
				template.add_value (l_product.build, "build")
			end
			template.add_value (a_download, "options")
			process
		end


	selected_platform (a_download: detachable DOWNLOAD_OPTIONS; a_platform: READABLE_STRING_32): detachable DOWNLOAD_PRODUCT_OPTIONS
		local
			l_found: BOOLEAN
		do
			if
				attached a_download and then
				attached a_download.product as l_product and then
				attached l_product.downloads as l_downloads
			then
				from
					l_downloads.start
				until
					l_downloads.after or l_found
				loop
					if l_downloads.item.platform ~ a_platform then
						Result := l_downloads.item
					end
					l_downloads.forth
				end
			end

		end

end
