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

	process_upload_single_file (a_source_file: STRING; a_target_file_dir: FILE_NAME): BOOLEAN
			-- Copies the uploaded and encoded (single) file to a new place and removes header and footer from it
			-- The uploaded temp file is expected to be in the following format. Other formats will likely result in endless loops!
			-- -----------------------------172158860518773611771834400137
			-- Content-Disposition: form-data; name="file"; filename="hallo.text"
			-- Content-Type: text/plain
			--
			-- This is a text.
			-- And this is a new line.
			--
			-- -----------------------------172158860518773611771834400137
		require
			a_source_file_attached_and_not_empty: a_source_file /= Void and then not a_source_file.is_empty
			a_target_file_dir_attached: a_target_file_dir /= Void
		local
			l_s_file: RAW_FILE
			l_t_file: RAW_FILE
			l_modulo, l_read, l_nb: INTEGER_32
			l_pos: INTEGER_32
			i: INTEGER
			l_end: INTEGER
			l_start: INTEGER
			l_block_size: INTEGER
		do
			Result := False
				create l_s_file.make (a_source_file)
				if l_s_file.exists and l_s_file.is_readable and l_s_file.is_access_readable then
					l_s_file.open_read
					l_s_file.read_line
					l_s_file.read_line
					if l_s_file.has ('"') then

						if attached l_s_file.last_string.split ('"').i_th (4) as l_up_filename then
							a_target_file_dir.set_file_name (l_up_filename)
							create l_t_file.make (a_target_file_dir)
							if l_t_file.exists and l_t_file.is_writable and l_t_file.is_access_writable then
								l_t_file.delete
							end
							if l_t_file.is_creatable then
								l_t_file.create_read_write
								if l_t_file.is_access_readable and l_t_file.is_readable and l_t_file.is_access_writable and l_t_file.is_writable then

										-- Find end of target file
									from
										i := 0
										l_s_file.finish
									until
											-- (Remove two lines from the bottom)
										i >= 3
									loop
										from
											l_s_file.back
											l_s_file.read_character
											l_s_file.back
										until
											l_s_file.last_character = '%N'
										loop
											l_s_file.back
											l_s_file.read_character
											l_s_file.back
										end
										i := i +1
									end
									l_end := l_s_file.position + 1


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

										l_s_file.read_stream (l_modulo)
										l_t_file.put_string (l_s_file.last_string)
										l_read := l_read + l_modulo
									end
									Result := True
								else
									o.eprint ("File upload: Created file is not readable or writable??", generating_type)
								end
								l_t_file.close
							else
								o.eprint ("File upload: Create file.", generating_type)
							end
						else
							o.eprint ("File upload: Invalid file format.", generating_type)
						end
					else
						o.eprint ("File upload: Invalid file format.", generating_type)
					end
					l_s_file.close
				else
					o.eprint ("File upload: Cannot read tmp file.", generating_type)
				end
		end

invariant
	current_request_attached: attached current_request
	server_control_attached: server_control /= Void
end
