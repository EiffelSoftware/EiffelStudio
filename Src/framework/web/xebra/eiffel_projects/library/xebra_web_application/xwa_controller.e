note
	description: "[
		All controllers used in xeb files have to inherit from this class.
		It's constructor has to be the make feature.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_CONTROLLER

inherit
	XU_SHARED_OUTPUTTER
	XU_STOPWATCH


feature -- Initialization

	make
			-- Initializes current
		do
			create {XH_REQUEST} current_request.make_empty
			create server_control.make
		ensure
			current_request_attached: current_request /= Void
			server_control_attached: server_control /= Void
		end

feature -- Access

	server_control: XWA_SERVER_CONTROL

	current_request: XH_REQUEST
		-- Represents the current request that was sent by the user

	current_session: detachable XH_SESSION
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
			current_session := a_session
		ensure
			current_session_attached: attached current_session
		end

feature -- Operations

	process_upload_single_file (a_source_file: STRING; a_target_file_dir: STRING): detachable STRING
			-- Copies the uploaded and encoded (single) file to a new place and removes header and footer from it
			--
			-- `a_source_file': The path to the tmp file that was created by mod_xebra.
			-- `a_target_file_dir': The path to the folder where the file should be written. Can contain environment vars.
			-- `Result': Returns the file name of the create file on success, void otherwise.
			--
			-- The uploaded temp file is expected to be in the following format. Other formats will likely result in endless loops!
			-- -----------------------------13689473967984000952010704750%R%N
			-- Content-Disposition: form-data; name=%"file%"; filename=%"{FILENAME}%"%R%N
			-- Content-Type: text/plain%R%N
			-- %R%N
			-- {CONTENT}%R%N
			-- -----------------------------13689473967984000952010704750--%R%N
		require
			a_source_file_attached_and_not_empty: a_source_file /= Void and then not a_source_file.is_empty
			a_target_file_dir_attached: a_target_file_dir /= Void
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
				create l_s_file.make (a_source_file)
				if l_s_file.exists and l_s_file.is_readable and l_s_file.is_access_readable then
					l_s_file.open_read
					l_s_file.read_line
					l_s_file.read_line
					if l_s_file.last_string.has ('"') then
						if attached l_s_file.last_string.split ('"').i_th (4) as l_up_filename then
							create l_util
							create l_t_fn.make_from_string (l_util.resolve_env_vars (a_target_file_dir, true))
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
									o.eprint ("File upload: Created file is not readable or writable?? " + l_t_file.name, generating_type)
								end
								l_t_file.close
							else
								o.eprint ("File upload: Target file is not creatable! " + l_t_file.name, generating_type)
							end
						else
							o.eprint ("File upload: Invalid file format. " + l_s_file.name , generating_type)
						end
					else
						o.eprint ("File upload: Invalid file format. " + l_s_file.name , generating_type)
					end
					l_s_file.close
				else
					o.eprint ("File upload: Cannot read tmp file. " + l_s_file.name , generating_type)
				end
		end

invariant
	current_request_attached: attached current_request
	server_control_attached: server_control /= Void
end
