indexing

	description:

		"Routines that ought to be in class OUTPUT_STREAM"

	library:    "Gobo Eiffel Kernel Library"
	author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
	copyright:  "Copyright (c) 1997, Eric Bezault"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_OUTPUT_STREAM_ROUTINES

inherit

	KL_IMPORTED_OUTPUT_STREAM_ROUTINES

feature -- Initialization

	make_file_open_write (a_filename: STRING): like OUTPUT_STREAM_TYPE is
			-- Create a new file object with `a_filename' as
			-- file name and try to open it in write-only mode.
			-- `is_open_write (Result)' is set to True
			-- if operation was successful.
		require
			a_filename_not_void: a_filename /= Void
			a_filename_not_empty: not a_filename.empty
		local
			rescued: BOOLEAN
		do
			if not rescued then
				!! Result.make (a_filename)
				Result.open_write
			elseif not Result.is_closed then
				Result.close
			end
		ensure
			file_not_void: Result /= Void
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

feature -- Status report

	is_open_write (a_stream: like OUTPUT_STREAM_TYPE): BOOLEAN is
			-- Is `a_stream' open in write mode?
		require
			a_stream_void: a_stream /= Void
		do
			Result := a_stream.is_open_write
		end

	is_closed (a_stream: like OUTPUT_STREAM_TYPE): BOOLEAN is
			-- Is `a_stream' closed?
		require
			a_stream_void: a_stream /= Void
		do
			Result := a_stream.is_closed
		end

feature -- Status setting

	close (a_stream: like OUTPUT_STREAM_TYPE) is
			-- Close `a_stream' if it is closable,
			-- let it open otherwise.
		require
			a_stream_not_void: a_stream /= Void
			not_closed: not is_closed (a_stream)
		do
			a_stream.close
		end

end -- class KL_OUTPUT_STREAM_ROUTINES
