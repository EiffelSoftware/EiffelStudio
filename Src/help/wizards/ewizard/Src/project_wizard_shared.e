indexing
	description: "This class is inherit by all the application"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_WIZARD_SHARED

inherit
	ARGUMENTS

feature -- Shared variables

	callback_content: STRING is
		local
			file: PLAIN_TEXT_FILE
		once
			if callback_filename /= Void then
				create file.make_open_read (callback_filename)
		
					-- Read the file.
				create Result.make (0)
				from
				until
					file.end_of_file
				loop
					file.read_line
					Result.append (file.last_string+"%N")
				end
				file.close
			end
		end

	callback_filename: STRING is
		once
			Result := separate_word_option_value ("callback")
			if Result /= Void and then Result.is_empty then
				Result := Void
			end
		ensure
			Result_void_or_not_empty: Result = Void or else not Result.is_empty
		end

	write_bench_notification_cancel is
			-- Write onto the file given as argument the project ace file, directory, ...
		local
			file: PLAIN_TEXT_FILE
			rescued: BOOLEAN
		do
			if not rescued then
				if callback_content /= Void then
						-- Modify the fields
					callback_content.replace_substring_all ("<SUCCESS>", "no")
				end

				if callback_filename /= Void then
					create file.make_open_write (callback_filename)
					file.put_string (callback_content)
					file.close
				end
			end
		rescue
			rescued := True
			retry
		end

end -- class PROJECT_WIZARD_SHARED

