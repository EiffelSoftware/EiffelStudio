note
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_FILE_READER

feature -- Access

	read_json_from (a_path: STRING): detachable STRING
		local
			l_file: PLAIN_TEXT_FILE
			template_content: STRING
			l_last_string: detachable STRING
		do
			create l_file.make (a_path)
				-- We perform several checks until we make a real attempt to open the file.
			if not l_file.exists then
				print ("error: '" + a_path + "' does not exist%N")
			else
				if not l_file.is_readable then
					print ("error: '" + a_path + "' is not readable.%N")
				else
					l_file.open_read
					create template_content.make_empty
					l_file.read_stream (l_file.count)
					l_last_string := l_file.last_string
					check l_last_string /= Void end -- implied by postcondition of `l_file.read_stream'
					template_content.append (l_last_string.string)
					Result := template_content
					l_file.close
				end
			end
		end

end
