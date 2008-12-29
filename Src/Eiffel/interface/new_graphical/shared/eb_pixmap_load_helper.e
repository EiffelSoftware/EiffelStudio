note
	description: "Pixmap file loading helper"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PIXMAP_LOAD_HELPER

feature -- Loading

	loaded_pixmap_from_file (a_file: STRING; a_default_pixmap: EV_PIXMAP; a_default_buffer: EV_PIXEL_BUFFER): TUPLE [a_pixmap: EV_PIXMAP; a_buffer: EV_PIXEL_BUFFER]
			-- Loaded pixmap as well as its pixel buffer from `a_file'.
			-- If loading failed, `a_buffer' will be `a_default_buffer' if set, otherwise `a_buffer' will be Void;
			-- and `a_pixmap' will be `a_default_pixmap' if set, otherwise `a_pixmap' will be Void too.
		require
			a_file_attached: a_file /= Void
		local
			l_retried: BOOLEAN
			l_file: RAW_FILE
			l_buffer: EV_PIXEL_BUFFER
			l_pixmap: EV_PIXMAP
		do
			if not l_retried and not a_file.is_empty then
				create l_buffer
				create l_file.make (a_file)
				if l_file.exists and then l_file.is_readable then
					l_buffer.set_with_named_file (a_file)
					l_pixmap := l_buffer.sub_pixmap (create {EV_RECTANGLE}.make (0, 0, l_buffer.width, l_buffer.height))
				end
			end
			if l_pixmap = Void then
				l_pixmap := a_default_pixmap
			end
			-- `l_buffer' is not void after exceptions in exectuing `set_with_named_file'.
			-- We need to check `l_retried' here.
			if l_buffer = Void or l_retried then
				l_buffer := a_default_buffer
			end
			Result := [l_pixmap, l_buffer]
		rescue
			l_retried := True
			retry
		end

end
