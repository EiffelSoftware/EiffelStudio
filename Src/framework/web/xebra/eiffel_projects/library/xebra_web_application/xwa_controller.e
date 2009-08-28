note
	description: "[
		All controllers used in xeb files have to inherit from this class.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_CONTROLLER

inherit
	ANY
		redefine
			default_create
		end
	XU_SHARED_OUTPUTTER
		undefine
			default_create
		end
	XU_STOPWATCH
		undefine
			default_create
		end


feature -- Initialization

	default_create
			-- Initializes current
		do
			create {XH_REQUEST} current_request.make_empty
			create server_control
			create session.make
		ensure then
			server_control_attached: server_control /= Void
			current_request_attached: current_request /= Void
			session_attached: session /= Void
		end

feature -- Access

	server_control: XWA_SERVER_CONTROL
		-- Used to send commands to the server

	current_request: XH_REQUEST
		-- Represents the current request that was sent by the user

	session: XH_SESSION
		-- Represents the session that belongs to the user that has send the current request

feature -- Render actions

	on_load (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			-- Is called before anything happens with the request or the response.
		require
			a_request_attached: attached a_request
			a_reponse_attached: attached a_response
		do
			-- Do nothing per default
		end

	pre_render (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			-- Is called after on_load and before the page is rendered.
		require
			a_request_attached: attached a_request
			a_reponse_attached: attached a_response
		do
			-- Do nothing per default
		end

	post_render (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			-- Is called after the page has been rendered.
		require
			a_request_attached: attached a_request
			a_reponse_attached: attached a_response
		do
			-- Do nothing per default
		end

feature -- Status Change

	set_current_request (a_request: XH_REQUEST)
			-- Setts current_request.
		require
			a_request_attached: attached a_request
		do
			current_request := a_request
		ensure
			current_request_attached: attached current_request
		end

	set_current_session (a_session: XH_SESSION)
			-- Sets current_session.
		require
			a_session_attached: attached a_session
		do
			session := a_session
		ensure
			current_session_attached: attached session
		end

feature -- Operations

	process_uploaded_single_file (a_target_file_dir: STRING): detachable STRING
			-- Reads filename from request arguments and calls either
			-- interal_iis_process_upload_single_file or internal_apache_process_upload_single_file
			--
			-- `a_target_file_dir': The path to the folder where the file should be written. Can contain environment vars.
			-- `Result': Returns the file name of the created file on success, void otherwise.
		require
			a_target_file_dir_attached: a_target_file_dir /= Void and then not a_target_file_dir.is_empty
		local
			l_source_file: STRING
			l_target_filename: FILE_NAME
		do
			if current_request.is_post then
				l_source_file := current_request.args.twin
					-- Try extract source file
				if l_source_file.starts_with ({XU_CONSTANTS}.Request_file_upload_iis) then
					l_source_file.remove_head ({XU_CONSTANTS}.Request_file_upload_iis.count)
						-- Try extract target filename
					if l_source_file.has_substring ({XU_CONSTANTS}.Request_file_upload_filename) then
						create l_target_filename.make_from_string (a_target_file_dir)
						l_target_filename.set_file_name (l_source_file.substring (l_source_file.substring_index ({XU_CONSTANTS}.Request_file_upload_filename, 1) + {XU_CONSTANTS}.Request_file_upload_filename.count, l_source_file.count))
						l_source_file.remove_tail (l_source_file.count + 1 - l_source_file.substring_index ({XU_CONSTANTS}.Request_file_upload_filename, 1))
						Result := interal_iis_process_upload_single_file (l_source_file, l_target_filename)
					else
						log.eprint ("File upload: Filename missing in upload from IIS", generating_type)
					end
				elseif l_source_file.starts_with ({XU_CONSTANTS}.Request_file_upload_apache) then
					l_source_file.remove_head ({XU_CONSTANTS}.Request_file_upload_apache.count)
					Result := internal_apache_process_upload_single_file (l_source_file, a_target_file_dir)
				else
					log.eprint ("File upload: Unknown uploader identifier " + l_source_file , generating_type)
				end
			else
				log.eprint ("File upload: Invalid request method.", generating_type)
			end
		end

feature {NONE} -- Implementation

	interal_iis_process_upload_single_file (a_source_file: STRING; a_target_file: STRING): detachable STRING
			-- Copy uploaded file to new location
			--
			-- `a_source_file': The path to the tmp file that was created by XebraHandler. Can contain environment vars.
			-- `a_target_file': The path to the target file. Can contain environment vars.
			-- `Result': Returns the file name of the created file on success, void otherwise.
		require
			a_source_file_attached_and_not_empty: a_source_file /= Void and then not a_source_file.is_empty
			a_target_file_attached: a_target_file /= Void and then not a_target_file.is_empty
		local
			l_s_file: RAW_FILE
			l_t_file: RAW_FILE
			l_list: LIST [STRING]
			l_util: XU_FILE_UTILITIES
			l_slash: CHARACTER
		do
			create l_util
			create l_s_file.make (l_util.resolve_env_vars (a_source_file, True))
			create l_t_file.make (l_util.resolve_env_vars (a_target_file, True))
			if l_s_file.exists and l_s_file.is_readable and l_s_file.is_access_readable then
				l_s_file.open_read
				if	not l_t_file.exists and l_t_file.is_creatable then
					l_t_file.create_read_write
					if l_t_file.is_writable and l_s_file.is_access_writable then
						l_s_file.copy_to (l_t_file)
						Result := l_t_file.name
					else
						log.eprint ("File upload: Cannot write into target file " + l_t_file.name , generating_type)
					end
					l_t_file.close
				else
					log.eprint ("File upload: Cannot create target file " + l_t_file.name , generating_type)
				end
				l_s_file.close
			else
				log.eprint ("File upload: Cannot read tmp file " + l_s_file.name , generating_type)
			end
		end

	internal_apache_process_upload_single_file (a_source_file: STRING; a_target_file_dir: STRING): detachable STRING
			-- Copy the uploaded and encoded (single) file to a new place and remove header and footer from it
			-- The uploaded temp file is expected to be in the following format. Other formats will likely result in endless loops!
			-- {BOUNDARY}%R%N
			-- Content-Disposition: form-data; name=%"{NAME}%"; filename=%"{FILENAME}%"%R%N
			-- Content-Type: text/plain%R%N
			-- %R%N
			-- {CONTENT}%R%N
			-- {BOUNDARY}%R%N
			--
			-- `a_source_file': The path to the tmp file that was created by mod_xebra. Can contain environment vars.
			-- `a_target_file_dir': The path to the folder where the file should be written. Can contain environment vars.
			-- `Result': Returns the file name of the created file on success, void otherwise.
		require
			a_source_file_attached_and_not_empty: a_source_file /= Void and then not a_source_file.is_empty
			a_target_file_dir_attached: a_target_file_dir /= Void and then not a_target_file_dir.is_empty
		local
			l_util: XU_FILE_UTILITIES
			l_s_file: RAW_FILE
			l_t_file: RAW_FILE
			l_modulo, l_read, l_nb: INTEGER_32
			l_pos: INTEGER_32
			i: INTEGER
			l_end: INTEGER
			l_start: INTEGER
			l_block_size: INTEGER
			l_buf: STRING
			l_t_fn: FILE_NAME
		do
				create l_util
				create l_s_file.make (l_util.resolve_env_vars (a_source_file, True))
				if l_s_file.exists and l_s_file.is_readable and l_s_file.is_access_readable then
					l_s_file.open_read
					l_s_file.read_line
					l_s_file.read_line
					if l_s_file.last_string.has ('"') then
						if attached l_s_file.last_string.split ('"').i_th (4) as l_up_filename then
							create l_t_fn.make_from_string (l_util.resolve_env_vars (a_target_file_dir, True))
							l_t_fn.set_file_name (l_up_filename)
							create l_t_file.make (l_t_fn)
							if l_t_file.exists and l_t_file.is_writable and l_t_file.is_access_writable then
								l_t_file.delete
							end
							if l_t_file.is_creatable then
								l_t_file.create_read_write
								if l_t_file.is_access_readable and l_t_file.is_readable and l_t_file.is_access_writable and l_t_file.is_writable then
										-- Find end of target file
									from
										l_s_file.finish
										i := 1
									until
										i = 3
									loop
										from
											l_s_file.back
											l_s_file.read_character
											l_s_file.back
										until
											l_s_file.last_character = '%R'
										loop
											l_s_file.back
											l_s_file.read_character
											l_s_file.back
										end
										i := i + 1
									end
									l_end := l_s_file.position
										-- Find start of target file
									from
										i := 0
										l_s_file.start
									until
											-- (Remove four lines from the top)
										i >= 4
									loop
										from
											l_s_file.read_character
										until
											l_s_file.last_character = '%N'
										loop
											l_s_file.read_character
										end
										i := i +1
									end
									l_start := l_s_file.position

									from
										l_block_size := 51200
										l_modulo := l_block_size
										l_read := l_start
										l_s_file.go (l_start)
										l_t_file.start
									until
										l_modulo <= 0
									loop
										if (l_end - l_read) > l_block_size then
											l_modulo := l_block_size
										else
											l_modulo := l_end - l_read
										end
										if l_modulo > 0 then
											l_s_file.read_stream (l_modulo)
											l_t_file.put_string (l_s_file.last_string)
											l_read := l_read + l_modulo
										end
									end
									Result := l_t_file.name
								else
									log.eprint ("File upload: Created file is not readable or writable " + l_t_file.name, generating_type)
								end
								l_t_file.close
							else
								log.eprint ("File upload: Target file is not creatable " + l_t_file.name, generating_type)
							end
						else
							log.eprint ("File upload: Invalid file format " + l_s_file.name , generating_type)
						end
					else
						log.eprint ("File upload: Invalid file format " + l_s_file.name , generating_type)
					end
					l_s_file.close
				else
					log.eprint ("File upload: Cannot read tmp file " + l_s_file.name , generating_type)
				end
		end

invariant
	server_control_attached: server_control /= Void
	current_request_attached: attached current_request
	session_attached: session /= Void
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
