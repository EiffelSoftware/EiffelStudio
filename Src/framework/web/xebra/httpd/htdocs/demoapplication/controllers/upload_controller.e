note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
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
		do
			if attached {STRING} current_request.upload_filename as l_filename then
				create l_s_file.make_open_read (l_filename)
				if l_s_file.exists and l_s_file.is_readable and l_s_file.is_access_readable then

					l_s_file.read_line
					l_s_file.read_line

					if attached l_s_file.last_string.split ('"').i_th (4) as l_up_filename then
						create l_t_file.make_open_read_write ("~/home/" + l_up_filename)
						if l_t_file.is_access_writable and l_t_file.is_creatable and l_t_file.is_writable and l_t_file.is_readable and l_t_file.is_access_readable then
							l_s_file.copy_to (l_t_file)
						else
							Result := "Error, cannot properly access target file"
						end
					else
						Result := "Error, invalid file format."
					end

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
