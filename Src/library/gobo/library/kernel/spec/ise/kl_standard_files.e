indexing

	description:

		"Standard files"

	library:    "Gobo Eiffel Kernel Library"
	author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
	copyright:  "Copyright (c) 1997, Eric Bezault"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_STANDARD_FILES

inherit

	KL_IMPORTED_INPUT_STREAM_ROUTINES

	KL_IMPORTED_OUTPUT_STREAM_ROUTINES

feature -- Access

	input: FILE is
			-- Standard input file
		once
			Result := io.input
		ensure
			file_not_void: Result /= Void
			file_open_read: INPUT_STREAM_.is_open_read (Result)
		end

	output: FILE is
			-- Standard output file
		once
			Result := io.output
		ensure
			file_not_void: Result /= Void
			file_open_write: OUTPUT_STREAM_.is_open_write (Result)
		end

	error: FILE is
			-- Standard error file
		once
			Result := io.error
		ensure
			file_not_void: Result /= Void
			file_open_write: OUTPUT_STREAM_.is_open_write (Result)
		end

end -- class KL_STANDARD_FILES
