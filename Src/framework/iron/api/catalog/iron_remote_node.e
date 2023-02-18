note
	description: "[
			Objects that access the remote iron server node.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REMOTE_NODE

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make_with_repository

feature {NONE} -- Initialization

	make_with_repository (a_urls: IRON_URL_BUILDER; a_api_version: IMMUTABLE_STRING_8; a_repo: IRON_WEB_REPOSITORY)
			-- Initialize `Current'.
		do
			urls := a_urls
			api_version := a_api_version
			repository := a_repo
		end

	urls: IRON_URL_BUILDER

	api_version: IMMUTABLE_STRING_8

feature -- Access

	repository: IRON_WEB_REPOSITORY

	packages: detachable LIST [IRON_PACKAGE]
		local
			sess: like new_session
			res: HTTP_CLIENT_RESPONSE
			f: JSON_TO_IRON_FACTORY
		do
			last_operation_succeed := False
			last_operation_error_message := Void
			sess := new_session (repository.server_uri.string)
			res := sess.get (urls.path_package_list (repository), Void)
			if res.error_occurred then
				last_operation_succeed := False
				last_operation_error_message := "ERROR: connection failed"
			elseif attached res.body as l_body then
				last_operation_succeed := True
				create {ARRAYED_LIST [IRON_PACKAGE]} Result.make (5)
				create f
				if attached f.json_to_packages (l_body, repository) as lst then
					across
						lst as p
					loop
						Result.force (p)
					end
				else
					last_operation_succeed := False
					last_operation_error_message := "ERROR: invalid package data"
					Result := Void
				end
			else
				last_operation_succeed := False
				last_operation_error_message := "ERROR: empty response body"
			end
		end

	download_package_archive (a_package: IRON_PACKAGE; a_filename: PATH; a_ignore_cache: BOOLEAN)
			-- Download archive for `a_package' as file `filename'.
			-- If `a_ignore_cache' is True then always download
			-- otherwise download only if there is a newer version.
		require
			a_package_has_archive_uri: a_package.has_archive_uri
			a_filename_folder_exists: (create {FILE_UTILITIES}).directory_path_exists (a_filename.parent)
		local
			sess: like new_session
			ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			f: RAW_FILE
			t: PATH
			hdate: HTTP_DATE
			h: HTTP_HEADER
			res: HTTP_CLIENT_RESPONSE
		do
			if attached a_package.archive_uri as l_uri then
				sess := new_session (l_uri.string)
				create ctx.make
				sess.set_timeout (0) -- never timeout

				create f.make_with_path (a_filename)
				if f.exists then
					if a_ignore_cache then
						f.delete
					else
						create h.make_with_count (1)
						create hdate.make_from_timestamp (f.date)
						h.put_header_key_value ({HTTP_HEADER_NAMES}.header_if_modified_since, hdate.rfc1123_string)
						ctx.add_header_lines (h)
					end
				end
				t := a_filename.appended_with_extension ("tmp-download")
				create f.make_with_path (t)
				f.create_read_write
				ctx.set_output_content_file (f)
				res := sess.get ("", ctx)
				if res.error_occurred then
					f.close
					f.delete
				else
					f.close
					if res.status = {HTTP_STATUS_CODE}.not_modified then
						f.delete
					else
						f.rename_path (a_filename)
						if f.exists and then f.is_empty then
								-- No empty package !!!
							f.delete
						end
					end
				end
			else
				check a_package_has_archive_uri: False end
				create f.make_with_path (a_filename)
				if f.exists then
					f.delete
				end
			end
		end

feature -- Operation

	last_operation_succeed: BOOLEAN

	last_operation_error_message: detachable READABLE_STRING_8

	publish_package (a_id, a_name, a_title, a_description: detachable READABLE_STRING_32; a_package_file_location: detachable PATH;
				a_package: detachable IRON_PACKAGE; a_published_package_cell: detachable CELL [detachable IRON_PACKAGE];
				a_user, a_password: READABLE_STRING_32)
		require
			same_repository: a_package /= Void implies repository.is_same_repository (a_package.repository)
		local
			sess: like new_auth_session
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			res: HTTP_CLIENT_RESPONSE
			f: JSON_TO_IRON_FACTORY
		do
			last_operation_succeed := False
			last_operation_error_message := Void
			sess := new_auth_session (repository.server_uri.string, a_user, a_password)
			if a_package /= Void then
				check same_repo: repository.is_same_repository (a_package.repository) end
--				sess := new_auth_session (a_package.repository.remote_repository.server_uri.string, a_user, a_password)
			end
			sess.set_timeout (0) -- never timeout
			create ctx.make_with_credentials_required
			if a_id /= Void then
				ctx.add_form_parameter ("id", a_id)
			end
			if a_name /= Void then
				ctx.add_form_parameter ("name", a_name)
			end
			if a_title /= Void then
				ctx.add_form_parameter ("title", a_title)
			end
			if a_description /= Void then
				ctx.add_form_parameter ("description", a_description)
			end
			if a_package_file_location /= Void and then attached file_content (a_package_file_location) as l_info then
				ctx.add_form_parameter ("package_info", l_info)
			end
			if a_package = Void then
				res := sess.post (urls.path_create_package (repository), ctx, Void)
			else
				res := sess.post (urls.path_update_package (repository, a_package), ctx, Void)
--				res := sess.post (urls.path_update_package (a_package.repository.remote_repository, a_package), ctx, Void)				
			end
			if res.error_occurred then
				last_operation_succeed := False
				if attached res.error_message as errmsg then
					last_operation_error_message := "[Error] Publish package failed!%N" + errmsg
				else
					last_operation_error_message := "[Error] Publish package failed!"
				end
			elseif res.status = 401 then
				last_operation_succeed := False
				if attached res.body as l_body then
					last_operation_error_message := "[Error] Publish package not authorized!" + l_body
				else
					last_operation_error_message := "[Error] Publish package not authorized!"
				end
			elseif res.status = 500 then
				last_operation_succeed := False
				last_operation_error_message := "[Error] Server reported internal error!"
			else
				last_operation_succeed := True
				if
					a_published_package_cell /= Void and then
					attached res.body as l_body
				then
					create f
					if attached f.json_to_package_within_repository (l_body, repository) as l_package then
						a_published_package_cell.replace (l_package)
					end
				end
			end
			debug
				if attached res.body as l_body then
					print (l_body)
					print ('%N')
				end
			end
		end

	add_indexes (a_package: IRON_PACKAGE;
			a_indexes: ITERABLE [READABLE_STRING_32];
			a_user, a_password: READABLE_STRING_32)
		require
			a_package_has_id: a_package.has_id
			same_repository: repository.is_same_repository (a_package.repository)
		local
			sess: like new_auth_session
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			res: HTTP_CLIENT_RESPONSE
		do
			last_operation_succeed := False
			last_operation_error_message := Void
			sess := new_auth_session (repository.server_uri.string, a_user, a_password)
			create ctx.make_with_credentials_required
			ctx.add_form_parameter ("id", a_package.id.to_string_32)
			across
				a_indexes as ic
			loop
				ctx.add_form_parameter ("map[]", ic.to_string_8)
			end
			res := sess.post (urls.path_add_package_index (repository, a_package), ctx, Void)
			if res.error_occurred then
				last_operation_succeed := False
				if attached res.error_message as errmsg then
					last_operation_error_message := "[Error] Adding maps failed!%N" + errmsg
				else
					last_operation_error_message := "[Error] Adding maps failed!"
				end
			elseif res.status = 401 then
				last_operation_succeed := False
				last_operation_error_message := "[Error] Adding maps not authorized!"
			else
				last_operation_succeed := True
			end
		end

	upload_package_archive (a_package: IRON_PACKAGE; a_archive: IRON_ARCHIVE; a_user, a_password: READABLE_STRING_32; a_out_body: detachable CELL [detachable READABLE_STRING_8])
		require
			a_package_has_id: a_package.has_id
			same_repository: repository.is_same_repository (a_package.repository)
		local
			sess: like new_auth_session
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			res: HTTP_CLIENT_RESPONSE
		do
			last_operation_succeed := False
			last_operation_error_message := Void
			sess := new_auth_session (repository.server_uri.string, a_user, a_password)
			create ctx.make_with_credentials_required
			ctx.set_upload_filename (a_archive.path.name)
			ctx.add_header ("Content-Type", "application/zip")
			sess.set_timeout (0) -- Never timeout ...
			res := sess.post (urls.path_upload_package_archive (repository, a_package), ctx, Void)
			if a_out_body /= Void then
				a_out_body.replace (res.body)
			end
			if res.error_occurred then
				last_operation_succeed := False
				if attached res.error_message as errmsg then
					last_operation_error_message := "[Error] archive uploading failed!%N" + errmsg
				else
					last_operation_error_message := "[Error] archive uploading failed [" + res.status.out+ "]!"
				end
			elseif res.status = 401 then
				last_operation_succeed := False
				last_operation_error_message := "[Error] archive uploading not authorized!"
			elseif res.status = 404 then
				last_operation_succeed := False
				last_operation_error_message := "[Error] package not found!"
			else
					--| TODO: check conherence of size and hash value.
				last_operation_succeed := True
			end
			ctx.set_upload_filename (Void)
		end

	delete_package (a_package: IRON_PACKAGE; a_user, a_password: READABLE_STRING_32)
			-- Delete package `a_package' using credential `a_user:a_password'
			-- Set `last_operation_succeed' and `last_operation_error_message'
			--  accordingly with operation result.
		require
			same_repository: repository.is_same_repository (a_package.repository)
		local
			sess: like new_auth_session
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			res: HTTP_CLIENT_RESPONSE
		do
			last_operation_succeed := False
			last_operation_error_message := Void
			sess := new_auth_session (repository.server_uri.string, a_user, a_password)
			create ctx.make_with_credentials_required
			res := sess.delete (urls.path_package_delete (repository, a_package), ctx)
			if res.error_occurred then
				last_operation_succeed := False
				if attached res.error_message as errmsg then
					last_operation_error_message := "[Error] Delete package failed!%N" + errmsg
				else
					last_operation_error_message := "[Error] Delete package failed!"
				end
			elseif res.status = 401 then
				last_operation_succeed := False
				last_operation_error_message := "[Error] Delete package not authorized!"
			else
				last_operation_succeed := True
			end
		end

feature {NONE} -- Implementation

	http_client: HTTP_CLIENT
		once
			create {DEFAULT_HTTP_CLIENT} Result
		end

	new_auth_session (a_base_url: READABLE_STRING_8; a_user, a_password: READABLE_STRING_32): HTTP_CLIENT_SESSION
		do
			Result := new_session (a_base_url)
			Result.set_credentials (a_user, a_password)
		end

	new_session (a_base_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
		local
			cl: HTTP_CLIENT
		do
			cl := http_client
			Result := cl.new_session (a_base_url)
			if attached proxy_information as l_proxy then
				Result.set_proxy (l_proxy.hostname, l_proxy.port)
			end

			Result.set_connect_timeout (connect_timeout (30)) -- connect timeout: 10 seconds
			Result.set_timeout (timeout (60)) -- timeout = 60 seconds
			Result.set_is_insecure (True)
			Result.add_header ("Accept", "application/json")
			Result.add_header ({IRON_API_CONSTANTS}.iron_http_header_name, api_version)
		end

	proxy_information: detachable TUPLE [hostname: detachable READABLE_STRING_8; port: INTEGER]
			-- Proxy information based on environment variable
			-- specified as "hostname:port"
			--| note: "8888" is same as "hostname:8888"
			--| note: "example.com" is same as "example.com:80"
		local
			l_port, i: INTEGER
			h: detachable READABLE_STRING_8
			s: STRING_8
		do
			if attached execution_environment.item ({IRON_API_CONSTANTS}.iron_proxy_variable_name) as v then
				if v.is_empty or else not v.is_valid_as_string_8 then
				elseif v.is_integer then
					Result := [Void, v.to_integer]
				else
					s := v.to_string_8
					i := s.last_index_of (':', s.count)
					if i > 0 then
						h := s.substring (1, i - 1)
						s := s.substring (i + 1, s.count)
						if s.is_integer then
							l_port := s.to_integer
						end
					else
						h := s
						l_port := 80
					end
					if l_port > 0 then
						Result := [h, l_port]
					end
				end
			end
		end

	connect_timeout (dft: INTEGER): INTEGER
			-- Connect timeout value based on associated IRON environment variable.
			-- If no value is available from environment, then use default `dft'.
		do
			Result := dft
			if attached execution_environment.item ({IRON_API_CONSTANTS}.iron_connect_timeout_variable_name) as v then
				if v.is_empty then
				elseif v.is_integer then
					Result := v.to_integer
				end
			end
		end

	timeout (dft: INTEGER): INTEGER
			-- Timeout value based on associated IRON environment variable.
			-- If no value is available from environment, then use default `dft'.	
		do
			Result := dft
			if attached execution_environment.item ({IRON_API_CONSTANTS}.iron_timeout_variable_name) as v then
				if v.is_empty then
				elseif v.is_integer then
					Result := v.to_integer
				end
			end
		end

	file_content (a_path: PATH): detachable STRING
			-- Eventual content of file at location `a_path'.
		local
			f: RAW_FILE
			done: BOOLEAN
		do
			create f.make_with_path (a_path)
			if f.exists and then f.is_access_readable then
				create Result.make (f.count)
				f.open_read
				from
				until
					done
				loop
					f.read_stream_thread_aware (1024)
					Result.append (f.last_string)
					done := f.last_string.count < 1024 or f.exhausted or f.end_of_file
				end
				f.close
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
