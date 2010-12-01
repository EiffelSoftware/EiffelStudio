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
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			create file.make (l_constants.xml_file_name)
			file.create_read_write
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
			file.flush
		end

	close
			--
		do
			file.close
		end
		
feature -- Output

	put_character (c: CHARACTER)
			--
		do
			file.put_character (c)
		end

	put_string (a_string: STRING)
			-- Write `a_string' to output stream.
		do
			file.put_string (a_string)
		end

feature {NONE} -- Implementation

	file: RAW_FILE
			--

end
