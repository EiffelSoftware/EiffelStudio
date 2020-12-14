note
	description: "Summary description for {EIFFEL_DOWNLOAD_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DOWNLOAD_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER
		rename
			make as make_cms_webapi_handler
		end

	WSF_URI_TEMPLATE_HANDLER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make (a_api: EIFFEL_DOWNLOAD_API)
		do
			download_api := a_api
			make_cms_webapi_handler (a_api.cms_api)
		end

	download_api: EIFFEL_DOWNLOAD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if req.is_get_request_method then
				execute_get (req, res)
			elseif req.is_post_request_method then
				execute_post (req, res)
			elseif req.is_delete_request_method then
				execute_delete (req, res)
			else
				new_bad_request_error_response (Void, req, res).execute
			end
		end

feature -- Errors

	new_unavailable_channel_error_response (req: WSF_REQUEST; res: WSF_RESPONSE): HM_WEBAPI_RESPONSE
		do
			Result := new_error_response ({STRING_32} "Invalid channel, valid values are: [" + available_channels_to_string ('|') + "]" , req, res)
			Result.add_iterator_field ("channels", available_channels)
			Result.set_status_code ({HTTP_STATUS_CODE}.bad_request)
		end

feature -- Execution GET

	 execute_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: HM_WEBAPI_RESPONSE
			l_value: STRING
			l_channel: STRING
		do
			if api.has_permissions (<<"view downloads">>) then
				if
					attached {WSF_STRING} req.path_parameter ("channel") as p_channel and then
					is_valid_channel (p_channel.value)
				then
					l_channel := p_channel.value
					if attached {WSF_STRING} req.path_parameter ("release") as l_release then
						l_value := l_release.value
						if is_valid_version (l_value) then
							if attached {WSF_STRING} req.query_parameter ("platform") as l_platform then
									-- retrieve product by platform and release.
								rep := retrieve_by_release_and_platform (req, res, l_value, l_platform.value)
							else
									-- retrieve product by release
								rep := retrieve_by_release (req, res, l_value)
							end
						else
								-- Invalid Release
							rep := new_error_response ("Release [" + l_value + "] invalid" , req, res)
							rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
						end
					else
							-- retrieve all available products for channel `l_channel` using the latest release.
						rep := retrieve_all_public_products (l_channel, req, res)
					end
				else
						-- Invalid Channel
					rep := new_unavailable_channel_error_response (req, res)
				end
				rep.execute
			end
		end

feature -- Execute Delete

	 execute_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: HM_WEBAPI_RESPONSE
			l_file: FILE
			l_dir: DIRECTORY
		do
			rep := new_response (req, res)
			if
				api.has_permissions (<<"delete download">>)
			then
				if
					attached {WSF_STRING} req.path_parameter ("channel") as p_channel and then
					attached p_channel.value as l_channel and then
					is_valid_channel (l_channel)
				then
					if
						attached {WSF_STRING} req.path_parameter ("release") as l_release and then
						req.query_string.is_empty and then
						is_valid_version (l_release.value) and then
						not l_release.value.is_case_insensitive_equal ("all")
					then
						create l_dir.make_with_path (api.module_location_by_name ("eiffel_download"))

						if l_dir.exists  then
							create {RAW_FILE} l_file.make_open_write (l_dir.path.extended ("channel").extended (l_channel).extended ("downloads_configuration_" + release_version_dot_format (l_release.value)+ ".json").name)
							if l_file.exists then
								l_file.close
								delete_uploaded_file (l_file.path)
								rep.set_status_code ({HTTP_STATUS_CODE}.no_content)
							else
								-- File does not exist.
								rep := new_error_response ("Bad request [" + req.absolute_script_url ("") + "] does not exist" , req, res)
								rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
							end
						end
					else
						rep := new_error_response ("Bad request [" + req.absolute_script_url ("") + "] invalid" , req, res)
						rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
					end
				else
						-- Invalid Channel
					rep := new_unavailable_channel_error_response (req, res)
				end
			else
					-- FIXME: use specific Web API response!
				rep := new_access_denied_error_response (Void, req, res)
			end
			rep.execute
		end

feature -- Execute POST

	 execute_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: HM_WEBAPI_RESPONSE
			l_tmp: WSF_UPLOADED_FILE
			l_file: FILE
			l_dir: DIRECTORY
			l_data: STRING
		do
			if
				api.has_permissions (<<"update download">>)
			then
				if
					attached {WSF_STRING} req.path_parameter ("channel") as p_channel and then
					attached p_channel.value as l_channel and then
					is_valid_channel (l_channel)
				then
					rep := new_response (req, res)
					if req.has_uploaded_file then
						across req.uploaded_files as c loop
							l_tmp := c.item
						end
					else
						create l_data.make_empty
						req.read_input_data_into (l_data)
					end
					if l_tmp /= Void then
						if attached  process_uploaded_file (l_tmp) as l_uploaded then
							create l_dir.make_with_path (api.module_location_by_name ("eiffel_download").extended ("channel").extended (l_channel))
							if l_dir.exists then
								create {RAW_FILE} l_file.make_open_write (l_dir.path.extended ("downloads_configuration_" + l_uploaded.number + ".json").name)
								l_file.put_string (l_uploaded.to_json_representation)
								l_file.close
							end
							rep.add_string_field ("Success", "File uploaded")
							rep.add_string_field ("Filename", "downloads_configuration_" + l_uploaded.number + ".json")
						else
							rep := new_error_response ("Bad file format" , req, res)
							rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
						end
					elseif l_data /= Void then
						if attached  process_uploaded_data (l_data) as l_uploaded then
							create l_dir.make_with_path (api.module_location_by_name ("eiffel_download").extended ("channel").extended (l_channel))
							if l_dir.exists then
								create {RAW_FILE} l_file.make_open_write (l_dir.path.extended ("downloads_configuration_" + l_uploaded.number + ".json").name)
								l_file.put_string (l_uploaded.to_json_representation)
								l_file.close
							end
							rep.add_string_field ("Success", "File uploaded")
							rep.add_string_field ("Filename", "downloads_configuration_" + l_uploaded.number + ".json")
						else

						end
					else
						rep := new_error_response ("File not found or Missing data content" , req, res)
						rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
					end
				else
						-- Invalid Channel
					rep := new_unavailable_channel_error_response (req, res)
				end
			else
					-- FIXME: use specific Web API response!
				rep := new_access_denied_error_response (Void, req, res)
			end
			rep.execute
		end


feature {NONE} -- Implementation

	product_options_link (a_prod: DOWNLOAD_PRODUCT; a_prod_opts: DOWNLOAD_PRODUCT_OPTIONS; a_mirror: READABLE_STRING_8): detachable STRING
		do
			if attached a_prod_opts.filename as l_filename then
				a_prod_opts.get_link
				if attached a_prod_opts.link as lnk then
					Result := lnk
				elseif
					attached a_prod.build as l_build and then
					attached a_prod.name as l_name and then
					attached a_prod.number as l_number
				then
					create Result.make_from_string (a_mirror)
					Result.append (url_encoded (l_name))
					Result.append_character (' ')
					Result.append (url_encoded (l_number))
					Result.append_character ('/')
					Result.append (url_encoded (l_build))
					Result.append_character ('/')
					Result.append (url_encoded (l_filename))
				end
			end
		end

	retrieve_by_release_and_platform (req: WSF_REQUEST; res: WSF_RESPONSE; a_release: READABLE_STRING_32; a_platform: READABLE_STRING_32): HM_WEBAPI_RESPONSE
		local
			l_list: LIST [EIFFEL_DOWNLOAD_RESOURCE]
			l_url: STRING
			l_product: DOWNLOAD_PRODUCT
			l_prod_options: DOWNLOAD_PRODUCT_OPTIONS
		do
			Result := new_response (req, res)
			if attached download_api as l_download_api then
				if
					a_release.is_case_insensitive_equal ("all") and then
					a_platform.is_case_insensitive_equal ("all") and then
					attached l_download_api.download_channel_configuration (Void) as cfg and then
					attached l_download_api.retrieve_public_products (cfg) as l_all_products and then
					attached l_download_api.retrieve_mirror (cfg) as l_mirror
				then
						-- all releases and all platforms.
					across
						l_all_products as ic
					loop
						l_product := ic.item
						if
							attached l_product.number as l_number and then
							attached l_product.downloads as l_downloads
						then
							create {ARRAYED_LIST [EIFFEL_DOWNLOAD_RESOURCE]} l_list.make (l_downloads.count)
							across l_downloads as ic1 loop
								l_prod_options := ic1.item
								if
									attached l_prod_options.filename as l_filename and then
									attached product_options_link (l_product, l_prod_options, l_mirror) as l_link
								then
									l_url := l_link.twin
									l_list.force (create {EIFFEL_DOWNLOAD_RESOURCE}.make (l_filename, l_url, l_prod_options.size, l_prod_options.platform))
								end
							end
							Result.add_iterator_field ("downloads_" + l_number , l_list)
						end
					end
				elseif
						-- specific release all platforms
					a_release.is_case_insensitive_equal ("all") and then
					not a_platform.is_case_insensitive_equal ("all") and then
					attached l_download_api.download_channel_configuration (Void) as cfg and then
					attached l_download_api.retrieve_products (cfg) as l_all_products and then
					attached l_download_api.retrieve_mirror (cfg) as l_mirror
				then
						-- all releases and specific platform.
					across
						l_all_products as ic
					loop
						if
							attached ic.item.number as l_number and then
							attached ic.item.downloads as l_downloads
						then
							create {ARRAYED_LIST [EIFFEL_DOWNLOAD_RESOURCE]} l_list.make (l_downloads.count)
							across l_downloads as ic1 loop
								l_prod_options := ic1.item
								if
									attached l_prod_options.filename as l_filename and then
									attached l_prod_options.platform as l_platform and then
									l_platform.is_case_insensitive_equal (a_platform)
								then
									if attached product_options_link (ic.item, l_prod_options, l_mirror) as l_link then
										l_url := l_link.twin
										l_list.force (create {EIFFEL_DOWNLOAD_RESOURCE}.make (l_filename, l_url, l_prod_options.size, l_prod_options.platform))
									end
								end
							end
							Result.add_iterator_field ("downloads_" + l_number , l_list)
						end
					end
				elseif
						-- specific release and specific platform
					not a_release.is_case_insensitive_equal ("all") and then
					not a_platform.is_case_insensitive_equal ("all") and then
					attached l_download_api.download_channel_configuration (Void) as cfg and then
					attached l_download_api.retrieve_public_product_by_version (cfg, a_release) as prod and then
					attached l_download_api.retrieve_mirror (cfg) as l_mirror and then
					attached prod.build as l_build and then
					attached prod.name as l_name and then
					attached prod.version as l_version and then
					attached prod.number as l_number
				then
					Result.add_string_field ("name", l_name)
					Result.add_string_field ("build", l_build)
					Result.add_string_field ("version", l_version)
					Result.add_string_field ("number", l_number)
						-- filter by platform
					if
						attached l_download_api.selected_platform (prod.downloads, a_platform) as l_selected and then
						attached l_selected.filename as l_filename and then
						attached product_options_link (prod, l_selected, l_mirror) as l_link
					then
						Result.add_link ("download", utf_8_encoded (l_filename), l_link)
					end
				end
			else
				Result := new_error_response ("Internal Server Error, module not available", req, res)
				Result.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
			end
		end

	retrieve_by_release (req: WSF_REQUEST; res: WSF_RESPONSE; a_release: READABLE_STRING_32): HM_WEBAPI_RESPONSE
				-- Retrieve EiffelStudio filtered by release 'a_release'.
		local
			l_list: LIST [EIFFEL_DOWNLOAD_RESOURCE]
			l_url: STRING
			l_prod_options: DOWNLOAD_PRODUCT_OPTIONS
		do
			Result := new_response (req, res)
			if attached download_api as l_download_api then
				if a_release.is_case_insensitive_equal ("all") then
					Result := retrieve_by_release_and_platform (req, res, "all", "all")
				elseif
					attached l_download_api.download_channel_configuration (Void) as cfg and then
					attached l_download_api.retrieve_public_product_by_version (cfg, a_release) as l_product and then
				  	attached l_download_api.retrieve_mirror (cfg) as l_mirror and then
				   	attached l_product.build as l_build and then
				  	attached l_product.name as l_name and then
				  	attached l_product.version as l_version and then
				   	attached l_product.number as l_number
				then
							-- filter by release
					Result.add_string_field ("name", l_name)
					Result.add_string_field ("build", l_build)
					Result.add_string_field ("version", l_version)
					Result.add_string_field ("number", l_number)
					if attached l_product.downloads as l_downloads then
						create {ARRAYED_LIST [EIFFEL_DOWNLOAD_RESOURCE]} l_list.make (l_downloads.count)
						across l_downloads as ic loop
							l_prod_options := ic.item
							if
								attached l_prod_options.filename as l_filename and then
								attached l_prod_options.platform as l_platform and then
								attached product_options_link (l_product, l_prod_options, l_mirror) as l_link
							then
								create l_url.make_from_string (l_link)
								l_list.force (create {EIFFEL_DOWNLOAD_RESOURCE}.make (l_filename, l_url, l_prod_options.size, l_platform))
							end
						end
						Result.add_iterator_field ("downloads", l_list)
					end
				else
					Result := new_error_response ("Release [" + a_release  +"] not found" , req, res)
					Result.set_status_code ({HTTP_STATUS_CODE}.bad_request)
				end
			else
				Result := new_error_response ("Internal Server Error, module not available", req, res)
				Result.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
			end
		end

	retrieve_all_public_products (a_channel: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE): HM_WEBAPI_RESPONSE
				-- Retrieve all EiffelStudio available downloads from channel `a_channel` (or stable if not defined).
		local
			l_list: LIST [EIFFEL_DOWNLOAD_RESOURCE]
			l_url: STRING_8
			l_prod_options: DOWNLOAD_PRODUCT_OPTIONS
		do
			Result := new_response (req, res)
			if attached download_api as l_download_api then
				if
					attached l_download_api.download_channel_configuration (a_channel) as cfg and then
					attached l_download_api.retrieve_public_product (cfg) as l_product and then
					attached l_download_api.retrieve_mirror (cfg) as l_mirror and then
					attached l_product.build as l_build and then
					attached l_product.name as l_name and then
					attached l_product.version as l_version and then
					attached l_product.number as l_number
				then
					Result.add_string_field ("name", l_name)
					Result.add_string_field ("build", l_build)
					Result.add_string_field ("version", l_version)
					Result.add_string_field ("number", l_number)
					if attached l_product.downloads as l_downloads then
						create {ARRAYED_LIST [EIFFEL_DOWNLOAD_RESOURCE]} l_list.make (1)
						across l_downloads as ic loop
							l_prod_options := ic.item
							if
								attached l_prod_options.filename as l_filename and then
								attached l_prod_options.platform as l_platform and then
								attached product_options_link (l_product, l_prod_options, l_mirror) as l_link
							then
								create l_url.make_from_string (l_link)
								l_list.force (create {EIFFEL_DOWNLOAD_RESOURCE}.make (l_filename, l_url, l_prod_options.size, l_platform))
							end
						end
						Result.add_iterator_field ("downloads", l_list)
					end
				end
			else
				Result := new_error_response ("Internal Server Error, module not available", req, res)
				Result.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
			end
		end

	is_valid_version (a_version: READABLE_STRING_GENERAL): BOOLEAN
			-- Is version 'a_version' valid?
			-- major_minor
			-- format {XY}_{WZ}
		do
			if a_version.count = 5 then
					-- Check XY are digits
				if
					a_version [1].is_digit and then
					a_version [2].is_digit
				then
						-- Check character at(3) '_'
					if a_version [3] = '_' then
						if
							a_version [4].is_digit and then
							a_version [5].is_digit
						then
							Result := True
						end
					end
				end
			elseif a_version.is_case_insensitive_equal ("all") then
				Result := True
			end
		end

	process_uploaded_file (a_uploaded_file: WSF_UPLOADED_FILE): detachable EIFFEL_UPLOAD_CONFIGURATION
			-- process the uploaded file.
		do
			if attached a_uploaded_file.tmp_path as l_path then
				Result := (create {EIFFEL_UPLOAD_JSON_CONFIGURATION}).configuration_from_uploaded_json_file (l_path)
				delete_uploaded_file (l_path)
			end
		end

	process_uploaded_data (a_uploaded_data: STRING): detachable EIFFEL_UPLOAD_CONFIGURATION
			-- process the uploaded data.
		do
			Result := (create {EIFFEL_UPLOAD_JSON_CONFIGURATION}).configuration_from_uploaded_json_string (a_uploaded_data)
		end

	delete_uploaded_file (p: PATH)
			-- Remove uploaded temporal file at path `p'.
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if retried then
				write_error_log (generator.to_string_32 + {STRING_32} "Can not delete file %"" + p.name + "%"")
			else
				create f.make_with_path (p)
				if f.exists then
					f.delete
				else
						-- Not considered as failure.
				end
			end
		rescue
			retried := True
			retry
		end

	release_version_dot_format (a_version: READABLE_STRING_GENERAL): STRING_32
			-- Release version XY_ZW as XY.ZW
		require
			 is_valid: is_valid_version (a_version)
		do
			create Result.make_from_string_general (a_version)
			Result.replace_substring_all ("_", ".")
		end

feature {NONE} -- Implementation

	available_channels: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			Result := download_api.channels
		end

	available_channels_to_string (sep: CHARACTER): STRING_32
		do
			create Result.make (10)
			across
				available_channels as ic
			loop
				if not Result.is_empty then
					Result.append_character (sep)
				end
				Result.append_string_general (ic.item)
			end
		end

	is_valid_channel (a_channel: READABLE_STRING_GENERAL): BOOLEAN
			-- Is channel a known `a_channel`?
		do
			Result := download_api.is_channel_available (a_channel)
		end

end
