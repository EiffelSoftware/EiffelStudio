note
	description: "[
			Stream JSON writer into file.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_STREAM_FILE_WRITER

inherit
	JSON_STREAM_WRITER
		undefine
			reset
		end

	JSON_STREAM_WRITER_IMP

create
	make_with_file

feature {NONE} -- Intialization

	make_with_file (f: FILE)
			-- Initialize writer with file `f`.
		require
			f.is_open_write
		do
			output := f
			create active_stack.make (3)
			reset
		end

	output: FILE
			-- Target file.

feature {NONE} -- Implementation

	output_string (s: READABLE_STRING_8)
		do
			output.put_string (s)
		end

	output_character (c: CHARACTER)
		do
			output.put_character (c)
		end


note
	copyright: "2010-2022, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
