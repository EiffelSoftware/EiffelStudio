note
	description: "Summary description for {EIFFEL_DOWNLOAD_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DOWNLOAD_MODULE
inherit
	CMS_MODULE

	CMS_HOOK_VALUE_ALTER

	CMS_HOOK_AUTO_REGISTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			name := "download"
			version := "1.0"
			description := "Eiffel GPL Download"
			package := "download"
			create download_json
			enable
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		local
			fs: WSF_FILE_SYSTEM_HANDLER
		do
			service := a_service

				-- FIXME: this code could/should be retarded to when it is really needed
				-- then if the module is disabled, it won't take CPU+memory for nothing.
			download_json := (create {DOWNLOAD_JSON_CONFIGURATION}).new_download_configuration (a_service.site_var_dir.extended ("downloads_configuration.json"))

			a_service.map_uri_template ("/download", agent handle_download (a_service, ?, ?))

			a_service.add_value_alter_hook (Current)


			create fs.make_with_path (a_service.theme_location.extended ("res").extended ("images"))
			fs.disable_index
			a_service.router.handle ("/theme/images", fs)
		end

feature -- Access: config

	gpl_version: detachable DOWNLOAD_OPTIONS
		do
			create Result
			Result.set_product (retrieve_product_gpl)
		end

	retrieve_mirror_gpl: detachable READABLE_STRING_32
		do
			if attached download_json.mirror as l_mirror then
				Result := l_mirror
			end
		end

	retrieve_product_gpl: detachable DOWNLOAD_PRODUCT
		do
			if attached download_json.products as l_products then
				Result := l_products.at (1)
			end
		end


	download_json: DOWNLOAD_CONFIGURATION



feature -- Hooks

	value_alter (a_value: CMS_VALUE_TABLE; a_execution: CMS_EXECUTION)
		local
			l_ua: CMS_USER_AGENT
		do
			if
				attached retrieve_product_gpl as l_product and then
				attached l_product.release as l_release and then
				attached l_product.date as l_date and then
				attached l_product.version as l_version and then
				attached retrieve_mirror_gpl as l_mirror
			then
				a_value.force (l_release +" " + l_version, "last_release")
				a_value.force (l_date, "date")
				a_value.force (l_mirror, "mirror")
				a_value.force ((create {CMS_LOCAL_LINK}.make ("download link", "download")), "link")
			end

			create l_ua.make_from_string (a_execution.request.http_user_agent)

			if attached l_ua.os_family as l_os and then
			   	attached l_ua.address_register_size as l_platform
			then
			 	-- Todo build the link
			end

			across a_value as ic loop a_execution.set_value (ic.item, ic.key)  end
		end

feature -- Handler		

	handle_download (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			to_implement("Download Handler")
			hardcode_download (req, res)

		end

	hardcode_download  (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Simple response to download content
			-- Harcoded for testing.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_disposition ("attachment; filename", "[
						http://sourceforge.net/projects/eiffelstudio/files/EiffelStudio%2014.05/Build_95417/Eiffel_14.05_gpl_95417-windows.msi/download
						]")
			h.put_current_date
			h.put_header_key_value ("Content-type", "application/octet-stream")
			h.put_location ("[
						http://sourceforge.net/projects/eiffelstudio/files/EiffelStudio%2014.05/Build_95417/Eiffel_14.05_gpl_95417-windows.msi/download
						]")
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end



	html_encoded (s: detachable READABLE_STRING_GENERAL): STRING_8
		do
			if s /= Void then
				Result := html_encoder.general_encoded_string (s)
			else
				create Result.make_empty
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
