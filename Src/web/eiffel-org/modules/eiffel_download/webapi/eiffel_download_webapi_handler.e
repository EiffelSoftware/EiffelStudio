note
	description: "Summary description for {EIFFEL_DOWNLOAD_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DOWNLOAD_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER

	WSF_URI_TEMPLATE_HANDLER

	SHARED_LOGGER

create
	make

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

feature -- Execution GET

	 execute_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: HM_WEBAPI_RESPONSE
			l_value: STRING
			l_channel: STRING
		do
			if api.has_permissions (<<"view downloads">>) then
				if attached {WSF_STRING} req.path_parameter ("channel") as ll_channel and then
					is_valid_channel (ll_channel.value)
				then
					l_channel := ll_channel.value
					if  attached {WSF_STRING} req.path_parameter ("release") as l_release then
						l_value := l_release.value
						if is_valid_version (l_value) then
							if attached {WSF_STRING} req.query_parameter ("platform") as l_platform then
								if is_valid_platform (l_platform.value) then
										-- retrieve product by platform and release.
									rep := retrieve_by_release_and_platform (req, res, l_value, l_platform.value)
								else
										-- Invalid Platform
									rep := new_error_response ("Platform [" + l_platform.value + "] invalid", req, res)
									rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
								end
							else
									-- retrieve product by release
								rep := retrieve_by_release (req, res, l_value)
							end
						else
								-- Invalid Release
							rep := new_error_response ("Release [" + l_value + "] invalid" , req, res)
							rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
						end
					elseif
						l_channel.same_string_general ("beta")
					then
							-- Beta Channel Release
						rep := retrieve_all_beta_products (req, res)
					else
							-- retrieve all available products by default using the latst release.
						rep := retrieve_all_products (req, res)
					end
				else
						-- Invalid Channel
					rep := new_error_response ("Invalid channel, valid values are: [stable|beta]" , req, res)
					rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
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
				if attached {WSF_STRING} req.path_parameter ("channel") as l_channel and then
					is_valid_channel (l_channel.value)
				then
					if
						attached {WSF_STRING} req.path_parameter ("release") as l_release and then
						req.query_string.is_empty and then
						is_valid_version (l_release.value) and then
						not l_release.value.is_case_insensitive_equal ("all")
					then
						create l_dir.make_with_path (api.module_location_by_name ("eiffel_download"))

						if l_dir.exists  then
							create {RAW_FILE} l_file.make_open_write (l_dir.path.extended("channel").extended (l_channel.value).extended ("downloads_configuration_" + release_version_dot_format (l_release.value)+ ".json").name.out)
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
					rep := new_error_response ("Invalid channel, valid values are: [stable|beta]" , req, res)
					rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
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
				if attached {WSF_STRING} req.path_parameter ("channel") as l_channel and then
					is_valid_channel (l_channel.value)
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
							create l_dir.make_with_path (api.module_location_by_name ("eiffel_download").extended ("channel").extended(l_channel.value))
							if l_dir.exists then
								create {RAW_FILE} l_file.make_open_write (l_dir.path.extended ("downloads_configuration_" + l_uploaded.number + ".json").name.out)
								l_file.put_string (l_uploaded.to_json_representation)
								l_file.close
							end
							rep.add_string_field ("Success", "File uploaded")
							rep.add_string_field ("Filename", "downloads_configuration_" + l_uploaded.number + ".json")
						else
							rep := new_error_response ("Bad file format" , req, res)
							rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
						end
					elseif l_data /= void then
						if attached  process_uploaded_data (l_data) as l_uploaded then
							create l_dir.make_with_path (api.module_location_by_name ("eiffel_download").extended ("channel").extended(l_channel.value))
							if l_dir.exists then
								create {RAW_FILE} l_file.make_open_write (l_dir.path.extended ("downloads_configuration_" + l_uploaded.number + ".json").name.out)
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
					rep := new_error_response ("Invalid channel, valid values are: [stable|beta]" , req, res)
					rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
				end
			else
					-- FIXME: use specific Web API response!
				rep := new_access_denied_error_response (Void, req, res)
			end
			rep.execute
		end


feature {NONE} -- Implementation

	retrieve_by_release_and_platform (req: WSF_REQUEST; res: WSF_RESPONSE; a_release: READABLE_STRING_32; a_platform: READABLE_STRING_32): HM_WEBAPI_RESPONSE
		local
			l_link: STRING
			l_list: LIST [EIFFEL_DOWNLOAD_RESOURCE]
			l_url: STRING
		do
			Result := new_response (req, res)
			if
				attached {EIFFEL_DOWNLOAD_API} api.module_api ({EIFFEL_DOWNLOAD_MODULE}) as l_download
			then
				if
					a_release.is_case_insensitive_equal ("all") and then
					a_platform.is_case_insensitive_equal ("all") and then
					attached l_download.download_stable_configuration as cfg and then
					attached l_download.retrieve_products (cfg) as l_all_products  and then
					attached l_download.retrieve_mirror_gpl (cfg) as l_mirror
				then
						-- all releases and all platforms.
					across l_all_products as ic
					loop
						if
							attached ic.item.downloads as l_downloads and then
							attached ic.item.name as l_name and then
							attached ic.item.number as l_number and then
							attached ic.item.build as l_build
						then
							create {ARRAYED_LIST [EIFFEL_DOWNLOAD_RESOURCE]} l_list.make (1)
							l_link := l_mirror
							l_link.append_character ('/')
							l_link.append (url_encoded (l_name))
							l_link.append_character (' ')
							l_link.append (url_encoded (l_number))
							l_link.append_character ('/')
							l_link.append (url_encoded (l_build))
							l_link.append_character ('/')
							across l_downloads as ic1  loop
								if
									attached ic1.item.filename as l_filename and then
									attached ic1.item.platform as l_platform
								then
									create l_url.make_from_string (l_link)
									l_url.append (url_encoded (l_filename))
									l_list.force (create {EIFFEL_DOWNLOAD_RESOURCE}.make (l_filename, l_url, ic1.item.size, l_platform))
								end
							end
							Result.add_iterator_field ("downloads_" + l_number , l_list)
						end
					end
				elseif
						-- specific release all platforms
					a_release.is_case_insensitive_equal ("all") and then
					not a_platform.is_case_insensitive_equal ("all") and then
					attached l_download.download_stable_configuration as cfg and then
					attached l_download.retrieve_mirror_gpl (cfg) as l_mirror and then
					attached l_download.retrieve_products (cfg) as l_all_products
				then
						-- all releases and specific platform.
					across l_all_products as ic
					loop
						if
							attached ic.item.downloads as l_downloads and then
							attached ic.item.name as l_name and then
							attached ic.item.number as l_number and then
							attached ic.item.build as l_build
						then
							create {ARRAYED_LIST [EIFFEL_DOWNLOAD_RESOURCE]} l_list.make (1)
							l_link := l_mirror
							l_link.append_character ('/')
							l_link.append (url_encoded (l_name))
							l_link.append_character (' ')
							l_link.append (url_encoded (l_number))
							l_link.append_character ('/')
							l_link.append (url_encoded (l_build))
							l_link.append_character ('/')
							across l_downloads as ic1  loop
								if
									attached ic1.item.filename as l_filename and then
									attached ic1.item.platform as l_platform and then
									l_platform.is_case_insensitive_equal (a_platform)
								then
									create l_url.make_from_string (l_link)
									l_url.append (url_encoded (l_filename))
									l_list.force (create {EIFFEL_DOWNLOAD_RESOURCE}.make (l_filename, l_url, ic1.item.size, l_platform))
								end
							end
							Result.add_iterator_field ("downloads_" + l_number , l_list)
						end
					end
				elseif
						-- specific release and specific platform
					not a_release.is_case_insensitive_equal ("all") and then
					not a_platform.is_case_insensitive_equal ("all") and then
					attached l_download.download_stable_configuration as cfg and then
					attached l_download.retrieve_product_gpl_by_version (cfg, a_release) as l_product and then
					attached l_download.retrieve_mirror_gpl (cfg) as l_mirror and then
					attached l_product.build as l_build and then
					attached l_product.name as l_name and then
					attached l_product.version as l_version and then
					attached l_product.number as l_number
				then
					Result.add_string_field ("name", l_name)
					Result.add_string_field ("build", l_build)
					Result.add_string_field ("version", l_version)
					Result.add_string_field ("number", l_number)
						-- filter by plarform
					l_link := l_mirror
					l_link.append_character ('/')
					l_link.append (url_encoded (l_name))
					l_link.append_character (' ')
					l_link.append (url_encoded (l_number))
					l_link.append_character ('/')
					l_link.append (url_encoded (l_build))
					l_link.append_character ('/')

					if
						attached l_download.selected_platform (l_product.downloads, a_platform) as l_selected and then
						attached l_selected.filename as l_filename
					then
						l_link.append (url_encoded (l_filename))
						Result.add_string_field ("name", l_name)
						Result.add_string_field ("build", l_build)
						Result.add_string_field ("version", l_version)
						Result.add_string_field ("number", l_number)
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
			l_link: STRING
			l_list: LIST [EIFFEL_DOWNLOAD_RESOURCE]
			l_url: STRING
		do
			Result := new_response (req, res)
			if
				attached {EIFFEL_DOWNLOAD_API} api.module_api ({EIFFEL_DOWNLOAD_MODULE}) as l_download
			then
				if a_release.is_case_insensitive_equal ("all") then
					Result := retrieve_by_release_and_platform (req, res, "all", "all")
				elseif
					attached l_download.download_stable_configuration as cfg and then
					attached l_download.retrieve_product_gpl_by_version (cfg, a_release) as l_product and then
				   	attached l_product.build as l_build and then
				  	attached l_product.name as l_name and then
				  	attached l_product.version as l_version and then
				   	attached l_product.number as l_number and then
				  	attached l_download.retrieve_mirror_gpl (cfg) as l_mirror
				then
							-- filter by release
					Result.add_string_field ("name", l_name)
					Result.add_string_field ("build", l_build)
					Result.add_string_field ("version", l_version)
					Result.add_string_field ("number", l_number)
					if attached l_product.downloads as l_downloads then
						l_link := l_mirror
						l_link.append_character ('/')
						l_link.append (url_encoded (l_name))
						l_link.append_character (' ')
						l_link.append (url_encoded (l_number))
						l_link.append_character ('/')
						l_link.append (url_encoded (l_build))
						l_link.append_character ('/')
						create {ARRAYED_LIST [EIFFEL_DOWNLOAD_RESOURCE]} l_list.make (1)
						across l_downloads as ic  loop
							if
								attached ic.item.filename as l_filename and then
								attached ic.item.platform as l_platform
							then
								create l_url.make_from_string (l_link)
								l_url.append (url_encoded (l_filename))
								l_list.force (create {EIFFEL_DOWNLOAD_RESOURCE}.make (l_filename, l_url, ic.item.size, l_platform))
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

	retrieve_all_products (req: WSF_REQUEST; res: WSF_RESPONSE): HM_WEBAPI_RESPONSE
				-- Retrieve all EiffelStudio available downloads.
		local
			l_list: LIST [EIFFEL_DOWNLOAD_RESOURCE]
			l_link: STRING_8
			l_url: STRING_8
		do
			Result := new_response (req, res)
			if
				attached {EIFFEL_DOWNLOAD_API} api.module_api ({EIFFEL_DOWNLOAD_MODULE}) as l_download
			then
				if attached l_download.download_stable_configuration as cfg and then
					attached l_download.retrieve_product_gpl (cfg) as l_product and then
					attached l_product.build as l_build and then
					attached l_product.name as l_name and then
					attached l_product.version as l_version and then
					attached l_product.number as l_number and then
					attached l_download.retrieve_mirror_gpl (cfg) as l_mirror
				then
					Result.add_string_field ("name", l_name)
					Result.add_string_field ("build", l_build)
					Result.add_string_field ("version", l_version)
					Result.add_string_field ("number", l_number)
					if attached l_product.downloads as l_downloads then
						l_link := l_mirror
						l_link.append_character ('/')
						l_link.append (url_encoded (l_name))
						l_link.append_character (' ')
						l_link.append (url_encoded (l_number))
						l_link.append_character ('/')
						l_link.append (url_encoded (l_build))
						l_link.append_character ('/')
						create {ARRAYED_LIST [EIFFEL_DOWNLOAD_RESOURCE]} l_list.make (1)
						across l_downloads as ic  loop
							if
								attached ic.item.filename as l_filename and then
								attached ic.item.platform as l_platform
							then
								create l_url.make_from_string (l_link)
								l_url.append (url_encoded (l_filename))
								l_list.force (create {EIFFEL_DOWNLOAD_RESOURCE}.make (l_filename, l_url, ic.item.size, l_platform))
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

	retrieve_all_beta_products (req: WSF_REQUEST; res: WSF_RESPONSE): HM_WEBAPI_RESPONSE
				-- Retrieve all EiffelStudio available beta downloads.
		local
			l_list: LIST [EIFFEL_DOWNLOAD_RESOURCE]
			l_link: STRING_8
			l_url: STRING_8
		do
			Result := new_response (req, res)
			if
				attached {EIFFEL_DOWNLOAD_API} api.module_api ({EIFFEL_DOWNLOAD_MODULE}) as l_download
			then
				if
					attached l_download.download_channel_configuration ("beta") as cfg and then
					attached l_download.retrieve_product_gpl (cfg) as l_product and then
					attached l_product.build as l_build and then
					attached l_product.name as l_name and then
					attached l_product.version as l_version and then
					attached l_product.number as l_number and then
					attached l_download.retrieve_mirror_gpl (cfg) as l_mirror
				then
					Result.add_string_field ("name", l_name)
					Result.add_string_field ("build", l_build)
					Result.add_string_field ("version", l_version)
					Result.add_string_field ("number", l_number)
					if attached l_product.downloads as l_downloads then
						l_link := l_mirror
						l_link.append_character ('/')
						l_link.append (url_encoded (l_name))
						l_link.append_character (' ')
						l_link.append (url_encoded (l_number))
						l_link.append_character ('/')
						l_link.append (url_encoded (l_build))
						l_link.append_character ('/')
						create {ARRAYED_LIST [EIFFEL_DOWNLOAD_RESOURCE]} l_list.make (1)
						across l_downloads as ic  loop
							if
								attached ic.item.filename as l_filename and then
								attached ic.item.platform as l_platform
							then
								create l_url.make_from_string (l_link)
								l_url.append (url_encoded (l_filename))
								l_list.force (create {EIFFEL_DOWNLOAD_RESOURCE}.make (l_filename, l_url, ic.item.size, l_platform))
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

	is_valid_platform (a_platform: READABLE_STRING_32): BOOLEAN
			-- Is platform 'a_platform' valid?
		do
			if
				a_platform.is_case_insensitive_equal_general ("solaris-x86-64") or else
				a_platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") or else
				a_platform.is_case_insensitive_equal_general ("linux-x86-suncc") or else
				a_platform.is_case_insensitive_equal_general ("macosx-x86-64") or else
				a_platform.is_case_insensitive_equal_general ("freebsd-x86-64") or else
				a_platform.is_case_insensitive_equal_general ("windows") or else
				a_platform.is_case_insensitive_equal_general ("linux-x86-64") or else
				a_platform.is_case_insensitive_equal_general ("openbsd-x86-64") or else
				a_platform.is_case_insensitive_equal_general ("freebsd-x86") or else
				a_platform.is_case_insensitive_equal_general ("solaris-sparc-64") or else
				a_platform.is_case_insensitive_equal_general ("linux-armv6") or else
				a_platform.is_case_insensitive_equal_general ("solaris-sparc") or else
				a_platform.is_case_insensitive_equal_general ("solaris-x86") or else
				a_platform.is_case_insensitive_equal_general ("linux-x86") or else
				a_platform.is_case_insensitive_equal_general ("win64") or else
				a_platform.is_case_insensitive_equal_general ("all")
			then
				Result := True
			end
		end

	is_valid_version (a_version: READABLE_STRING_32): BOOLEAN
			-- Is version 'a_version' valid?
			-- major_minor
			-- format {XY}_{WZ}
		do
			if a_version.count = 5 then
					-- Check XY are digits
				if
					a_version.at (1).is_digit and then
					a_version.at (2).is_digit
				then
						-- Check character at(3) '_'
					if a_version.at (3).is_equal ('_') then
						if
							a_version.at (4).is_digit and then
							a_version.at (5).is_digit
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
		local
			s: STRING
		do
			s := (create {CMS_ENCODERS}).utf_8_encoded (a_uploaded_data)
			Result := (create {EIFFEL_UPLOAD_JSON_CONFIGURATION}).configuration_from_uploaded_json_string (a_uploaded_data)
		end

	delete_uploaded_file (p: PATH)
			-- Remove uploaded temporal file at path `p'.
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if retried then
				write_error_log (generator + {STRING_32} "Can not delete file %"" + p.name + "%"")
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

	release_version_dot_format (a_version: READABLE_STRING_32): READABLE_STRING_32
			-- Release version XY_ZW as XY.ZW
		require
			 is_valid: is_valid_version (a_version)
		local
			l_result: STRING
		do
			create l_result.make_from_string (a_version)
			l_result.replace_substring_all ("_", ".")
			Result := l_result
		end

feature {NONE} --NONE

	is_valid_channel (a_channel: READABLE_STRING_GENERAL): BOOLEAN
			-- Is channel a `a_channel` stable or beta?
		do
			Result := a_channel.is_case_insensitive_equal ("stable") or else  a_channel.is_case_insensitive_equal ("beta")
		end


end
