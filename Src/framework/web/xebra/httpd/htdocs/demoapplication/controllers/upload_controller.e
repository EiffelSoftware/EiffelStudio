note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	UPLOAD_CONTROLLER

inherit
	DEMOAPPLICATION_CONTROLLER

create
	make

feature -- Status Change

	process_upload: STRING
			-- Copies the uploaded file to a new place and removes header and footer from it
		local
			l_s_file: RAW_FILE
			l_t_file: RAW_FILE
			l_modulo, l_read, l_nb: INTEGER
			l_pos: INTEGER
		do
			if attached {STRING} current_request.upload_filename as l_filename then
				create l_s_file.make (l_filename)
				if l_s_file.exists and l_s_file.is_readable and l_s_file.is_access_readable then
					l_s_file.open_read
					l_s_file.read_line
					l_s_file.read_line

					if attached l_s_file.last_string.split ('"').i_th (4) as l_up_filename then
						create l_t_file.make(l_up_filename)
						if l_t_file.exists and l_t_file.is_writable and l_t_file.is_access_writable then
							l_t_file.delete
						end
						if l_t_file.is_creatable then
							l_t_file.create_read_write
							if l_t_file.is_access_readable and l_t_file.is_readable and
							 l_t_file.is_access_writable and l_t_file.is_writable then
									-- Maybe there is a faster way than line by line?
								l_s_file.next_line
								l_s_file.next_line
								l_s_file.next_line
								l_s_file.next_line

								from
									l_read := 0
									l_nb := l_s_file.count
									l_modulo := 51200
								until
									l_read >= l_nb
								loop
									l_s_file.read_stream (l_modulo)
									l_t_file.put_string (l_s_file.last_string)
									l_read := l_read + l_modulo
								end


								Result := "Success, file is now at: " + l_t_file.name
							else
								Result := "Error, created file is not readable or writable??"
							end

							l_t_file.close
						else
							Result := "Error, create file"
						end
					else
						Result := "Error, invalid file format."
					end
					l_s_file.close
				else
					Result := "Error, cannot read uploaded file..."
				end
			else
				Result := "Error, where is uploaded file?"
			end
		ensure
			Result_attached: Result /= Void
		end
end
