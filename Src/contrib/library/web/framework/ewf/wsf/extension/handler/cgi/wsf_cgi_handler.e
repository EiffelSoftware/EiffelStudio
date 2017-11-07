note
	description: "Handler to process CGI script."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_CGI_HANDLER

inherit
	WSF_EXECUTE_HANDLER

create
	make

feature {NONE} -- Creation

	make (a_dir: PATH)
		do
			working_direction := a_dir
		end

feature -- Settings

	buffer_size: INTEGER = 1_024

	working_direction: PATH

feature -- Status report

	cgi_file_path (req: WSF_REQUEST): PATH
		local
			l_path_info: READABLE_STRING_32
		do
				-- Path to CGI executable.
			l_path_info := req.path_info
			if l_path_info.starts_with_general ("/") then
				l_path_info := l_path_info.substring (2, l_path_info.count)
			end

				-- Process
			Result := working_direction.extended (l_path_info)
		end

	exists (req: WSF_REQUEST): BOOLEAN
			-- CGI file exists?
		do
			Result := (create {FILE_UTILITIES}).file_path_exists (cgi_file_path (req))
		end

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			fut: FILE_UTILITIES
			l_exec_path: PATH
			proc: BASE_PROCESS
			l_input_env: STRING_TABLE [READABLE_STRING_GENERAL]
			l_input_header: detachable STRING
			l_input_buf: STRING
			l_output: STRING
			l_output_header_sent: BOOLEAN
			l_error: STRING
			s: STRING
			i, j, n: INTEGER
		do
				-- Header
			if attached req.raw_header_data as l_header then
				l_input_header := l_header
			end
				-- Input data
			create l_input_buf.make (req.content_length_value.to_integer_32)
			req.read_input_data_into (l_input_buf)

				-- Input environment
			create l_input_env.make (10)
			across
				req.meta_variables as ic
			loop
				if attached {WSF_STRING} ic.item as var then
					l_input_env.force (var.value, var.name)
				else
					check supported: False end
				end
			end
				-- No need to import `l_input_header` in environment
				-- As current connector already did the job.

				-- Process
			l_exec_path := cgi_file_path (req)
			if fut.file_path_exists (l_exec_path) then
				proc := (create {BASE_PROCESS_FACTORY}).process_launcher (l_exec_path.name, Void, working_direction.name)
				proc.set_hidden (True)
				proc.set_environment_variable_table (l_input_env)
				proc.set_separate_console (False)
				proc.redirect_input_to_stream
				proc.redirect_output_to_stream
				proc.redirect_error_to_stream

					-- Launch CGI execution
				proc.launch
				if proc.launched then
						-- Do not send the header to CGI script
						-- value are passed via environment variables
						--				proc.put_string (l_input_header)
						-- Send payload.
					proc.put_string (l_input_buf)

					create l_output.make_empty
					create l_error.make_empty
					get_output_and_error_from_process (proc, l_output, l_error)
					if l_error /= Void and then not l_error.is_whitespace then
						res.put_error (l_error)
					end

						-- Wait for process exit
					if not proc.has_exited then
						proc.wait_for_exit
					end
					if proc.exit_code /= 0 then
						res.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
						s := "CGI script execution failed [exit code=" + proc.exit_code.out+ "]!"
						res.header.put_content_type_utf_8_text_plain
						res.header.put_content_length (s.count)
						res.put_string (s)
					else
							-- Send the response
							-- error already sent via `res.put_error (l_error)`
						from
							i := 1
							n := l_output.count
						until
							i > n or l_output_header_sent
						loop
							j := l_output.index_of ('%N', i)
							if j > 0 then
								s := l_output.substring (i, j)
								s.right_adjust
								if s.is_empty then
										-- Reached end of header
									l_output_header_sent := True
								else
									res.add_header_line (s)
								end
							else
									-- ERROR
								l_output_header_sent := True
							end
							i := j + 1
						end
						if l_output_header_sent then
							if i <= n then
								res.put_string (l_output.substring (i, n))
							end
						else
							res.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
							s := "Internal server error!"
							res.header.put_content_type_utf_8_text_plain
							res.header.put_content_length (s.count)
							res.put_string (s)
						end
					end
				else
					res.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
					s := "Could not launch CGI script!"
					res.header.put_content_type_utf_8_text_plain
					res.header.put_content_length (s.count)
					res.put_string (s)
				end
			else
				res.set_status_code ({HTTP_STATUS_CODE}.not_found)
				s := "Not found!"
				res.header.put_content_type_utf_8_text_plain
				res.header.put_content_length (s.count)
				res.put_string (s)
			end
		end

	get_output_and_error_from_process (proc: BASE_PROCESS; a_output: STRING; a_error: STRING)
		local
			output_buf, error_buf: SPECIAL [NATURAL_8]
		do
			from
				create output_buf.make_filled (0, buffer_size)
				create error_buf.make_filled (0, buffer_size)
			until
				not attached output_buf and not attached error_buf
			loop
				if attached output_buf then
					if proc.has_output_stream_error or proc.has_output_stream_closed then
						output_buf := Void
					end
					if attached output_buf then
							-- Try reading from standard output.
						proc.read_output_to_special (output_buf)
						across
							output_buf as ic
						loop
							a_output.append_code (ic.item)
						end
					end
				end
				if attached output_buf implies output_buf.count = 0 and then attached error_buf then
						-- Nothing is read from standard output, switch to standard error.
					if proc.has_error_stream_error or proc.has_error_stream_closed then
						error_buf := Void
					end
					if attached error_buf then
							-- Try reading from standard error.
						proc.read_error_to_special (error_buf)
						across
							error_buf as ic
						loop
							a_error.append_code (ic.item)
						end
					end
				end
				if attached output_buf then
					output_buf.extend_filled (0)
				end
				if attached error_buf then
					error_buf.extend_filled (0)
				end
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
