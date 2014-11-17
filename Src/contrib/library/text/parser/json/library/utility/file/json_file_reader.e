note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_FILE_READER

feature -- Access

	read_json_from (a_path: READABLE_STRING_GENERAL): detachable STRING
		local
			l_file: PLAIN_TEXT_FILE
			l_last_string: detachable STRING
			l_file_count: INTEGER
			l_fetch_done: BOOLEAN
		do
			create l_file.make_with_name (a_path)
				-- We perform several checks until we make a real attempt to open the file.
			if not l_file.exists then
				print ("error: '" + a_path.out + "' does not exist%N") -- FIXME: unicode may be truncated
			else
				if not l_file.is_readable then
					print ("error: '" + a_path.out + "' is not readable.%N") -- FIXME: unicode may be truncated
				else
					l_file_count := l_file.count
					l_file.open_read
					from
						create Result.make (l_file_count)
					until
						l_fetch_done
					loop
						l_file.read_stream (1_024)
						l_last_string := l_file.last_string
						l_fetch_done := l_file.exhausted or l_file.end_of_file or l_last_string.count < 1_024
						if not l_last_string.is_empty then
							Result.append (l_last_string)
						end
					end
					l_file.close
				end
			end
		end

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
