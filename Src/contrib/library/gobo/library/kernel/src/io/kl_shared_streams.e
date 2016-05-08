note

	description:

		"Shared input and output streams"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_SHARED_STREAMS

feature -- Access

	null_input_stream: KL_STRING_INPUT_STREAM
			-- Null input stream
		once
			create Result.make ("")
		ensure
			null_input_stream_not_void: Result /= Void
		end

	null_output_stream: KL_NULL_TEXT_OUTPUT_STREAM
			-- Null output stream
		once
			create Result.make ("null")
		ensure
			null_output_stream_not_void: Result /= Void
		end

end
