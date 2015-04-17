note
	description: "Object responsible to read html templates to be send by emails."
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL_HTML_RESOURCE

create
	make

feature {NONE} -- Initialization

	make (a_path: PATH)
			-- Initialize `Current'.
		local
			l_path : PATH
		do
			l_path := a_path.extended ("email_video_resources.html")
			read_file (l_path)
		end


feature -- Access

	representation: detachable STRING
			-- Html represenation content.

feature {NONE} -- Implementation

	read_file (a_path: PATH)
				-- Read file at path `a_path', and write the content
				-- to output attribute, if successful.
		local
			f: RAW_FILE
		do
			create f.make_with_path (a_path)
			f.open_read
			if f.exists and then f.is_readable then
				f.read_stream (f.count)
				f.close
				representation := f.last_string
			else
				-- TODO add log to describe the rror.
			end
		end
end
