note
	description: "Summary description for {WDOCS_FILE_STRING_8_CACHE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_FILE_STRING_8_CACHE

inherit
	WDOCS_FILE_CACHE [STRING]

create
	make

feature -- Access

	append_to (a_output: STRING)
			-- Append `item' to `a_output'.
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create f.make_with_path (path)
				if f.exists and then f.is_access_readable then
					f.open_read
					if attached file_to_item (f) as s then
						a_output.append (s)
					end
					f.close
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	file_to_item (f: FILE): detachable STRING
		local
			retried: BOOLEAN
		do
			if retried then
				Result := Void
			else
				from
					create Result.make_empty
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (1_024)
					Result.append (f.last_string)
				end
			end
		rescue
			retried := True
			retry
		end

	item_to_file (a_data: STRING; f: FILE)
		do
			f.put_string (a_data)
		end

end
