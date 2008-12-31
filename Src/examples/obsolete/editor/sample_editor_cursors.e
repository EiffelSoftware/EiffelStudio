note
	description: "Cursors for current application"
	date: "$Date$"
	revision: "$Revision$"

class
	SAMPLE_EDITOR_CURSORS

inherit
	EDITOR_CURSORS

feature -- Cursors

	cur_cut_selection: EV_POINTER_STYLE
			-- Editor cut cursor icon
		local
			l_env: EXECUTION_ENVIRONMENT
			l_path: FILE_NAME
			l_buffer: EV_PIXEL_BUFFER
		do
			create l_env
			if l_env.get ("ISE_LIBRARY") /= Void then
				create l_path.make_from_string (l_env.get ("ISE_LIBRARY"))
				l_path.extend_from_array (<< "examples", "obsolete", "editor", "bitmaps" >>)
				l_path.set_file_name ("cut_selection")
				l_path.add_extension ("png")
				create l_buffer
				l_buffer.set_with_named_file (l_path)
				create Result.make_with_pixel_buffer (l_buffer, 1, 1)
			else
				create Result
			end
		end

	cur_copy_selection: EV_POINTER_STYLE
			-- Editor copy cursor icon
		local
			l_env: EXECUTION_ENVIRONMENT
			l_path: FILE_NAME
			l_buffer: EV_PIXEL_BUFFER
		do
			create l_env
			if l_env.get ("ISE_LIBRARY") /= Void then
				create l_path.make_from_string (l_env.get ("ISE_LIBRARY"))
				l_path.extend_from_array (<< "examples", "obsolete", "editor", "bitmaps" >>)
				l_path.set_file_name ("copy_selection")
				l_path.add_extension ("png")
				create l_buffer
				l_buffer.set_with_named_file (l_path)
				create Result.make_with_pixel_buffer (l_buffer, 1, 1)
			else
				create Result
			end
		end

end
