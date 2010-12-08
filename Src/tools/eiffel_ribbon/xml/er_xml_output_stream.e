note
	description: "Summary description for {ER_OUTPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_OUTPUT_STREAM

inherit
	XML_OUTPUT_STREAM

create
	make

feature {NONE} -- Initialization

	make
			-- Create stream
		local
			l_file: like file
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			if attached l_constants.xml_full_file_name as l_file_name then
				create l_file.make (l_file_name)
				file := l_file
				l_file.create_read_write
			else
				Check should_not_happen: False end
			end
		end

feature -- Access

	name: STRING = "eiffel_ribbon_output_stream"
			-- Name of current stream

feature -- Status report

	is_open_write: BOOLEAN = True

feature -- Basic operation

	flush
			-- Flush buffered data to stream.
		do
			if attached file as l_file then
				l_file.flush
			end
		end

	close
			--
		do
			if attached file as l_file then
				l_file.close
			end
		end

feature -- Output

	put_character (c: CHARACTER)
			--
		do
			if attached file as l_file then
				l_file.put_character (c)
			end
		end

	put_string (a_string: STRING)
			-- Write `a_string' to output stream.
		do
			if attached file as l_file then
				l_file.put_string (a_string)
			end
		end

feature {NONE} -- Implementation

	file: detachable RAW_FILE
			--

end
