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

			if attached retrieve_product_gpl as l_product then
				if attached selected_platform (l_product.downloads, get_platform (l_ua)) as l_selected then
					a_value.force (l_selected.filename, "filename")
				end
			end


			across a_value as ic loop a_execution.set_value (ic.item, ic.key)  end
		end

feature -- Handler		

	handle_download (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_link: STRING
			l_ua: CMS_USER_AGENT
		do

			create l_ua.make_from_string (req.http_user_agent)

			if attached retrieve_product_gpl as l_product and then
			   attached l_product.build as l_build and then
			   attached l_product.name as l_name and then
			   attached l_product.number as l_number and then
			   attached retrieve_mirror_gpl as l_mirror
			then
			    l_link := l_mirror
			    l_link.append (l_name)
			    l_link.append (" ")
			    l_link.append (l_number)
			    l_link.append_character ('/')
			    l_link.append (l_build)
			    l_link.append_character ('/')
				if attached selected_platform (l_product.downloads, get_platform (l_ua)) as l_selected then
					if attached l_selected.filename as l_filename then
						l_link.append (l_filename)
						file_download (req, res, l_link)
					end
				end
			end
		end

	file_download  (req: WSF_REQUEST; res: WSF_RESPONSE a_link: READABLE_STRING_32)
			-- Simple response to download content
			-- Harcoded for testing.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_disposition ("attachment; filename", a_link)
			h.put_current_date
			h.put_header_key_value ("Content-type", "application/octet-stream")
			h.put_location (a_link)
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

feature {NONE}  -- Helper

	selected_platform (a_downloads: detachable LIST[DOWNLOAD_PRODUCT_OPTIONS]; a_platform: READABLE_STRING_32): detachable DOWNLOAD_PRODUCT_OPTIONS
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
					if a_downloads.item.platform ~ a_platform then
						Result := a_downloads.item
					end
					a_downloads.forth
				end
			end
		end


	get_platform (a_user_agent: CMS_USER_AGENT)	: READABLE_STRING_32
				-- Set by default win64
				--	<option value="freebsd-x86">FreeBSD x86 32-bit</option>
				--	<option value="freebsd-x86-64">FreeBSD x86 64-bit</option>
				--	<option value="linux-x86">Linux x86 32-bit</option>
				--	<option value="linux-x86-64">Linux x86 64-bit</option>
				--	<option value="macosx-x86-64">Mac OS X</option>
				--  <option value="openbsd-x86">OpenBSD x86 32-bit</option>
				--	<option value="openbsd-x86-64">OpenBSD x86 64-bit</option>
				--	<option value="solaris-x86">Solaris x86 32-bit</option>
				--	<option value="solaris-x86-64">Solaris x64 64-bit</option>
				--	<option value="solaris-sparc">Solaris Sparc 32-bit</option>
				--	<option value="solaris-sparc-64">Solaris Sparc 64-bit</option>
				--	<option value="win64" selected="">Windows 64-bit</option>
				--	<option value="windows">Windows 32-bit</option>		
		do
			Result := "win64"
			if a_user_agent.is_windows_os then
				if a_user_agent.is_64bits then
					Result := "win64"
				else
					Result := "windows"
				end
			elseif a_user_agent.is_linux_os then
				if a_user_agent.is_64bits then
					Result := "linux-x86-64"
				else
					Result := "linux-x86"
				end
			elseif a_user_agent.is_mac_os then
				Result := "macosx-x86-64"
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
